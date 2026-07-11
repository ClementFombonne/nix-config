local mainMonitor = "DP-1"
local secondMonitor = "DP-4"
local thirdMonitor = "eDP-1"

hl.monitor({ output = "DP-4", mode = "1920x1080@143.85", position = "0x0", scale = 1, transform = 1 })
hl.monitor({ output = "DP-1", mode = "2560x1440@165.00", position = "1080x0", scale = 1.25 })
hl.monitor({ output = "eDP-1", mode = "3072x1920@120.00", position = "3128x0", scale = 2 })

hl.workspace_rule({ workspace = 1, monitor = mainMonitor, layout = "scrolling", default = true, persistent = true })
hl.workspace_rule({ workspace = 2, monitor = mainMonitor })
hl.workspace_rule({ workspace = 3, monitor = mainMonitor })

hl.workspace_rule({ workspace = 4, monitor = secondMonitor })
hl.workspace_rule({ workspace = 5, monitor = secondMonitor })
hl.workspace_rule({ workspace = 6, monitor = secondMonitor })

hl.workspace_rule({ workspace = 7, monitor = thirdMonitor })
hl.workspace_rule({ workspace = 8, monitor = thirdMonitor })
hl.workspace_rule({ workspace = 9, monitor = thirdMonitor })
