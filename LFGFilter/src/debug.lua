function LFGFilter.DebugPrint(message)
	if (LFGFilter.Config.Debug) then
		print("|cFF7777FFLFGFilter Debug:|cFFFFFFFF ", message)
	end
end

function LFGFilter.DebugTable(tab)
	LFGFilter.DebugPrint("Debugging table:")
	for key, value in pairs(tab or {}) do
		LFGFilter.DebugPrint("[" .. key .. "] = " .. value)
	end
end
