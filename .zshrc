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
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"

alias gs='git status'
alias gl='git pull'
alias gm='git merge'
alias ga='git add .'
alias gc='git commit -m'
alias gg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gcn='git commit -n -m'
alias ggpush='git push origin $(git branch --show-current)'
# 查看当前分支名并复制
alias gb='CB=$(git branch --show-current);echo "$CB" | pbcopy;echo "$CB Copied!"'
# 切换主分支
alias gbm='git checkout main 2>/dev/null || git checkout master'


# 开启代理
alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
# 关闭代理
alias unproxy='unset https_proxy http_proxy all_proxy'


# 查看当前 shell 的架构
alias checkarch="uname -m"
# 临时切换到 x86 的 zsh，使用 exit 回到 arm 架构
alias usex86="arch -x86_64 zsh"


# 在项目根目录中执行，备份当前项目
alias backup='rsync -av --delete --exclude="node_modules/" --exclude=".git/" ./ "$HOME/backup-buffalo/$(basename "$PWD")/"'
# 在项目根目录中执行，自动切换到主分支，备份当前项目，再切换回原分支
backup_main() {
  # 获取当前分支
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  # 定义主分支名字，先尝试 main，不行再尝试 master
  local main_branch
  if git show-ref --verify --quiet refs/heads/main; then
    main_branch="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    main_branch="master"
  else
    echo "没有找到 main 或 master 分支"
    return 1
  fi
  # 如果当前不在主分支，切换过去
  if [ "$current_branch" != "$main_branch" ]; then
    git checkout "$main_branch" || return 1
  fi
  # 拉取最新代码
  git pull || return 1
  # 执行 backup 命令
  backup
  echo "备份完成!"
  # 如果之前不在主分支，切换回去
  if [ "$current_branch" != "$main_branch" ]; then
    git checkout "$current_branch" || return 1
  fi
  echo "done!"
}


# 切换 starship 主题
export STARSHIP_CONFIG=~/.config/starship/rose-pine.toml
# export STARSHIP_CONFIG=~/.config/starship/gruvbox.toml


# 上传蒲公英
[ -f ~/.upload_pgyer ] && source ~/.upload_pgyer

# Added by Antigravity
export PATH="/Users/yasin/.antigravity/antigravity/bin:$PATH"
