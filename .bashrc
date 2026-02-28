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
alias musicmanager='sudo python ~/Documents/3.Python\ Programs/MusicManager/musicmanager/mp3_player_manager_v2_withGUI.pyw'
alias ytdlp='yt-dlp -x --audio-format mp3 --embed-metadata '
alias ports='sudo ss -tulpn' # see open ports

# dwm+ specific
alias cdwm="nano ~/.#/dwm/config.h; nano ~/.#/dwmblocks-async/config.h"
alias mdwm="cd ~/.#/dwm; sudo make clean install; cd -; echo '====================='; cd ~/.#/dwmblocks-async; sudo make clean install; cd -"
alias cplayers="nano ~/.#/scripts/players.txt"

# terminal math
__calc() {
	python -c "from math import *; print($*)"
	set +f # reenable wildcard expansion
}
alias C='set -f; __calc '

export PATH="$PATH:~/Scripts"
export EDITOR="nano"
export VISUAL="nano"


