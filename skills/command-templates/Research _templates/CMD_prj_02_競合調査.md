# CMD_prj_02_競合調査

最終更新日時: 2025年12月25日 9:06

# 02 調査: 競合調査（Web検索ベース）

## 最初に質問（実行前に回答してください）

- 調査対象のプロジェクト名（必須）
- 自社の製品・サービスの概要（必須）
- 主な競合企業・サービス（任意・カンマ区切り）
- 競合調査で特に知りたい側面（必須・例：価格戦略、マーケティング手法）

## 目的

Rules（`basic/00_master_rules.mdc`）に準拠し、Web検索を活用した競合調査レポートを自動生成します。競合企業の戦略、強み・弱み、市場ポジションを分析します。あわせて、競合/代用品/代替品の分類リストと、比較マトリックスを作成します。

## 必要入力

- プロジェクト名: 調査対象のプロジェクト名
- 自社製品/サービス: 自社の製品・サービスの概要
- 主な競合: 既知の競合企業・サービス（分かる範囲で）
- 調査フォーカス: 特に知りたい側面（価格・機能・マーケティング等）

## 実行手順（Rules Steps）

```yaml
- trigger: "(競合調査|Competitor Research)"
  priority: high
  steps:
    - name: "collect_research_requirements"
      action: "ask_questions"
      questions:
        - key: "project_name"
          question: "調査対象のプロジェクト名を入力してください"
          required: true
        - key: "product_service"
          question: "自社の製品・サービスの概要を簡潔に教えてください"
          required: true
        - key: "main_competitors"
          question: "主な競合企業・サービスがあれば教えてください（カンマ区切りで複数可）"
          required: false
        - key: "research_focus"
          question: "競合調査で特に知りたい側面を教えてください（例：価格戦略、マーケティング手法、製品機能など）"
          required: true
      store_as: "research_params"
    - name: "confirm_research"
      action: "confirm"
      message: "以下の内容で競合調査を実施します：\n\nプロジェクト: {{research_params.project_name}}\n自社製品/サービス: {{research_params.product_service}}\n主な競合: {{research_params.main_competitors}}\n調査フォーカス: {{research_params.research_focus}}\n\nWeb検索を開始してよろしいですか？"
    - name: "web_research_competitors"
      action: "web_search"
      search_term: "{{research_params.product_service}} 業界 主要企業 競合 マーケットシェア 最新"
      explanation: "業界の主要競合企業に関する情報を収集します"
      store_as: "competitors_data"
    - name: "web_research_specific_competitors"
      action: "web_search"
      search_term: "{{research_params.main_competitors}} {{research_params.research_focus}} 戦略 特徴 最新動向"
      condition: "research_params.main_competitors"
      explanation: "指定された競合企業についての詳細情報を収集します"
      store_as: "specific_competitors_data"
    - name: "web_research_market_trends"
      action: "web_search"
      search_term: "{{research_params.product_service}} 市場動向 業界トレンド 最新技術 将来予測"
      explanation: "業界の市場動向と最新トレンドに関する情報を収集します"
      store_as: "market_trends_data"
    - name: "web_research_competitive_strategies"
      action: "web_search"
```

```yaml
      search_term: "{{research_params.product_service}} 業界 {{research_params.research_focus}} 競争戦略 差別化要因"
      explanation: "競合の戦略と差別化要因に関する情報を収集します"
      store_as: "strategies_data"
    - name: "analyze_web_research"
      action: "analyze"
      data: ["{{competitors_data}}", "{{specific_competitors_data}}", "{{market_trends_data}}", "{{strategies_data}}"]
      instructions: "収集したWeb検索データを分析し、競合企業の主要特性、市場ポジション、戦略、強み・弱みを抽出します"
      store_as: "analyzed_results"
    - name: "create_draft"
      action: "create_markdown_file"
      path: "{{patterns.flow_date}}/draft_competitor_research.md"
      template_reference: "basic/02_pmbok_research.mdc => competitor_research_template"
    - name: "create_competitor_classification"
      action: "create_markdown_file"
      path: "{{patterns.flow_date}}/competitor_summary_and_matrix.md"
      template_reference: null
      message: "競合/代用品/代替品の分類リストと比較マトリックスのドラフトを作成します（後続で上書き可能）。"

    - name: "append_comparison_matrix"
      action: "append_to_file"
      file: "{{patterns.flow_date}}/competitor_summary_and_matrix.md"
      block: |
        \n---\n\n## 比較マトリックス（雛形）\n\n| 項目 | 競合A | 競合B | 競合C | 代用品 | 代替品 |\n| --- | --- | --- | --- | --- | --- |\n| 主な用途 |  |  |  |  |  |\n| 導入/UX |  |  |  |  |  |\n| ガバナンス |  |  |  |  |  |\n| テンプレ/ワンクリック |  |  |  |  |  |\n| 計測/監査 |  |  |  |  |  |\n| 価格/契約 |  |  |  |  |  |\n| 強み |  |  |  |  |  |\n| 弱み |  |  |  |  |  |
      message: "比較マトリックスの雛形を追記しました。"
```

## 競合調査の分析項目

### 🏢 企業基本情報

- *企業概要: 設立年・規模・事業領域*
- *財務状況: 売上・利益・成長率*
- *市場シェア: 業界内でのポジション*
- *組織体制: 経営陣・従業員数・拠点*

### 📦 製品・サービス分析

- *製品ラインナップ: 主力商品・サービス一覧*
- *機能比較: 自社との機能差分*
- *価格戦略: 価格帯・料金体系*
- *品質・性能: 技術力・品質レベル*

### 📢 マーケティング戦略

- *ターゲット: 主要顧客層・市場セグメント*
- *チャネル: 販売チャネル・流通戦略*
- *プロモーション: 広告・PR・イベント戦略*
- *ブランディング: ブランドポジション・メッセージ*

### 💪 SWOT分析

- *Strengths（強み）: 競合の優位性・強み*
- *Weaknesses（弱み）: 課題・弱点*
- *Opportunities（機会）: 市場機会・成長可能性*
- *Threats（脅威）: 脅威・リスク要因*

## 生成物

- Flow/.../draft_competitor_research.md（ドラフト）
- Flow/.../competitor_summary_and_matrix.md（分類リスト＋比較マトリックス）
- Stock/.../2_research/competitor_research.md（確定版）

## 活用方法

### 🎯 戦略策定

- 自社の差別化ポイントの明確化
- 競合対策の立案
- 市場参入戦略の検討

### 📊 ベンチマーキング

- 業界標準の把握
- 自社の相対的ポジション確認
- 改善目標の設定

### 🔄 継続監視

- 競合動向の定期的な監視
- 新規参入者の早期発見
- 市場変化への対応

## 次に実行

- 「02_課題定義」で競合分析結果を基に課題を明確化
- 「02_ペルソナ作成」で競合との差別化ポイントを反映
- 「03_ロードマップ作成」で競合対策を含む計画を策定

## 参照Rule

- `.cursor/rules/basic/00_master_rules.mdc`（競合調査）
- `.cursor/rules/basic/02_pmbok_research.mdc`

## トラブルシュート

- 競合情報が不足する場合は、業界レポートや専門メディアを参考
- 直接競合がいない場合は、間接競合や代替手段も調査対象に
- 情報の信頼性に注意し、複数のソースで情報を確認