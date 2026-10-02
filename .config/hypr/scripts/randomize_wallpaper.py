#!/bin/python3
from pathlib import Path
import random
import subprocess
import sys
import re

WALLPAPER_DIR = Path("/home/alex/Nextcloud/Desktop Backgrounds/Adventure Time")
SCRIPT_DIR = Path("/home/alex/dotfiles/.config/hypr/scripts")

bookmarks = {
    "bmo": "/home/alex/Nextcloud/Desktop Backgrounds/Adventure Time/2026-05-07-223619_hyprshot.png",
    "old_reliable": "/home/alex/Nextcloud/Desktop Backgrounds/wallhaven-kx516d.png"
}

def get_new_wall(args):
    if len(args) >= 2 and args[1]:
        arg = args[1]
        if Path(arg).exists():
            return arg
        if arg in bookmarks:
            return bookmarks[arg]
        
    return get_random_wall()

def get_colors():
    with open("/home/alex/.cache/wal/colors") as f:
        old_colors = f.readlines()

    return [color.strip() for color in old_colors]

def get_random_wall():
    wallpaper_paths = list(WALLPAPER_DIR.iterdir())
    return random.choice(wallpaper_paths)

def change_wallpapers(new_wall):
    cmd = [
        "hyprctl",
        "hyprpaper",
        "wallpaper",
        f",{new_wall},cover"
    ]

    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True
    )

    print("return code:", result.returncode)
    print("stdout:", repr(result.stdout))
    print("stderr:", repr(result.stderr))

# ASSUMES LABEL FIELD IS LAST AND NO COLOR LINES APPEAR AFTER
def update_hyprlock(new_wall):
    new_label_color = get_colors()[1]
    new_text = ""
    with open(SCRIPT_DIR.parent / "hyprlock.conf") as f:
        first_path_seen = False
        label_body_seen = False
        for line in f:
            if not first_path_seen and "path" in line:
                new_text += f"    path = {new_wall}\n"
                first_path_seen = True
            elif label_body_seen and "color" in line:
                new_text += f"    color = rgb({new_label_color})\n"
            else:
                new_text += line
            if not label_body_seen and "label {" in line:
                label_body_seen = True

    with open(SCRIPT_DIR.parent / "hyprlock.conf", "w") as f:
        f.write(new_text)

def regenerate_colors(new_wall):
    # first, get a list of the old colors (since wal doesn't generate a file for starship)
    old_colors = get_colors()

    cmd_1 = ["wal", "-i", f"{new_wall}"]
    result = subprocess.run(
        cmd_1,
        capture_output= True,
        text= True
    )
    print("return code:", result.returncode)
    print("stderr:", repr(result.stderr))

    return old_colors

def reload_waybar():
    cmd_2 = ["killall", "-SIGUSR2", "waybar"]

    result = subprocess.run(
        cmd_2,
        capture_output= True,
        text= True
    )
    print("return code:", result.returncode)
    print("stderr:", repr(result.stderr))

def update_starship():
    new_colors = get_colors()

    with open("/home/alex/dotfiles/.config/starship.toml") as f:
        config = f.read()

    old_colors = re.findall(r"#[0-9A-Fa-f]{6}", config)
    with open("/home/alex/dotfiles/.config/starship.toml.bak", "w") as f:
        f.write(config)
    
    for i in range(len(old_colors)):
        config = config.replace(old_colors[i], new_colors[i])

    print(f"{config=}")

    with open("/home/alex/dotfiles/.config/starship.toml", "w") as f:
        f.write(config)

def update_pywalfox():
    pass
    # if you ever feel like dealing with this, the old command was
    # pywalfox update > /dev/null 2>&1

def reload_noctalia():
    cmd = ["noctalia", "msg", "config-reload"]

    result = subprocess.run(
        cmd,
        capture_output= True,
        text= True
    )
    print("return code:", result.returncode)
    print("stderr:", repr(result.stderr))


if __name__ == "__main__":
    new_wall = get_new_wall(sys.argv)
    change_wallpapers(new_wall)
    update_hyprlock(new_wall)
    old_colors = regenerate_colors(new_wall)
    reload_waybar()
    reload_noctalia()
    update_starship()
    result = subprocess.run(
        ["wal", "--preview"],
        capture_output= True,
        text= True
    )
