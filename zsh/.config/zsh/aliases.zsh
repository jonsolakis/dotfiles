alias zshrc="vim ~/.zshrc"
alias sshrc="vim ~/.ssh/config"
alias ohmyzsh="vim ~/.oh-my-zsh"

#Git
alias nah="git add . && git reset --hard"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias amend="git add . && git commit --amend --no-edit && git push origin -f"

# List all files colorized in long format
alias l="ls -laF"

# PHP
alias switch-php74="brew unlink php && brew link --overwrite --force php@7.4"
alias switch-php80="brew unlink php && brew link --overwrite --force php@8.0"
alias switch-php81="brew unlink php && brew link --overwrite --force php@8.1"
alias switch-php82="brew unlink php && brew link --overwrite --force php@8.2"
alias switch-php83="brew unlink php && brew link --overwrite --force php@8.3"

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
