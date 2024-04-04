local L = _G.LibStub("AceLocale-3.0"):NewLocale("LFGFilter", "deDE")

if (L) then
	L["Select Dungeon"] = "Dungeon auswählen"

	-- Bei den Dungeon-Tokens darf davon ausgegangen werden, dass mit ihnen ein PATTERN-MATCHING
	-- durchgeführt wird, d.h. LUA Matching Patterns sind erlaubt. Man sollte davon ausgehen,
	-- dass alle angegebenen Kürzel als "abgeschlossenes Wort" gematcht werden, d.h. vor dem Testen
	-- werden vorne und hinten ein "%W" angefügt (%W = alles außer Buchstaben und Ziffern), um
	-- Wortanfang und -ende zu gewährleisten. Und ja: Auch Anfang und Ende der Chatzeile werden
	-- berücksichtigt (keine Bange)

	L["Ragefire Chasm"] = "Flammenschlund"
	L["RFC-Tokens"] = { "fs", "flammenschlund", "rfa" }

	L["Wailing Caverns"] = "Höhlen des Wehklagens"
	L["WC-Tokens"] = { "hdw", "wehklagens?" }

	L["The Deadmines"] = "Die Todesminen"
	L["DM-Tokens"] = { "tm", "to[dt]esmie?nen?" }
	L["DM-AntiTokens"] = { "ost", "nord" }

	L["Shadowfang Keep"] = "Burg Schattenfang"
	L["SFK-Tokens"] = { "bsf", "schattenfang" }

	L["Blackfathom Deeps"] = "Tiefschwarze Grotte"
	L["BFD-Tokens"] = { "bft", "tsg", "grott?e", "tiefschwarz%a+" }

	L["The Stockades"] = "Das Verlies"
	L["STOCKS-Tokens"] = { "verlie?ss?", "verließ" } -- er verließ sich darauf, dass er trotz Rechtschreibschwäche ins Verlies mitgenommen würde

	L["Gnomeregan"] = "Gnomeregan"
	L["GNOME-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Razorfen Kraul"] = "Kral der Klingenhauer"
	L["RK-Tokens"] = { "kral", "kdk" }

	L["The Scarlet Monastery"] = "Scharlachrotes Kloster"
	L["SM-Tokens"] = { "kloster", "scharlachrotes" }

	L["The Scarlet Monastery: Graveyard"] = "Scharlachrotes Kloster: Friedhof"
	L["GY-Tokens"] = { "fh", "friedhof" }

	L["The Scarlet Monastery: Library"] = "Scharlachrotes Kloster: Bibliothek"
	L["LIB-Tokens"] = { "bib", "bibi", "bibliothek", "biblio?" }

	L["The Scarlet Monastery: Armory"] = "Scharlachrotes Kloster: Waffenkammer"
	L["ARM-Tokens"] = { "wk", "waffenkammer", "waffelkammer" } -- das mit L hab ich schon gesehen, ich fand's witzig

	L["The Scarlet Monastery: Cathedral"] = "Scharlachrotes Kloster: Kathedrale"
	L["CATH-Tokens"] = { "kath", "kathe%a*", "kat", "kahte%a*" }

	L["Razorfen Downs"] = "Hügel der Klingenhauer"
	L["RD-Tokens"] = { "huegel", "hdk" }
	L["RD-AntiTokens"] = { "schlingen.*" } 

	L["Uldaman"] = "Uldaman"
	L["ULDA-Tokens"] = { } -- man könnte Ulduar eintragen, ich hab das schon im Chat gelesen, aber ich lass das mal^^

	L["Zul'Farak"] = "Zul'Farak"
	L["ZF-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Maraudon"] = "Maraudon"
	L["MARA-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Temple of Atal'Hakkar"] = "Tempel von Atal'Hakkar"
	L["TEMPLE-Tokens"] = { "vt", "versunkener", "tempel" }

	L["Blackrock Depths"] = "Schwarzfelstiefen"
	L["BRD-Tokens"] = { "brt", "sft", "blackr.*tiefen" }

	L["Lower Blackrock Spire"] = "Untere Schwarzfelsspitze"
	L["LBRS-Tokens"] = { "untere.*spitze" }

	L["Upper Blackrock Spire"] = "Obere Schwarzfelsspitze"
	L["UBRS-Tokens"] = { "obere.*spitze" }

	L["Stratholme"] = "Stratholme"
	L["STRAT-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Scholomance"] = "Scholomance"
	L["SCHOLO-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Dire Maul"] = "Düsterbruch"
	L["DIREMAUL-Tokens"] = {}

	L["Dire Maul East"] = "Düsterbruch Ost"
	L["DMEAST-Tokens"] = { "db.*ost", "due?st.*ost", "dm.*ost", "dire.*ost" }

	L["Dire Maul West"] = "Düsterbruch West"
	L["DMWEST-Tokens"] = { "db.*west", "due?st.*west" }

	L["Dire Maul North"] = "Düsterbruch Nord"
	L["DMNORTH-Tokens"] = { "db.*nord", "due?st.*nord", "dm.*nord", "dire.*nord" }

	L["Molten Core"] = "Geschmolzener Kern"
	L["MC-Tokens"] = { "geschmolzener", "kern" }

	L["Onyxia's Lair"] = "Onyxias Hort"
	L["ONY-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Blackwing Lair"] = "Pechschwingenhort"
	L["BWL-Tokens"] = { "psh", "pechschw%a*", "pech%a+hort" }

	L["Zul'Gurub"] = "Zul'Gurub"
	L["ZG-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Temple of Ahn'Qiraj"] = "Tempel von Ahn'Qiraj"
	L["AQ40-Tokens"] = { "aq%W*tempel", "tempel.*aq", "tempel.*qiraj", "tempel.*%Waq" }

	L["Ruins of Ahn'Qiraj"] = "Ruinen von Ahn'Qiraj"
	L["AQ20-Tokens"] = { "aq%W*ruinen", "ruinen", "ruin.*qiraj", "ruin.*%Waq" }

	L["Naxxramas"] = "Naxxramas"
	L["NAXX-Tokens"] = { } -- keine besonderen deutschen Kürzel

	L["Nightmare Incursion"] = "Albtraum-Überfall"
	L["NIGHTMARE-Tokens"] = { "al[bp]traum" }

	--------------------------------------------- BCC ----------------------------------------------
	
	L["Hellfire Ramparts"] = "Höllenfeuerbollwerk"
	L["HR-Tokens"] = { "bw", "%a*bol%a*werk", "bwk" }
	
	L["Blood Furnace"] = "Blutkessel"
	L["BF-Tokens"] = { "bk", "kessel", "blut.*kess%a*" }

	L["Slave Pens"] = "Sklavenunterkünfte"
	L["SP-Tokens"] = { "sk[la]+ven%a*", "unterku%a+" }

	L["Underbog"] = "Tiefensumpf"
	L["UB-Tokens"] = { "tief%a*sum[pf]+", "sumpf", "tiefen" }
	L["UB-AntiTokens"] = { "blackr%a*", "schwarzf%a*" }
	
	L["Manatombs"] = "Managruft"
	L["MANA-Tokens"] = { "mg", "gruft", "man.*gr%a*", "mana" }

	L["Auchenai Crypts"] = "Auchenaikrypta"
	L["AC-Tokens"] = { "%a*krypta?", "auche%a*", "crypta?" } 

	L["Old Hillsbrad Foothills"] = "Vorgebirge des alten Hügellands"
	L["HF-Tokens"] = { "hdz%W*1", "alt.*huegell%a*", "zeit.*1" }
	L["HF-AntiTokens"] = { "hdz.*2" }

	L["Sethekk Halls"] = "Sethekkhallen"
	L["SH-Tokens"] = { "sethekk", "set%a*[%-]?hall%a*", "se%a*ek+" }

	L["Steamvault"] = "Dampfkammer"
	L["SV-Tokens"] = { "dampf%a*", "d[mapf]+k[ame]+r" } -- removed "dk" as it is now used for Death Knights

	L["Shadow Labyrinth"] = "Schattenlabyrinth"
	L["SL-Tokens"] = { "schlab%a*", "schattenl%a*", "schlap+[iy]e?" }

	L["Shattered Halls"] = "Zerschmetterte Hallen"
	L["SHH-Tokens"] = { "zh", "zersch.*hallen?", "a%schmet.*hallen?", "hallen" }
	L["SHH-AntiTokens"] = { "set%a*", "blitz%a*", "stein%a*" }

	L["Black Morass"] = "Der Schwarze Morast"
	L["MORASS-Tokens"] = { "mor+ast", "hdz.*2", "zeit.*2" }

	L["Botanica"] = "Botanica"
	L["BOT-Tokens"] = { }

	L["Mechanar"] = "Mechanar"
	L["MECH-Tokens"] = {}

	L["Arcatraz"] = "Arkatraz"
	L["ARCA-Tokens"] = { "arka", "a[lrk]+atrat?[sz]+" }

	L["Magister's Terrace"] = "Terrasse der Magister"
	L["MAT-Tokens"] = { "ter+as+e", "magister", "tdm" }

	L["Karazhan"] = "Karazhan"
	L["KARA-Tokens"] = { }

	L["Gruul's Lair"] = "Gruuls Unterschlupf"
	L["GRUUL-Tokens"] = { "unterschlu%a*" }

	L["Magtheridon's Lair"] = "Magtheridons Kammer"
	L["MAG-Tokens"] = { "magt%a*" }
	L["MAG-AntiTokens"] = { "mag" } -- german word often used in chat, but not for Magtheridon

	L["Serpentshrine Cavern"] = "Höhle des Schlangenschreins"
	L["SSC-Tokens"] = { "schlangenschrein", "schlang%a*", "vashj", "hoehl.*%Wd.*schlangensc%a*" }

	L["Tempest Keep"] = "Festung der Stürme"
	L["TK-Tokens"] = { "fds", "fest.*%Wd.*stue?r%a*", "stuerme" }

	L["Zul Aman"] = "Zul Aman"
	L["ZA-Tokens"] = { "baer.*run" }

	L["Mount Hyjal"] = "Hyjalgipfel"
	L["MH-Tokens"] = { "hyjal", "archim%a*" }

	L["Black Temple"] = "Der Schwarze Tempel"
	L["BT-Tokens"] = { "schwar.*temp%a*" }

	L["Sunwell Plateau"] = "Sonnenbrunnenplateau"
	L["SUN-Tokens"] = { "%a*jaeden", "sonnenbr%a*" }

  ----------------------------------------------------------------------
  -- Wrath of the Lich King

  L["Utgarde Keep"] = "Burg Utgarde"
  L["UK-Tokens"] = { "burg", "bu", "bu%a+%Wutg[arde]*" }
	L["UK-AntiTokens"] = { "schattena%*" }
  
  L["The Nexus"] = "Der Nexus"
  L["NEX-Tokens"] = {}

  L["Azjol-Nerub"] = "Azjol-Nerub"
  L["AZJ-Tokens"] = {}

  L["Ahn'kahet: The Old Kingdom"] = "Ahn'kahet: Das alte Königreich"
  L["AHNK-Tokens"] = {}

  L["Drak'Tharon Keep"] = "Feste Drak'Tharon"
  L["DT-Tokens"] = { "feste" }
	L["DT-AntiTokens"] = { "vio%a*" } -- welcher Idiot schreibt "Violette Feste"? seufz...

  L["Violet Hold"] = "Violette Festung"
  L["VH-Tokens"] = { "viol*.fest%a*", "vf" }

  L["Gundrak"] = "Gundrak"
  L["GD-Tokens"] = {}

  L["Halls of Stone"] = "Hallen des Steins"
  L["HOS-Tokens"] = { "hds", "hall.*stein%a*" }

  L["Culling of Stratholme"] = "Das Ausmerzen von Stratholme"
  L["COS-Tokens"] = { "ausmerz%a*", "hdz.*4", "zeit.*4" }

  L["Utgarde Pinnacle"] = "Turm Utgarde"
  L["UP-Tokens"] = { "turm", "tu",  "tu%a+%Wutg[arde]*" }
	--L["UP-AntiTokens"] = { "burg" }

  L["Halls of Lightning"] = "Hallen der Blitze"
  L["HOL-Tokens"] = { "hdb", "hall.*blitz%a*", "blitze" }

  L["Oculus"] = "Der Oculus"
  L["OCU-Tokens"] = {}

  L["Trial of the Champion"] = "Prüfung des Champions"
  L["TOC-Tokens"] = { "pdc", "prüf[%wungdes]+cha[mpions]+" }

  L["Pit of Saron"] = "Grube von Saron"
  L["POS-Tokens"] = { "gvs", "grube" }

  L["Forge of Souls"] = "Die Seelenschmiede"
  L["FOS-Tokens"] = { "ss", "seelens%a*" }

  L["Halls of Reflection"] = "Hallen der Reflexion"
  L["HOR-Tokens"] = { "hdr", "halle.*reflex%a*" }

	L["World Tour"] = "World Tour"
	L["TOUR-Tokens"] = {}

	L["Daily"] = "Daily"
	L["DAILY-Tokens"] = { "tägl[iche]+" }

  -- Raids 

  -- L["Naxxramas"] = "Naxxramas" -- already defined in Classic section
  -- L["NAXX-Tokens"] = { }

  L["Malygos"] = "Malygos"
  L["MALY-Tokens"] = { "auge", "aug.*ewig?keit" }

  L["Obsidian Sanctum"] = "Das Obsidiansanktum"
  L["OBSI-Tokens"] = { "obsi10[er]*", "obsi25[er]*" }

  L["Vault of Archavon"] = "Archavons Kammer"
  L["VOA-Tokens"] = { "ak", "arch%a*von.*kammer", "archa[vons]*" }

  L["Ulduar"] = "Ulduar"
  L["ULDUAR-Tokens"] = {}

	L["Trial of the Crusader"] = "Prüfung des Kreuzfahrers"
	L["TOCR-Tokens"] = { "pdk", "pdok", "pd[%(o%)]+k", "prü[%Wfungdesobrtn]+kreuz[fahres]+", "pdo?k25%a*", "pdo?k10%a*" }

	L["Icecrown Citadel"] = "Eiskronenzitadelle"
	L["ICC-Tokens"] = {}

  --L[""] = ""
  --L["-Tokens"] = {}

	------------------------------------------------------------------------------------------------
	
	-- Arenas

	L["Nagrand Arena"] = "Nagrand Arena"
	L["NAGRANDARENA-Tokens"] = {}

	L["Zul'Drak Arena"] = "Zul'Drak Arena"
	L["ZULDRAKARENA-Tokens"] = {}

	------------------------------------------------------------------------------------------------

	L["Custom"] = "Benutzerdefiniert"

	L["RoleKeywords"] = {
		"dd",
		"dds",
		"heiler",
		"schaden",
	}

	L["LFMKeywords"] = {
		"dann go",
	}

	L["LFGKeywords"] = {
		--"gruppe",
	}

	L["NoDungeons"] = {
		"kaufe",
		"rekru.*",
		"raidzeit%a*",
		"verkaufe",
		"gilde",
		"tausche",
		"rezept%a*",
	}

	L["HeroTags"] = {
		"heroisch",
		"pdok%s*",
	}
	
	L["HeroPlusTags"] = {}
	
	L["HeroBetaTags"] = {}
	
	L["HeroGammaTags"] = {}
	
	L["NonHeroTags"] = {}

	L["PvP"] = {}

	L["StopWords"] = {
		"voll danke",
		"danke voll",
	}
end