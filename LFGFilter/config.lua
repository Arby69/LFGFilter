LFGFilter.Config = {
	Debug = true,
	--ADD_COLOR = 1,
	--REMOVE_FOUND = 2,
	--REMOVE_IRRELEVANT = 4,
	--GREY_IRRELEVANT = 8,
	--ADD_LFGLFM_TAG = 16,
	--ADD_DUNGEON_TAGS = 32,
	--ADD_IRRELEVANT = 64,
	Filter = LFGFilter.Filters.ADD_COLOR + LFGFilter.Filters.ADD_LFGLFM_TAG + LFGFilter.Filters.ADD_DUNGEON_TAGS + LFGFilter.Filters.ADD_IRRELEVANT + LFGFilter.Filters.GREY_IRRELEVANT,
    Font = "Fonts\\FRIZQT__.ttf",
    Network = {
        Debug = false,
        Prefix = "CLFG_Network",
        Channel = {
            Name = "ClassicLFG", -- let's hijack ClassicLFG's channel so we can monitor its messages, too
            Id = 1
        }
    },
 	DungeonNameColor = { r = 255, g = 255, b = 0 },
	GroupTimeToLive = 2.5 * 60,
	GroupTimeToPend = 5 * 60,
	CheckGroupInterval = 5,
}

if (GetLocale() == "ruRU") then
    LFGFilter.Config.Font = "Fonts\\FRIZQT___CYR.TTF"
end

if (GetLocale() == "koKR") then
    LFGFilter.Config.Font = "Fonts\\2002.TTF"
end

if (GetLocale() == "zhCN") then
    LFGFilter.Config.Font = "Fonts\\ARKai_T.ttf"
end

if (GetLocale() == "zhTW") then
    LFGFilter.Config.Font = "Fonts\\blei00d.TTF"
end