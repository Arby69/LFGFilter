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

function LFGFilter.IsQuest(message)
	if message then 
		if string.find(message, "%[(..-) %((%d+)%)%]") then return true end -- this is the pattern questie detects to insert its own link
		if string.find(message, "%|Hquestie:") then return true end         -- this is when questie has already inserted its own link
	end 
	return false -- no quest in chat line detected
end

function LFGFilter:DefineTokens()
	self.LfmTags = self.CreateTokenTable({ "lfm", "lf3m", "lf2m", "lf1m", "need", "lf", "looking for more" }, self.Locale["LFMKeywords"] or {})
	self.LfgTags = self.CreateTokenTable({ "lfg", "group", "grp" }, self.Locale["LFGKeywords"] or {})
	self.RoleTags = self.CreateTokenTable({ "tank", "heal", "healer", "dps", "damage" }, self.Locale["RoleKeywords"] or {})
	self.StopWords = self.CreateTokenTable({ "grp full", "thanks full", "ty full", "full ty", "full thanks", "http" }, self.Locale["StopWords"] or {})
	self.NoDungeons = self.CreateTokenTable({ "wts", "wtb", "buy", "sell", "selling" }, self.Locale["NoDungeons"] or {})
	self.HeroTags = self.CreateTokenTable({ "hc", "heroic", "hero" }, self.Locale["HeroTags"] or {})
	self.Blacklist = {}
end

-- returns found(bool), isQuest(bool), hasLfm(bool), hasLfg(bool), isHero(bool), dungeons(table), matchlevel(int)
function LFGFilter:ParseMessage(message, playerId)
	
	-- for matching we use a lowercase instance of the message where special chars are replaced
	local lowerMessage = " " .. LFGFilter.ReplaceUmlauts(string.lower(message)) .. " "
	
	-- detect keywords for trading like "buy", "wts" or others
	if LFGFilter.MessageHasToken(lowerMessage, self.NoDungeons) then return false end

	-- detect blacklisted words (if any), eg. "boost" or "buy gold"
	if LFGFilter.MessageHasToken(lowerMessage, self.Blacklist) then return false end

	-- detect keywords that appear to end the search for a group or group members
	if LFGFilter.MessageHasToken(lowerMessage, self.StopWords) then
		-- todo: use playerId to remove the group record from the list
		-- LFGFilter:RemoveGroup(playerId)
		return false
	end

	-- check if a quest pattern (like from Questie) is present (we won't search for dungeons then)
	local isQuest = LFGFilter.IsQuest(message)
	-- are special tokens present like "lfm" or "lfg" that indicate a message searching for a group or members?
	local hasLfg = LFGFilter.MessageHasToken(lowerMessage, self.LfgTags) 
	local hasLfm = LFGFilter.MessageHasToken(lowerMessage, self.LfmTags) 
	-- search for mentioned roles (like "Tank"), which indicate a group search	
	local hasRole = LFGFilter.MessageHasToken(lowerMessage, self.RoleTags)
	-- search for tokens indicating a heroic dungeon (which shifts the level range)
	local isHero = LFGFilter.MessageHasToken(lowerMessage, self.HeroTags)
	-- search for usage of dungeon names, their common abbreviations or tokens players usually use (like "bfd" for "Blackfathom Deeps")
	local dungeons = {}
	local matchlevel = 3
	
	if isQuest then
		-- matchlevel for quest requests is always 3 ("yellow")
		table.insert(dungeons, "Quest")
	else
		dungeons = self:GetMatchingDungeons(lowerMessage, isHero)
		-- when "LFM" or "LFG" or a role were found, it is most likely a group search, we are just too silly to find out for what.
		if #dungeons == 0 and (hasLfm or hasRole or hasLfg) then
			table.insert(dungeons, "Unknown")
		end
	end

	if (#dungeons > 0) then
		return true, isQuest, hasLfm, hasLfg, isHero, dungeons
	end
	
	return false
end