# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="cloud"

# Hide username in prompt
DEFAULT_USER=`whoami`

export COMPOSER_PROCESS_TIMEOUT=600
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=/usr/local/bin:$PATH

plugins=(git composer macos)

source $ZSH/oh-my-zsh.sh
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/work_exports.zsh"




