eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)

alias ll='eza --long --icons'
alias la='eza -la'
alias yz=yazi
alias lg=lazygit

alias gl='git pull'
alias gm='git merge'
alias ga='git add .'
alias gc='git commit -m'
alias gcn='git commit -n -m'
alias ggpush='git push origin $(git branch --show-current)'

alias ip='curl cip.cc'

alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"