#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
STOW_PACKAGES=(bin diffnav git k9s kitty nvim tmux vim zsh)
INSTALL_BREW=true
INSTALL_ZSH=true
INSTALL_MACOS=false
RUN_STOW=true

log() {
  printf '\n==> %s\n' "$*"
}

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --help       Show this help message.
  --macos      Apply macOS defaults after installing dotfiles.
  --no-brew    Skip Homebrew bundle install.
  --stow-only  Only stow dotfiles; skip Homebrew, Zsh setup, and macOS defaults.
EOF
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$1" >&2
    exit 1
  fi
}

clone_or_update() {
  local repo="$1"
  local dest="$2"

  if [ -d "$dest/.git" ]; then
    log "Updating ${dest}"
    git -C "$dest" pull --ff-only
  elif [ -e "$dest" ]; then
    printf 'Refusing to clone %s because %s already exists and is not a git repository.\n' "$repo" "$dest" >&2
    exit 1
  else
    log "Cloning ${repo}"
    git clone "$repo" "$dest"
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --help)
      usage
      exit 0
      ;;
    --macos)
      INSTALL_MACOS=true
      ;;
    --no-brew)
      INSTALL_BREW=false
      ;;
    --stow-only)
      INSTALL_BREW=false
      INSTALL_ZSH=false
      INSTALL_MACOS=false
      RUN_STOW=true
      ;;
    *)
      printf 'Unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

if [ "$INSTALL_ZSH" = true ]; then
  require_command curl
  require_command git
fi

if [ "$INSTALL_BREW" = true ]; then
  require_command brew
fi

if [ "$INSTALL_BREW" = true ] && [ -f "$BREWFILE" ]; then
  log "Installing Homebrew packages"
  brew bundle --file="$BREWFILE"
fi

require_command stow

if [ "$INSTALL_ZSH" = true ]; then
  log "Installing Oh My Zsh"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    printf 'Oh My Zsh already installed; skipping.\n'
  fi

  log "Installing Zsh plugins"
  mkdir -p "$ZSH_CUSTOM_DIR/plugins"
  clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
  clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

  log "Installing Jovial theme and plugin"
  if [ ! -d "$ZSH_CUSTOM_DIR/plugins/jovial" ] && [ ! -f "$ZSH_CUSTOM_DIR/themes/jovial.zsh-theme" ]; then
    curl -sSL https://github.com/zthxxx/jovial/raw/master/installer.sh | sudo -E bash -s "${USER:-$(whoami)}"
  else
    printf 'Jovial already installed; skipping.\n'
  fi
fi

if [ "$RUN_STOW" = true ]; then
  log "Stowing dotfiles"
  cd "$DOTFILES_DIR"
  stow --target="$HOME" "${STOW_PACKAGES[@]}"
fi

if [ "$INSTALL_MACOS" = true ]; then
  "$DOTFILES_DIR/macos/defaults.sh"
fi

cat <<'EOF'

NvChad post-install:
  1. Open Neovim once with: nvim
  2. After lazy.nvim finishes, run: :MasonInstallAll
  3. Then run: :TSInstallAll
EOF
