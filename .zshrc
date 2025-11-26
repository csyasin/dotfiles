eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)

alias ll='eza --long --icons=always'
alias la='eza -la'
alias tree='eza --icons=always -T -L'
alias ssh='TERM=xterm-256color ssh'
alias cat='bat -p'
alias yz=yazi
alias lg=lazygit

alias gs='git status'
alias gl='git pull'
alias gm='git merge'
alias ga='git add .'
alias gc='git commit -m'
alias gg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gcn='git commit -n -m'
alias ggpush='git push origin $(git branch --show-current)'
alias gb='CB=$(git branch --show-current);echo "$CB" | pbcopy;echo "$CB Copied!"'

# 开启代理
alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
# 关闭代理
alias unproxy='unset https_proxy http_proxy all_proxy'

# 查看当前 shell 的架构
alias checkarch="uname -m"
# 临时切换到 x86 的 zsh，使用 exit 回到 arm 架构
alias usex86="arch -x86_64 zsh"

alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"

# starship 主题
export STARSHIP_CONFIG=~/.config/starship/rose-pine.toml
# export STARSHIP_CONFIG=~/.config/starship/gruvbox.toml


# 上传蒲公英
[ -f ~/.upload_pgyer ] && source ~/.upload_pgyer
