# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""

# Hide username in prompt
DEFAULT_USER=`whoami`

export COMPOSER_PROCESS_TIMEOUT=600
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

plugins=(
  git
  autojump
  urltools
  bgnotify
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-enquirer
  jovial
)

source $ZSH/oh-my-zsh.sh

setopt prompt_subst
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#7287fd}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#d20f39}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{#40a02b}+%f"
PROMPT='%F{#1e66f5}%~%f $(git_prompt_info)%F{#40a02b}>%f '

for file in \
  "$HOME/.config/zsh/exports.zsh" \
  "$HOME/.config/zsh/functions.zsh" \
  "$HOME/.config/zsh/aliases.zsh"; do
  [ -r "$file" ] && source "$file"
done

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export HOMEBREW_NO_AUTO_UPDATE=true

export SOBOLE_THEME_MODE=light
# pnpm
export PNPM_HOME="/Users/jon/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jon/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export PATH="$HOME/.local/bin:$PATH"
