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

# 将当前 git 项目的主分支打包备份到 ~/buffalo-backup
backup() {
  local backup_root buffalo_root archive archive_file project_name project_root
  local current_branch main_branch backup_status restore_status failed
  local project_roots archives

  backup_root="$HOME/buffalo-backup"
  buffalo_root="$HOME/BUFFALO"
  project_roots=()
  failed=0

  if [[ "$1" == "-a" ]] && (( $# == 1 )); then
    archives=("$backup_root"/*.tar.gz(N))
    if (( ${#archives[@]} == 0 )); then
      echo "没有找到已有备份压缩包: $backup_root/*.tar.gz"
      return 1
    fi

    for archive_file in "${archives[@]}"; do
      project_name="${archive_file:t}"
      project_name="${project_name%.tar.gz}"
      project_root="$buffalo_root/$project_name"
      if [[ ! -d "$project_root" ]]; then
        echo "跳过不存在的项目: $project_root"
        failed=1
        continue
      fi
      project_roots+=("$project_root")
    done

    if (( ${#project_roots[@]} == 0 )); then
      return 1
    fi
  elif (( $# == 0 )); then
    project_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
      echo "当前目录不是 git 仓库"
      return 1
    }
    project_roots=("$project_root")
  else
    echo "用法: backup [-a]"
    return 1
  fi

  mkdir -p "$backup_root" || return 1

  for project_root in "${project_roots[@]}"; do
    project_name=$(basename "$project_root")
    archive="$backup_root/${project_name}.tar.gz"
    echo "开始备份: $project_name"

    current_branch=$(git -C "$project_root" branch --show-current) || {
      failed=1
      continue
    }
    if [[ -z "$current_branch" ]]; then
      echo "跳过 detached HEAD 项目: $project_root"
      failed=1
      continue
    fi

    if git -C "$project_root" show-ref --verify --quiet refs/heads/main; then
      main_branch="main"
    elif git -C "$project_root" show-ref --verify --quiet refs/heads/master; then
      main_branch="master"
    else
      echo "跳过没有 main 或 master 分支的项目: $project_root"
      failed=1
      continue
    fi

    if [[ -n "$(git -C "$project_root" status --porcelain)" ]]; then
      echo "跳过有未提交修改的项目: $project_root"
      failed=1
      continue
    fi

    if [[ "$current_branch" != "$main_branch" ]]; then
      git -C "$project_root" checkout "$main_branch" || {
        failed=1
        continue
      }
    fi

    git -C "$project_root" pull --ff-only
    backup_status=$?

    if [[ $backup_status -eq 0 ]]; then
      COPYFILE_DISABLE=1 tar -czf "$archive" \
        --exclude="*/.git" \
        --exclude="*/node_modules" \
        --exclude="*/.next" \
        --exclude="*/dist" \
        -C "$(dirname "$project_root")" "$project_name"
      backup_status=$?
    fi

    if [[ "$current_branch" != "$main_branch" ]]; then
      git -C "$project_root" checkout "$current_branch"
      restore_status=$?
      if [[ $restore_status -ne 0 ]]; then
        echo "切回原分支失败: $project_root -> $current_branch"
        failed=1
        continue
      fi
    fi

    if [[ $backup_status -eq 0 ]]; then
      echo "🪴备份完成: $archive"
    else
      echo "💥备份失败: $project_root"
      failed=1
    fi
  done

  return $failed
}

# 切换 starship 主题
export STARSHIP_CONFIG=~/.config/starship/tokyo-night-pill.toml
# export STARSHIP_CONFIG=~/.config/starship/rose-pine.toml
# export STARSHIP_CONFIG=~/.config/starship/gruvbox.toml

# 上传蒲公英
[ -f ~/.upload_pgyer ] && source ~/.upload_pgyer
