LFGFilter = LibStub("AceAddon-3.0"):NewAddon("LFGFilter", "AceConsole-3.0") --, "AceEvent-3.0" );
LFGFilter.Locale = LibStub("AceLocale-3.0"):GetLocale("LFGFilter")
-- LFGFilter.AceGUI = LibStub("AceGUI-3.0")
-- LFGFilter.MinimapIcon = LibStub("LibDBIcon-1.0")

LFGFilter.Version = GetAddOnMetadata("LFGFilter", "Version")
LFGFilter.AddonTitle = LFGFilter.name .. " v" .. tostring(LFGFilter.Version)
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

function LFGFilter:OnInitialize()
	self.Initialized = true;
	self:DefineTokens()
	self:DefineDungeons()
	self:DefineBCCDungeons()
	self.Groups = { }
end

local function hasbit(x, p)
	return x % (p + p) >= p       
end

local init = false
local function filterFunc(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
	--if self["name"] == nil then
	--	LFGFilter.DebugPrint("--------------") -- if you want to do something only once per chat message you could check for self["name"] == nil
	--end
	local found, hasLfm, hasLfg, dungeons, matchLevel, ishero = LFGFilter:ParseMessage(arg1)
	if (found) then
		--if (lastMsgId ~= arg11) then
		if (self["name"] == nil and dungeons and #dungeons > 0) then
			--lastMsgId = arg11
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
		return false, text, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17

--		if (filter == LFGFilter.Filters.AddDungeonName or filter == LFGFilter.Filters.AddIfRelevant) then
--			local names = ""
--			local isRelevant = false
--			for _,n in pairs(dungeons) do 
--				local dungeon = LFGFilter.Dungeons[n]
--				if (dungeon) then
--					local d = LFGFilter:GetDifficulty(n)
--					if (d > 1 and d < 5) then isRelevant = true end
--					local c = LFGFilter.Colors[d]
--					local ctext = ("ff%.2x%.2x%.2x"):format(c.r, c.g, c.b)
--					names = names .. "|c" .. ctext .. "[" .. dungeon.LocalizedName .. "]|r"
--				end
--			end
--			if (names ~= "" and (isRelevant == true or filter == LFGFilter.Filters.AddDungeonName)) then
--				--local c = LFGFilter.Config.DungeonNameColor
--				if (hasLfm) then
--					names = "|cffff8020[LFM]|r" .. names
--				elseif (hasLfg) then
--					names = "|cff80ff20[LFG]|r" .. names
--				end
--				local text = names .. " " .. arg1
--			end
--		elseif (filter == LFGFilter.Filters.RemoveLine) then
--			return true
--		end
	end
	return
end

function LFGFilter:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filterFunc)
	if GetLFGDungeonInfo then
		for i = 1, 1000 do
			local dungeonname, typeid, subtypeid, minlvl, maxlvl,reclvl,minreclvl,maxreclvl,expansionid,groupid,texturename,difficulty,maxplayers,dungeondesc,isholiday = GetLFGDungeonInfo(i)
			if typeid == 1 or typeid == 2 then
				self.DebugPrint("[" .. i .. "] DungeonName=" .. dungeonname)
			end
		end
	end
end

function LFGFilter:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", filterFunc)
end

