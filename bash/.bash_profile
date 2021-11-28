# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
          . ~/.bashrc
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Go
export PATH=$PATH:/usr/local/go/bin
