export PATH=/opt/homebrew/bin:$PATH
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
export PATH=$PATH:$GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/a/work/dothatch/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/a/work/dothatch/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/a/work/dothatch/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/a/work/dothatch/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# ulimit
ulimit -n 2048
