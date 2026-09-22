# ============================================================
# === DEBUG: .zshrc 起動時間計測 (ZSHRC_DEBUG=1 で有効化) ===
# 使い方:
#   ZSHRC_DEBUG=1 zsh -i -c exit       # ログイン用初期化を1回流して計測
#   ZSHRC_DEBUG=1 exec zsh             # 現在のシェルを置き換えて計測
# 解除:
#   unset ZSHRC_DEBUG                  # 環境変数を外す
# ============================================================
if [[ -n "$ZSHRC_DEBUG" ]]; then
  zmodload zsh/datetime
  zmodload zsh/zprof
  typeset -F __zshrc_debug_start=$EPOCHREALTIME
  typeset -F __zshrc_debug_prev=$EPOCHREALTIME
  __zshrc_log() {
    local now=$EPOCHREALTIME
    local elapsed=$(( (now - __zshrc_debug_prev) * 1000 ))
    local total=$(( (now - __zshrc_debug_start) * 1000 ))
    printf "[zshrc] +%7.2fms (total %7.2fms)  %s\n" $elapsed $total "$1" >&2
    __zshrc_debug_prev=$now
  }
  __zshrc_log "START"
else
  __zshrc_log() { : }
fi

export PATH=/opt/homebrew/bin:$PATH
# trivy が docker と通信するために、tcp 通信で環境変数を設定する
export DOCKER_HOST='tcp://127.0.0.1:2375'
#export DOCKER_HOST=unix://$HOME/.lima/docker/sock/docker.sock
#export DOCKER_HOST=unix:///Users/a2-ito/.colima/default/docker.sock

export LSCOLORS=cxfxcxdxbxegedabagacad
alias ll='ls -lGF'
alias ls='ls -GF'
alias vi='nvim'
# alias vi='nvim --startuptime ~/nvim_startuptime.txt`date "+%Y%m%d_%H%M%S"`'
alias view='nvim -R'
# tmux
alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'
__zshrc_log "basic env / alias"

# Python (pyenv を遅延ロード化: shim は PATH に通すが init は pyenv 初回呼び出し時)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  pyenv "$@"
}
__zshrc_log "pyenv (lazy)"

# Go (GOROOT をキャッシュ化: 初回のみ `go env GOROOT` を実行)
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
__GO_VERSION_CMD="go1.24.4"
__GO_CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/goroot-${__GO_VERSION_CMD}"
if [[ -r "$__GO_CACHE_FILE" ]]; then
  export GOROOT="$(<"$__GO_CACHE_FILE")"
else
  if command -v "$__GO_VERSION_CMD" >/dev/null 2>&1; then
    export GOROOT="$("$__GO_VERSION_CMD" env GOROOT)"
    mkdir -p "${__GO_CACHE_FILE:h}"
    print -r -- "$GOROOT" > "$__GO_CACHE_FILE"
  fi
fi
unset __GO_VERSION_CMD __GO_CACHE_FILE
[[ -n "$GOROOT" ]] && export PATH=$PATH:$GOROOT/bin
export GOTOOLCHAIN=go1.25.0+auto
__zshrc_log "Go (GOROOT cached)"

# ulimit
ulimit -n 2048

# Ruby
# eval "$(rbenv init - zsh)"

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/Users/a/kotlinc/bin:$PATH"

# Node (Volta)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
__zshrc_log "ulimit / JDK / Volta path"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/a2-ito/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/a2-ito/google-cloud-sdk/path.zsh.inc'; fi
__zshrc_log "gcloud path.zsh.inc"

# gcloud 補完を遅延ロード化（初回 gcloud/bq/gsutil 呼び出し時に source する）
__gcloud_completion='/Users/a2-ito/google-cloud-sdk/completion.zsh.inc'
if [[ -f "$__gcloud_completion" ]]; then
  for __cmd in gcloud gsutil bq; do
    eval "${__cmd}() {
      unfunction gcloud gsutil bq 2>/dev/null
      source '$__gcloud_completion'
      ${__cmd} \"\$@\"
    }"
  done
  unset __cmd
fi
unset __gcloud_completion
__zshrc_log "gcloud completion (lazy)"

# Secrets
if [ -f ~/.zshrc_secrets ]; then
	source ~/.zshrc_secrets
fi
__zshrc_log "~/.zshrc_secrets"

# MySQL
export PATH=$PATH:/opt/homebrew/opt/mysql-client/bin

# JDK
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openjdk@17/include"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Added by LM Studio LI (lms)
export PATH="$PATH:/Users/a2-ito/.lmstudio/bin"
# End of LM Studio CLI section

# LMS
export PATH="/Users/a2-ito/.lmstudio/bin:$PATH"
__zshrc_log "MySQL/JDK/Ruby/PG/LMS path"

# API KEYS
set -a
source ~/.secrets
set +a
__zshrc_log "~/.secrets"

# git alias は ~/.gitconfig に永続化済みなので毎回設定する必要なし（旧コード削除）
alias gmain='git checkout main && git pull origin main'
__zshrc_log "git (skipped, persisted in ~/.gitconfig)"

# Datadog
export DD_SITE="datadoghq.com"  # or us5.datadoghq.com etc.

# AWS SSO (全プロファイルが sso_session = edash-org を共有)
alias awslogin='aws sso login --sso-session edash-org'

# Claude
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
alias claude='claude --enable-auto-mode'

# Android SDK (homebrew: android-commandlinetools)
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
__zshrc_log "Android SDK"

# bindkey リセット（これやる必要ない気がするが、原因不明、、、）
bindkey -e
__zshrc_log "Datadog/Claude env / bindkey"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
__zshrc_log "wt shell init"

# ============================================================
# === cmux: タブ名を <リポジトリ名>:<ブランチ名> に自動設定 ===
# ============================================================
# cmux のタブ名は端末のタイトル (OSC 2) を拾う。ghostty のシェル統合による
# タイトル自動設定は shell-integration-features = no-title で切ってあるので、
# ここで流した値がそのまま残る。
# Claude Code などのエージェント用サーフェスは cmux が会話内容からタイトルを
# 付けてくれるので、CMUX_AGENT_LAUNCH_KIND が付いている場合は何もしない。
if [[ -n "$CMUX_SURFACE_ID" && -z "$CMUX_AGENT_LAUNCH_KIND" ]]; then
  __cmux_set_tab_title() {
    local title repo branch
    # git 呼び出しは 1 回で済ませる (1 行目: リポジトリルート / 2 行目: ブランチ名)
    if repo=$(git rev-parse --show-toplevel --abbrev-ref HEAD 2>/dev/null); then
      branch="${repo#*$'\n'}"
      repo="${repo%%$'\n'*}"
      # detached HEAD のときは短縮 SHA を出す
      [[ "$branch" == "HEAD" ]] && branch=$(git rev-parse --short HEAD 2>/dev/null)
      title="${repo:t}:${branch}"
    else
      title="${PWD:t}"
      [[ -z "$title" ]] && title="/"
    fi

    # printf は builtin なので毎回書いてよい。他が上書きしても次のプロンプトで戻る
    printf '\033]2;%s\a' "$title"
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd __cmux_set_tab_title
fi
__zshrc_log "cmux tab title"

# ============================================================
# === DEBUG: 計測終了 & zprof 表示 ===
# ============================================================
if [[ -n "$ZSHRC_DEBUG" ]]; then
  __zshrc_log "END"
  echo "" >&2
  echo "===== zprof (関数別累計時間 TOP) =====" >&2
  zprof
fi
