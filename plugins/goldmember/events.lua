AddEventHandler("OnPlayerSpawn", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)

    if not player then return end
    if player:IsFakeClient() then return end

    if not HasDns(player) then
        ReplyToCommand(playerid, config:Fetch("goldmember.prefix"), FetchTranslation("goldmember.NoDNS"):gsub("{SERVER_DNS}", config:Fetch("goldmember.ServerDNS")))
    else
        NextTick(function()
            ReplyToCommand(playerid, config:Fetch("goldmember.prefix"), FetchTranslation("goldmember.HasDNS"))
            if not player:CBaseEntity():IsValid() then return end
            if not player:CCSPlayerPawn():IsValid() then return end
            player:CBaseEntity().Health = config:Fetch("goldmember.Benefits.HP")
            player:CCSPlayerPawn().ArmorValue = config:Fetch("goldmember.Benefits.Armor")
            if config:Fetch("goldmember.Benefits.DefuseKit") == true and player:CBaseEntity().TeamNum == Team.CT then
                player:GetWeaponManager():GiveWeapon("item_defuser")
            end
            if config:Fetch("goldmember.Benefits.Healthshot") == true then
                player:GetWeaponManager():GiveWeapon("weapon_healthshot")
            end
            local grenades = config:Fetch("goldmember.Benefits.Grenades")
            local grenadestogive = string.split(grenades, ";")
            for i = 1, #grenadestogive do
                player:GetWeaponManager():GiveWeapon(grenadestogive[i])
            end
            if config:Fetch("goldmember.Benefits.Money") and not IsPistolRound() then
                if not player:CCSPlayerController():IsValid() then return end
                player:CCSPlayerController().InGameMoneyServices.Account = player:CCSPlayerController().InGameMoneyServices.Account + config:Fetch("goldmember.Benefits.Money")
            end
        end)
    end
end)