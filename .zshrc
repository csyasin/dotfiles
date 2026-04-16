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

alias gl='git pull'
alias ga='git add .'
alias gg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gc='git commit -m'
alias gcn='git commit -n -m'
alias ggpush='git push origin $(git branch --show-current)'
# amazing fzf
alias gsb="git branch --format='%(refname:short)' | fzf --preview 'git log --oneline --graph --color=always {}' | xargs git switch"
alias gmb="git branch --format='%(refname:short)' | fzf --preview 'git log --oneline --graph --color=always {}' | xargs git merge"
# 查看当前分支名并复制
curb() {
  local current_branch=$(git branch --show-current)
  echo "$current_branch" | pbcopy
  echo "$current_branch Copied!"
}
# 切换到主分支 (带 -r 参数尝试识别远程 HEAD 分支)
main() {
  local target="main"
  if [[ "$1" == "-r" ]]; then
    target=$(git remote show origin 2>/dev/null | grep 'HEAD branch' | awk '{print $NF}')
    [[ -z "$target" ]] && target="main"
  fi
  git checkout "$target" 2>/dev/null || git checkout master 2>/dev/null || echo "找不到主分支:("
}


# 开启代理
alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
# 关闭代理
alias unproxy='unset https_proxy http_proxy all_proxy'


# 查看当前 shell 的架构
alias checkarch="uname -m"
# 临时切换到 x86 的 zsh，使用 exit 回到 arm 架构
alias usex86="arch -x86_64 zsh"

# AnyBar 控制函数
# 用法:
#   anybar add [title]      - 打开一个新的 AnyBar 实例，端口从 1738 自动递增寻找可用端口
#                             可选参数 title 设置窗口标题
#   anybar <color> [port]   - 向指定端口的 AnyBar 发送颜色指令，端口默认 1738
#                             支持的颜色: white, red, orange, yellow, green, cyan, blue, purple, black, question, exclamation
# 示例:
#   anybar add              # 打开 AnyBar，自动分配端口
#   anybar add "My App"     # 打开 AnyBar，自动分配端口，标题为 "My App"
#   anybar green 1738       # 将端口 1738 的 AnyBar 设为绿色
#   anybar red              # 将端口 1738（默认）的 AnyBar 设为红色
anybar() {
  if [ "$1" = "add" ]; then
    # 从 1738 开始寻找未被占用的端口
    local port=1738
    while lsof -i UDP:$port >/dev/null 2>&1; do
      ((port++))
    done
    # 如果有第 2 个参数，则设置 ANYBAR_TITLE
    if [ -n "$2" ]; then
      ANYBAR_PORT=$port ANYBAR_TITLE="$2" open -na AnyBar
    else
      ANYBAR_PORT=$port open -na AnyBar
    fi
    echo "AnyBar opened on port $port"
  else
    echo -n $1 | nc -4u -w0 localhost ${2:-1738}
  fi
}

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
export STARSHIP_CONFIG=~/.config/starship/tokyo-night.toml
# export STARSHIP_CONFIG=~/.config/starship/rose-pine.toml
# export STARSHIP_CONFIG=~/.config/starship/gruvbox.toml


# 上传蒲公英
[ -f ~/.upload_pgyer ] && source ~/.upload_pgyer

# Added by Antigravity
export PATH="/Users/yasin/.antigravity/antigravity/bin:$PATH"
