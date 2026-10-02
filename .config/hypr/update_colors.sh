#!/bin/bash

# Create list of old colors
old_colors=()
i=0
while IFS= read -r line; do
    old_colors[i]=$line
    ((i++))
done < ~/.cache/wal/colors
# echo "Old colors: ${old_colors[@]}"

wal -i "$1"
sed -i 's/#//' ~/.cache/wal/colors-hyprland.conf

new_colors=()
i=0
while IFS= read -r line; do
    new_colors[i]=$line
    ((i++))
done < ~/.cache/wal/colors
# echo "New colors: ${new_colors[@]}"

for (( i = 0; i < ${#old_colors[@]}; i++)); do
    sed -i "s/${old_colors[$i]}/${new_colors[$i]}/g" ~/dotfiles/.config/starship.toml
    sed -i "s/${old_colors[$i]}/${new_colors[$i]}/g" ~/dotfiles/.config/cava/config
done

pywalfox update > /dev/null 2>&1

# lines_list=()
# i=0
# while IFS= read -r line; do
#     i=$(( i + 1 ))
#     color=$(sed -n "${i}p" ~/.cache/wal/colors-hyprland.conf)
#     lines_list+=("$line")
# done < ~/.cache/wal/colors-hyprland.conf

text="    color = ${new_colors[1]}"
# background="    color = ${lines_list[5]}"
# back_border="    border_color = ${lines_list[3]}"
sed -i "55c\\$text" ~/dotfiles/.config/hypr/hyprlock.conf
# sed -i "68c\\$text" ~/dotfiles/.config/hypr/hyprlock.conf
