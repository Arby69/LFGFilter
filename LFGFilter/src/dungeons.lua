function LFGFilter:DefineClassicDungeon(name, location, faction, minlevel, yellow, green, maxlevel, tokens, antitokens)
	return LFGFilter:DefineDungeon("classic", name, 5, location, faction, minlevel, yellow, green, maxlevel, 0, tokens, antitokens)
end

function LFGFilter:DefineClassicRaid(name, size, location, minlevel, yellow, tokens, antitokens)
	return LFGFilter:DefineDungeon("classic", name, size, location, LFGFilter.Factions.BOTH, minlevel, yellow, 60, 60, 0, tokens, antitokens)
end

function LFGFilter:DefineBCDungeon(name, location, minlevel, yellow, green, maxlevel, tokens, antitokens)
	return LFGFilter:DefineDungeon("bc", name, 5, location, LFGFilter.Factions.BOTH, minlevel, yellow, green, maxlevel, 70, tokens, antitokens)
end

function LFGFilter:DefineBCRaid(name, size, location, tokens, antitokens)
	return LFGFilter:DefineDungeon("bc", name, size, location, LFGFilter.Factions.BOTH, 70, 70, 70, 70, 0, tokens, antitokens)
end

function LFGFilter:DefineWotlkDungeon(name, location, minlevel, yellow, green, maxlevel, tokens, antitokens)
	return LFGFilter:DefineDungeon("wotlk", name, 5, location, LFGFilter.Factions.BOTH, minlevel, yellow, green, maxlevel, 80, tokens, antitokens)
end

function LFGFilter:DefineWotlkRaid(name, location, tokens, antitokens)
	return LFGFilter:DefineDungeon("wotlk", name, 25, location, LFGFilter.Factions.BOTH, 80, 80, 80, 80, 80, tokens, antitokens)
end

function LFGFilter:DefineDungeon(addon, name, size, location, faction, minlevel, yellow, green, maxlevel, herolevel, tokens, antitokens)
	local lName = self.Locale[name] or name
	-- local shortname = string.upper(tokens[1] or name)
	local shortname = name
	if tokens and type(tokens) == "table" and #tokens > 0 then
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
		Tokens = { },
		AntiTokens = { },
	}
	table.insert(dungeon.Tokens, "%W" .. LFGFilter.ReplaceUmlauts(string.lower(name)) .. "%W")
	if (name ~= lName) then
		table.insert(dungeon.Tokens, "%W" .. LFGFilter.ReplaceUmlauts(string.lower(lName)) .. "%W")
	end
	if (type(tokens) == "table") then
		for _, tok in pairs(tokens) do
			table.insert(dungeon.Tokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%W")
		end
	end
	if (type(antitokens) == "table") then
		for _, tok in pairs(antitokens) do
			table.insert(dungeon.AntiTokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%W")
		end
	end
	if (name ~= "Custom") then
		local locTokens = self.Locale[shortname .. "-Tokens"] or {}
		if (type(locTokens) == "table") then
			for _, tok in pairs(locTokens) do
				table.insert(dungeon.Tokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%W")
			end
		end
		local locAnti = self.Locale[shortname .. "-AntiTokens"] or {}
		if (type(locAnti) == "table") then
			for _, tok in pairs(locAnti) do
				table.insert(dungeon.AntiTokens, "%W" .. LFGFilter.ReplaceUmlauts(tok) .. "%W")
			end
		end
	end
	self.Dungeons[name] = dungeon
end

local RED = { r = 255, g = 0, b = 0 }
local ORANGE = { r = 255, g = 128, b = 64 }
local YELLOW = { r = 255, g = 255, b = 0 }
local GREEN = { r = 0, g = 168, b = 0 }
local GREY = { r = 128, g = 128, b = 128 }

function LFGFilter:GetDifficultyColor(dungeonname)
	return self.Colors[self:GetDifficulty(dungeonname)]
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
		-- add some logic to consider 10/25 selection in wotlk raids
		if (dungeon.Addon == "wotlk" and dungeon.IsRaid) then
		  if (string.find(line, token .. "10")) then
				return true
			end
			if (string.find(line, token .. "25")) then
				return true
			end
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

function LFGFilter:GetMatchingDungeons(message)
	local result = { }
	local matchLevel = 0
	local DMKey = nil
	local ifOver40 = false
	--local line = " " .. message .. " "
	if (type(message) == "string") then
		local isQuest = LFGFilter.IsQuest(message)
		if (isQuest == false) then
			for key, dungeon in pairs(self.Dungeons) do
				if (IsDungeonMatch(message, dungeon) == true) then
					table.insert(result, key)
					local diff = self:GetDifficulty(dungeon)
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
				local diff = self:GetDifficulty(dungeon)
				local dOffset = 3 - abs(3-diff)
				if (dOffset > matchLevel) then
					matchLevel = dOffset
				end
			end
		else
			matchLevel = 3
		end
	end
	return result, matchLevel
end

function LFGFilter:DefineDungeons()
	self.Colors = { }
	self.Colors[0] = self.Config.DungeonNameColor
	self.Colors[1] = GREY
	self.Colors[2] = GREEN
	self.Colors[3] = YELLOW
	self.Colors[4] = ORANGE
	self.Colors[5] = RED
	self.Dungeons = { }
	-- function LFGFilter:DefineClassicDungeon(name, location, faction, minlevel, yellow, green, maxlevel, tokens, antitokens)
	self:DefineClassicDungeon("Ragefire Chasm", "Orgrimmar", LFGFilter.Factions.HORDE, 10, 13, 18, 21, { "rfc", "ragefire", "chasm" })
	self:DefineClassicDungeon("Wailing Caverns", "Barrens", LFGFilter.Factions.BOTH, 12, 15, 20, 25, { "wc", "wailing", "caverns?" })
	self:DefineClassicDungeon("The Deadmines", "Westfall", LFGFilter.Factions.BOTH, 15, 18, 23, 26, { "dm", "mines", "dea[dt]h?mine%a*" }, { "east", "north", "west" })
	self:DefineClassicDungeon("Shadowfang Keep", "Silverpine Forest", LFGFilter.Factions.BOTH, 19, 22, 27, 30, { "sfk", "shadowfang", "%a*fang%W*keep" })
	self:DefineClassicDungeon("The Stockades", "Stormwind", LFGFilter.Factions.ALLIANCE, 21, 24, 29, 32, { "stocks", "stockades?" })
	self:DefineClassicDungeon("Blackfathom Deeps", "Ashenvale", LFGFilter.Factions.BOTH, 21, 24, 29, 32, { "bfd", "blackfath%a*", "fathom", "%a*om%W*deeps?" })
	self:DefineClassicDungeon("Gnomeregan", "Dun Morogh", LFGFilter.Factions.BOTH, 26, 29, 35, 38, { "gnome", "gnomer%a*", "gnomegeran", "gno%a*gan" })
	self:DefineClassicDungeon("Razorfen Kraul", "Barrens", LFGFilter.Factions.BOTH, 27, 30, 37, 40, { "rk", "rfk", "kraul" })
	self:DefineClassicDungeon("The Scarlet Monastery: Graveyard", "Tirisfal Glades", LFGFilter.Factions.BOTH, 23, 26, 33, 45, { "gy", "g%a*yard", "sm%W*gy" })
	self:DefineClassicDungeon("The Scarlet Monastery: Library", "Tirisfal Glades", LFGFilter.Factions.BOTH, 26, 29, 36, 45, { "lib", "library", "sm%W*lib%a*" })
	self:DefineClassicDungeon("The Scarlet Monastery: Armory", "Tirisfal Glades", LFGFilter.Factions.BOTH, 29, 32, 39, 45, { "arm", "armory", "sm%W*arm%a*" })
	self:DefineClassicDungeon("The Scarlet Monastery: Cathedral", "Tirisfal Glades", LFGFilter.Factions.BOTH, 32, 35, 42, 45, { "cath", "cath%a*", "sm%W*cath%a*" })
	self:DefineClassicDungeon("Razorfen Downs", "Barrens", LFGFilter.Factions.BOTH, 37, 40, 47, 50, { "rd", "rfd", "downs", "raz%a*%Wdowns?" })
	self:DefineClassicDungeon("Uldaman", "Badlands", LFGFilter.Factions.BOTH, 39, 42, 49, 52, { "ulda", "ulda[man]*" })
	self:DefineClassicDungeon("Zul'Farak", "Tanaris", LFGFilter.Factions.BOTH, 41, 44, 51, 54, { "zf", "farr?ak", "zul%W?farr?ak" }) -- must remove "zul", now too many dungeon names colliding
	self:DefineClassicDungeon("Maraudon", "Desolace", LFGFilter.Factions.BOTH, 43, 46, 52, 55, { "mara", "maura%a*", "mara%a*", "m%a+r%a+don" })
	self:DefineClassicDungeon("Temple of Atal'Hakkar", "Swamp of Sorrows", LFGFilter.Factions.BOTH, 47, 50, 57, 60, { "st", "toa", "atal", "hakkar", "sunken", "temple" }, { "aq.*", ".*qiraj" })
	self:DefineClassicDungeon("Blackrock Depths", "Blackrock Mountain", LFGFilter.Factions.BOTH, 50, 52, 60, 60, { "brd", "%a*rock%W*de*pt?h?s?", "imp.*run", "ony.*pre%a*" })
	--table.insert(self.Dungeons["BlackrockDepths"].Tokens, "%Warena%W") -- add this only in Classic, not in TBC. In TBC "arena" is reserved for the Nagrand Arena quests
	self:DefineClassicDungeon("Lower Blackrock Spire", "Blackrock Mountain", LFGFilter.Factions.BOTH, 54, 55, 60, 60, { "lbrs", "lower.*spire" })
	self:DefineClassicDungeon("Upper Blackrock Spire", "Blackrock Mountain", LFGFilter.Factions.BOTH, 55, 55, 60, 60, { "ubrs", "upper.*spire", "urbs", "rend" })
	self:DefineClassicDungeon("Dire Maul East", "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmeast", "dm%We", "dm.*east", "dme", "dire.*east", "jump.*run" })
	self:DefineClassicDungeon("Dire Maul North", "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmnorth", "dm%Wn", "dm.*nor%a*", "dmn", "dire.*north", "tribut%a*" })
	self:DefineClassicDungeon("Dire Maul West", "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmwest", "dm%Ww", "dm.*west", "dmw", "dire.*west" })
	self:DefineClassicDungeon("Stratholme", "Eastern Plaguelands", LFGFilter.Factions.BOTH, 56, 58, 60, 60, { "strat", "strath%a*", "baron", "starth%a*", "straht%a*" })
	self:DefineClassicDungeon("Scholomance", "Western Plaguelands", LFGFilter.Factions.BOTH, 56, 58, 60, 60, { "scholo", "scholo.*" })

	-- Grouping Dungeons
	self:DefineClassicDungeon("Dire Maul", "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, {})
	self:DefineClassicDungeon("The Scarlet Monastery", "Tirisfal", LFGFilter.Factions.BOTH, 23, 26, 42, 45, {})

	-- RAIDS
	-- function LFGFilter:DefineClassicRaid(name, size, location, minlevel, yellow, tokens, antitokens)
	self:DefineClassicRaid("Molten Core", 40, "Blackrock Mountain", 55, 58, { "mc", "molten", "core", "ragnaros" })
	self:DefineClassicRaid("Onyxia's Lair", 40, "Dustwallow Marsh", 55, 58, { "ony", "onyxia" }, { "pre" })
	self:DefineClassicRaid("Blackwing Lair", 40, "Blackrock Mountain", 60, 60, { "bwl", "blackwing", "nefa?r?i?a?n?" })
	self:DefineClassicRaid("Zul Gurub", 20, "Stranglethorn Vale", 60, 60, { "zg", "gurub", "zul%W?gurub" })
	self:DefineClassicRaid("Ruins of Ahn'Qiraj", 20, "Silithus", 60, 60, { "aq20", "aq.20", "ruins.*qiraj", "aq.*ruins", "ossirian" })
	self:DefineClassicRaid("Ahn'Qiraj Temple", 40, "Silithus", 60, 60, { "aq40", "aq.40", "temple.*qiraj", ".*qiraj.*temple", "aq.*temple", "c%W?thun" }, { "bl%a*", "bt" })
	--self:DefineClassicRaid("Naxxramas", 40, "Eastern Plaguelands", 60, 60, { "naxx", "naxx%a*", "k?e?l?%W?thuzad" }) -- removed/updated in WotLK

		-- CUSTOM / QUESTS
	-- function LFGFilter:DefineDungeon(addon, name, size, location, faction, minlevel, yellow, green, maxlevel, herolevel, tokens, antitokens)
	self:DefineDungeon("", "Custom")

end

function LFGFilter:DefineBCCDungeons()

	self.Dungeons = self.Dungeons or { }
	
	-- function LFGFilter:DefineBCDungeon(name, location, minlevel, yellow, green, maxlevel, tokens, antitokens)
	self:DefineBCDungeon("Hellfire Ramparts", "Hellfire Peninsula", 59, 60, 62, 70, { "hr", "ramp.*s", "rampart" })
	self:DefineBCDungeon("Blood Furnace", "Hellfire Peninsula", 60, 61, 63, 70, { "bf", "furnace", "bloo.*f" })
	self:DefineBCDungeon("Slave Pens", "Zangarmarsh", 61, 62, 64, 70, { "sp", "slav%a*", "pens" })
	self:DefineBCDungeon("Underbog", "Zangarmarsh", 62, 63, 65, 70, { "ub", "underb%a*", "bog", "under[bd]og" })
	self:DefineBCDungeon("Manatombs", "Auchindoun", 63, 64, 66, 70, { "mana", "mt", "mana%a*", "tombs?" })
	self:DefineBCDungeon("Auchenai Crypts", "Auchindoun", 64, 65, 67, 70, { "ac", "auchen%a*", "crypts?" })
	self:DefineBCDungeon("Old Hillsbrad Foothills", "Caverns of Time", 65, 66, 68, 70, { "hf", "hillsbra%a*", "foothi%a*", "durnh.*esc%a*", "cot.*1", "durn[holde]*" })
	self:DefineBCDungeon("Sethekk Halls", "Auchindoun", 66, 67, 69, 70, { "sh", "seth%a*", "set%a*halls?", "set%a*ek%a*" })
	self:DefineBCDungeon("Steamvault", "Zangarmarsh", 67, 68, 70, 70, { "sv", "stea%a*vault", "vault" })
	self:DefineBCDungeon("Shadow Labyrinth", "Auchindoun", 68, 69, 70, 70, { "sl", "slabs?", "shadow%a+", "s%a*lab", "sha.*lab%a*", "lab%a*" })
	self:DefineBCDungeon("Black Morass", "Caverns of Time", 68, 70, 70, 70, { "morass", "moras+", "black.*mo%a*", "cot.*2" }) -- changed BM to MORASS, so Beast Masters don't get confused, as BC is not the current addon anymore
	self:DefineBCDungeon("Shattered Halls", "Hellfire Peninsula", 69, 69, 70, 70, { "shh", "shatt%a*halls?", "shatt%a*d", "halls" }, { "seth%a*" })
	self:DefineBCDungeon("Botanica", "Tempest Keep", 70, 70, 70, 70, { "bot", "bota%a*" })
	self:DefineBCDungeon("Mechanar", "Tempest Keep", 70, 70, 70, 70, { "mech", "mec%a*ar", "mecha%a*" })
	self:DefineBCDungeon("Arcatraz", "Tempest Keep", 70, 70, 70, 70, { "arca", "arcat%a*", "a[lrk]a[tr]+a[sz]+" })
	self:DefineBCDungeon("Magister's Terrace", "Sunstrider Isle", 70, 70, 70, 70, { "mat", "ter+ace", "magist%a*" })

	-- function LFGFilter:DefineBCRaid(name, size, location, tokens, antitokens)
	self:DefineBCRaid("Karazhan", 10, "Deadwind Pass", { "kara", "kara[hz]+an" }, { "pre", "preq%a*" })
	self:DefineBCRaid("Gruul's Lair", 25, "Blade's Edge", { "gruul", "gru+ls?" })
	self:DefineBCRaid("Magtheridon's Lair", 25, "Hellfire Peninsula", { "mag", "magt[heridon]+" })
	self:DefineBCRaid("Serpentshrine Cavern", 25, "Zangarmarsh", { "ssc", "serpents[shrine]+" })
	self:DefineBCRaid("Tempest Keep", 25, "Netherstorm", { "tk", "the keep", "tempest" }) -- "the eye" removed, collides with "eye of eternity" (Malygos)
	self:DefineBCRaid("Zul Aman", 10, "Ghostlands", { "za", "bear.*run", "aman" })
	self:DefineBCRaid("Mount Hyjal", 25, "Caverns of Time", { "mh", "hyjal", "cot%W?3" })
	self:DefineBCRaid("Black Temple", 25, "Shadowmoon Valley", { "bt", "illidan", "bl.*temple" }, { "aq.*", ".*qiraj" })
	self:DefineBCRaid("Sunwell Plateau", 25, "Sunstrider Isle", { "sun", "sunw%a*", "plateau" })

end 

function LFGFilter:DefineWotLKDungeons()

	self.Dungeons = self.Dungeons or { }
	
	-- function LFGFilter:DefineWotlkDungeon(name, location, minlevel, yellow, green, maxlevel, tokens, antitokens)
	self:DefineWotlkDungeon("Utgarde Keep", "Howling Fjord", 65, 69, 72, 80, { "uk", "u.*keep" })
	self:DefineWotlkDungeon("The Nexus", "Borean Tundra", 66, 71, 73, 80, { "nex", "nexus", "nex%a*" })
	self:DefineWotlkDungeon("Azjol-Nerub", "Dragonblight", 67, 72, 74, 80, { "azj", "azjo?l", "nerub" })
	self:DefineWotlkDungeon("Ahn'kahet: The Old Kingdom", "Dragonblight", 68, 73, 75, 80, { "ahnk", "ah%a*.?kah%a*", "old%Wkingd%a*" })
	self:DefineWotlkDungeon("Drak'Tharon Keep", "Grizzly Hills", 69, 74, 76, 80, { "dt", "%a*k%W*tharon" })
	self:DefineWotlkDungeon("Violet Hold", "Dalaran", 70, 75, 77, 80, { "vh", "vio%a*", "v%a*%W*hold" })
	self:DefineWotlkDungeon("Gundrak", "", 71, 76, 78, 80, { "gd", "g%a*drak", "gun%Wdrak" })
	self:DefineWotlkDungeon("Halls of Stone", "The Storm Peaks", 72, 77, 79, 80, { "hos", "hall%a*stone" })
	self:DefineWotlkDungeon("Culling of Stratholme", "Tanaris", 75, 79, 80, 80, { "cos", "culling", "cot.*4", "strat", "strath%a*", "starth%a*", "straht%a*", "%a*ganis" })
	self:DefineWotlkDungeon("Utgarde Pinnacle", "Howling Fjord", 77, 79, 80, 80, { "up", "pin+ac[le]*", "ymiron" })
	self:DefineWotlkDungeon("Halls of Lightning", "The Storm Peaks", 75, 79, 80, 80, { "hol", "lightn[ing]*", "loken" })
	self:DefineWotlkDungeon("Oculus", "Borean Tundra", 75, 79, 80, 80, { "oculus", "oc+u[lus]*" })
	--self:DefineWotlkDungeon("Trial of the Champion", "Icecrown", 75, 79, 80, 80, { "toc", "trial", "trail" })
	--self:DefineWotlkDungeon("Pit of Saron", "Icecrown", 79, 80, 80, 80, { "pos", "pit+", "saron" })
	--self:DefineWotlkDungeon("Forge of Souls", "Icecrown", 79, 80, 80, 80, { "fos", "forge", "souls" })
	--self:DefineWotlkDungeon("Halls of Reflection", "Icecrown", 79, 80, 80, 80, { "hor", "reflec[tion]*" })

	-- function LFGFilter:DefineWotlkRaid(name, location, tokens, antitokens)
	self:DefineWotlkRaid("Naxxramas", "Dragonblight", { "naxx", "naxx%a*", "k?e?l?%W?thuzad" })
	self:DefineWotlkRaid("Malygos", "Borean Tundra", { "maly", "mal+y[gos]+", "eye%Wof%Weter[nity]+" })
	self:DefineWotlkRaid("Obsidian Sanctum", "Dragonblight", { "obsi", "sanctum", "obsi%dd?", "obsi.%d" })
	self:DefineWotlkRaid("Vault of Archavon", "Wintergrasp", { "voa", "archa[von]*" })
	--self:DefineWotlkRaid("Ulduar", "The Storm Peaks", { "ulduar" })
	--self:DefineWotlkRaid("Trial of the Crusader", "Icecrown", { })
	--self:DefineWotlkRaid("Icecrown Citadel", "Icecrown", { "icc" })
	--self:DefineWotlkRaid("Ruby Sanctum", "Dragonblight", { "ruby" })
	--self:DefineWotlkRaid("Onyxia's Lair", "Dustwallow Marsh", { "ony", "onyxia" }, { "pre" }) -- not yet active

	self:DefineWotlkDungeon("World Tour", "Northrend", 80, 80, 80, 80, { "tour" })

end