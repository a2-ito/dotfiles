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

## シークレットスキャン

シークレットの混入を **ローカルのコミット時** と **CI** の二段構えでチェックする。
検出には [gitleaks](https://github.com/gitleaks/gitleaks) を使う。

### ローカル (pre-commit フック)

`install.sh` が `core.hooksPath` を `.githooks` に設定するので、
このリポジトリへのコミット時に `.githooks/pre-commit` が自動で走る。
ステージされた差分のみをスキャンし、検出されるとコミットは中断される。

```sh
# 手動で設定する場合
git config core.hooksPath .githooks

# gitleaks の導入 (install.sh 経由なら .Brewfile で入る)
brew install gitleaks
```

| 状況 | 挙動 |
| --- | --- |
| シークレットを検出 | コミットを中断する |
| 誤検知 | `.gitleaksignore` に finding の fingerprint を追記して除外する |
| 一時的に回避したい | `SKIP_GITLEAKS=1 git commit ...` |
| gitleaks 未インストール | 警告を出してスキップする (CI 側で検出する) |

### CI (GitHub Actions)

`.github/workflows/secret-scan.yml` で実行する。

| トリガー | スキャン範囲 |
| --- | --- |
| pull request / main への push | その差分のコミット |
| 毎週月曜 06:00 JST (schedule) | 全コミット履歴 |
| 手動実行 (workflow_dispatch) | 全コミット履歴 |

## 自動マージ

`.github/workflows/auto-merge.yml` が PR に対して GitHub の auto-merge を有効化する。
必須チェック (Secret Scan の `gitleaks`) が通った時点で GitHub 側が自動でマージする。

| 項目 | 設定 |
| --- | --- |
| 対象 | すべての PR（Draft と fork からの PR は除く） |
| マージ方式 | squash マージ |
| マージ後 | 作業ブランチを自動削除 |
| マージ条件 | main のブランチ保護で `gitleaks` チェックを必須にしている |

Draft の PR は対象外なので、まだマージされたくない場合は Draft で作成し、
準備ができたら Ready for review にすると auto-merge が有効になる。
