function LFGFilter:DefineClassicDungeon(name, location, faction, minlevel, yellow, green, maxlevel, ...)
	return LFGFilter:DefineDungeon("classic", name, 5, location, faction, minlevel, yellow, green, maxlevel, 0, ...)
end

function LFGFilter:DefineClassicRaid(name, size, location, minlevel, yellow, ...)
	return LFGFilter:DefineDungeon("classic", name, size, location, LFGFilter.Factions.BOTH, minlevel, yellow, 60, 60, 0, ...)
end

function LFGFilter:DefineBCDungeon(name, location, minlevel, yellow, green, maxlevel, ...)
	return LFGFilter:DefineDungeon("bc", name, 5, location, LFGFilter.Factions.BOTH, minlevel, yellow, green, maxlevel, 70, ...)
end

function LFGFilter:DefineBCRaid(name, size, location, ...)
	return LFGFilter:DefineDungeon("bc", name, size, location, LFGFilter.Factions.BOTH, 70, 70, 70, 70, 0, ...)
end

function LFGFilter:DefineWotlkDungeon(name, location, minlevel, yellow, green, maxlevel, ...)
	return LFGFilter:DefineDungeon("wotlk", name, 5, location, LFGFilter.Factions.BOTH, minlevel, yellow, green, maxlevel, 80, ...)
end

function LFGFilter:DefineWotlkRaid(name, location, ...)
	return LFGFilter:DefineDungeon("wotlk", name, 25, location, LFGFilter.Factions.BOTH, 80, 80, 80, 80, 80, ...)
end

function AddPattern(tokens, expr, wotlkraid)
	if expr then
		if (type(expr) == "table") then
			for _, tok in pairs(expr) do
				table.insert(tokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%W")
				if (wotlkraid) then
					table.insert(tokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%d%d['ners]*%W")
				end
			end
		else
			table.insert(tokens, "%W" .. LFGFilter.ReplaceUmlauts(expr) .. "%W")
		end
	end
end

function LFGFilter:DefineDungeon(addon, name, size, location, faction, minlevel, yellow, green, maxlevel, herolevel, tokens, antitokens, achvmnt_ids)
	local lName = self.Locale[name] or name
	local shortname = name
	tokens = tokens or {}
	antitokens = antitokens or {}
	if type(tokens) == "table" and #tokens > 0 then
		shortname = tokens[1]
	end
	shortname = string.upper(shortname)
	location = location or ""
	local dungeon = {
		Name = name,
		Addon = addon or "",
		Shortname = shortname,
		LocalizedName = lName,
		Size = size or 40,
		IsRaid = (size or 0) > 5,
		Location = LFGFilter.Locale[location] or location,
		Faction = faction or LFGFilter.Factions.BOTH,
		MinLevel = minlevel or 0,
		YellowLevel = yellow or 0,
		GreenLevel = green or 999,
		MaxLevel = maxlevel or 999,
		HeroLevel = herolevel or 0,
		Tokens = {},
		AntiTokens = {},
		Achievements = achvmnt_ids or {},
	}
	local isWotlkRaid = (addon == "wotlk" and size == 25)
	AddPattern(dungeon.Tokens, string.lower(name))
	if (name ~= lName) then
		AddPattern(dungeon.Tokens, string.lower(lName))
	end
	AddPattern(dungeon.Tokens, tokens, isWotlkRaid)
	AddPattern(dungeon.AntiTokens, antitokens)
	if (name ~= "Custom") then
		AddPattern(dungeon.Tokens, self.Locale[shortname .. "-Tokens"] or {}, isWotlkRaid)
		AddPattern(dungeon.AntiTokens, self.Locale[shortname .. "-AntiTokens"] or {})
	end
	self.Dungeons[name] = dungeon
end

function LFGFilter:GetDifficultyColor(dungeonname, ishero)
	return self.Colors[self:GetDifficulty(dungeonname, ishero)]
end

function LFGFilter:GetDifficulty(dungeon, ishero)
	if (type(dungeon) == "string") then
		dungeon = self.Dungeons[dungeon]
	end
	if (type(dungeon) == "table") then
		local level = UnitLevel("player")
		if ishero then
			if (level < dungeon.HeroLevel) then
				return 5
			elseif (level > dungeon.HeroLevel+3) then
				return 1
			elseif (level > dungeon.HeroLevel) then
				return 2
			else
				return 3
			end
		else
			if (level < dungeon.MinLevel) then
				return 5
			elseif (level < dungeon.YellowLevel) then
				return 4
			elseif (level > dungeon.MaxLevel) then
				return 1
			elseif (level > dungeon.GreenLevel) then
				return 2
			else
				return 3
			end
		end
	end
	return 0
end

--function dump(o)
--   if type(o) == 'table' then
--      local s = '{ '
--      for k,v in pairs(o) do
--         if type(k) ~= 'number' then k = '"'..k..'"' end
--         s = s .. '['..k..'] = ' .. dump(v) .. ','
--      end
--      return s .. '} '
--   else
--      return tostring(o)
--   end
--end
--
local function IsAchievementMatch(line, dungeon)
	for _, avm in pairs(dungeon.Achievements or {}) do
		if (string.find(line, "|hachievement:0*" .. avm[1] .. ":.*|h")) then
			local ishcplus = (avm[2] == 3)
			local ishero = ishcplus or (avm[2] == 2)
			return avm[1], ishero, ishcplus
		end
	end
	return 0, false
end

local function IsDungeonMatch(line, dungeon)
	-- if (level < dungeon.MinLevel - 2) or (level > dungeon.MaxLevel + 2) then return false end
	for _, anti in pairs(dungeon.AntiTokens) do
		if (string.find(line, anti)) then
			return false
		end
	end
	for _, token in pairs(dungeon.Tokens) do
		if (string.find(line, token)) then
			return true
		end
	end
	return false
end

function RemoveDungeonFromTable(dungeons, key)
	for i, n in pairs(dungeons) do
		if (n == key) then
			table.remove(i)
			return
		end
	end
end

function LFGFilter:GetMatchingDungeons(pmessage, ishero, ishcplus)
	local result = { }
	local matchLevel = 0
	local DMKey = nil
	local ifOver40 = false
	local message = pmessage
	if (type(message) == "string") then
		local isQuest = LFGFilter.IsQuest(message)
		if (isQuest == false) then
			for key, dungeon in pairs(self.Dungeons) do
				local isMatch = false
				local avm, hc, hcp = IsAchievementMatch(message, dungeon)
				if (avm > 0) then 
					isMatch = true
					message = message:gsub("|hachievement:0*" .. avm .. ".*|h%[.*%]|h", "")
					if hc or hcp then ishero = true end
					if hcp then ishcplus = true end
				else
					isMatch = IsDungeonMatch(message, dungeon)
				end
				if (isMatch) then
					table.insert(result, key)
					local diff = self:GetDifficulty(dungeon, ishero)
					local dOffset = 3 - abs(3-diff)
					if (dOffset > matchLevel) then
						matchLevel = dOffset
					end
					-- special case DM is Deadmines or Dire Maul, depends on level of poster or the min level of other dungeons mentioned in the same post
					if (dungeon.Name == "The Deadmines") then DMKey = key end
					if (dungeon.MinLevel > 40) then ifOver40 = true end
				end
			end
			-- if Deadmines is found, but other dungeons are lvl > 40, most probably Dire Maul was meant!
			if (DMKey and ifOver40) then
				-- replace "The Deadmines" in result table with "Dire Maul"
				local dungeon = LFGFilter.Dungeons["Dire Maul"]
				--result[DMKey] = dungeon -- doesn't seem to work, check why!
				RemoveDungeonFromTable(result, DMKey)
				table.insert(result, dungeon.Name)
				local diff = self:GetDifficulty(dungeon, ishero)
				local dOffset = 3 - abs(3-diff)
				if (dOffset > matchLevel) then
					matchLevel = dOffset
				end
			end
		else
			matchLevel = 3
		end
	end
	return result, matchLevel, ishero, ishcplus
end