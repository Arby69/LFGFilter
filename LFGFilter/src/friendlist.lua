function LFGFilter.PlayerIsIgnored(playerName)
    for i = 1, C_FriendList.GetNumIgnores() do
        if (C_FriendList.GetIgnoreName(i) == playerName) then
            return true
        end
    end
    return false
end

function LFGFilter.PlayerIsFriend(playerName)
    for i = 1, C_FriendList.GetNumFriends() do
        local player = C_FriendList.GetFriendInfoByIndex(i)
        if (player and playerName == player.name) then
            return true
        end
    end
    return false
end

function LFGFilter.PlayerIsBattleNetFriend(playerName)
    for i = 1, BNGetNumFriends() do
        local _, _, _, _, name = BNGetFriendInfo(i) or ""
        if (playerName == name) then
            return true
        end
    end
    return false
end