#!/usr/bin/env bash
set -uo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
STOW_PACKAGES=(bin diffnav git k9s kitty nvim tmux vim zsh)

failures=0

ok() {
  printf '[ok] %s\n' "$*"
}

warn() {
  printf '[warn] %s\n' "$*"
}

fail() {
  printf '[fail] %s\n' "$*"
  failures=$((failures + 1))
}

print_output() {
  local output="$1"

  if [ -n "$output" ]; then
    printf '%s\n' "$output" | sed 's/^/  /'
  fi
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

check_command() {
  local cmd="$1"

  if has_command "$cmd"; then
    ok "$cmd is installed"
  else
    fail "$cmd is missing"
  fi
}

check_brewfile() {
  local output

  if [ ! -f "$BREWFILE" ]; then
    warn "Brewfile not found; skipping Homebrew bundle check"
    return
  fi

  if ! has_command brew; then
    fail "brew is missing; cannot check Brewfile"
    return
  fi

  if output="$(brew bundle check --file="$BREWFILE" --no-upgrade 2>&1)"; then
    ok "Brewfile dependencies are installed"
  else
    fail "Brewfile has missing dependencies"
    print_output "$output"
  fi
}

check_stow_packages() {
  local package
  local missing=0
  local output

  for package in "${STOW_PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$package" ]; then
      ok "stow package exists: $package"
    else
      fail "stow package is missing: $package"
      missing=1
    fi
  done

  if [ "$missing" -ne 0 ]; then
    return
  fi

  if ! has_command stow; then
    fail "stow is missing; cannot simulate links"
    return
  fi

  if output="$(cd "$DOTFILES_DIR" && stow --simulate --target="$HOME" "${STOW_PACKAGES[@]}" 2>&1)"; then
    ok "stow simulation completed without conflicts"
  else
    fail "stow simulation found conflicts"
    print_output "$output"
  fi
}

check_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    ok "Oh My Zsh is installed"
  else
    warn "Oh My Zsh is not installed"
  fi

  if [ -d "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
    ok "zsh-autosuggestions is installed"
  else
    warn "zsh-autosuggestions is not installed"
  fi

  if [ -d "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]; then
    ok "zsh-syntax-highlighting is installed"
  else
    warn "zsh-syntax-highlighting is not installed"
  fi
}

printf 'Checking dotfiles setup in %s\n\n' "$DOTFILES_DIR"

check_command bash
check_command curl
check_command git
check_command brew
check_command stow

printf '\n'
check_brewfile

printf '\n'
check_stow_packages

printf '\n'
check_zsh

if [ "$failures" -gt 0 ]; then
  printf '\n%s check(s) failed.\n' "$failures"
  exit 1
fi

printf '\nAll required checks passed.\n'
