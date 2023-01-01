export PATH=/opt/homebrew/bin:$PATH
export DOCKER_HOST='tcp://127.0.0.1:2375'

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
