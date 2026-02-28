# Dotfiles management with GNU Stow
alias config='git -C ~/dotfiles'

# Quick stow commands
alias stow-install='cd ~/dotfiles && stow . --target ~'
alias stow-remove='cd ~/dotfiles && stow -D . --target ~'

# View dotfiles status
alias config-status='git -C ~/dotfiles status --short'
alias config-diff='git -C ~/dotfiles diff'

# Quick add and commit
alias config-add='git -C ~/dotfiles add'
alias config-commit='git -C ~/dotfiles commit -m'
alias config-push='git -C ~/dotfiles push'
alias config-pull='git -C ~/dotfiles pull'
