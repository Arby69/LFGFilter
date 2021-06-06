function LFGFilter.ArrayContainsValue(array, val)
    for _, value in ipairs(array or {}) do
        if value == val then
            return true
        end
    end
    return false
end

function LFGFilter.ArrayContainsArrayValue(array1, array2)
    for _, value in pairs(array2 or {}) do
        if (LFGFilter.ArrayContainsValue(array1, value)) then
            return true
        end
    end
    return false
end
