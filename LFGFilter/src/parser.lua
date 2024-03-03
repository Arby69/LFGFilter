
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
	local hclvl = -1
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
				local ispvp = LFGFilter.MessageHasToken(lowerMessage, self.PvpTags)
				if (LFGFilter.MessageHasToken(lowerMessage, self.HeroGammaTags)) then
					hclvl = 3
				elseif (LFGFilter.MessageHasToken(lowerMessage, self.HeroBetaTags)) then
					hclvl = 2
				elseif (LFGFilter.MessageHasToken(lowerMessage, self.HeroPlusTags)) then
					hclvl = 1
				elseif (LFGFilter.MessageHasToken(lowerMessage, self.HeroTags)) then
					hclvl = 0
				end
				local dungeons, matchLevel, hclvl = self:GetMatchingDungeons(lowerMessage, hclvl)
				local isQuest = LFGFilter.IsQuest(message)
				if isQuest then
					matchLevel = 3
				else
					if #dungeons == 0 and (hasLfm or hasRole or hasLfg) then
						table.insert(dungeons, "Custom")
						matchLevel = 3
					end
				end
				if (#dungeons > 0 or isQuest or ispvp) then
					--local entry = LFGChatScannerGroupEntry(sender, message, channel, dungeons)
					--LFGChatScanner.EventBus:PublishEvent(LFGChatScanner.Config.Events.ChatAnnouncementFound, entry)
					return true, hasLfm, hasLfg, dungeons, matchLevel, hclvl, ispvp
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
	if type(t1) == "table" then
		for _, v in pairs(t1) do
			table.insert(result, "%W" .. tostring(v) .. "%W")
		end
	end
	if type(t2) == "table" then
		for _, v in pairs(t2) do
			table.insert(result, "%W" .. tostring(v) .. "%W")
		end
	end
	return result
end

function LFGFilter:DefineTokens()
	self.LfmTags = self.CreateTokenTable({ "lfm", "lf3m", "lf2m", "lf1m", "need", "looking for more" }, self.Locale["LFMKeywords"] or {})
	self.LfgTags = self.CreateTokenTable({ "lfg", "group", "grp" }, self.Locale["LFGKeywords"] or {})
	self.RoleTags = self.CreateTokenTable({ "tank", "heal", "healer", "dps", "damage" }, self.Locale["RoleKeywords"] or {})
	self.StopWords = self.CreateTokenTable({ "grp full", "thanks full", "ty full", "full ty", "full thanks", "http", "layer", "trade.*gold" }, self.Locale["StopWords"] or {})
	self.NoDungeons = self.CreateTokenTable({ "wts", "wtb", "buy", "sell", "selling", "recru.*", "guild", "ambition.*", "trade", "recip%a*" }, self.Locale["NoDungeons"] or {})
	self.PvpTags = self.CreateTokenTable({ "pvp", "2vs?2", "3vs?3", "5vs?5", "2on?2", "3on?3", "5on?5", "2s", "3s", "5s" }, self.Locale["PvP"] or {})
	if not LFGFilter.IsClassic then
		self.HeroTags = self.CreateTokenTable({ "hcs?", "heroic", "hero", "togc", "beta", "alpha" }, self.Locale["HeroTags"] or {})
		self.NonHeroTags = self.CreateTokenTable({ "nhc", "non%Whc" }, self.Locale["NonHeroTags"] or {})
		if LFGFilter.IsWOTLK then
			self.HeroPlusTags = self.CreateTokenTable({ "alpha", "hc%s*%+", "hc%s*plus", "hcp", "h%s*%+", "hca" }, self.Locale["HeroPlusTags"] or {})
			self.HeroBetaTags = self.CreateTokenTable({ "beta", "hc%s*%+%+", "h%s*%+%+", "%s*%+%+", "hcb" }, self.Locale["HeroBetaTags"] or {})
			self.HeroGammaTags = self.CreateTokenTable({ "gamma", "h%s*%+%+%+", "%s*%+%+%+", "hcg" }, self.Locale["HeroGammaTags"] or {})
		end
	end
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
