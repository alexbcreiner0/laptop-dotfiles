# Uncomment this to get a log of what happens with every line of this zshrc file on starting up a temminal
# set -x
# If you come from bash you might have to change your $PATH.
# Run tmux on startup
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

export XCURSOR_THEME=Bibata-Modern-Classic
export XCURSOR_SIZE=24
export KAGGLE_API_TOKEN=KGAT_c899313a0e3666488ad1f68c6fdf2af1
export MANPAGER='nvim +Man!'

# export OVERSEER_CONFIG=/home/alex/Nextcloud/Personal-Programming/python/Modeling-Tools-Data/laptop_config.yml

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(command cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
command cat ~/.cache/wal/sequences

# Load environment vars
# source "/home/alex/.config/zsh/.zshenv"

#TODO: Move the history to the config folder to share it between systems
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=/home/alex/.zsh_history

# According to ChatGPT:
# This sets the auto_pushd option in zsh. With this option enabled, every time you cd into a new directory, the previous directory is automatically pushed onto a directory stack. This allows you to quickly navigate back to previously visited directories using the pushd, popd, and dirs commands.
setopt auto_pushd

# Initialize the autocompletion. The -u option restricts completion in some ways for security reasons 
autoload compinit 
zstyle ':completion:*' menu select
# Sets up fancier smart matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist # loads a module that make everything better
compinit -u
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Initialize plugins
eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# Enable fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable fzf auto-completion
[ -f ~/.fzf/completion.zsh ] && source ~/.fzf/completion.zsh

source /home/alex/.config/zsh/plugins/zsh_autosuggestions/zsh-autosuggestions.zsh

fpath=(/home/alex/.config/zsh/plugins/zsh-completions/src $fpath)

source /home/alex/.config/zsh/plugins/zsh-autopairs/autopair.zsh

source /home/alex/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/alex/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
    alias rrm='command rm'
    alias nvim-python-example='NVIM_APPNAME="nvim-python-starter" nvim'
    alias nvim-test='NVIM_APPNAME="nvim-rebuild" nvim'
    # laptop only (for now)
    alias gnome-control-center='XDG_CURRENT_DESKTOP=gnome gnome-control-center'
fi

# lazy loading nvm stuff because it's slow as shit
# function load_nvm {
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# }
# alias nvm="load_nvm; nvm"
# alias node="load_nvm; node"
# alias npm="load_nvm; npm"
# alias npx="load_nvm; npx"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# alias rm="/usr/local/bin/trash"
alias sudo='sudo ' # ?????
alias obsidian='flatpak run md.obsidian.Obsidian &'
alias chrome='flatpak run com.google.Chrome &'
alias python='python3'
alias cat='bat --paging=never'
# alias emacs="emacsclient -c -a 'emacs' &" 
alias sublime-text="subl"
# Removes the error message that prints for some kind of issue with curses
alias ranger='ranger 2>/dev/null'
alias yazi="yazi_quits"
alias ssh="TERM=xterm-256color ssh"
# alias neofetch="neofetch --source ~/.config/neofetch/ascii-art-neofetch/communist"
alias vi="nvim"
alias edit-desktop-files="~/dotfiles/.config/rofi/desktop_editor.sh"
alias resource-zshrc="source ~/dotfiles/.config/zsh/.zshrc"
alias edit-zshrc="nvim ~/dotfiles/.config/zsh/.zshrc"

function empty_trash {
    command rm -rf ~/.local/share/Trash/files/*
    command rm -rf ~/.local/share/Trash/info/*
}

alias switch-terminals="term-switch"
function term-switch {
    local arg="$1"
    
    if [[ "$arg" == "student" ]]; then
        rm "/home/alex/.config/starship.toml"
        rm "/home/alex/dotfiles/.config/starship.toml"
        cp "/home/alex/dotfiles/.config/starship-student.toml" "/home/alex/dotfiles/.config/starship.toml"
        stow -d "/home/alex/dotfiles" .
    else
        rm "/home/alex/.config/starship.toml"
        rm "/home/alex/dotfiles/.config/starship.toml"
        cp "/home/alex/dotfiles/.config/starship-mine.toml" "/home/alex/dotfiles/.config/starship.toml"
        stow -d "/home/alex/dotfiles" .
    fi
}

function switch-display-mode {
    local setting=$1
    if [ $setting = "standalone" ]; then
        ~/.config/hypr/scripts/swap_monitors.sh $setting
        ~/.config/hypr/scripts/swap_workspaces.sh $setting
        hyprctl reload
        sed -i 's/^\(Xft.dpi:\s*\)[0-9]\+/\1150/' ~/.Xresources
        xrdb ~/.Xresources
    elif [ $setting = "office" ]; then
        ~/.config/hypr/scripts/swap_monitors.sh $setting
        ~/.config/hypr/scripts/swap_workspaces.sh $setting
        hyprctl reload
        sed -i 's/^\(Xft.dpi:\s*\)[0-9]\+/\150/' ~/.Xresources
        xrdb ~/.Xresources
    elif [ $setting = "classroom" ]; then
        ~/dotfiles/.config/hypr/scripts/swap_monitors.sh "classroom"
        ~/dotfiles/.config/hypr/scripts/swap_workspaces.sh "standalone"
        hyprctl reload
        sed -i 's/^\(Xft.dpi:\s*\)[0-9]\+/\150/' ~/.Xresources
        xrdb ~/.Xresources
    else
        echo "Argument $1 not recognized"
    fi
}

function change-background {
    local image_path=$(realpath $1)

    # Replace hyprpaper with new image
    hyprctl hyprpaper preload $image_path > /dev/null
    local preload_line="preload = $image_path"
    sed -i "1c\\$preload_line" ~/dotfiles/.config/hypr/hyprpaper.conf
    hyprctl hyprpaper wallpaper ",$image_path" > /dev/null
    local wallpaper_line="wallpaper = ,$image_path"
    sed -i "2c\\$wallpaper_line" ~/dotfiles/.config/hypr/hyprpaper.conf
    local lock_line="    path = $image_path"
    sed -i "3c\\$lock_line" ~/dotfiles/.config/hypr/hyprlock.conf

    # Call pywal
    ~/dotfiles/.config/hypr/update_colors.sh $image_path
    killall waybar
    hyprctl dispatch exec waybar > /dev/null
    # Run script to regenerate colors
}

# this comes with bashrc, no idea if it still matters
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=logw -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Allows you to press shift+q in order to exit ranger and simultaneously cd to the directory ranger was looking at
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

# same as above for yazi
function yazi_quits() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	command rm -f -- "$tmp" 2> /dev/null
}

function lazy-commit {
    local commit_msg="$1"

    git add .
    if [ -z "$commit_msg" ]; then
        commit_msg=$(date +"%Y-%m-%d")
    fi
    git commit -m "$commit_msg"
    git push
}

function con-laptop {
    local user="$1"

    if nc -z -w5 192.168.1.59 22; then
        ssh "${user}@192.168.1.59"
    else
        ssh "${user}@24.218.16.45"
    fi
}

function con-device {
    local device="$1"

    if [[ "$device" == "steam-deck" ]]; then
        TERM=xterm-256color ssh deck@steamdeck
    elif [[ "$device" == "home-desktop" ]]; then
        TERM=xterm-256color ssh alex@archibald
    elif [[ "$device" == "server" ]]; then
        TERM=xterm-256color ssh alex@creiner-main-server
    elif [[ "$device" == "laptop-server"  ]]; then
        TERM=xterm-256color ssh alex@192.168.1.62
    elif [[ "$device" == "home-assistant" ]]; then
        TERM=xterm-256color ssh root@homeassistant # doesn't currently work
    elif [[ "$device" == "router" ]]; then
        TERM=xterm-256color ssh root@192.168.1.1
    elif [[ "$device" == 'pikvm' ]]; then 
        TERM=xterm-256color ssh root@pikvm
    elif [[ "$device" == 'laptop' ]]; then
        ssh alex@192.168.1.79
    else
        echo "Unrecognized device. Options are:
- steam-deck
- server
- home-desktop
- laptop-server
- home-assistant
- router
- pikvm"
    fi
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
	# Internal IP Lookup.
	if [ -e /sbin/ip ]; then
		echo -n "Internal IP: "
		/sbin/ip addr show wlo1 | grep "inet " | awk -F: '{print $1}' | awk '{print $2}'
	else
		echo -n "Internal IP: "
		/sbin/ifconfig wlo1 | grep "inet " | awk -F: '{print $1} |' | awk '{print $2}'
	fi

	# External IP Lookup
	echo -n "External IP: "
	curl -s ifconfig.me
}

alias newbackgroundplease="newbackgroundplease"
function newbackgroundplease () {
    /home/alex/dotfiles/.config/hypr/scripts/randomize_wallpaper.py "$1" > /dev/null
}


