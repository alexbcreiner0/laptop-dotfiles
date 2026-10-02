local scripts_dir = os.getenv("HOME") .. "/.config/hypr/scripts"
local home_dir = os.getenv("HOME")

hl.bind("SUPER + Q", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nemo"))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + I", hl.dsp.exec_cmd("waybar"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("killall waybar"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd(scripts_dir .. "/toggle_opacity.py"))

hl.bind("SUPER + KP_add", function()
    hl.plugin.hyprexpo.expo("toggle all")
end)

hl.bind("CTRL + W", hl.dsp.window.close(), {description = "Close Program"})
hl.bind("CTRL + SHIFT + W", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Forcefully zap a window" })
hl.bind("SUPER + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
-- hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("wlogout"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("gnome-system-monitor"))

hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = "Window: Fullscreen" })

hl.bind("SUPER + U", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86Launch6", hl.dsp.exec_cmd(scripts_dir .. "/toggle_mode.sh"))

hl.bind("SHIFT + SUPER + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
-- hl.bind("SHIFT + SUPER + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload; killall -SIGUSR2 waybar"))


-- hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
-- hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- hl.bind("SUPER + B", hl.dsp.exec_cmd("hyprshot -m window"))
-- hl.bind("SUPER + N", hl.dsp.exec_cmd("hyprshot -m region"))

-- hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
-- hl.bind("SUPER + N", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
-- hl.bind("PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))

hl.bind("SUPER + N", hl.dsp.submap("screenshots"))
hl.bind("PRINT", hl.dsp.submap("screenshots"))

hl.define_submap("screenshots", function()
    hl.bind("A", function()
        hl.dispatch(hl.dsp.exec_cmd("noctalia msg screenshot-annotate"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)

    hl.bind("F", function()
        hl.dispatch(hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)

    hl.bind("R", function()
        hl.dispatch(hl.dsp.exec_cmd("noctalia msg screenshot-region"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)

    hl.bind("P", function()
        hl.dispatch(hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen pick"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)

    hl.bind("escape", hl.dsp.submap("reset"))
end)

for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local vimkey = { "H", "L", "K", "J" }
    local focusdir = { "l", "r", "u", "d" }
    hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }),
        { description = "Window: Focus " .. arrowkey[i] })
    hl.bind("SUPER + " .. vimkey[i], hl.dsp.focus({ direction = focusdir[i] }),
        { description = "Window: Focus " .. arrowkey[i] })
    hl.bind(
        "SUPER + SHIFT + " .. arrowkey[i], hl.dsp.exec_cmd(scripts_dir .. "/switch_monitor.sh")
    )
end

for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Move" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize"})

-- workspace nav scripts
hl.bind("CTRL + ALT + Left", hl.dsp.exec_cmd(scripts_dir .. "/nav_workspaces.sh --left"))
hl.bind("CTRL + ALT + Right", hl.dsp.exec_cmd(scripts_dir .. "/nav_workspaces.sh --right"))
hl.bind("CTRL + ALT + SHIFT + Left", hl.dsp.exec_cmd(scripts_dir .. "/move_workspaces.sh --left"))
hl.bind("CTRL + ALT + SHIFT + Right", hl.dsp.exec_cmd(scripts_dir .. "/move_workspaces.sh --right"))

hl.bind("SUPER + W", hl.dsp.exec_cmd("noctalia msg desktop-widgets-toggle"))

-- special workspaces
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("minimized"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.move({workspace = "special:minimized", follow = false}))
hl.bind("SUPER + T", hl.dsp.workspace.toggle_special("tray"))
