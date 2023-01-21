function LFGFilter:DefineDungeons()

	self.Dungeons = self.Dungeons or { }

	-------------------------------------------------------------------------------------------------------------------
	-- Classic (Vanilla)
	-------------------------------------------------------------------------------------------------------------------

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
	self:DefineClassicDungeon("Dire Maul", "Feralas", LFGFilter.Factions.BOTH, 55, 58, 60, 60, { "diremaul" })
	self:DefineClassicDungeon("The Scarlet Monastery", "Tirisfal", LFGFilter.Factions.BOTH, 23, 26, 42, 45, { "monastery" })

	-- RAIDS
	-- function LFGFilter:DefineClassicRaid(name, size, location, minlevel, yellow, tokens, antitokens)
	self:DefineClassicRaid("Molten Core", 40, "Blackrock Mountain", 55, 58, { "mc", "molten", "core", "ragnaros" })
	self:DefineClassicRaid("Onyxia's Lair", 40, "Dustwallow Marsh", 55, 58, { "ony", "onyxia" }, { "pre" })
	self:DefineClassicRaid("Blackwing Lair", 40, "Blackrock Mountain", 60, 60, { "bwl", "blackwing", "nefa?r?i?a?n?" })
	self:DefineClassicRaid("Zul Gurub", 20, "Stranglethorn Vale", 60, 60, { "zg", "gurub", "zul%W?gurub" })
	self:DefineClassicRaid("Ruins of Ahn'Qiraj", 20, "Silithus", 60, 60, { "aq20", "aq.20", "ruins.*qiraj", "aq.*ruins", "ossirian" })
	self:DefineClassicRaid("Ahn'Qiraj Temple", 40, "Silithus", 60, 60, { "aq40", "aq.40", "temple.*qiraj", ".*qiraj.*temple", "aq.*temple", "c%W?thun" }, { "bl%a*", "bt" })
	self:DefineClassicRaid("Naxxramas", 40, "Eastern Plaguelands", 60, 60, { "naxx", "naxx%a*", "k?e?l?%W?thuzad" }) -- removed/updated in WotLK

	-------------------------------------------------------------------------------------------------------------------
	-- Burning Crusade (TBC)
	-------------------------------------------------------------------------------------------------------------------

	-- function LFGFilter:DefineBCDungeon(name, location, minlevel, yellow, green, maxlevel, tokens, antitokens)
	self:DefineBCDungeon("Hellfire Ramparts", "Hellfire Peninsula", 59, 60, 62, 70, { "hr", "ramp.*s", "rampart" })
	self:DefineBCDungeon("Blood Furnace", "Hellfire Peninsula", 60, 61, 63, 70, { "bf", "furnace", "bloo.*f" })
	self:DefineBCDungeon("Slave Pens", "Zangarmarsh", 61, 62, 64, 70, { "sp", "slav%a*", "pens" })
	self:DefineBCDungeon("Underbog", "Zangarmarsh", 62, 63, 65, 70, { "ub", "underb%a*", "bog", "under[bd]og" })
	self:DefineBCDungeon("Manatombs", "Auchindoun", 63, 64, 66, 70, { "mana", "mt", "mana%a*", "tombs?" })
	self:DefineBCDungeon("Auchenai Crypts", "Auchindoun", 64, 65, 67, 70, { "ac", "auchen%a*", "crypts?" })
	self:DefineBCDungeon("Old Hillsbrad Foothills", "Caverns of Time", 65, 66, 68, 70, { "hf", "hillsbra%a*", "foothi%a*", "durnh.*esc%a*", "cot.*1", "durn[holde]*" })
	self:DefineBCDungeon("Sethekk Halls", "Auchindoun", 66, 67, 69, 70, { "sh", "seth%a*", "set%a*halls?", "set%a*ek%a*" }, { "shatt%a*", "ston%a*", "light%a*" })
	self:DefineBCDungeon("Steamvault", "Zangarmarsh", 67, 68, 70, 70, { "sv", "stea%a*vault", "vault" })
	self:DefineBCDungeon("Shadow Labyrinth", "Auchindoun", 68, 69, 70, 70, { "sl", "slabs?", "shadow%a+", "s%a*lab", "sha.*lab%a*", "lab%a*" })
	self:DefineBCDungeon("Black Morass", "Caverns of Time", 68, 70, 70, 70, { "morass", "moras+", "black.*mor+a%a*", "cot.*2" }) -- changed BM to MORASS, so Beast Masters don't get confused, as BC is not the current addon anymore
	self:DefineBCDungeon("Shattered Halls", "Hellfire Peninsula", 69, 69, 70, 70, { "shh", "shatt%a*halls?", "shatt%a*d", "halls" }, { "seth%a*", "light%a*", "ston%a*" })
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

	-- PvP
	self:DefineBCDungeon("PvP", "", 80, 80, 80, 80, { "pvp", "2vs?2", "3vs?3", "5vs?5", "2on?2", "3on?3", "5on?5", "2s", "3s", "5s" })

end