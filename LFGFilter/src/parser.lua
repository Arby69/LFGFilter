
function LFGFilter.ReplaceUmlauts(message)
	local result = string.gsub(message, "ä", "ae")
	result = string.gsub(result, "ö", "oe")
	result = string.gsub(result, "ü", "ue")
	result = string.gsub(result, "Ä", "ae")
	result = string.gsub(result, "Ö", "oe")
	result = string.gsub(result, "Ü", "ue")
	result = string.gsub(result, "ß", "ss")
	return result
end

function LFGFilter:ParseMessage(message)
	local lowerMessage = " " .. LFGFilter.ReplaceUmlauts(string.lower(message)) .. " "
	local isTrade = LFGFilter.MessageHasToken(lowerMessage, self.NoDungeons) -- LFGFilter.ArrayContainsArrayValue(lowerWords, WtbTags)
	if (isTrade == false) then
		local hasBL = LFGFilter.MessageHasToken(lowerMessage, self.Blacklist)
		if (hasBL == false) then
			local hasStop = LFGFilter.MessageHasToken(lowerMessage, self.StopWords)
			if (hasStop == false) then
				local hasRole = LFGFilter.MessageHasToken(lowerMessage, self.RoleTags)
				local hasLfg = LFGFilter.MessageHasToken(lowerMessage, self.LfgTags) 
				local hasLfm = LFGFilter.MessageHasToken(lowerMessage, self.LfmTags) 
				local ishero = LFGFilter.MessageHasToken(lowerMessage, self.HeroTags)
				local dungeons, matchLevel, ishero = self:GetMatchingDungeons(lowerMessage, ishero)
				local isQuest = LFGFilter.IsQuest(message)
				local hasGuild = LFGFilter.MessageHasToken(lowerMessage, self.GuildTags)
				if isQuest then
					matchLevel = 3
				else
					if #dungeons == 0 and (hasLfm or hasRole or hasLfg) and (hasGuild == false) then
						table.insert(dungeons, "Custom")
						matchLevel = 3
					end
				end
				if (#dungeons > 0 or isQuest) then
					--local entry = LFGChatScannerGroupEntry(sender, message, channel, dungeons)
					--LFGChatScanner.EventBus:PublishEvent(LFGChatScanner.Config.Events.ChatAnnouncementFound, entry)
					return true, hasLfm, hasLfg, dungeons, matchLevel, ishero
				end
			else
				-- TODO: look up group table and remove group from it if present
			end
		end
	end
	return false
end

function LFGFilter.CreateTokenTable(t1, t2)
	local result = { }
	if (type(t1) == "table" and type(t2) == "table") then
		for _, v in pairs(t1) do
			table.insert(result, "%W" .. tostring(v) .. "%W")
		end
		for _, v in pairs(t2) do
			table.insert(result, "%W" .. tostring(v) .. "%W")
		end
	end
	return result
end

function LFGFilter:DefineTokens()
	self.LfmTags = self.CreateTokenTable({ "lfm", "lf3m", "lf2m", "lf1m", "need", "lf", "looking for more" }, self.Locale["LFMKeywords"] or {})
	self.LfgTags = self.CreateTokenTable({ "lfg", "group", "grp" }, self.Locale["LFGKeywords"] or {})
	self.RoleTags = self.CreateTokenTable({ "tank", "heal", "healer", "dps", "damage" }, self.Locale["RoleKeywords"] or {})
	self.StopWords = self.CreateTokenTable({ "grp full", "thanks full", "ty full", "full ty", "full thanks", "http", "layer", "trade.*gold" }, self.Locale["StopWords"] or {})
	self.NoDungeons = self.CreateTokenTable({ "wts", "wtb", "buy", "sell", "selling", "recru.*" }, self.Locale["NoDungeons"] or {})
	self.HeroTags = self.CreateTokenTable({ "hcs?", "heroic", "hero" }, self.Locale["HeroTags"] or {})
	self.NonHeroTags = self.CreateTokenTable({ "nhc", "non%Whc" }, self.Locale["NonHeroTags"] or {})
	self.GuildTags = self.CreateTokenTable({ "guild", "recru.*", "ambition.*" }, self.Locale["GuildTags"] or {})
end

function LFGFilter.IsQuest(message)
	if message then 
		if string.find(message, "%[(..-) %((%d+)%)%]") then return true end -- this is the pattern questie detects to insert its own link
		if string.find(message, "%|Hquestie:") then return true end         -- this is when questie has already inserted its own link
	end 
	return false -- no quest in chat line detected
end

function LFGFilter.MessageHasToken(message, tokens)
	if (type(message) == "string" and type(tokens) == "table") then
		for _, tok in pairs(tokens) do
			if (string.find(message, tok)) then
				return true
			end
		end
	end
	return false
end
