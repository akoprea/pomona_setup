
# ~/.bash_profile
#

#### 
# This bash file should hold any processes that should be run EVERY time the I log in
####

# Welcome message
## printf "Welcome back, $(whoami)!\n"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add splash to /etc/issue
# Works bc perms of ^ are 646.
cat ~/Scripts/etc_issue_base.txt > /etc/issue 	# clears old and resets base
python3 ~/Scripts/splash-generator/splash.py >> /etc/issue
echo >> /etc/issue 	# add newline to end

# Start x-server for DWM quietly (see ~/.xinitrc)
startx &> /dev/null

