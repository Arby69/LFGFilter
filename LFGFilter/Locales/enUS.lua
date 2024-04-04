local L = _G.LibStub("AceLocale-3.0"):NewLocale("LFGFilter", "enUS", true, true)

if L then
  L["Select Dungeon"] = "Select Dungeon"	

  -- Using Dungeon Tokens, you can assume them being used for LUA pattern matching.
  -- That means, matching patterns are allowed. You should consider all tokens are
  -- surrounded by word boundings ("%W" = all but alphanumeric chars), to ensure
  -- found tokens are words for itself.
  -- (Yes, beginning and ending of the chat line are taken into consideration!)

  L["Ragefire Chasm"] = "Ragefire Chasm"
  L["RFC-Tokens"] = { }

  L["Wailing Caverns"] = "Wailing Caverns"
  L["WC-Tokens"] = { }

  L["The Deadmines"] = "The Deadmines"
  L["DM-Tokens"] = { }
    
  L["Shadowfang Keep"] = "Shadowfang Keep"
  L["SFK-Tokens"] = { }

  L["Blackfathom Deeps"] = "Blackfathom Deeps"
  L["BFD-Tokens"] = { }

  L["The Stockades"] = "The Stockades"
  L["STOCKS-Tokens"] = { }

  L["Gnomeregan"] = "Gnomeregan"
  L["GNOME-Tokens"] = { } 

  L["Razorfen Kraul"] = "Razorfen Kraul"
  L["RK-Tokens"] = { }

  L["The Scarlet Monastery"] = "The Scarlet Monastery"
  L["SM-Tokens"] = { }

  L["The Scarlet Monastery: Graveyard"] = "The Scarlet Monastery: Graveyard"
  L["GY-Tokens"] = { }

  L["The Scarlet Monastery: Library"] = "The Scarlet Monastery: Library"
  L["LIB-Tokens"] = { }

  L["The Scarlet Monastery: Armory"] = "The Scarlet Monastery: Armory"
  L["ARM-Tokens"] = { }

  L["The Scarlet Monastery: Cathedral"] = "The Scarlet Monastery: Cathedral"
  L["CATH-Tokens"] = { }

  L["Razorfen Downs"] = "Razorfen Downs"
  L["RD-Tokens"] = { }

  L["Uldaman"] = "Uldaman"
  L["ULDA-Tokens"] = { }

  L["Zul'Farak"] = "Zul'Farak"
  L["ZF-Tokens"] = { }

  L["Maraudon"] = "Maraudon"
  L["MARA-Tokens"] = { }

  L["Temple of Atal'Hakkar"] = "Temple of Atal'Hakkar"
  L["TEMPLE-Tokens"] = { }

  L["Blackrock Depths"] = "Blackrock Depths"
  L["BRD-Tokens"] = { }

  L["Lower Blackrock Spire"] = "Lower Blackrock Spire"
  L["LBRS-Tokens"] = { }

  L["Upper Blackrock Spire"] = "Upper Blackrock Spire"
  L["UBRS-Tokens"] = { }

  L["Stratholme"] = "Stratholme"
  L["STRAT-Tokens"] = { }

  L["Scholomance"] = "Scholomance"
  L["SCHOLO-Tokens"] = { }

  L["Dire Maul"] = "Dire Maul"
  L["DIREMAUL-Tokens"] = { }

  L["Dire Maul East"] = "Dire Maul East"
  L["DMEAST-Tokens"] = { }

  L["Dire Maul West"] = "Dire Maul West"
  L["DMWEST-Tokens"] = { }

  L["Dire Maul North"] = "Dire Maul North"
  L["DMNORTH-Tokens"] = { }

  L["Molten Core"] = "Molten Core"
  L["MC-Tokens"] = { }

  L["Onyxia's Lair"] = "Onyxia's Lair"
  L["ONY-Tokens"] = { }

  L["Blackwing Lair"] = "Blackwing Lair"
  L["BWL-Tokens"] = { }

  L["Zul'Gurub"] = "Zul'Gurub"
  L["ZG-Tokens"] = { }

  L["Ahn'Qiraj Temple"] = "Ahn'Qiraj Temple"
  L["AQ40-Tokens"] = { }

  L["Ruins of Ahn'Qiraj"] = "Ruins of Ahn'Qiraj"
  L["AQ20-Tokens"] = { }

  L["Naxxramas"] = "Naxxramas"
  L["NAXX-Tokens"] = { }

  ----------------------------------------------------------------------
  -- Burning Crusade

  L["Hellfire Ramparts"] = "Hellfire Ramparts"
  L["HR-Tokens"] = {}

  L["Blood Furnace"] = "Blood Furnace"
  L["BF-Tokens"] = {}

  L["Slave Pens"] = "Slave Pens"
  L["SP-Tokens"] = {}

  L["Underbog"] = "Underbog"
  L["UB-Tokens"] = {}

  L["Manatombs"] = "Manatombs"
  L["MANA-Tokens"] = {}

  L["Auchenai Crypts"] = "Auchenai Crypts"
  L["AC-Tokens"] = {}

  L["Old Hillsbrad Foothills"] = "Old Hillsbrad Foothills"
  L["HF-Tokens"] = {}

  L["Sethekk Halls"] = "Sethekk Halls"
  L["SH-Tokens"] = {}

  L["Steamvault"] = "Steamvault"
  L["SV-Tokens"] = {}

  L["Shadow Labyrinth"] = "Shadow Labyrinth"
  L["SL-Tokens"] = {}

  L["Shattered Halls"] = "Shattered Halls"
  L["SHH-Tokens"] = {}

  L["Black Morass"] = "Black Morass"
  L["MORASS-Tokens"] = {}

  L["Botanica"] = "Botanica"
  L["BOT-Tokens"] = {}

  L["Mechanar"] = "Mechanar"
  L["MECH-Tokens"] = {}

  L["Arcatraz"] = "Arcatraz"
  L["ARCA-Tokens"] = {}

  L["Magister's Terrace"] = "Magister's Terrace"
  L["MAT-Tokens"] = {}

  L["Karazhan"] = "Karazhan"
  L["KARA-Tokens"] = {}

  L["Gruul's Lair"] = "Gruul's Lair"
  L["GRUUL-Tokens"] = {}

  L["Magtheridon's Lair"] = "Magtheridon's Lair"
  L["MAG-Tokens"] = {}

  L["Serpentshrine Cavern"] = "Serpentshrine Cavern"
  L["SSC-Tokens"] = {}

  L["Tempest Keep"] = "Tempest Keep"
  L["TK-Tokens"] = {}

  L["Zul Aman"] = "Zul Aman"
  L["ZA-Tokens"] = {}

  L["Mount Hyjal"] = "Mount Hyjal"
  L["MH-Tokens"] = {}

  L["Black Temple"] = "Black Temple"
  L["BT-Tokens"] = {}

  L["Sunwell Plateau"] = "Sunwell Plateau"
  L["SUN-Tokens"] = {}

  ----------------------------------------------------------------------
  -- Wrath of the Lich King

  L["Utgarde Keep"] = "Utgarde Keep"
  L["UK-Tokens"] = {}
  
  L["The Nexus"] = "The Nexus"
  L["NEX-Tokens"] = {}

  L["Azjol-Nerub"] = "Azjol-Nerub"
  L["AZJ-Tokens"] = {}

  L["Ahn'kahet: The Old Kingdom"] = "Ahn'kahet: The Old Kingdom"
  L["AHNK-Tokens"] = {}

  L["Drak'Tharon Keep"] = "Drak'Tharon Keep"
  L["DT-Tokens"] = {}

  L["Violet Hold"] = "Violet Hold"
  L["VH-Tokens"] = {}

  L["Gundrak"] = "Gundrak"
  L["GD-Tokens"] = {}

  L["Halls of Stone"] = "Halls of Stone"
  L["HOS-Tokens"] = {}

  L["Culling of Stratholme"] = "Culling of Stratholme"
  L["COS-Tokens"] = {}

  L["Utgarde Pinnacle"] = "Utgarde Pinnacle"
  L["UP-Tokens"] = {}

  L["Halls of Lightning"] = "Halls of Lightning"
  L["HOL-Tokens"] = {}

  L["Oculus"] = "Oculus"
  L["OCU-Tokens"] = {}

  L["Trial of the Champion"] = "Trial of the Champion"
  L["TOC-Tokens"] = {}

  L["Pit of Saron"] = "Pit of Saron"
  L["POS-Tokens"] = {}

  L["Forge of Souls"] = "Forge of Souls"
  L["FOS-Tokens"] = {}

  L["Halls of Reflection"] = "Halls of Reflection"
  L["HOR-Tokens"] = {}

  L["World Tour"] = "World Tour"
  L["TOUR-Tokens"] = {}

  L["Daily"] = "Daily"
  L["DAILY-Tokens"] = {}

  -- Raids 

  -- L["Naxxramas"] = "Naxxramas" -- already defined in Classic section
  -- L["NAXX-Tokens"] = { }

  L["Malygos"] = "Malygos"
  L["MALY-Tokens"] = {}

  L["Obsidian Sanctum"] = "The Obsidian Sanctum"
  L["OBSI-Tokens"] = {}

  L["Vault of Archavon"] = "Vault of Archavon"
  L["VOA-Tokens"] = {}

  L["Ulduar"] = "Ulduar"
  L["ULDUAR-Tokens"] = {}

  L["Trial of the Crusader"] = "Trial of the Crusader"
	L["TOCR-Tokens"] = {}

  L["Icecrown Citadel"] = "Icecrown Citadel"
	L["ICC-Tokens"] = {}

  --L[""] = ""
  --L["-Tokens"] = {}

  ------------------------------------------------------------------------------------------------
	
  -- Arenas

  L["Nagrand Arena"] = "Nagrand Arena"
  L["NAGRANDARENA-Tokens"] = {}

  L["Zul'Drak Arena"] = "Zul'Drak Arena"
  L["ZULDRAKARENA-Tokens"] = {}

  ----------------------------------------------------------------------

  L["Custom"] = "Custom"
  L["RoleKeywords"] = { }
  L["LFMKeywords"] = { }
  L["LFGKeywords"] = { }
  L["NoDungeons"] = { }
  L["StopWords"] = { }
  L["HeroTags"] = { }
  L["HeroPlusTags"] = { }
  L["NonHeroTags"] = { }
  L["HeroBetaTags"] = {}
  L["HeroGammaTags"] = {}
  L["PvP"] = {}

end