# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# And include the parameter for ZSH
export HISTORY_IGNORE="(ls|cd|cd -|pwd|exit|date|* --help)"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

#Set AWS Profile for tokendito
export AWS_PROFILE='C51_AWS_PROD_ReadOnly'

#ZSH autcomplete
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

#use Neovim for editor
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"
