#!/bin/zsh
#
# symlink 運用できない設定ファイル (copies.zsh に定義) を
# 実体のある ~/.config 側から dotfiles へ取り込む。
#
# 使い方:
#   ./sync.sh          差分を表示するだけ (取り込みはしない)
#   ./sync.sh --apply  dotfiles へ取り込む

cd "${0:A:h}" || exit 1
source ./copies.zsh

apply=0
[[ "$1" == "--apply" ]] && apply=1

changed=0
for i in ${copies[@]}
do
	_file=`echo $i | cut -f1 -d','`
	_target=`echo $i | cut -f2 -d','`

	if [[ ! -e "${_target}" ]]; then
		echo "skip: ${_target} が存在しない"
		continue
	fi

	if diff -q "${_file}" "${_target}" > /dev/null 2>&1; then
		echo "same: ${_file}"
		continue
	fi

	changed=1
	echo "diff: ${_file} <- ${_target}"
	diff -u "${_file}" "${_target}"

	if (( apply )); then
		cp "${_target}" "${_file}"
		echo "pulled: ${_file}"
	fi
done

if (( ! apply )) && (( changed )); then
	echo
	echo "取り込むには: ./sync.sh --apply"
fi
