local QBCore = exports['qb-core']:GetCoreObject()

print('========================================')
print('[RDS-Customweapons] Rubber Ducks Script RDS Custom Crafting')
print('[RDS-Customweapons] Author: Rubber Duck Scripts (RDS)')
print('[RDS-Customweapons] Version: ' .. Config.Version)
print('========================================')

local Tier3Tracker = {}

local function RevokeLicense(citizenid, adminName, reason)
    MySQL.update('UPDATE rds_player_craft_totals SET license_issued = 0 WHERE citizenid = ?', { citizenid })

    for _, src in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and Player.PlayerData.citizenid == citizenid then
            local item = Player.Functions.GetItemByName(Config.License.item)
            if item then
                Player.Functions.RemoveItem(Config.License.item, item.amount)
            end
        end
    end
end

local function HandleTier3Abuse(Player)
    if not Config.Tier3Abuse.enabled then return end

    local cid = Player.PlayerData.citizenid
    local now = os.time()

    Tier3Tracker[cid] = Tier3Tracker[cid] or {}
    table.insert(Tier3Tracker[cid], now)

    for i = #Tier3Tracker[cid], 1, -1 do
        if now - Tier3Tracker[cid][i] > (Config.Tier3Abuse.windowMinutes * 60) then
            table.remove(Tier3Tracker[cid], i)
        end
    end

    if #Tier3Tracker[cid] >= Config.Tier3Abuse.maxCrafts then
        RevokeLicense(cid, 'SYSTEM', Config.Tier3Abuse.autoRevokeReason)
        Tier3Tracker[cid] = {}
    end
end
