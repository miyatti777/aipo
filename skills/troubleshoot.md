---
name: troubleshoot
description: "AIPO操作相談スキル - 困りごとへのアドバイスとコピペ用プロンプト提供"
license: "MIT"
---

# AIPO 操作相談スキル（Troubleshoot）

## 概要

AIPOの操作に困ったときの汎用相談スキルです。現在の状況を把握し、適切なアドバイスとコピペ用プロンプトを提供します。

---

## 使い方

```
@troubleshoot.md [困りごとの内容]
```

### 例

```
@troubleshoot.md 並列実行したい
@troubleshoot.md 次のアクションがわからない
@troubleshoot.md 途中から再開したい
@troubleshoot.md エラーが出た
```

---

## 対応できる困りごと

### 🔄 並列実行したい

**やること:**
1. tasks.yaml を読み込んで依存関係を分析
2. 並列実行可能なタスクを Wave（実行波）に分類
3. 各タブ用のプロンプトを生成

**分析テンプレート:**

```
Wave N ─────────────────────────────────────
  T00X (タスク名)  ⬅️ 並列OK
  T00Y (タスク名)  ⬅️ 並列OK
```

**並列実行の方法:**
- **方法1**: `Cmd + L` で新しいチャットタブを開く → 各タブで別プロンプト
- **方法2**: Background Agents（設定で有効化）
- **方法3**: 複数ウィンドウ（別プロジェクトの場合）

**出力形式:**

```markdown
## 📝 タブ1用プロンプト
[コピペ用プロンプト]

## 📝 タブ2用プロンプト
[コピペ用プロンプト]
```

---

### ❓ 次のアクションがわからない

**やること:**
1. 現在のLayer構造を確認（layer.yaml）
2. タスク状況を確認（tasks.yaml）
3. 未完了の最優先タスクを特定
4. 次のコマンドを提案

**確認するファイル:**
- `layer.yaml` → status, sublayers
- `tasks.yaml` → 各タスクのstatus
- `context.yaml` → 収集済みContext

**出力形式:**

```markdown
## 📊 現在の状況
- Layer: [Layer名]
- フェーズ: [sense/focus/discover/deliver/operation]
- 完了タスク: X/Y

## 🎯 次のアクション
[推奨アクションの説明]

## 📝 コピペ用プロンプト
[プロンプト]
```

---

### 🔀 途中から再開したい

**やること:**
1. プロジェクトフォルダを検索（Flow/配下）
2. 最新のLayer構造を特定
3. 各SubLayerのstatusを確認
4. 再開ポイントを特定

**検索パターン:**
```
Flow/YYYYMM/YYYY-MM-DD/[プロジェクト名]/
├── layer.yaml
├── tasks.yaml
└── sublayers/
```

**出力形式:**

```markdown
## 📍 最後の作業位置
- プロジェクト: [名前]
- 日付: [YYYY-MM-DD]
- Layer: [Layer名]
- 最後に完了したタスク: [タスク名]

## 🔄 再開ポイント
[どこから再開すべきかの説明]

## 📝 再開用プロンプト
[プロンプト]
```

---

### ⚠️ エラーが出た

**よくあるエラーと対処法:**

| エラー | 原因 | 対処法 |
|--------|------|--------|
| `layer.yaml not found` | Layerが初期化されていない | `/aipo/01_sense` を実行 |
| `tasks.yaml not found` | Focusフェーズ未完了 | `/aipo/02_focus` を実行 |
| `Parent Layer not found` | 親Layerのパス間違い | layer.yamlのparent_pathを確認 |
| `Context file not found` | Context未収集 | `/aipo/01_sense` でContext収集 |

**出力形式:**

```markdown
## ⚠️ エラー分析
- エラー内容: [エラーメッセージ]
- 原因: [推定原因]
- 影響範囲: [どこに影響するか]

## 🔧 修正方法
[具体的な修正手順]

## 📝 修正用プロンプト
[プロンプト]
```

---

### 📊 進捗を確認したい

**やること:**
1. 親Layerのtasks.yamlを読み込む
2. 各SubLayerのstatusを集計
3. 完了率を計算
4. 残タスクをリストアップ

**出力形式:**

```markdown
## 📊 進捗サマリー

| Layer | Status | 進捗 |
|-------|--------|------|
| L001 | active | 30% |
| └─ SG1 | active | 50% |
| └─ SG2 | pending | 0% |
| └─ SG3 | pending | 0% |

## 📋 残タスク一覧
| ID | タスク | 期限 | 優先度 |
|----|--------|------|--------|
| T003 | ... | 1/24 | P0 |

## 🎯 次のアクション
[推奨アクション]
```

---

### 🛠️ カスタマイズしたい

**カスタマイズ可能な項目:**

| 項目 | ファイル | 説明 |
|------|----------|------|
| タスクの追加/削除 | `tasks.yaml` | tasksセクションを編集 |
| SubLayerの追加 | `tasks.yaml` | sublayersセクションを編集 |
| Context追加 | `Context/` | 新しい.mdファイルを追加 |
| 期限変更 | `layer.yaml`, `tasks.yaml` | due_dateを編集 |
| 担当者変更 | `tasks.yaml` | assigneeを編集 |

**出力形式:**

```markdown
## 🛠️ カスタマイズ方法

### [変更したい項目]

**対象ファイル:** `[ファイルパス]`

**変更前:**
```yaml
[現在の内容]
```

**変更後:**
```yaml
[変更後の内容]
```

**注意事項:**
- [注意点があれば記載]
```

---

## 状況把握のためのチェックリスト

相談を受けたら、まず以下を確認してください：

1. **プロジェクトの場所**
   - `Flow/YYYYMM/YYYY-MM-DD/[プロジェクト名]/` を検索

2. **現在のフェーズ**
   - `layer.yaml` の status を確認
   - `tasks.yaml` の有無を確認

3. **タスクの状況**
   - `tasks.yaml` の各タスクの status を確認
   - pending / in_progress / completed / blocked

4. **SubLayerの状況**
   - `sublayers/` フォルダの中身を確認
   - 各SubLayerの `layer.yaml` を確認

---

## プロンプト生成テンプレート

### 並列実行用

```
/aipo/04_deliver を [タスクID] に対して実行してください。

タスク: [タスク名]
成果物: [期待する成果物]

【要件】
- [要件1]
- [要件2]
```

### 再開用

```
前回のセッションの続きです。

プロジェクト「[プロジェクト名]」で、以下まで完了しています：
- [完了した内容]

現在の状況：
- Layer: [Layer名]
- 最後に完了したタスク: [タスク名]

次のアクションとして、[次のタスク/コマンド]を実行してください。
```

### エラー修正用

```
以下のエラーが発生しました：

[エラーメッセージ]

現在の状況：
- Layer: [Layer名]
- 実行しようとしたコマンド: [コマンド]

このエラーを修正してください。
```

---

## 関連スキル・コマンド

- `/aipo/01_sense` - Layer初期化・Context収集
- `/aipo/02_focus` - Goal分解・タスク生成
- `/aipo/03_discover` - コマンドページ生成
- `/aipo/04_deliver` - タスク実行
- `/aipo/05_operation` - 継続運用
- `@execution-rules.md` - 実行ルール
- `@session-rules.md` - セッション管理ルール
