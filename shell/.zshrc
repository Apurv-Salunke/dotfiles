# Detect Cursor / VS Code (including Glass terminal — ignores terminal.integrated profiles)
_is_cursor_context() {
  [[ -n "${VSCODE_RESOLVING_ENVIRONMENT:-}" ]] && return 0
  [[ "${TERM_PROGRAM:-}" == "vscode" ]] && return 0
  [[ -n "${CURSOR_TRACE_ID:-}${CURSOR_AGENT:-}${CURSOR_CLI_MODE:-}${CURSOR_CHANNEL:-}" ]] && return 0
  return 1
}

# Cursor probing env on app launch
if [[ -n "${VSCODE_RESOLVING_ENVIRONMENT:-}" ]]; then
  [[ -f "$HOME/.cursor-fast-zsh.zsh" ]] && source "$HOME/.cursor-fast-zsh.zsh"
  return
fi

# Cursor / Glass / agent shells — minimal only (never load plugins/starship/bun hooks)
if _is_cursor_context; then
  export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"
  [[ -f "$HOME/.pyenv-guard.zsh" ]] && source "$HOME/.pyenv-guard.zsh"
  export NVM_DIR="$HOME/.nvm"
  # nvm's default Node first on PATH, so tools that call `node` (pnpm, corepack) get it before nvm loads.
  [[ -r "$NVM_DIR/alias/default" ]] && export PATH="$NVM_DIR/versions/node/v$(<"$NVM_DIR/alias/default")/bin:$PATH"
  _nvm_lazy_load() {
    unset -f nvm node npm npx _nvm_lazy_load
    [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
  }
  nvm()  { _nvm_lazy_load; nvm  "$@"; }
  node() { _nvm_lazy_load; node "$@"; }
  npm()  { _nvm_lazy_load; npm  "$@"; }
  npx()  { _nvm_lazy_load; npx  "$@"; }
  PROMPT='%F{cyan}%n@%m%f %~ %# '
  [[ -f "$HOME/.zshrc.cursor-extras" ]] && source "$HOME/.zshrc.cursor-extras"
  return
fi

# --- Normal shells (Terminal.app, iTerm, etc.) ---
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
# nvm's default Node first on PATH, so tools that call `node` (pnpm, corepack) get it before nvm loads.
[[ -r "$NVM_DIR/alias/default" ]] && export PATH="$NVM_DIR/versions/node/v$(<"$NVM_DIR/alias/default")/bin:$PATH"
_nvm_lazy_load() {
  unset -f nvm node npm npx _nvm_lazy_load
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
  [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
nvm()  { _nvm_lazy_load; nvm  "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm()  { _nvm_lazy_load; npm  "$@"; }
npx()  { _nvm_lazy_load; npx  "$@"; }
[[ -f "$HOME/.pyenv-guard.zsh" ]] && source "$HOME/.pyenv-guard.zsh"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

typeset -U PATH

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS EXTENDED_HISTORY

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons' ll='eza -lh --icons --git' la='eza -lah --icons --git' lt='eza --tree --icons'
fi
alias ga='git add' gaa='git add .' gs='git status' gc='git commit -m'
alias gcm='git checkout main' gco='git checkout' gb='git branch'
alias gpl='git pull' gps='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff' gr='git restore' grs='git restore --staged' gcl='git clone'
alias pwc='pwd | pbcopy'

if [[ -o interactive ]] && [[ "${TERM_PROGRAM:-}" == "Apple_Terminal" || "${TERM_PROGRAM:-}" == "iTerm.app" || "${TERM_PROGRAM:-}" == "WezTerm" ]]; then
  [[ -f "$HOME/.zshrc.heavy" ]] && source "$HOME/.zshrc.heavy"
fi

# Machine-local / private config (not tracked)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
