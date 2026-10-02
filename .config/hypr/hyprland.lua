require("monitors")
require("keybindings")
require("windowrules")
require("decoration")
require("animations")
require("general")

-- ENVIRONMENT_VARIABLES --
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", "/home/alex/Pictures/Screenshots")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
hl.env("GDK_SCALE", "2")

-- try deleting later, temporary fix
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 2 && hyprctl reload")
end)

hl.on("hyprland.start", function ()
    hl.exec_cmd("dunst -config \"$HOME/.config/dunst/dunstrc\"")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("hyprpaper & sleep 3; /home/alex/dotfiles/.config/hypr/scripts/randomize_wallpaper.py 2> /home/alex/dotfiles/.config/hypr/user_err.txt ")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("noctalia -d")
    hl.exec_cmd("numlockx on")
    hl.exec_cmd("sleep 2 && hyprctl reload")
    hl.exec_cmd("copyq --start-server")
    hl.exec_cmd("hyprpm reload")
    -- hl.exec_cmd("wlsunset -l 42.360081 -L -71.058884")
    hl.exec_cmd("nextcloud")
    -- hl.exec_cmd("insync start")
    hl.exec_cmd("kdeconnect-app")
    hl.exec_cmd("signal-desktop")
    -- hl.exec_cmd("sleep 5 && insync show")
    hl.exec_cmd("/opt/brother/scanner/brscan-skey/brscan-skey")
    hl.exec_cmd("hyprswitch init --show-title &")
    hl.exec_cmd("$HOME/.config/hypr/hyprland/scripts/start_geoclue_agent.sh")
    hl.exec_cmd("qs -c $qsConfig")
    hl.exec_cmd("$HOME/.config/hypr/custom/scripts/__restore_video_wallpaper.sh")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Some fix idk
    hl.exec_cmd("easyeffects --hide-window --service-mode")
    hl.exec_cmd("wl-clipboard-history-t")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("wl-paste --type text --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update'")
    hl.exec_cmd("wl-paste --type image --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update'")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

hl.config({
    plugin = {
        hyprexpo = {
            columns = 3,
            gaps_in = 5,
            gaps_out = 0,
            bg_col = "rgb(111111)",
            workspace_method = "center current",
            gesture_distance = 200,
            cancel_key = "escape",
            show_cursor = 1,
        },
    },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 4,
  direction = "down",
  action = function()
        hl.plugin.hyprexpo.expo("toggle all")
    end,
})

for workspace = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "eDP-1",
        persistent = true,
    })
    hl.workspace_rule({
        workspace = tostring(workspace+5),
        monitor = "DP-4",
        persistent = true,
    })
end

hl.workspace_rule({workspace = "special:minimized", persistent = true, default_name = "minimized"})

hl.config({
    dwindle = {
        preserve_split = true,
        force_split = 2
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_anr_dialog = false,
        background_color = 0x0000000
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true
        }
    },
    debug = {
        disable_logs = false
    }
})

-- hl.config({
--     plugin = {
--         hyprbars = {
--             bar_height = 20,
--             on_double_click = "hyprctl dispatch fullscreen 1",
--         },
--     },
-- })

-- hl.plugin.hyprbars.add_button({
--     bg_color = "rgb(ff4040)",
--     fg_color = "rgb(ffffff)",
--     size = 10,
--     icon = "X",
--     action = "hyprctl dispatch killactive",
-- })

-- hl.plugin.hyprbars.add_button({
--     bg_color = "rgb(eeee11)",
--     fg_color = "rgb(000000)",
--     size = 10,
--     icon = "_",
--     action = "hyprctl dispatch fullscreen 1",
-- })
