Config = {}

Config.Version = '1.0.0'

Config.VersionCheck = {
    enabled = true,
    url = 'https://raw.githubusercontent.com/RubberDuckScripts/RDS-Customweapons/main/version.json'
}

Config.Job = 'ghost'
Config.RequiredGrade = 1

Config.License = {
    item = 'weapon_license'
}

Config.Tier3Abuse = {
    enabled = true,
    maxCrafts = 3,
    windowMinutes = 10,
    autoRevokeLicense = true,
    autoRevokeReason = 'Tier-3 crafting abuse detected'
}

Config.Webhooks = {
    Melee = "https://discord.com/api/webhooks/1449740702794649683/iqoPJJUY_gJMdpQrMcrU5cVwESSq6QxRbEyU37qx3teH4BOZBuM6YJAQ8Y6S5KdwVc7Z",
    Firearms = "https://discord.com/api/webhooks/1449740799213436995/hU1vBuSF3Hv3an1qtjHWGwS8alVr5QnqrEuSj0pNjY0FcRmXiQ7dKtgKt170alCOOfby",
    Attachments = "https://discord.com/api/webhooks/1449741043716329579/A5twuazfx3F0PxJeXT3rc9I3gEChAZp-UsldL4PMCBc_NvgFqOdmWgSaozHMsCtPCGeF",
    Ammo = "https://discord.com/api/webhooks/1449741140088590501/lqOaUQwXWwYUjlheLfn28HAZ4BFi0Xv07VXs39YvdEZGvdlpPPGOoa5Ix37NGIcnnbbr",
    Tints = "https://discord.com/api/webhooks/1449741229406421125/bJzyFvIzqPj3fCBWpvjKHCN7nwe0ame786KjfHKeUsSLKyag5zBy04zTeYobwcDrhrxQ",
    Throwables = "https://discord.com/api/webhooks/1449741311316988077/G9x397B6yS7lFA1A58JpevI3EV5CH15RyqNGf821V7YCytA75p3awp2QkF1PweXg1qyD",
    Items Seriels = "https://discord.com/api/webhooks/1449741389272318032/Zoqp33JzPeWFSJBd-lLX7oTVgKcDlhKWp3Y4kr_z5xEtMZfrgKVVbdEA--KV_7AwL_By",
    Licenses = "https://discord.com/api/webhooks/1449741526124204266/oXf8bw3zKlbQ1oaNb_gnsc-y6_uss9tTlgI4UFWHXyRxzpnB3ZlRVUzGAmfpQbFj4Wlw",
    CraftTotals = ''
}

Config.RecipeTiers = {
    melee = 'Tier 1',
    firearms = 'Tier 2',
    attachments = 'Tier 2',
    ammo = 'Tier 1',
    tints = 'Tier 1',
    throwables = 'Tier 3'
}

Config.Benches = {
    melee = { label = 'Melee Bench', minGrade = 1 },
    firearms = { label = 'Firearms Bench', minGrade = 2 },
    attachments = { label = 'Attachment Bench', minGrade = 2 },
    ammo = { label = 'Ammo Bench', minGrade = 1 },
    tints = { label = 'Tint Bench', minGrade = 1 },
    throwables = { label = 'Explosives Bench', minGrade = 4 }
}

Config.ItemRecipes = {
    weapon_pistol = {
        steel = 15,
        aluminum = 10,
        springs = 2
    },
    weapon_knife = {
        steel = 5,
        rubber = 1
    },
    pistol_ammo = {
        gunpowder = 5,
        copper = 5
    }
}
