local L = _G.LibStub("AceLocale-3.0"):NewLocale("LFGFilter", "frFR")

if (L) then
	
	L["Select Dungeon"] = "Select Dungeon"
	L["Unknown"] = "Unknown"
	L["Quest"] = "Quest"

	--------------------------------------------- Vanilla ----------------------------------------------

	L["Ragefire Chasm"] = "Gouffre de Ragefeu"
	L["RFC-Tokens"] = { "gdr", "rf", "ragefeu", "gouf+re.*rag%a+" }

	L["Wailing Caverns"] = "Cavernes des lamentations"
	L["WC-Tokens"] = { "cdl", "lament%a*", "lams?" }

	L["The Deadmines"] = "Les Mortemines"
	L["DM-Tokens"] = { "mm", "mor%a*mines?" }

	L["Shadowfang Keep"] = "Donjon d'Ombrecroc"
	L["SFK-Tokens"] = { "do", "ddo", "ombrecroc", "donj.*ombr%a*" }

	L["Blackfathom Deeps"] = "Profondeurs de Brassenoire"
	L["BFD-Tokens"] = { "pdb", "pb", "bras%a*noir%a*" }

	L["The Stockades"] = "La Prison"
	L["STOCKS-Tokens"] = { "pris", "prisons?" }

	L["Gnomeregan"] = "Gnomeregan"
	L["GNOME-Tokens"] = { } 

	L["Razorfen Kraul"] = "Kraal de Tranchebauge"
	L["RK-Tokens"] = { "kra+l+", "kdt", "kt" }

	L["The Scarlet Monastery"] = "Monastère Écarlate"
	L["The Scarlet Monastery: Graveyard"] = "Monastère Écarlate: Cimetière"
	L["GY-Tokens"] = { "(sm)?cim", "(sm)?cimet[ier]*" }

	L["The Scarlet Monastery: Library"] = "Monastère Écarlate: Bibliothèque"
	L["LIB-Tokens"] = { "(sm)?bib", "bibi", "(sm)?bibl[io]*[thequ]*" }

	L["The Scarlet Monastery: Armory"] = "Monastère Écarlate: Armurerie"
	L["ARM-Tokens"] = { "(sm)?armu", "(sm)?armu[rei]*" }

	L["The Scarlet Monastery: Cathedral"] = "Monastère Écarlate: Cathédrale"
	L["CATH-Tokens"] = { "(sm)?cath", "(sm)?cathe[dral]*" }

	L["Razorfen Downs"] = "Souilles de Tranchebauge"
	L["RD-Tokens"] = { "souil+es?", "sdt" }

	L["Uldaman"] = "Uldaman"
	L["ULDA-Tokens"] = { } 

	L["Zul'Farak"] = "Zul'Farak"
	L["ZF-Tokens"] = { } 

	L["Maraudon"] = "Maraudon"
	L["MARA-Tokens"] = { }

	L["Temple of Atal'Hakkar"] = "Le Temple'd Atal'Hakkar" -- Le Temple englouti
	L["ST-Tokens"] = { "templ.*d?.*at.*hak+[ar]*", "templs", "englou[ti]*" }

	L["Blackrock Depths"] = "Profondeurs de Blackrock"
	L["BRD-Tokens"] = { "pdb", "pb", "brdx?%d", "prof.*bl.*rock" }

	L["Lower Blackrock Spire"] = "Bas du Pic de Rochenoire"
	L["LBRS-Tokens"] = { "bas.*pic.*rochen%a*" }

	L["Upper Blackrock Spire"] = "Sommet du Pic de Rochenoire"
	L["UBRS-Tokens"] = { "som.*pic.*rochen%a*" }

	L["Stratholme"] = "Stratholme"
	L["STRAT-Tokens"] = { } 

	L["Scholomance"] = "Scholomance"
	L["SCHOLO-Tokens"] = { }

	L["Dire Maul"] = "Hache Tripes"
	L["Dire Maul East"] = "Hache Tripes Est"
	L["DMEAST-Tokens"] = { "ht.*%West", "hach.*tri.*%West", "dm.*%West", "dire.*%West", "htes?t?" }

	L["Dire Maul West"] = "Hache Tripes Ouest"
	L["DMWEST-Tokens"] = { "ht.*ouest", "hach.*tri.*ouest", "dm.*ouest", "dire.*ouest", "htou?e?s?t?" }

	L["Dire Maul North"] = "Hache Tripes Nord"
	L["DMNORTH-Tokens"] = { "ht.*nord", "hach.*tri.*nord", "dm.*nord", "dire.*nord", "htno?r?d?" }

	L["Molten Core"] = "Cœur du Magma"
	L["MC-Tokens"] = { "coeur", "coe.*mag%a*", "cdm", "cm" }

	L["Onyxia's Lair"] = "Repaire d'Onyxia"
	L["ONY-Tokens"] = { "rep.*onyx%a*" } 

	L["Blackwing Lair"] = "Repaire de l'Aile noire"
	L["BWL-Tokens"] = { "ran", "rep.*ail.*noir%a*" }

	L["Zul'Gurub"] = "Zul'Gurub"
	L["ZG-Tokens"] = { } 

	L["Temple of Ahn'Qiraj"] = "Le Temple'd Ahn'Qiraj"
	L["AQ40-Tokens"] = { "aq.*%Wtemp[le]*", "a.*qir.*templ%a*", "templ.*qira%a*" }

	L["Ruins of Ahn'Qiraj"] = "Ruines d'Ahn'Qiraj"
	L["AQ20-Tokens"] = { "aq.*%Wruin%a*", "ruines", "ruin.*qira%a*" }

	L["Naxxramas"] = "Naxxramas"
	L["NAXX-Tokens"] = { }

	--------------------------------------------- BCC ----------------------------------------------
	
	L["Hellfire Ramparts"] = "Remparts des Flammes infernales"
	L["HR-Tokens"] = { "rem", "remp.*fla.*infer%a*", "remp[arts]*" }
	
	L["Blood Furnace"] = "La Fournaise du sang"
	L["BF-Tokens"] = { "fs", "fds", "fourn.*sang" }

	L["Slave Pens"] = "Les enclos aux esclaves"
	L["SP-Tokens"] = { "esclav%a*", "enclo[ts]+" }

	L["Underbog"] = "La Basse-tourbière"
	L["UB-Tokens"] = { "basse", "bas.*tourb%a*", "bt" }
	
	L["Manatombs"] = "Tombes-mana"
	L["MANA-Tokens"] = { "tm", "tombe?s?", "man+a" }

	L["Auchenai Crypts"] = "Cryptes Auchenaï"
	L["AC-Tokens"] = { "ca", "auche%a*", "crypt[es]*" }

	L["Old Hillsbrad Foothills"] = "Contreforts de Hautebrande d'antan"
	L["HF-Tokens"] = { "cdt1?", "cont.*haut%a*", "temp.*1" }
	L["HF-AntiTokens"] = { "cdt.*2" }

	L["Sethekk Halls"] = "Les salles des Sethekk"
	L["SH-Tokens"] = { "ss", "seth[ek]*", "sall.*set+h?%a*" }

	L["Steamvault"] = "Le Caveau de la vapeur"
	L["SV-Tokens"] = { "cav.*vap[eur]*", "cv" }

	L["Shadow Labyrinth"] = "Labyrinthe des ombres"
	L["SL-Tokens"] = { "lab[iy].*omb%a*", "lab[yi]*[rintes]*", "labo" }

	L["Shattered Halls"] = "Les Salles brisées"
	L["SHH-Tokens"] = { "sb", "sal.*bris[es]*" }

	L["Black Morass"] = "Le Noir Marécage"
	L["BM-Tokens"] = { "cdt.*2", "temp.*2", "marec[age]*" }

	L["Botanica"] = "La Botanica"
	L["BOT-Tokens"] = { }

	L["Mechanar"] = "Le Méchanar"
	L["MECH-Tokens"] = { }

	L["Arcatraz"] = "L'Arcatraz"
	L["ARCA-Tokens"] = { }

	L["Magister's Terrace"] = nil
	L["MAT-Tokens"] = { }

	L["Karazhan"] = "Karazhan"
	L["KARA-Tokens"] = { }

	L["Gruul's Lair"] = "Repaire de Gruul"
	L["GRUUL-Tokens"] = { "rep.*gru[ul]*" }

	L["Magtheridon's Lair"] = "Le repaire de Magtheridon"
	L["MAG-Tokens"] = { "rep.*mag[theridon]*" }

	L["Serpentshrine Cavern"] = nil
	L["SSC-Tokens"] = { }

	L["Tempest Keep"] = nil
	L["TK-Tokens"] = { }

	L["Zul Aman"] = "Zul Aman"
	L["ZA-Tokens"] = { }

	L["Mount Hyjal"] = nil
	L["MH-Tokens"] = { }

	L["Black Temple"] = nil
	L["BT-Tokens"] = { }

	L["Sunwell Plateau"] = nil
	L["SUN-Tokens"] = { }

	------------------------------------------------------------------------------------------------
	
	L["RoleKeywords"] = {
		"souigneur",
	}

	L["LFMKeywords"] = { 
		"demnand%a*",
		"place",
		"person",
	}

	L["LFGKeywords"] = {
	}

	L["NoDungeons"] = {
	}

	L["HeroTags"] = {
		"heroiq[ue]*",
	}
	
	L["StopWords"] = {
	}

end