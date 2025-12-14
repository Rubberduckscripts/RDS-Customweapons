Config = {}

Config.Version = '1.0.0'

Config.VersionCheck = {
    enabled = true,
    url = 'https://raw.githubusercontent.com/RubberDuckScripts/RDS-Customweapons/main/version.json'
}

Config.Job = 'ghost'

Config.License = {
    item = 'weapon_license'
}

Config.Tier3Abuse = {
    enabled = true,
    maxCrafts = 3,
    windowMinutes = 10,
    autoRevokeLicense = true,
    autoRevokeReason = 'Excessive Tier-3 crafting activity',
    blockCrafting = true
}

Config.Webhooks = {
    Throwables = '',
    Licenses = ''
}
