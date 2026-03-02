# PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Java (OpenJDK)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Android Studio
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# VSCode
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Deduplicate PATH
typeset -U PATH

# eza (better ls)
alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias lt='eza --tree --icons'

# Git aliases
alias ga='git add'
alias gaa='git add .'
alias gs='git status'
alias gc='git commit -m'
alias gcm='git checkout main'
alias gco='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gr='git restore'
alias grs='git restore --staged'
alias gcl='git clone'

# Dotfiles aliases
[ -f "$HOME/.dotfiles-aliases.zsh" ] && source "$HOME/.dotfiles-aliases.zsh"

# Zsh plugins (via Homebrew)
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fzf
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Starship prompt
eval "$(starship init zsh)"
