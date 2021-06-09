local addonName, addon = ...

LFGFilter = _G.LibStub("AceAddon-3.0"):NewAddon(addon, addonName)
LFGFilter.Locale = _G.LibStub("AceLocale-3.0"):GetLocale("LFGFilter")
LFGFilter.Version = _G.GetAddOnMetadata(addonName, "Version")
LFGFilter.AddonTitle = addonName .. " v" .. LFGFilter.Version
LFGFilter.Factions = { BOTH = "BOTH", ALLIANCE = "Alliance", HORDE = "Horde" }
LFGFilter.Filters = {
	ADD_COLOR = 1,
	REMOVE_FOUND = 2,
	REMOVE_IRRELEVANT = 4,
	GREY_IRRELEVANT = 8,
	ADD_LFGLFM_TAG = 16,
	ADD_DUNGEON_TAGS = 32,
	ADD_QUESTS = 64,
	ADD_HEROIC = 128,
}

function LFGFilter:OnInitialize()
	self.Initialized = true
	self:DefineTokens()
	self:DefineDungeons()
	self:DefineBCCDungeons()
	self.Groups = { }
end

local function hasbit(x, p)
	return x % (p + p) >= p       
end

local init = false
local function filterFunc(self, event, arg1, ...)
	local _, _, channelname, playername, _, _, _, channelbasename, _, _, playerId = ...

	local found, isquest, hasLfm, hasLfg, ishero, dungeons = LFGFilter:ParseMessage(arg1)
	if found then

		-- Keep track of group requests so we could enlist them in a frame, sort, filter and so on
--		if (dungeons and #dungeons > 0) then
--			local group = {
--				Player = playername,
--				Dungeons = dungeons,
--				Message = arg1,
--				Channel = channelbasename,
--				LastUpdate = GetTime(),
--				Heroic = ishero,
--			}
--			--LFGFilter:DungeonGroupFound(playername, dungeons, arg1, channelbasename, ishero)
--		end

		local hasRelevant = false
		for _, dungeon in pairs(dungeons) do 
			if (dungeon) then
				local d = LFGFilter:GetDifficulty(dungeon, ishero)
				if d > 1 and d < 5 then
					hasRelevant = true
					break
				end
			end
		end

		local filter = LFGFilter.Config.Filter

		-- remove chatline from chat when a lfg/lfm request is found
		if hasbit(filter, LFGFilter.Filters.REMOVE_FOUND) then return true end
		-- keep chatline unchanged for quests
		if hasbit(filter, LFGFilter.Filters.ADD_QUESTS) == false and isquest then return end 
		-- remove chatline from chat when dungeon is too low (grey) or too high (red)
		if hasbit(filter, LFGFilter.Filters.REMOVE_IRRELEVANT) and (hasRelevant == false) then return true end

		local useGrey = hasbit(filter, LFGFilter.Filters.GREY_IRRELEVANT) and (hasRelevant == false)
		local addColor = hasbit(filter, LFGFilter.Filters.ADD_COLOR) and (useGrey == false)
		local grey = ""
		if useGrey then
			grey = "|cff606060"
		end

		local lfmTag = ""
		local lfgTag = "" 
		if hasbit(filter, LFGFilter.Filters.ADD_LFGLFM_TAG) then
			if hasLfm then
				if addColor then
					lfmTag = "|cff80ff20[LFM]|r"
				else
					lfmTag = "[LFM]"
				end
			end
			if hasLfg then
				if addColor then
					lfgTag = "|cff0040ff[LFG]|r"
				else
					lfgTag = "[LFG]"
				end
			end
		end

		local heroic = ""
		if ishero and hasbit(filter, LFGFilter.Filters.ADD_HEROIC) then
			if addColor then
				heroic = "|cffff2020[HC]|r"
			else
				heroic = "[HC]"
			end
		end

		local dungeonnames = ""
		if hasbit(filter, LFGFilter.Filters.ADD_DUNGEON_TAGS) then
			for _, dungeon in pairs(dungeons) do 
				local dname = "[" .. dungeon.LocalizedName .. "]"
				if (addColor) then
					local c = LFGFilter.Colors[LFGFilter:GetDifficulty(dungeon, ishero)]
					local ctext = ("ff%.2x%.2x%.2x"):format(c.r, c.g, c.b)
					dname = "|c" .. ctext .. dname .. "|r"
				end
				dungeonnames = dungeonnames .. dname
			end
		end

		local formatted = (grey .. lfmTag .. lfgTag .. " " .. (hcTag .. dungeonnames .. " " .. arg1):trim()):trim()
		return false, formatted, ...
	end
	return
end

function LFGFilter:OnEnable()
	_G.ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filterFunc)
	print(self.AddonTitle .. " enabled")
end

function LFGFilter:OnDisable()
end