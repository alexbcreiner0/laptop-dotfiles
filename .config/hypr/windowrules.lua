-- WINDOWS AND WORKSPACES
hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- DO NOT REMOVE THESE COMMENTS -- 
-- OPACITIES --
hl.window_rule({
   name = "kitty-opacity",
   match = { class = "kitty" },
   opacity = "0.85",
   xray = true,
})

hl.window_rule({
   name = "spotify-opacity",
   match = { class = "spotify" },
   opacity = "0.85",
   xray = true,
})

hl.window_rule({
   name = "md.obsidian.Obsidian-opacity",
   match = { class = "md.obsidian.Obsidian" },
   opacity = "0.85",
   xray = true,
})

hl.window_rule({
   name = "nemo-opacity",
   match = { class = "nemo" },
   opacity = "0.85",
   xray = true,
})

-- END OPACITIES --

hl.window_rule({
    name = "alacritty-floating",
    match = { class = "Alacritty" },
    float = true,
    size = { 600, 400 },
    move = { "cursor_x + (-300)", "cursor_y + (-200)" },
})

hl.window_rule({
    name = "nemo-floating",
    match = { class = "nemo" },
    float = true,
    size = { 700, 530 },
})

hl.window_rule({
    name = "wine-desktop-floating",
    match = { title = "Wine Desktop" },
    float = true,
    size = { 700, 530 },
})

-- hl.window_rule({
--     name = "kitty",
--     match = { class = "kitty" },
--     float = true,
--     size = { 800, 600 },
-- })

hl.window_rule({
    name = "gnome-weather-floating",
    match = { class = "org.gnome.Weather" },
    float = true,
    size = { 1060, 500 },
})

hl.window_rule({
    name = "zotero-plugin-manager",
    match = { class = "Zotero", title = "Plugins Manager" },
    float = true,
    size = { 1060, 500 },
})

hl.window_rule({
    name = "gnome-calendar-floating",
    match = { class = "org.gnome.Calendar" },
    float = true,
    size = { 1000, 700 },
})

hl.window_rule({
    name = "nwg-look-floating",
    match = { class = "nwg-look" },
    float = true,
    size = { 660, 600 },
})

hl.window_rule({
    name = "blueberry-floating",
    match = { class = "blueberry.py" },
    float = true,
    size = { 600, 600 },
    move = { "cursor_x + (-200)", "cursor_y + (-200)" },
})

hl.window_rule({
    name = "gnome-clocks-floating",
    match = { class = "org.gnome.clocks" },
    float = true,
})

hl.window_rule({
    name = "gnome-clock-size",
    match = { class = "org.gnome.clock" },
    size = { 600, 400 },
})

hl.window_rule({
    name = "pavucontrol-floating",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    size = { 630, 340 },
})

hl.window_rule({
    name = "gnome-settings-floating",
    match = { class = "org.gnome.Settings" },
    float = true,
    size = { 700, 800 },
})

hl.window_rule({
    name = "gnome-calculator-floating",
    match = { class = "org.gnome.Calculator" },
    float = true,
    size = { 360, 590 },
})

hl.window_rule({
    name = "python-on-dp4",
    match = { class = "python3" },
    monitor = "DP-4",
})

hl.window_rule({
    name = "celeste-tray",
    match = { class = "com.hunterwittenborn.Celeste" },
    float = true,
    move = { 45, 500 },
    size = { 760, 550 },
    workspace = "special:tray silent",
})

hl.window_rule({
    name = "kdeconnect-tray",
    match = { class = "org.kde.kdeconnect.app" },
    float = true,
    size = { 270, 270 },
    move = { 860, 120 },
    workspace = "special:tray silent",
})

hl.window_rule({
    name = "insync-tray",
    match = { class = "insync" },
    float = true,
    size = { 800, 600 },
    move = { 900, 460 },
    workspace = "special:tray silent",
})

hl.window_rule({
    name = "nextcloud-tray",
    match = { class = "com.nextcloud.desktopclient.nextcloud" },
    float = true,
    size = { 670, 380 },
    move = { 80, 75 },
    workspace = "special:tray silent",
})

hl.window_rule({
    name = "spotify-size",
    match = { class = "Spotify" },
    size = { 600, 400 },
})

hl.window_rule({
    name = "popsicle-floating",
    match = { class = "Popsicle" },
    float = true,
    size = { 550, 400 },
})

hl.window_rule({
    name = "signal-magic",
    match = { class = "signal" },
    float = true,
    size = { 840, 530 },
    workspace = "special:magic silent",
    move = { "monitor_w * 0.1", "monitor_h * 0.1" },
})

-- hl.window_rule({
--     name = "kitty-opacity",
--     match = { class = "kitty" },
--     opacity = "0.9",
--     xray = true,
-- })

-- XWayland / lowercase class variants
hl.window_rule({
    name = "spotify-lowercase-on-dp4",
    match = { class = "spotify" },
    monitor = "DP-4",
})

hl.window_rule({
    name = "obsidian-on-dp4",
    match = { class = "obsidian" },
    monitor = "DP-4",
})

hl.window_rule({
    name = "suppress-maximize-c-suffix",
    match = { class = ".*C" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "mpv-floating",
    match = { class = "mpv" },
    float = true,
    size = { 1500, 900 },
})

hl.window_rule({
    name = "dolphin-emu-floating",
    match = { class = "^dolphin-emu$" },
    float = true,
    focus_on_activate = true,
})

