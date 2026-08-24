-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
	local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
	local entry = share .. "/hypr/hyde.lua"
	local handle = io.open(entry, "r")
	if not handle then
		error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
	end
	handle:close()
	dofile(entry)
end

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").
hl.config({
	input = {
		kb_layout = "us,ir",
		kb_options = "caps:escape_shifted_capslock",
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("~/.local/bin/todo")
end)

_F = { description = "[Launcher|Apps] browser" }
hl.bind("SUPER + B", hl.dsp.exec_cmd("qutebrowser"), _F)
_F = { description = "[Launcher|Apps] File Manager" }
hl.bind("SUPER + E", hl.dsp.exec_cmd("yazi"), _F)
_F = { description = "[Launcher|Apps] Editor" }
hl.bind("SUPER + C", hl.dsp.exec_cmd("nvim"))
_F = { description = "[Launcher|Apps] Waterfox" }
hl.bind("SUPER + F", hl.dsp.exec_cmd("waterfox"))
_F = { description = "[Launcher|Apps] Telegram" }
hl.bind("SUPER + G", hl.dsp.exec_cmd("Telegram"))
_F = { description = "[Utilities] System Update" }
hl.bind("SUPER + U", hl.dsp.exec_cmd("hyde-shell system.update up"))
_F = { description = "[Utilities] Word Definition" }
hl.bind("SUPER + ALT + D", hl.dsp.exec_cmd("define"))

local kp = {
	[1] = { "plus" },
	[2] = { "bracketleft" },
	[3] = { "braceleft" },
	[4] = { "parenleft" },
	[5] = { "equal" },
	[6] = { "dollar" },
	[7] = { "ampersand" },
	[8] = { "parenright" },
	[9] = { "braceright" },
	[10] = { "bracketright" },
}
for i = 1, 10 do
	hl.unbind("SUPER + " .. i)
	for _, key in ipairs(kp[i]) do
		hl.bind(
			"SUPER + " .. key,
			hl.dsp.focus({ workspace = tostring(i) }),
			{ description = "[Workspaces|Navigation] navigate to workspace " .. i }
		)
	end
end
-- move window to workspace
for i = 1, 10 do
	hl.unbind("SUPER + SHIFT + " .. i)
	for _, key in ipairs(kp[i]) do
		hl.bind(
			"SUPER + SHIFT + " .. key,
			hl.dsp.window.move({ workspace = tostring(i) }),
			{ description = "[Workspaces|Move window to workspace] move focused window to workspace " .. i }
		)
	end
end
-- move window to workspace silent
for i = 1, 10 do
	hl.unbind("SUPER + ALT + " .. i)
	for _, key in ipairs(kp[i]) do
		hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = tostring(i), follow = false }), {
			description = "[Workspaces|Move window to workspace (Don't follow)] move focused window to workspace " .. i,
		})
	end
end

_F = { description = "[Window Management|Change focus] focus left" }
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }), _F)
hl.unbind("SUPER + L")
_F = { description = "[Window Management|Change focus] focus right" }
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }), _F)
