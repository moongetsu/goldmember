function HasDns(player)
    local playername = player:CBasePlayerController().PlayerName:lower()
    local serverDNS = config:Fetch("goldmember.ServerDNS"):lower()
    local playernameUpper = player:CBasePlayerController().PlayerName:upper()
    local serverDNSUpper = config:Fetch("goldmember.ServerDNS"):upper()

    local hasDNSLower = string.find(playername, serverDNS, 1, true) ~= nil
    local hasDNSUpper = string.find(playernameUpper, serverDNSUpper, 1, true) ~= nil
    return hasDNSLower or hasDNSUpper
end

function IsPistolRound()
    local gameRules = GetCCSGameRules()
    if gameRules == nil then return false end
    if gameRules.WarmupPeriod then return false end
    return gameRules.TotalRoundsPlayed == 0 or gameRules.RoundsPlayedThisPhase == 0 or (gameRules.SwitchingTeamsAtRoundReset and gameRules.OvertimePlaying == 0) or gameRules.GameRestart;
end