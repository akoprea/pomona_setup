#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors and Prompt
alias ls='ls --color=auto'
alias grep='grep --color=auto'
## PS1='[\u@\h \W]\$ '
PS1='\[\e[1;31m\]\u@\h:\[\e[0;34m\]\w\[\e[0m\]\$ '
## \033 instead of \e

alias cls="clear"
alias ..="cd .."
alias la="ls -a"
alias ll="ls -la"
alias rp="realpath ."
alias t='tldr'
alias musicmanager='sudo python ~/Documents/3.Python\ Programs/MusicManager/musicmanager/mp3_player_manager_v2_withGUI.pyw'
alias ytdlp='yt-dlp -x --audio-format mp3 --embed-metadata '
alias spotdl='~/.venv/myvenv/bin/spotdl'
alias show-ports='sudo ss -tulpn' # see open ports
alias notify-see="dunstctl history-pop"
alias py='python'
alias vpython='~/.venv/myvenv/bin/python' # python venv
alias vpy='vpython'

# dwm+ specific
alias cdwm="nano ~/.#/dwm/config.h; nano ~/.#/dwmblocks-async/config.h"
alias mdwm="cd ~/.#/dwm; sudo make clean install; cd -; echo '====================='; cd ~/.#/dwmblocks-async; sudo make clean install; cd -"
alias cplayers="nano ~/.#/scripts/players.txt"

export PATH="$PATH:~/Scripts"
export EDITOR="nano"
export VISUAL="nano"


