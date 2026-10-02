#!/bin/python3
CONFIG_DIR = "/home/alex/dotfiles/.config/hypr"
TRANS_OPACITY = 0.85

# the CLASS
whitelist = [
    "kitty",
    "spotify",
    "md.obsidian.Obsidian",
    "nemo"
]

def get_window_rules():
    after_lines = []
    with open(f"{CONFIG_DIR}/windowrules.lua") as f:
        all_lines = f.readlines()

    start = all_lines.index("-- OPACITIES --\n")
    stop = all_lines.index("-- END OPACITIES --\n")

    before_lines = all_lines[:start+1]
    op_section_lines = all_lines[start+1:stop]
    after_lines = all_lines[stop:len(all_lines)]

    return before_lines, op_section_lines, after_lines

def get_window_rule(name):
    return [
        "hl.window_rule({\n",
        f"   name = \"{name}-opacity\",\n",
        f"   match = {{ class = \"{name}\" }},\n",
        f"   opacity = \"{TRANS_OPACITY}\",\n"
        "   xray = true,\n",
        "})\n",
        "\n"
    ]

def revise_op_section_lines(op_section_lines):
    opacity_on = (len(op_section_lines) > 0)
    op_section_lines.clear()
    if not opacity_on:
        for name in whitelist:
            op_section_lines += get_window_rule(name)

def rebuild_config(*line_lists):
    new_config = ""
    for line_list in line_lists:
        for line in line_list:
            new_config += line

    return new_config
   
if __name__ == "__main__":
    before_lines, op_section_lines, after_lines = get_window_rules()
    revise_op_section_lines(op_section_lines)
    new_config = rebuild_config(before_lines, op_section_lines, after_lines)

    with open(f"{CONFIG_DIR}/windowrules.lua.bak", "w") as f:
        f.write(new_config)

    with open(f"{CONFIG_DIR}/windowrules.lua", "w") as f:
        f.write(new_config)

