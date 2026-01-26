#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors and Prompt
alias ls='ls --color=auto'
alias grep='grep --color=auto'
## PS1='[\u@\h \W]\$ '
PS1='\[\033[0;32m\]\u@\h:\[\033[0;34m\]\w\[\033[0m\]\$ '


alias cls="clear"
alias ..="cd .."
alias ll="ls -la"
alias spotdl="~/.venv/python-spotdl/bin/spotdl"

# dwm specific
alias cdwm="nano ~/.#/dwm/config.h"
alias mdwm="cd ~/.#/dwm; sudo make clean install; cd -"

export PATH="$PATH:~/Scripts"
