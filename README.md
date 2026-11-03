# dotfiles

macOS config for zsh, WezTerm, Neovim (LazyVim), lazygit and starship, managed with GNU Stow.

## Setup

```sh
curl -fsSL https://raw.githubusercontent.com/Apurv-Salunke/dotfiles/main/install.sh | bash
```

Installs Homebrew and everything in `Brewfile`, clones this repo to `~/dotfiles`,
backs up conflicting files to `~/.dotfiles-backup/`, and symlinks each package into `~`.
Safe to re-run.

## Secret scanning

This repo is public. [gitleaks](https://github.com/gitleaks/gitleaks) runs as a
pre-commit hook (`.githooks/pre-commit`, enabled by `install.sh`) and in CI on every
push/PR. Keep machine-specific or sensitive shell config in untracked files
(e.g. `~/.devserver.zsh`) sourced from `.zshrc`.

## Layout

Each top-level dir is a stow package mirroring `$HOME`:

| Package    | Links to                          |
|------------|-----------------------------------|
| `shell`    | `~/.zshrc`, `~/.zshrc.heavy`, ... |
| `wezterm`  | `~/.wezterm.lua`                  |
| `nvim`     | `~/.config/nvim`                  |
| `lazygit`  | `~/.config/lazygit`               |
| `starship` | `~/.config/starship.toml`         |
