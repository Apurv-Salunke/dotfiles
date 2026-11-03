# Dotfiles management with GNU Stow
alias config='git -C ~/dotfiles'

# Quick stow commands
alias stow-install="stow --restow --target ~ -d ~/dotfiles shell git wezterm nvim lazygit starship"
alias stow-remove="stow -D --target ~ -d ~/dotfiles shell git wezterm nvim lazygit starship"

# View dotfiles status
alias config-status='git -C ~/dotfiles status --short'
alias config-diff='git -C ~/dotfiles diff'

# Quick add and commit
alias config-add='git -C ~/dotfiles add'
alias config-commit='git -C ~/dotfiles commit -m'
alias config-push='git -C ~/dotfiles push'
alias config-pull='git -C ~/dotfiles pull'
