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
	L["ST-Tokens"] = { "vt", "versunkener", "tempel" }

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

	--------------------------------------------- BCC ----------------------------------------------
	
	L["Hellfire Ramparts"] = "Höllenfeuerbollwerk"
	L["HR-Tokens"] = { "bw", "%a*bol%a*werk", "bwk" }
	
	L["Blood Furnace"] = "Blutkessel"
	L["BF-Tokens"] = { "bk", "kessel", "blut.*kess%a*" }

	L["Slave Pens"] = "Sklavenunterkünfte"
	L["SP-Tokens"] = { "sklav%a*", "unterku%a+" }

	L["Underbog"] = "Tiefensumpf"
	L["UB-Tokens"] = { "tief%a*sumpf", "sumpf", "tiefen" }
	L["UB-AntiTokens"] = { "blackr%a*", "schwarzf%a*" }
	
	L["Manatombs"] = "Managruft"
	L["MANA-Tokens"] = { "mg", "gruft", "man.*gr%a*", "mana" }

	L["Auchenai Crypts"] = "Auchenaikrypta"
	L["AC-Tokens"] = { "ak", "%a*krypta?", "auche%a*", "crypta?" }

	L["Old Hillsbrad Foothills"] = "Vorgebirge des alten Hügellands"
	L["HF-Tokens"] = { "hdz1?", "alt.*huegell%a*", "zeit.*1" }
	L["HF-AntiTokens"] = { "hdz.*2" }

	L["Sethekk Halls"] = "Sethekkhallen"
	L["SH-Tokens"] = { "sethekk", "set%a*[%-]?hall%a*", "se%a*ek+" }

	L["Steamvault"] = "Dampfkammer"
	L["SV-Tokens"] = { "dk", "dampf%a*", "d[mapf]+k[ame]+r" }

	L["Shadow Labyrinth"] = "Schattenlabyrinth"
	L["SL-Tokens"] = { "schlab%a*", "schattenl%a*" }

	L["Shattered Halls"] = "Zerschmetterte Hallen"
	L["SHH-Tokens"] = { "zh", "zersch.*hallen?", "hallen" }
	L["SHH-AntiTokens"] = { "set%a*" }

	L["Black Morass"] = "Der Schwarze Morast"
	L["BM-Tokens"] = { "mor+ast", "hdz.*2", "zeit.*2" }

	L["Botanica"] = "Botanica"
	L["BOT-Tokens"] = { }

	L["Mechanar"] = "Mechanar"
	L["MECH-Tokens"] = {}

	L["Arcatraz"] = "Arkatraz"
	L["ARCA-Tokens"] = { "arka", "a[lrk]+atra[sz]+" }

	L["Magister's Terrace"] = "Terrasse der Magister"
	L["MAT-Tokens"] = { "ter+as+e", "magister", "tdm" }

	L["Karazhan"] = "Karazhan"
	L["KARA-Tokens"] = { "kara", "marken.*run"}

	L["Gruul's Lair"] = "Gruuls Unterschlupf"
	L["GRUUL-Tokens"] = { "unterschlu%a*" }

	L["Magtheridon's Lair"] = "Magtheridons Kammer"
	L["MAG-Tokens"] = { "magt%a*", "kammer" }

	L["Serpentshrine Cavern"] = "Höhle des Schlangenschreins"
	L["SSC-Tokens"] = { "schlangenschrein", "schlang%a*", "vashj", "hoehl.*d.*schlangensc%a*" }

	L["Tempest Keep"] = "Festung der Stürme"
	L["TK-Tokens"] = { "fds", "festung", "stuerme", "auge" }

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
  L["UK-Tokens"] = { "burg", "bu" }
  
  L["The Nexus"] = "Der Nexus"
  L["NEX-Tokens"] = {}

  L["Azjol-Nerub"] = "Azjol-Nerub"
  L["AN-Tokens"] = {}

  L["Ahn'kahet: The Old Kingdom"] = "Ahn'kahet: Das alte Königreich"
  L["AK-Tokens"] = {}

  L["Drak'Tharon Keep"] = "Feste Drak'Tharon"
  L["DT-Tokens"] = { "feste" }

  L["The Violet Hold"] = "Violette Festung"
  L["VH-Tokens"] = { "viol*.fest%a*" }

  L["Gundrak"] = "Gundrak"
  L["GD-Tokens"] = {}

  L["Halls of Stone"] = "Hallen des Steins"
  L["HOS-Tokens"] = { "hds", "hallen.*stein%a*" }

  L["The Culling of Stratholme"] = "Das Ausmerzen von Stratholme"
  L["COS-Tokens"] = { "ausmerz%a*", "hdz.*4", "zeit.*4" }

  L["Utgarde Pinnacle"] = "Turm Utgarde"
  L["UP-Tokens"] = { "turm", "tu" }

  L["Halls of Lightning"] = "Hallen der Blitze"
  L["HOL-Tokens"] = { "hdb", "hall.*blitz%a*" }

  L["The Oculus"] = "Der Oculus"
  L["OCU-Tokens"] = {}

  L["Trial of the Champion"] = "Prüfung des Champions"
  L["TOC-Tokens"] = { "pdc", "prüf%a*g" }

  L["Pit of Saron"] = "Grube von Saron"
  L["POS-Tokens"] = { "gvs", "grube" }

  L["The Forge of Souls"] = "Die Seelenschmiede"
  L["FOS-Tokens"] = { "ss", "seelens%a*" }

  L["Halls of Reflection"] = "Hallen der Reflexion"
  L["HOR-Tokens"] = { "hdr", "halle.*reflex%a*" }

  -- Raids 

  -- L["Naxxramas"] = "Naxxramas" -- already defined in Classic section
  -- L["NAXX-Tokens"] = { }

  L["Malygos"] = "Malygos"
  L["MALY-Tokens"] = {}

  L["The Obsidian Sanctum"] = "Das Obsidiansanktum"
  L["OBSI-Tokens"] = {}

  L["Vault of Archavon"] = "Archavons Kammer"
  L["VOA-Tokens"] = {}

  --L[""] = ""
  --L["-Tokens"] = {}

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
		"verkaufe",
		"stä.*", -- umlaute sorgen dafür, dass "st" (sunken temple) erkannt wird, das müssen wir ausschließen
		"stö.*",
		"stü.*",
	}

	L["HeroTags"] = {
		"heroisch",
	}
	
	L["StopWords"] = {
		"voll danke",
		"danke voll",
	}
end