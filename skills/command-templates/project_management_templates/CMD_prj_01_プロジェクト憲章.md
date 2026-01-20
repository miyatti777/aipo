# CMD_prj_01_プロジェクト憲章

最終更新日時: 2025年12月25日 9:06

# 01 憲章: プロジェクト憲章

## 最初に質問（実行前に回答してください）

- プロジェクト名（必須）
- 背景と目的（必須）
- スコープ（含む/含まない）（任意）
- 主要ステークホルダー（必須）
- プロジェクトスポンサー（必須）
- 期間・予算（任意）

## 目的

Rules（`basic/01_pmbok_initiating.mdc`）に準拠し、プロジェクト憲章のドラフトを作成します。既存のFlow文書から関連情報を自動収集し、回答を事前入力します。

## 必要入力

- プロジェクト名: プロジェクトの正式名称
- 背景と目的: なぜこのプロジェクトが必要か、何を達成するか
- スコープ: プロジェクトに含まれる範囲・含まれない範囲
- ステークホルダー: 関係者（部署・役職）
- スポンサー: プロジェクトの承認者・責任者
- 期間・予算: 開始日・終了日・概算予算

## 実行手順（Rules Steps）

```
- trigger: "プロジェクト憲章|プロジェクトチャーター"
  priority: high
  mode: "exclusive"
  steps:
    - name: "collect_existing_info"
      action: "search_flow_files"
      query:
        doc_targets: "charter"
        importance_gte: 3
        lookback_days: 30
      store_as: "charter_materials"
      message: "プロジェクト憲章関連の既存情報を探しています..."
    - name: "auto_prefill"
      action: "prefill_question_answers"
      target_questions: "basic/01_pmbok_initiating.mdc => charter_questions"
      source: "{{charter_materials}}"
      message: "見つかった情報を元に回答を自動入力しています..."
    - name: "start_info_collection"
      action: "call basic/01_pmbok_initiating.mdc => charter_questions"
      message: "【プロジェクト憲章】の作成に必要な情報を収集します。以下の質問に回答してください。\n※既存の情報から推測した回答をあらかじめ入力してあります。必要に応じて修正してください。特に決まっていなければ、おまかせといっていただければ、推測で内容を作成します"
    - name: "wait_user_responses"
      action: "wait_for_all_answers"
      message: "必要な回答が揃うまで他のファイル作成を行いません。"
    - name: "confirm_document_creation"
      action: "confirm"
      message: "収集した情報で「プロジェクト憲章」のドラフトを作成してよろしいですか？（はい/いいえ）"
    - name: "create_draft"
      action: "create_markdown_file"
      path: "{{patterns.draft_charter}}"
      template_reference: "basic/01_pmbok_initiating.mdc => charter_template"
      message: "ドラフトを作成しました: {{patterns.draft_charter}}\n必要に応じて修正・追記した後、Stockディレクトリへ確定反映できます。"
```

## 生成物

- Flow/.../draft\_project\_charter.md（ドラフト）
- Stock/.../1\_initiating/project\_charter.md（確定版）

## 次に実行

- 「01\_関係者\_\_ステークホルダー分析」でステークホルダーを詳細分析
- 「03\_計画\_\_WBS作成」で作業分解構造を作成
- 「03\_計画\_\_リスク分析」でリスク計画を作成

## 参照Rule

- `.cursor/rules/basic/00_master_rules.mdc`（プロジェクト憲章）
- `.cursor/rules/basic/01_pmbok_initiating.mdc`

## トラブルシュート

- 既存情報の自動入力が不正確な場合は手動で修正してください
- 「おまかせ」と回答すると推測で内容を作成します