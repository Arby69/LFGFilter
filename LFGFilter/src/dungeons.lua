function LFGFilter:DefineDungeon(name, size, location, faction, minlevel, yellow, green, maxlevel, tokens, antitokens)
	return LFGFilter:DefineHeroDungeon(name, size, location, faction, minlevel, yellow, green, maxlevel, 0, tokens, antitokens)
end

function LFGFilter:DefineHeroDungeon(name, size, location, faction, minlevel, yellow, green, maxlevel, herolevel, tokens, antitokens)
	local lName = self.Locale[name] or name
	local shortname = string.upper(tokens[1] or name)
	local dungeon = {
		Name = name,
		Shortname = shortname,
		LocalizedName = lName,
		Size = size,
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
	end
	return false
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
					if (dungeon.Name == "The Deadmines") then DMKey = key end
					if (dungeon.MinLevel > 40) then ifOver40 = true end
				end
			end
			-- if Deadmines is found, but other dungeons are lvl > 40, most probably Dire Maul was meant!
			if (DMKey and ifOver40) then
				local dungeon = LFGFilter.Dungeons["Dire Maul"]
				result[DMKey] = dungeon
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
	self:DefineDungeon("Ragefire Chasm", 5, "Orgrimmar", LFGFilter.Factions.HORDE, 10, 13, 18, 21, { "rfc", "ragefire", "chasm" })
	self:DefineDungeon("Wailing Caverns", 5, "Barrens", LFGFilter.Factions.BOTH, 12, 15, 20, 25, { "wc", "wailing", "caverns?" })
	self:DefineDungeon("The Deadmines", 5, "Westfall", LFGFilter.Factions.BOTH, 15, 18, 23, 26, { "dm", "mines", "dea[dt]h?mine%a*" }, { "east", "north", "west" })
	self:DefineDungeon("Shadowfang Keep", 5, "Silverpine Forest", LFGFilter.Factions.BOTH, 19, 22, 27, 30, { "sfk", "shadowfang", "%a*fang%W*keep" })
	self:DefineDungeon("The Stockades", 5, "Stormwind", LFGFilter.Factions.ALLIANCE, 21, 24, 29, 32, { "stocks", "stockades?" })
	self:DefineDungeon("Blackfathom Deeps", 5, "Ashenvale", LFGFilter.Factions.BOTH, 21, 24, 29, 32, { "bfd", "blackfath%a*", "fathom", "%a*om%W*deeps?" })
	self:DefineDungeon("Gnomeregan", 5, "Dun Morogh", LFGFilter.Factions.BOTH, 26, 29, 35, 38, { "gnome", "gnomer%a*", "gnomegeran", "gno%a*gan" })
	self:DefineDungeon("Razorfen Kraul", 5, "Barrens", LFGFilter.Factions.BOTH, 27, 30, 37, 40, { "rk", "rfk", "kraul" })
	self:DefineDungeon("The Scarlet Monastery: Graveyard", 5, "Tirisfal Glades", LFGFilter.Factions.BOTH, 23, 26, 33, 45, { "gy", "g%a*yard", "sm%W*gy" })
	self:DefineDungeon("The Scarlet Monastery: Library", 5, "Tirisfal Glades", LFGFilter.Factions.BOTH, 26, 29, 36, 45, { "lib", "library", "sm%W*lib%a*" })
	self:DefineDungeon("The Scarlet Monastery: Armory", 5, "Tirisfal Glades", LFGFilter.Factions.BOTH, 29, 32, 39, 45, { "arm", "armory", "sm%W*arm%a*" })
	self:DefineDungeon("The Scarlet Monastery: Cathedral", 5, "Tirisfal Glades", LFGFilter.Factions.BOTH, 32, 35, 42, 45, { "cath", "cath%a*", "sm%W*cath%a*" })
	self:DefineDungeon("Razorfen Downs", 5, "Barrens", LFGFilter.Factions.BOTH, 37, 40, 47, 50, { "rd", "rfd", "downs", "raz%a*%Wdowns?" })
	self:DefineDungeon("Uldaman", 5, "Badlands", LFGFilter.Factions.BOTH, 39, 42, 49, 52, { "ulda", "ulda%a*" })
	self:DefineDungeon("Zul'Farak", 5, "Tanaris", LFGFilter.Factions.BOTH, 41, 44, 51, 54, { "zf", "farr?ak", "zul%W?farr?ak", "zul" })
	self:DefineDungeon("Maraudon", 5, "Desolace", LFGFilter.Factions.BOTH, 43, 46, 52, 55, { "mara", "maura%a*", "mara%a*", "m%a+r%a+don" })
	self:DefineDungeon("Temple of Atal'Hakkar", 5, "Swamp of Sorrows", LFGFilter.Factions.BOTH, 47, 50, 57, 60, { "st", "toa", "atal", "hakkar", "sunken", "temple" }, { "aq.*", ".*qiraj" })
	self:DefineDungeon("Blackrock Depths", 5, "Blackrock Mountain", LFGFilter.Factions.BOTH, 50, 52, 60, 60, { "brd", "%a*rock%W*de*pt?h?s?", "imp.*run", "ony.*pre%a*" })
	--table.insert(self.Dungeons["BlackrockDepths"].Tokens, "%Warena%W") -- add this only in Classic, not in TBC. In TBC "arena" is reserved for the Nagrand Arena quests
	self:DefineDungeon("Lower Blackrock Spire", 5, "Blackrock Mountain", LFGFilter.Factions.BOTH, 54, 55, 60, 60, { "lbrs", "lower.*spire" })
	self:DefineDungeon("Upper Blackrock Spire", 5, "Blackrock Mountain", LFGFilter.Factions.BOTH, 55, 55, 60, 60, { "ubrs", "upper.*spire", "urbs", "rend" })
	self:DefineDungeon("Dire Maul East", 5, "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmeast", "dm%We", "dm.*east", "dme", "dire.*east", "jump.*run" })
	self:DefineDungeon("Dire Maul North", 5, "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmnorth", "dm%Wn", "dm.*nor%a*", "dmn", "dire.*north", "tribut%a*" })
	self:DefineDungeon("Dire Maul West", 5, "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "dmwest", "dm%Ww", "dm.*west", "dmw", "dire.*west" })
	self:DefineDungeon("Stratholme", 5, "Eastern Plaguelands", LFGFilter.Factions.BOTH, 56, 58, 60, 60, { "strat", "strath%a*", "baron", "starth%a*", "straht%a*" })
	self:DefineDungeon("Scholomance", 5, "Western Plaguelands", LFGFilter.Factions.BOTH, 56, 58, 60, 60, { "scholo", "scholo.*" })

	-- RAIDS
	self:DefineDungeon("Molten Core", 40, "Blackrock Mountain", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "mc", "molten", "core", "ragnaros" })
	self:DefineDungeon("Onyxia's Lair", 40, "Dustwallow Marsh", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "ony", "onyxia" }, { "pre" })
	self:DefineDungeon("Blackwing Lair", 40, "Blackrock Mountain", LFGFilter.Factions.BOTH, 60, 60, 60, 60, { "bwl", "blackwing", "nefa?r?i?a?n?" })
	self:DefineDungeon("Zul Gurub", 20, "Stranglethorn Vale", LFGFilter.Factions.BOTH, 60, 60, 60, 60, { "zg", "gurub", "zul%W?gurub" })
	self:DefineDungeon("Ruins of Ahn'Qiraj", 20, "Silithus", LFGFilter.Factions.BOTH, 60, 60, 60, 60, { "aq20", "aq.20", "ruins.*qiraj", "aq.*ruins", "ossirian" })
	self:DefineDungeon("Ahn'Qiraj Temple", 40, "Silithus", LFGFilter.Factions.BOTH, 60, 60, 60, 60, { "aq40", "aq.40", "temple.*qiraj", ".*qiraj.*temple", "aq.*temple", "c%W?thun" }, { "bl%a*", "bt" })
	--self:DefineDungeon("Naxxramas", 40, "Eastern Plaguelands", LFGFilter.Factions.BOTH, 60, 60, 60, 60, { "naxx", "naxx%a*", "k?e?l?%W?thuzad" })

	-- CUSTOM / QUESTS
	self:DefineDungeon("Custom", 40, "", LFGFilter.Factions.BOTH, 0, 0, 70, 70, {})

	-- Grouping Dungeons
	self:DefineDungeon("Dire Maul", 5, "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, {})
	self:DefineDungeon("The Scarlet Monastery", 5, "Tirisfal", LFGFilter.Factions.BOTH, 23, 26, 42, 45, {})


end

function LFGFilter:DefineBCCDungeons()

	self.Dungeons = self.Dungeons or { }
	
	self:DefineHeroDungeon("Hellfire Ramparts", 5, "Hellfire Peninsula", LFGFilter.Factions.BOTH, 59, 60, 62, 70, 70, { "hr", "ramp.*s", "rampart" })
	self:DefineHeroDungeon("Blood Furnace", 5, "Hellfire Peninsula", LFGFilter.Factions.BOTH, 60, 61, 63, 70, 70, { "bf", "furnace", "bloo.*f" })
	self:DefineHeroDungeon("Slave Pens", 5, "Zangarmarsh", LFGFilter.Factions.BOTH, 61, 62, 64, 70, 70, { "sp", "slav%a*", "pens" })
	self:DefineHeroDungeon("Underbog", 5, "Zangarmarsh", LFGFilter.Factions.BOTH, 62, 63, 65, 70, 70, { "ub", "underb%a*", "bog", "under[bd]og" })
	self:DefineHeroDungeon("Manatombs", 5, "Auchindoun", LFGFilter.Factions.BOTH, 63, 64, 66, 70, 70, { "mana", "mt", "mana%a*", "tombs?" })
	self:DefineHeroDungeon("Auchenai Crypts", 5, "Auchindoun", LFGFilter.Factions.BOTH, 64, 65, 67, 70, 70, { "ac", "auchen%a*", "crypts?" })
	self:DefineHeroDungeon("Old Hillsbrad Foothills", 5, "Caverns of Time", LFGFilter.Factions.BOTH, 65, 66, 68, 70, 70, { "hf", "hillsbra%a*", "foothi%a*", "durnh.*esc%a*", "cot.*1", "durn[holde]*" })
	self:DefineHeroDungeon("Sethekk Halls", 5, "Auchindoun", LFGFilter.Factions.BOTH, 66, 67, 69, 70, 70, { "sh", "seth%a*", "set%a*halls?", "set%a*ek%a*" })
	self:DefineHeroDungeon("Steamvault", 5, "Zangarmarsh", LFGFilter.Factions.BOTH, 67, 68, 70, 70, 70, { "sv", "stea%a*vault", "vault" })
	self:DefineHeroDungeon("Shadow Labyrinth", 5, "Auchindoun", LFGFilter.Factions.BOTH, 68, 69, 70, 70, 70, { "sl", "slabs?", "shadow%a+", "s%a*lab", "sha.*lab%a*", "lab%a*" })
	self:DefineHeroDungeon("Black Morass", 5, "Caverns of Time", LFGFilter.Factions.BOTH, 68, 70, 70, 70, 70, { "bm", "moras+", "black.*mo%a*", "cot.*2" })
	self:DefineHeroDungeon("Shattered Halls", 5, "Hellfire Peninsula", LFGFilter.Factions.BOTH, 69, 69, 70, 70, 70, { "shh", "shatt%a*halls?", "shatt%a*d", "halls" }, { "seth%a*" })
	self:DefineHeroDungeon("Botanica", 5, "Tempest Keep", LFGFilter.Factions.BOTH, 70, 70, 70, 70, 70, { "bot", "bota%a*" })
	self:DefineHeroDungeon("Mechanar", 5, "Tempest Keep", LFGFilter.Factions.BOTH, 70, 70, 70, 70, 70, { "mech", "mec%a*ar", "mecha%a*" })
	self:DefineHeroDungeon("Arcatraz", 5, "Tempest Keep", LFGFilter.Factions.BOTH, 70, 70, 70, 70, 70, { "arca", "arcat%a*", "a[lrk]a[tr]+a[sz]+" })
	self:DefineHeroDungeon("Magister's Terrace", 5, "Sunstrider Isle", LFGFilter.Factions.BOTH, 70, 70, 70, 70, 70, { "mat", "ter+ace", "magist%a*" })

	self:DefineDungeon("Karazhan", 10, "Deadwind Pass", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "kara", "kara[hz]+an" }, { "pre", "preq%a*" })
	self:DefineDungeon("Gruul's Lair", 25, "Blade's Edge", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "gruul" })
	self:DefineDungeon("Magtheridon's Lair", 25, "Hellfire Peninsula", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "mag" })
	self:DefineDungeon("Serpentshrine Cavern", 25, "Zangarmarsh", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "ssc" })
	self:DefineDungeon("Tempest Keep", 25, "Netherstorm", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "tk", "the eye", "the keep" })
	self:DefineDungeon("Zul Aman", 10, "Ghostlands", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "za", "bear.*run" })
	self:DefineDungeon("Mount Hyjal", 25, "Caverns of Time", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "mh", "hyjal" })
	self:DefineDungeon("Black Temple", 25, "Shadowmoon Valley", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "bt", "illidan", "bl.*temple" }, { "aq.*", ".*qiraj" })
	self:DefineDungeon("Sunwell Plateau", 25, "Sunstrider Isle", LFGFilter.Factions.BOTH, 70, 70, 70, 70, { "sun", "sunw%a*", "plateau" })

end 

function LFGFilter:DefineWotLKDungeons()

	self.Dungeons = self.Dungeons or { }
	
	self:DefineHeroDungeon("Utgarde Keep", 5, "Howling Fjord", LFGFilter.Factions.BOTH, 65, 69, 72, 80, 80, { "uk", "u.*keep" })
	self:DefineHeroDungeon("The Nexus", 5, "Borean Tundra", LFGFilter.Factions.BOTH, 66, 71, 73, 80, 80, { "nex", "nexus", "nex%a*" })
	self:DefineHeroDungeon("Azjol-Nerub", 5, "Dragonblight", LFGFilter.Factions.BOTH, 67, 72, 74, 80, 80, { "an", "azjol", "nerub" })
	self:DefineHeroDungeon("Ahn'kahet: The Old Kingdom", 5, "Dragonblight", LFGFilter.Factions.BOTH, 68, 73, 75, 80, 80, { "ak", "ah%a*.?kah%a*", "ahnk", "old%Wkingd%a*" })
	self:DefineHeroDungeon("Drak'Tharon Keep", 5, "Grizzly Hills", LFGFilter.Factions.BOTH, 69, 74, 76, 80, 80, { "dt", "%a*k%W*tharon" })
	self:DefineHeroDungeon("The Violet Hold", 5, "Dalaran", LFGFilter.Factions.BOTH, 70, 75, 77, 80, 80, { "vh", "v%a*%W*hold" })
	self:DefineHeroDungeon("Gundrak", 5, "", LFGFilter.Factions.BOTH, 71, 76, 78, 80, 80, { "gd", "g%a*drak", "gun%Wdrak" })
	self:DefineHeroDungeon("Halls of Stone", 5, "The Storm Peaks", LFGFilter.Factions.BOTH, 72, 77, 79, 80, 80, { "hos", "hall%a*stone" })
	self:DefineHeroDungeon("The Culling of Stratholme", 5, "Tanaris", LFGFilter.Factions.BOTH, 75, 79, 80, 80, 80, { "cos", "cot.*4", "strat", "strath%a*", "starth%a*", "straht%a*", "%a*ganis" })
	self:DefineHeroDungeon("Utgarde Pinnacle", 5, "Howling Fjord", LFGFilter.Factions.BOTH, 77, 79, 80, 80, 80, { "up", "pin+ac[le]*", "ymiron" })
	self:DefineHeroDungeon("Halls of Lightning", 5, "The Storm Peaks", LFGFilter.Factions.BOTH, 75, 79, 80, 80, 80, { "hol", "lightn[ing]*", "loken" })
	self:DefineHeroDungeon("The Oculus", 5, "Borean Tundra", LFGFilter.Factions.BOTH, 75, 79, 80, 80, 80, { "oculus", "ocu[lus]*" })
	self:DefineHeroDungeon("Trial of the Champion", 5, "Icecrown", LFGFilter.Factions.BOTH, 75, 79, 80, 80, 80, { "toc", "trial", "trail" })
	self:DefineHeroDungeon("Pit of Saron", 5, "Icecrown", LFGFilter.Factions.BOTH, 80, 80, 80, 80, 80, { "pos", "pit+", "saron" })
	self:DefineHeroDungeon("The Forge of Souls", 5, "Icecrown", LFGFilter.Factions.BOTH, 80, 80, 80, 80, 80, { "fos", "forge", "souls" })
	self:DefineHeroDungeon("Halls of Reflection", 5, "Icecrown", LFGFilter.Factions.BOTH, 80, 80, 80, 80, 80, { "hor", "reflec[tion]*" })

	self:DefineDungeon("Naxxramas", 25, "Dragonblight", LFGFilter.Factions.BOTH, 80, 80, 80, 80, { "naxx", "naxx%a*", "k?e?l?%W?thuzad" })
	self:DefineDungeon("Malygos", 25, "Borean Tundra", LFGFilter.Factions.BOTH, 80, 80, 80, 80, { "maly", "maly[gos]+", "eye%Wof%Weter[nity]+" })
	self:DefineDungeon("The Obsidian Sanctum", 25, "Dragonblight", LFGFilter.Factions.BOTH, 80, 80, 80, 80, { "obsi", "sanctum", "obsi%dd?", "obsi.%d" })
	self:DefineDungeon("Vault of Archavon", 25, "Wintergrasp", LFGFilter.Factions.BOTH, 80, 80, 80, 80, { "voa", "archa[von]*" })
	
end