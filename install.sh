#!/bin/zsh

config=(
.zshrc,${HOME}/
.tmux.conf,${HOME}/
.tmux.session.conf,${HOME}/
init.vim,${HOME}/.config/nvim/
dein.toml,${HOME}/.config/nvim/
)

for i in ${config[@]}
do
	_file=`echo $i | cut -f1 -d','`
	_target=`echo $i | cut -f2 -d','`

	echo ln -s ${PWD}/${_file} ${_target}
	ln -s ${PWD}/${_file} "${_target}"
done
