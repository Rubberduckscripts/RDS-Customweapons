local QBCore = exports['qb-core']:GetCoreObject()

print('========================================')
print('[  script:rds-loading] Rubber Ducks Script RDS Custom Crafting')
print('[  script:rds-loading] Author: Rubber Duck Scripts (RDS)')
print('[  script:rds-loading] Version: ' .. Config.Version)
print('========================================')

-- VERSION CHECK
CreateThread(function()
    if not Config.VersionCheck.enabled then return end
    Wait(2000)
    PerformHttpRequest(Config.VersionCheck.url, function(code, data)
        if code ~= 200 or not data then return end
        local json = json.decode(data)
        if json and json.version ~= Config.Version then
            print('[RDS] UPDATE AVAILABLE | Current: ' .. Config.Version .. ' Latest: ' .. json.version)
        end
    end, 'GET')
end)

local Tier3Tracker = {}

local function SendWebhook(url, title, fields)
    if not url or url == '' then return end
    PerformHttpRequest(url, function() end, 'POST', json.encode({
        username = 'RDS Logs',
        embeds = {{
            title = title,
            color = 16753920,
            fields = fields,
            footer = { text = 'RDS-Customweapons' },
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }}
    }), { ['Content-Type'] = 'application/json' })
end

local function GenerateSerial(tier)
    return ('RDS-%s-%d'):format(tier:gsub(' ', ''), math.random(100000, 999999))
end

local function RevokeLicense(citizenid, admin, reason)
    MySQL.update('UPDATE rds_player_craft_totals SET license_issued = 0 WHERE citizenid = ?', { citizenid })

    for _, src in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and Player.PlayerData.citizenid == citizenid then
            local item = Player.Functions.GetItemByName(Config.License.item)
            if item then Player.Functions.RemoveItem(Config.License.item, item.amount) end
        end
    end

    SendWebhook(Config.Webhooks.Licenses, 'License Revoked', {
        { name = 'CitizenID', value = citizenid },
        { name = 'Admin', value = admin },
        { name = 'Reason', value = reason }
    })
end

RegisterNetEvent('RDS-Customweapons:server:craft', function(item, category, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.PlayerData.job.name ~= Config.Job then return end
    if Player.PlayerData.job.grade.level < Config.Benches[category].minGrade then return end

    local recipe = Config.ItemRecipes[item]
    if not recipe then return end

    for mat, qty in pairs(recipe) do
        if not Player.Functions.GetItemByName(mat) then return end
        if Player.Functions.GetItemByName(mat).amount < qty then return end
    end

    for mat, qty in pairs(recipe) do
        Player.Functions.RemoveItem(mat, qty)
    end

    local tier = Config.RecipeTiers[category]
    local serial = GenerateSerial(tier)

    Player.Functions.AddItem(item, amount or 1, false, {
        serial = serial,
        tier = tier
    })

    MySQL.insert(
        'INSERT INTO rds_weapon_serials (citizenid, player_name, job, job_grade, item, label, category, tier, serial, amount, materials) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        {
            Player.PlayerData.citizenid,
            Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
            Player.PlayerData.job.name,
            Player.PlayerData.job.grade.level,
            item,
            QBCore.Shared.Items[item].label,
            category,
            tier,
            serial,
            amount or 1,
            json.encode(recipe)
        }
    )

    if category == 'throwables' then
        Tier3Tracker[Player.PlayerData.citizenid] = (Tier3Tracker[Player.PlayerData.citizenid] or 0) + 1
        if Tier3Tracker[Player.PlayerData.citizenid] >= Config.Tier3Abuse.maxCrafts then
            RevokeLicense(Player.PlayerData.citizenid, 'SYSTEM', Config.Tier3Abuse.autoRevokeReason)
        end
    end
end)

QBCore.Commands.Add('craftstats', 'View craft totals', {}, false, function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name ~= 'ghost' or Player.PlayerData.job.grade.level < 5 then return end

    MySQL.single('SELECT * FROM rds_player_craft_totals WHERE citizenid = ?', {
        Player.PlayerData.citizenid
    }, function(data)
        if not data then return end
        TriggerClientEvent('chat:addMessage', src, {
            args = { 'RDS', 'Total Crafts: ' .. data.total }
        })
    end)
end)
