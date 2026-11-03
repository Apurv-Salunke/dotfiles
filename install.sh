#!/usr/bin/env bash
# One-command setup:
#   curl -fsSL https://raw.githubusercontent.com/Apurv-Salunke/dotfiles/main/install.sh | bash
set -euo pipefail

#   DOTFILES_MINIMAL=1  install only the core Brewfile (skip Brewfile.extra)
REPO="https://github.com/Apurv-Salunke/dotfiles.git"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
PACKAGES=(shell git wezterm nvim lazygit starship)

# Homebrew (also pulls in Xcode Command Line Tools / git)
if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

# Clone or update the repo
if [[ -d "$DOTFILES/.git" ]]; then
  git -C "$DOTFILES" pull --ff-only || echo "skipping pull (local changes or detached HEAD)"
else
  git clone "$REPO" "$DOTFILES"
fi

brew bundle --file="$DOTFILES/Brewfile"
if [[ -z "${DOTFILES_MINIMAL:-}" ]]; then
  brew bundle --file="$DOTFILES/Brewfile.extra" || echo "some extras failed to install; continuing"
fi

# Secret-scanning pre-commit hook
git -C "$DOTFILES" config core.hooksPath .githooks

# Move aside any real files that would block stow, then link everything
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
cd "$DOTFILES"
real_dotfiles="$(pwd -P)"
for pkg in "${PACKAGES[@]}"; do
  while IFS= read -r -d '' src; do
    rel="${src#"$pkg"/}"
    dest="$HOME/$rel"
    [[ -e "$dest" && ! -L "$dest" ]] || continue
    # already reached through a symlink into this repo
    [[ "$(cd "$(dirname "$dest")" && pwd -P)" == "$real_dotfiles"/* ]] && continue
    mkdir -p "$backup/$(dirname "$rel")"
    mv "$dest" "$backup/$rel"
    echo "backed up ~/$rel -> $backup/$rel"
  done < <(find "$pkg" -type f -print0)
done
# nvim dir as a whole (stow folds it into one symlink)
if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
  mkdir -p "$backup/.config" && mv "$HOME/.config/nvim" "$backup/.config/nvim"
fi

stow --restow --target="$HOME" "${PACKAGES[@]}"

# Install neovim plugins at the versions pinned in lazy-lock.json
nvim --headless "+Lazy! restore" +qa || true

echo "Done. Open a new terminal."
