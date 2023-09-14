alias zshrc="vim ~/.zshrc"
alias sshrc="vim ~/.ssh/config"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias token="tokendito"

#Git
alias nah="git add . && git reset --hard"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# List all files colorized in long format
alias l="ls -laF"

# PhpStorm
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'

# PHP
alias switch-php80="brew unlink php@7.4 && brew link --overwrite --force php"
alias switch-php74="brew unlink php && brew link --overwrite --force php@7.4"

# IP addresses
alias ip="curl https://diagnostic.opendns.com/myip ; echo"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Lock the screen
alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Always enable colored `grep` output
alias grep="grep --color=auto"

# Restart touch bar
alias touchbar="killall ControlStrip"
