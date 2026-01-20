# CMD_prj_05_スプリントレビュー

最終更新日時: 2025年12月25日 9:06

# 05 監視: スプリントレビュー

## 最初に質問（実行前に回答してください）

- プロジェクト名・スプリント番号（必須）
- スプリント期間（必須）
- 完了したユーザーストーリー（必須）
- 未完了項目・インペディメント（必須）
- チームの振り返り・改善点（必須）

## 目的

Rules（`basic/05_pmbok_monitoring.mdc`）に準拠し、スプリント完了時のレビューを実施します。Flow内の日次タスクを自動集約し、完了ストーリーとインペディメントを抽出してレビューレポートを作成します。

## 必要入力

- プロジェクト名: 対象プロジェクトの名称
- スプリント番号: レビュー対象のスプリント
- スプリント期間: 開始日・終了日
- 完了項目: 完了したユーザーストーリー・タスク
- 未完了項目: 未完了の作業・理由
- インペディメント: 障害・課題・問題
- 振り返り: チームの気づき・改善点

## 実行手順（Rules Steps）

```yaml
- trigger: "(スプリントレビュー作成|Sprint Review)"
  priority: high
  steps:
    # A) Flow 内の日次タスクを自動集約
    - collect_flow_materials:
        query:
          glob: "{{patterns.daily_tasks_glob}}"
          lookback_days: 14
        store_as: daily_pool

    # B) 完了ストーリー／インペディメント抽出
    - transform:
        source: "{{daily_pool}}"
        script: |
          # 入力: list[str] (= 日次タスク md)
          import re, yaml, textwrap, json, itertools, pathlib
          done = set(); imped = []
          for path,txt in source:
              for line in txt.splitlines():
                  m = re.match(r"- \[x\] (US-[0-9]+)", line, re.I)
                  if m: done.add(m.group(1))
                  if "⚠" in line or "impediment" in line.lower():
                      imped.append(line.lstrip("- "))

          print(json.dumps({
            "demo_items": "\n".join(f"- {d}" for d in sorted(done)),
            "impediments": "\n".join(f"- {i}" for i in imped)
          }))
        store_as: auto_data

    # C) 質問プリフィル
    - prefill_question_answers:
        target_questions: "pmbok_executing.mdc => sprint_review_questions"
        source: "{{auto_data}}"

    # D) 不足質問ヒアリング
    - ask_unfilled_questions:
        message: "Sprint Review に不足している情報を入力してください。"

    # E) 確認してドラフト生成
    - confirm: "入力＋自動集約で Sprint Review を Flow に作成します。よろしいですか？"
    - create_markdown_file:
        path: "{{patterns.draft_review}}"
        template_reference: "basic/pmbok_executing.mdc => sprint_review_template"
    - notify: |
        {{patterns.draft_review}} を生成しました。
        修正後「確定反映して」で Stock/sprints/{{sprint_id}} へ移動します。
```

## スプリントレビューの構成要素

### 📊 スプリント概要

- *基本情報: スプリント番号・期間・チーム*
- *ゴール: 当初設定したスプリントゴール*
- *計画: 計画していた作業・ユーザーストーリー*
- *実績: 実際に完了した作業・成果物*

### ✅ 完了項目

- *ユーザーストーリー: 完了したストーリー一覧*
- *タスク: 完了した技術的タスク*
- *成果物: 作成された成果物・ドキュメント*
- *品質: テスト結果・品質指標*

### ⚠️ 課題・改善点

- *未完了項目: 完了できなかった作業・理由*
- *インペディメント: 発生した障害・課題*
- *プロセス課題: 開発プロセスの問題点*
- *改善提案: 次スプリントへの改善案*

### 📈 メトリクス

- *ベロシティ: 完了したストーリーポイント*
- *バーンダウン: 作業の進捗状況*
- *品質指標: バグ数・テストカバレッジ*
- *チーム満足度: チームの満足度・モチベーション*

## 生成物

- Flow/.../draft_sprint_review_[番号].md（ドラフト）
- Stock/.../5_monitoring/sprints/sprint_review_[番号].md（確定版）

## スプリントレビューの活用方法

### 🎯 継続改善

- *プロセス改善: 開発プロセスの最適化*
- *チーム改善: チームワーク・コミュニケーション向上*
- *技術改善: 技術的な課題・制約の解決*
- *品質改善: 品質向上のための施策*

### 📊 計画調整

- *バックログ調整: 優先順位・内容の見直し*
- *容量調整: チームの作業容量の調整*
- *スケジュール調整: リリース計画の調整*
- *リソース調整: 人員・設備の調整*

### 🔄 ナレッジ共有

- *成功事例: うまくいった取り組みの共有*
- *失敗事例: 失敗から得た教訓の共有*
- *ベストプラクティス: 効果的な手法の蓄積*
- *組織学習: 組織全体での学習・改善*

## レビューのベストプラクティス

### ✅ 効果的なレビュー

- *事実ベース: 客観的な事実に基づく評価*
- *建設的: 批判ではなく改善に焦点*
- *具体的: 具体的な改善案・アクション*
- *チーム参加: 全メンバーが参加・発言*

### ❌ 避けるべきレビュー

- *個人攻撃: 個人を責める・批判する*
- *曖昧: 抽象的で行動につながらない*
- *一方的: 一部の人だけが発言*
- *後ろ向き: 問題点の指摘のみ*

## 次に実行

- 「04_スプリントゴール」で次スプリントの計画
- 「03_バックログ初期化」でバックログの調整
- 「07_週次レビュー」で定期的な振り返り

## 参照Rule

- `.cursor/rules/basic/05_pmbok_monitoring.mdc`（スプリントレビュー）
- `.cursor/rules/basic/00_master_rules.mdc`

## トラブルシュート

- 日次タスクデータが不足する場合は、手動で補完
- 自動抽出結果が不正確な場合は、手動で修正
- チームの合意が得られない場合は、ファシリテーションを工夫