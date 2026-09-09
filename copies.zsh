# symlink ではなくコピーで配置する設定ファイル。
#
# cmux は設定ファイルをアトミック書き込み (一時ファイル + rename) で更新するため、
# symlink を張っても rename で実ファイルに置き換えられてしまう。
# そのため実体は ~/.config 側に置き、dotfiles へは sync.sh で取り込む。
#
# 書式: <dotfiles 内のパス>,<配置先のフルパス>
copies=(
cmux/cmux.json,${HOME}/.config/cmux/cmux.json
)
