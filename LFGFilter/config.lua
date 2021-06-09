LFGFilter.Config = {
    Debug = false,
    
    --ADD_COLOR = 1,
    --REMOVE_FOUND = 2,
    --REMOVE_IRRELEVANT = 4,
    --GREY_IRRELEVANT = 8,
    --ADD_LFGLFM_TAG = 16,
    --ADD_DUNGEON_TAGS = 32,
	--ADD_QUESTS = 64,
	--ADD_HEROIC = 128,
    Filter = LFGFilter.Filters.ADD_COLOR + LFGFilter.Filters.ADD_LFGLFM_TAG + LFGFilter.Filters.ADD_DUNGEON_TAGS + LFGFilter.Filters.GREY_IRRELEVANT + LFGFilter.Filters.ADD_HEROIC + LFGFilter.Filters.ADD_QUESTS,

    -- Configuration for GUI and group list (both not yet implemented)
    Font = "Fonts\\FRIZQT__.ttf",
    DungeonNameColor = { r = 255, g = 255, b = 0 },
    GroupTimeToLive = 2.5 * 60, -- if a sender does not repeat his/her group request in 2.5 minutes, it will get a special mark in the group list
    GroupTimeToPend = 5 * 60, -- if a sender does not repeat his/her group request in 5 minutes, it will be removed from the group list
    CheckGroupInterval = 5,

    -- Network not used, I don't even know if Addon channels are allowed again in TBC Classic
    --    Network = {
    --        Debug = false,
    --        Prefix = "CLFG_Network",
    --        Channel = {
    --            Name = "ClassicLFG", -- let's hijack ClassicLFG's channel so we can monitor its messages, too
    --            Id = 1
    --        }
    --    },
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