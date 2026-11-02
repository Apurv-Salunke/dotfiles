# Minimal init when Cursor reads your environment (VSCODE_RESOLVING_ENVIRONMENT=1).
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.pyenv-guard.zsh" ]] && source "$HOME/.pyenv-guard.zsh"
