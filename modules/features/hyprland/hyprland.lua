require("conf.monitor")
require("conf.keybinds")

hl.on("hyprland.start", function()
	hl.exec_cmd("[workspace 1 silent] ghostty")
	hl.exec_cmd("[workspace 2 silent] zen-twilight")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd("noctalia")
end)

hl.config({
	input = {
		follow_mouse = 1,
		kb_layout = "fr",
		kb_variant = "azerty",
		touchpad = {
			natural_scroll = true,
		},
	},

	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 0,
		col = {
			active_border = "rgb(198,160,246)",
			inactive_border = "rgb(183,189,248)",
		},
	},

	decoration = {
		rounding = 16,
		rounding_power = 2,
	},

	animations = {
		enabled = true,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		vrr = false,
	},
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 2,
	bezier = "default",
	style = "slide",
})
