# CMD_prj_02_プロダクトポジションステートメント

最終更新日時: 2025年12月25日 9:06

# 02 発見: プロダクト・ポジションステートメント

## 最初に質問（実行前に回答してください）

- プロジェクト名（必須）
- いつ（時代背景・現状）: どのような現在（時代）において（必須）
- なにを（唯一性）: 世界（日本）で唯一の何か（必須）
- どのように（特徴）: 特徴的機能・差別化要素（必須）
- どこの（出自/対象市場）: どこに住んでいる（どこから来る）（必須）
- なぜ（ニーズ/問題）: どんなニーズ（問題）を持った（必須）
- だれに（ターゲット）: だれのために提供する（必須）

## 目的

Rules（`basic/02_pmbok_discovery.mdc`）に準拠し、プロダクトの提供価値と差別化を明文化するポジションステートメントを作成します。メッセージの核を短く、再利用可能な形で定義します。

## 必要入力

- プロジェクト名: 対象プロジェクトの名称
- いつ: 時代背景・現状（市場/技術/顧客の文脈）
- なにを: 「唯一性」の定義（カテゴリ内での唯一性・新結合）
- どのように: 特徴的機能/仕組み/体験（3〜5点）
- どこの: 地理/導入文脈/部門などの起点
- なぜ: 解決するニーズ/課題（1文）
- だれに: 明確な対象（役割/セグメント）

## 実行手順（Rules Steps）

```
- trigger: "(ポジションステートメント|プロダクトポジション|Positioning Statement)"
  priority: high
  steps:
    - name: "start_info_collection"
      action: "call"
      target: "basic/02_pmbok_discovery.mdc => positioning_questions"
      message: "【プロダクト・ポジションステートメント】に必要な情報を収集します。"
    - name: "wait_user_responses"
      action: "wait_for_all_answers"
      message: "必要な回答が揃うまで先に進みません。"
    - name: "confirm_document_creation"
      action: "confirm"
      message: "収集した情報でポジションステートメントを作成します。よろしいですか？"
    - name: "create_draft"
      action: "create_markdown_file"
      path: "{{patterns.flow_date}}/draft_positioning_statement.md"
      template_reference: "basic/02_pmbok_discovery.mdc => positioning_template"
      message: "ドラフトを作成しました。修正後『確定反映』でStockへ保存します。"
```

## 構成（テンプレート要素）

- いつ： __________ という現在（時代）において,
- なにを: 私たちのプロダクトは世界（日本）で唯一の __________ である。
- どのように: そのプロダクトの特徴的機能は __________ であり
- どこの: __________ に住んでいる（からやってくる）
- なぜ: __________ というニーズ（問題）を持った
- だれに: __________ のために 提供する。

## 生成物

- Flow/.../draft_positioning_statement.md（ドラフト）
- Stock/.../3_planning/positioning_statement.md（確定版）

## 活用方法

- メッセージガイドライン/プレスリリース/LP/ピッチ資料への転用
- 機能優先度・UX原則・ロードマップ方針の整合
- 競合比較時の差別化軸の明確化

## 次に実行

- 「02_ペルソナ作成」で対象の明確化
- 「02_ソリューション定義」で特徴機能を要件化
- 「03_OKR作成」「03_ロードマップ作成」で実行方針へ接続

## 参照Rule

- `.cursor/rules/basic/02_pmbok_discovery.mdc`（Positioning）
- `.cursor/rules/basic/00_master_rules.mdc`
- `.cursor/rules/basic/03_pmbok_planning.mdc`

## トラブルシュート

- 抽象度が高い場合は「だれに/なぜ」から具体化する
- 「なにを」が機能説明になっている場合は“唯一性”の言い換えを再検討
- 競合と同義になってしまう場合は「どのように（特徴）」で具体差分を3点以上挙げる