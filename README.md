# dotfiles

## Usage

```
./homebrew_install.sh
./dotfiles/install.sh
```


## cmux ショートカットキー

設定の実体は `cmux/cmux.json` の `shortcuts.bindings`。
prefix は `Ctrl+q` で、tmux (`.tmux.conf`) の prefix と揃えてある。
以下はすべて **`Ctrl+q` を押してから** 次のキーを押す。

### サーフェス / タブ

| キー | アクション | 説明 |
| --- | --- | --- |
| `c` | `newSurface` | 新しいサーフェスを作成 |
| `x` | `closeTab` | タブを閉じる |
| `n` | `nextSurface` | 次のサーフェスへ |
| `p` | `prevSurface` | 前のサーフェスへ |
| `1`〜 | `selectSurfaceByNumber` | 番号でサーフェスを選択 |
| `,` | `renameTab` | タブ名を変更 |

### 分割 / ペイン移動

| キー | アクション | 説明 |
| --- | --- | --- |
| `%` (`shift+5`) | `splitRight` | 右に分割 |
| `"` (`shift+quote`) | `splitDown` | 下に分割 |
| `h` / `j` / `k` / `l` | `focusLeft` / `focusDown` / `focusUp` / `focusRight` | Vim 方向キーでペイン移動 |
| `o` | `focusNextPane` | 次のペインへ |
| `;` | `focusPreviousPane` | 前のペインへ |
| `z` | `toggleSplitZoom` | ペインのズームをトグル |
| `Space` | `equalizeSplits` | 分割サイズを均等化 |

### ワークスペース / サイドバー

| キー | アクション | 説明 |
| --- | --- | --- |
| `s` | `goToWorkspace` | ワークスペース一覧へ移動 |
| `$` (`shift+4`) | `renameWorkspace` | ワークスペース名を変更 |
| `(` (`shift+9`) | `prevSidebarTab` | 前のサイドバータブへ |
| `)` (`shift+0`) | `nextSidebarTab` | 次のサイドバータブへ |

### その他

| キー | アクション | 説明 |
| --- | --- | --- |
| `[` | `toggleTerminalCopyMode` | コピーモードのトグル |
| `w` | `commandPalette` | コマンドパレットを開く |
