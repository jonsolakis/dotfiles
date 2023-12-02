# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="cloud"

# Hide username in prompt
DEFAULT_USER=`whoami`

export COMPOSER_PROCESS_TIMEOUT=600
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=/usr/local/bin:$PATH

plugins=(
    git
    composer
    macos
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

for file in $(find ~/.config/zsh/* -type f -print); do
    source "$file"
done




