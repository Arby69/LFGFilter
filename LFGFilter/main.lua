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
	ADD_IRRELEVANT = 64,
}

local RED = { r = 255, g = 0, b = 0 }
local ORANGE = { r = 255, g = 128, b = 64 }
local YELLOW = { r = 255, g = 255, b = 0 }
local GREEN = { r = 0, g = 168, b = 0 }
local GREY = { r = 128, g = 128, b = 128 }

function LFGFilter:OnInitialize()
	self.Initialized = true
	self.Colors = { }
	self.Colors[0] = self.Config.DungeonNameColor
	self.Colors[1] = GREY
	self.Colors[2] = GREEN
	self.Colors[3] = YELLOW
	self.Colors[4] = ORANGE
	self.Colors[5] = RED
	self.Dungeons = { }
	self:DefineTokens()
	self:DefineClassicDungeons()
	self:DefineBCCDungeons()
	self:DefineWotLKDungeons()
	self:DefineDungeon("", "Custom")
	self.Groups = { }
end

local function hasbit(x, p)
	return x % (p + p) >= p       
end

local init = false
local lastMsgId = nil
local lastMessage = nil

local function filterFunc(self, event, arg1, ...)
	local _, _, arg4, arg5, _, _, _, arg9, _, arg11, arg12 = ...
	if (lastMessage == arg1 and lastMsgId ~= arg11) then return true end -- identical message as before but new msgId? -> chat spam, filter it
	lastMessage = arg1
	lastMsgId = arg11
	local found, hasLfm, hasLfg, dungeons, matchLevel, ishero = LFGFilter:ParseMessage(arg1)
	if (found) then
		if (dungeons and #dungeons > 0) then
			local playerId = arg12
			local playername = arg5:SplitString("-")[1] 
			local channelname = arg4
			local channelbasename = arg9
			-- TODO: fire "dungeon found" event and store info in table with playerId as key
			local group = {
				Player = playername,
				Dungeons = dungeons,
				Message = arg1,
				Channel = channelbasename,
				LastUpdate = GetTime(),
				Heroic = ishero,
			}
		end
		local filter = LFGFilter.Config.Filter
		local lfglfmTag = "" -- lfg or lfm text to set at the beginning of line
		local names = ""
		local grey = ""
		if hasbit(filter, LFGFilter.Filters.REMOVE_IRRELEVANT) and matchLevel < 2 then return true end
		if hasbit(filter, LFGFilter.Filters.REMOVE_FOUND) and matchLevel > 1 then return true end
		local useGrey = hasbit(filter, LFGFilter.Filters.GREY_IRRELEVANT) and matchLevel < 2
		local addColor = useGrey == false and hasbit(filter, LFGFilter.Filters.ADD_COLOR)
		local addTags = hasbit(filter, LFGFilter.Filters.ADD_DUNGEON_TAGS)
		local addIrrelevant = hasbit(filter, LFGFilter.Filters.ADD_IRRELEVANT)
		if (useGrey) then
			grey = "|cff606060"
		end
		if (hasbit(filter, LFGFilter.Filters.ADD_LFGLFM_TAG)) then
			if (hasLfm) then
				if (addColor) then 
					lfglfmTag = "|cff80ff20[LFM]|r"
				else
					lfglfmTag = "[LFM]"
				end
			elseif (hasLfg) then
				if (addColor) then
					lfglfmTag = "|cff0040ff[LFG]|r"
				else
					lfglfmTag = "[LFG]"
				end
			end
		end
		hcTag = ""
		if ishero then
			if addColor then
				hcTag = "|cffff2020[HC]|r"
			else
				hcTag = "[HC]"
			end
		end
		if ((addTags and (matchLevel > 1)) or (addIrrelevant and (matchLevel < 2))) then
			for _, n in pairs(dungeons) do 
				local dungeon = LFGFilter.Dungeons[n]
				if (dungeon) then
					local d = LFGFilter:GetDifficulty(n, ishero)
					--if (d > 1 and d < 5) then isRelevant = true end
					local dname = "[" .. dungeon.LocalizedName .. "]"
					if (addColor) then
						local c = LFGFilter.Colors[d]
						local ctext = ("ff%.2x%.2x%.2x"):format(c.r, c.g, c.b)
						dname = "|c" .. ctext .. dname .. "|r"
					end
					names = names .. dname
				end
			end
		end
		local text = grey .. lfglfmTag .. " " .. (hcTag .. names .. " " .. arg1):trim()
		return false, text, ...
	end
	return
end

function LFGFilter:OnEnable()
	_G.ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filterFunc)
	print(self.AddonTitle .. " enabled")
end

function LFGFilter:OnDisable()
end