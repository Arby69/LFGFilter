function string:SplitString(seperator)
    local fields = {}
    local pattern = string.format("([^%s]+)", seperator)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end