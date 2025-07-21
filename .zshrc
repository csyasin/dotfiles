eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
alias cb='CB=$(git branch --show-current);echo "$CB" | pbcopy;echo "$CB Copied!"'

alias ip='curl cip.cc'
alias localip='LOCAL_IP=$(ipconfig getifaddr en0);echo "$LOCAL_IP" | pbcopy;echo "$LOCAL_IP Copied!"'

alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"

# 查看当前 shell 的架构
alias checkarch="uname -m"
# 临时切换到 x86 的 zsh，使用 exit 回到 arm 架构
alias usex86="arch -x86_64 zsh"

# 上传蒲公英
[ -f ~/.upload_pgyer ] && source ~/.upload_pgyer
