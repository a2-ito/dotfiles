export PATH=/opt/homebrew/bin:$PATH
# trivy が docker と通信するために、tcp 通信で環境変数を設定する
export DOCKER_HOST='tcp://127.0.0.1:2375'
#export DOCKER_HOST=unix://$HOME/.lima/docker/sock/docker.sock

export LSCOLORS=cxfxcxdxbxegedabagacad
alias ll='ls -lGF'
alias ls='ls -GF'
alias vi='nvim'
alias view='nvim -R'
# tmux
alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOROOT=`go1.22.2 env GOROOT`
export PATH=$PATH:$GOROOT/bin
go version

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/a/work/dothatch/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/a/work/dothatch/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/a/work/dothatch/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/a/work/dothatch/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# ulimit
ulimit -n 2048

# Ruby
eval "$(rbenv init - zsh)"

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/Users/a/kotlinc/bin:$PATH"
