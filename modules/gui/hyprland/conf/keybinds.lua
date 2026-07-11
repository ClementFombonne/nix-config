local terminal = "ghostty"
local browser = "zen-twilight"
local menu = "noctalia msg panel-toggle launcher"
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

local ws_keys = {
	{ key = "ampersand", ws = 1 },
	{ key = "eacute", ws = 2 },
	{ key = "quotedbl", ws = 3 },
	{ key = "apostrophe", ws = 4 },
	{ key = "parenleft", ws = 5 },
	{ key = "minus", ws = 6 },
	{ key = "egrave", ws = 7 },
	{ key = "underscore", ws = 8 },
	{ key = "ccedilla", ws = 9 },
	{ key = "agrave", ws = 10 },
}

for _, v in ipairs(ws_keys) do
	hl.bind(mainMod .. " + " .. v.key, hl.dsp.focus({ workspace = v.ws }))
	hl.bind(mainMod .. " + SHIFT + " .. v.key, hl.dsp.window.move({ workspace = v.ws }))
end

local bindel_flags = { repeating = true, locked = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), bindel_flags)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), bindel_flags)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), bindel_flags)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), bindel_flags)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), bindel_flags)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), bindel_flags)

local bindl_flags = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), bindl_flags)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), bindl_flags)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), bindl_flags)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), bindl_flags)
