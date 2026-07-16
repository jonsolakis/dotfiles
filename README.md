# dotfiles

## Install

```sh
./install.sh
```

The installer expects Homebrew to be installed, installs packages from
`Brewfile`, installs Zsh plugins, and stows the config directories into `$HOME`.

Install options:

```sh
./install.sh --no-brew
./install.sh --stow-only
./install.sh --macos
```

Check the current machine without changing anything:

```sh
./doctor.sh
```

## Homebrew

Install everything listed in the Brewfile:

```sh
brew bundle --file=./Brewfile
```

Refresh the Brewfile from the current machine:

```sh
brew bundle dump --file=./Brewfile --force
```

Or, after stowing `bin`, use:

```sh
dotfiles-brew-dump
```

## Scripts

Stowed helper commands live in `bin/.local/bin`:

```sh
dotfiles-doctor
dotfiles-brew-dump
dotfiles-update
```

## macOS Defaults

Apply preferred macOS settings:

```sh
./macos/defaults.sh
```

This is intentionally separate from `install.sh` because it changes system
preferences and restarts Finder, Dock, and SystemUIServer.
