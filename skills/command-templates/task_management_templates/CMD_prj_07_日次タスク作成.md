# CMD_prj_07_日次タスク作成

最終更新日時: 2025年12月25日 9:06

# 07 管理: 日次タスク作成（CSV優先モード）

## 最初に質問（実行前に回答してください）

- 特になし（自動実行）

## 目的

Rules（`basic/00_master_rules.mdc`・`07_task_management.mdc`）に準拠し、日次タスクファイルを自動生成します。CSV優先モードで高速実行し、FlowフォルダにCSVがある場合は高速、ない場合は全バックログ検索を行います。

## 必要入力

- なし（自動実行）

## 実行手順（シェルコマンド直接実行）

```bash
# CSV優先モードで日次タスク生成 + カレンダー統合
python {{root}}/scripts/generate_daily_tasks.py --filter-assignee && python {{root}}/scripts/merge_calendar_tasks.py
```

## 機能詳細

### 🚀 CSV優先モード

- *高速実行: FlowフォルダにCSVファイルがある場合、そのデータを優先使用*
- *フォールバック: CSVがない場合は全バックログYAMLを検索*
- *自動判定: システムが最適な実行方法を自動選択*

### 📋 生成内容

- *日次タスクリスト: 今日実行すべきタスクを抽出*
- *カレンダー統合: 予定とタスクを統合したスケジュール*
- *進捗管理: 完了状況の追跡*

### 📁 保存場所

```
Flow/[年月]/[日付]/
├── daily_tasks.md          # 日次タスクリスト
├── calendar_events.md      # カレンダー予定
└── routine_tasks.md        # ルーチンタスク
```

## 実行（Rules Steps）

```yaml
- trigger: "(今日のタスク|日次タスク作成|Daily tasks|タスク生成)"
  command: "python {{root}}/scripts/generate_daily_tasks.py --filter-assignee && python {{root}}/scripts/merge_calendar_tasks.py"
  message: "🚀 CSV優先モードで日次タスクを生成しています... (FlowフォルダにCSVがある場合は高速実行、ない場合は全バックログ検索)"
  instruction: "このコマンドのみを実行し、他の処理は一切行わないこと"
```

## 生成物

- Flow/.../daily_tasks.md（日次タスク）
- Flow/.../calendar_events.md（カレンダー予定）
- Flow/.../routine_tasks.md（ルーチンタスク）

## 次に実行

- 「07_週次レビュー」で週次の振り返りを実施
- 「07_バックログ同期」でバックログとの同期を確認
- タスク完了後は各タスクの状況を更新

## 関連コマンド

- *カレンダー確認: 「今日の予定確認」でカレンダーデータのみ取得*
- *バックログ同期: 「バックログ同期」でプロジェクトバックログとの同期*
- *週次レビュー: 「週次レビュー」で週単位の振り返り*

## 参照Rule

- `.cursor/rules/basic/00_master_rules.mdc`（日次タスク作成）
- `.cursor/rules/basic/07_task_management.mdc`

## トラブルシュート

- スクリプトエラーが発生した場合は、Pythonスクリプトの存在を確認
- CSVファイルの形式が正しくない場合は、バックログYAMLから再生成
- カレンダー統合でエラーが出る場合は、カレンダーアプリの設定を確認