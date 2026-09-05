#!/bin/zsh

config=(
.zshrc,${HOME}/
.tmux.conf,${HOME}/
# .tmux.session.conf,${HOME}/
# init.vim,${HOME}/.config/nvim/
init.lua,${HOME}/.config/nvim/
lua/lazy_nvim.lua,${HOME}/.config/nvim/lua/
lua/autocmds.lua,${HOME}/.config/nvim/lua/
lua/plugins.lua,${HOME}/.config/nvim/lua/
lua/config/lualine.lua,${HOME}/.config/nvim/lua/config/
lua/config/nvim-tree.lua,${HOME}/.config/nvim/lua/config/
# dein.toml,${HOME}/.config/nvim/
opencode.jsonc,${HOME}/.config/opencode/
colima/docker.yaml,${HOME}/.colima/_templates/default.yml
claude/keybindings.json,${HOME}/.claude/
claude/settings.json,${HOME}/.claude/
claude/style.md,${HOME}/.claude/output-styles/
cmux/cmux.json,${HOME}/.config/cmux/
ghostty/config,${HOME}/.config/ghostty/
.terraformrc,${HOME}/
)

directories=(
${HOME}/.terraformrc.d/plugin-cache
)

for i in ${config[@]}
do
	_file=`echo $i | cut -f1 -d','`
	_target=`echo $i | cut -f2 -d','`

	# 宛先が末尾 / ならディレクトリ、そうでなければファイルパスなので親を作る
	case "${_target}" in
		*/) _dir="${_target}" ;;
		*)  _dir="${_target:h}" ;;
	esac
	mkdir -p "${_dir}"

	echo ln -s ${PWD}/${_file} ${_target}
	ln -s ${PWD}/${_file} "${_target}"
done

for i in ${directories[@]}
do
	echo mkdir -p $i
	mkdir -p $i
done

# brew
./brew.sh
