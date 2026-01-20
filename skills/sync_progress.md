---
name: sync-progress
description: "フォルダ構造と成果物の存在確認によるtasks.yaml自動同期スキル"
license: "MIT"
---

# AIPO 進捗同期スキル（Sync Progress）

## 概要

フォルダ構造と成果物の存在を確認し、tasks.yamlのステータスを自動的に同期するスキルです。

---

## 使い方

```
@sync_progress.md [Layer名またはパス]
```

### 例

```
@sync_progress.md Explazaカレーパーティ
```

```
@sync_progress.md SG1_企画・準備
```

```
@sync_progress.md Flow/202601/2026-01-20/Explazaカレーパーティ
```

---

## 機能

### 1. 成果物の存在チェック

各タスクの`deliverables`（期待される成果物）を確認し、実際にファイルが存在するかをチェック。

**チェック対象:**
- `Documents/` フォルダ内のファイル
- `Context/` フォルダ内のファイル
- その他指定されたパス

### 2. ステータス自動判定

| 条件 | 判定ステータス |
|------|---------------|
| 全ての成果物が存在 | `completed` |
| 一部の成果物が存在 | `in_progress` |
| 成果物なし + 依存解決済み | `pending` |
| 依存タスク未完了 | `blocked` |

### 3. tasks.yaml 自動更新

判定結果に基づいて、tasks.yamlを更新。

---

## 実行手順

### Step 1: Layer特定

```
🔍 Layer構造を検索中...

【発見したLayer】
📁 Flow/202601/2026-01-20/Explazaカレーパーティ/
├── layer.yaml
├── tasks.yaml
├── Context/ (5ファイル)
├── Documents/ (3ファイル)
└── sublayers/
    ├── SG1_企画・準備/
    ├── SG2_当日運営/
    └── SG3_振り返り/

このLayerの進捗を同期しますか？
```

### Step 2: タスク分析

```
📊 tasks.yamlを分析中...

【タスク一覧と成果物チェック】
| ID | タスク | 期待成果物 | 存在 | 現status | 推奨status |
|----|--------|-----------|------|----------|------------|
| T001 | フォーム作成 | Documents/T001_form.md | ✅ | pending | completed |
| T002 | 会場確認 | Documents/T002_venue.md | ✅ | pending | completed |
| T003 | 回答収集 | Documents/T003_responses.md | ❌ | pending | in_progress |
| T004 | 日程確定 | Documents/T004_schedule.md | ❌ | pending | blocked |

【不整合検出】
⚠️ T001: 成果物あり だが status=pending
⚠️ T002: 成果物あり だが status=pending
```

### Step 3: 同期実行

```
🔄 tasks.yamlを更新中...

【更新内容】
T001: pending → completed
T002: pending → completed
T003: pending → in_progress
T004: pending → blocked (依存: T003)

✅ tasks.yaml を更新しました

【更新後の進捗】
進捗: ████░░░░░░ 20% (2/10 完了)
```

---

## 成果物チェックルール

### 1. deliverables フィールド

tasks.yaml に `deliverables` が定義されている場合：

```yaml
tasks:
  - id: T001
    name: "フォーム作成"
    deliverables:
      - "Documents/T001_form.md"
      - "Documents/T001_slack_message.md"
```

→ 全てのファイルが存在すれば `completed`

### 2. 成果物パターン推定

`deliverables` が未定義の場合、以下のパターンで推定：

| タスクタイプ | 期待される成果物パターン |
|-------------|------------------------|
| `coordination` | `Documents/T{ID}_*.md` |
| `implementation` | `Documents/T{ID}_*.md` または コード/DB |
| `verification` | `Documents/T{ID}_*.md` |
| `management` | ファイル不要（ステータス更新のみ） |

### 3. Context ファイル

タスク実行時に生成された Context も成果物としてカウント：

```
Context/T001_部門情報.md → T001の成果物
Context/T002_会場チェックリスト.md → T002の成果物
```

---

## 依存関係チェック

`depends_on` フィールドに基づいて、ブロック状態を判定：

```yaml
tasks:
  - id: T004
    name: "日程確定"
    depends_on: ["T003"]
    status: pending  # T003が未完了なら blocked に変更
```

---

## SubLayer 同期

親Layerの進捗同期時、SubLayerの進捗も集計：

```
📊 SubLayer進捗

| SubLayer | 完了Task | 総Task | 進捗 |
|----------|---------|--------|------|
| SG1_企画・準備 | 2 | 10 | 20% |
| SG2_当日運営 | 0 | 5 | 0% |
| SG3_振り返り | 0 | 2 | 0% |

【親Layer集計】
SubLayer完了: 0/3
総合進捗: 12%
```

---

## 出力形式

### 同期レポート

```markdown
# 進捗同期レポート

**Layer**: Explazaカレーパーティ
**同期日時**: 2026-01-20 20:30
**同期者**: AI (sync_progress)

## 更新サマリー

| 項目 | 変更前 | 変更後 |
|------|--------|--------|
| 完了タスク | 0 | 2 |
| 進行中タスク | 0 | 1 |
| ブロック中タスク | 0 | 1 |
| 未着手タスク | 10 | 6 |

## 詳細変更

### T001: フォーム作成
- status: `pending` → `completed`
- completed_at: 2026-01-20
- deliverables: Documents/T001_form.md ✅

### T002: 会場確認
- status: `pending` → `completed`
- completed_at: 2026-01-20
- deliverables: Documents/T002_venue.md ✅

## 次のアクション

1. **T003 (回答収集)**: 進行中 - 回答期限 1/24
2. **T004 (日程確定)**: T003完了後に実行可能
```

---

## オプション

### --dry-run

実際には更新せず、変更内容のプレビューのみ表示：

```
@sync_progress.md Explazaカレーパーティ --dry-run
```

### --force

手動で設定したステータスも上書き：

```
@sync_progress.md Explazaカレーパーティ --force
```

### --recursive

SubLayerも再帰的に同期：

```
@sync_progress.md Explazaカレーパーティ --recursive
```

---

## 注意事項

1. **手動ステータスの尊重**: デフォルトでは、`in_progress` や `blocked` に手動設定されたタスクは上書きしない

2. **成果物の品質は未判定**: ファイルの存在のみをチェック。内容の品質は判定しない

3. **タイムスタンプ確認**: ファイルの最終更新日時を `completed_at` に記録

4. **バックアップ**: 更新前に `tasks.yaml.bak` を作成

---

## 関連スキル・コマンド

- `/aipo/04_deliver` - タスク実行（完了時に自動更新）
- `@troubleshoot.md` - 操作相談
- `@execution-rules.md` - 実行ルール
