# CMD_prj_02_顧客調査

最終更新日時: 2025年12月25日 9:06

# 02 調査: 顧客調査（Web検索ベース）

## 最初に質問（実行前に回答してください）

- 調査対象のプロジェクト名（必須）
- 調査したいターゲットオーディエンス（必須）
- 顧客調査で特に知りたい内容やトピック（必須・複数可）
- 業界や市場の背景情報（任意）

## 目的

Rules（`basic/00_master_rules.mdc`）に準拠し、Web検索を活用した顧客調査レポートを自動生成します。ターゲットオーディエンスの特性、消費者行動、ニーズを調査します。

## 必要入力

- プロジェクト名: 調査対象のプロジェクト名
- ターゲットオーディエンス: 具体的な顧客層（例：20代女性、中小企業経営者）
- 調査トピック: 知りたい内容（例：購買行動、価格感度、利用シーン）
- 業界背景: 業界や市場の背景情報（任意）

## 実行手順（Rules Steps）

```yaml
- trigger: "(顧客調査|Customer Research)"
  priority: high
  steps:
    - name: "collect_research_requirements"
      action: "ask_questions"
      questions:
        - key: "project_name"
          question: "調査対象のプロジェクト名を入力してください"
          required: true
        - key: "target_audience"
          question: "調査したいターゲットオーディエンスを具体的に教えてください"
          required: true
        - key: "research_topics"
          question: "顧客調査で特に知りたい内容やトピックを教えてください（複数可、カンマ区切り）"
          required: true
        - key: "industry_context"
          question: "業界や市場の背景情報があれば教えてください"
          required: false
      store_as: "research_params"
    - name: "confirm_research"
      action: "confirm"
      message: "以下の内容で顧客調査を実施します：\n\nプロジェクト: {{research_params.project_name}}\nターゲット: {{research_params.target_audience}}\n調査トピック: {{research_params.research_topics}}\n\nWeb検索を開始してよろしいですか？"
    - name: "web_research_audience"
      action: "web_search"
      search_term: "{{research_params.target_audience}} 顧客特性 消費者行動 ニーズ 最新動向"
      explanation: "ターゲットオーディエンスについての最新情報を収集します"
      store_as: "audience_data"
    - name: "web_research_topics"
      action: "web_search"
      search_term: "{{research_params.target_audience}} {{research_params.research_topics}} 消費者調査 市場調査 最新"
      explanation: "指定されたトピックに関する顧客調査情報を収集します"
      store_as: "topic_data"
    - name: "web_research_behavior"
      action: "web_search"
      search_term: "{{research_params.target_audience}} 購買行動 意思決定プロセス 顧客体験 {{research_params.industry_context}}"
      explanation: "ターゲットの購買行動や意思決定プロセスに関する情報を収集します"
      store_as: "behavior_data"
    - name: "analyze_web_research"
      action: "analyze"
      data: ["{{audience_data}}", "{{topic_data}}", "{{behavior_data}}"]
      instructions: "収集したWeb検索データを分析し、主要な洞察、傾向、パターンを抽出します"
```

```yaml
      store_as: "analyzed_results"
    - name: "create_draft"
      action: "create_markdown_file"
      path: "{{patterns.flow_date}}/draft_customer_research.md"
      template_reference: "basic/02_pmbok_research.mdc => customer_research_template"
```

## 生成物

- Flow/.../draft_customer_research.md（ドラフト）
- Stock/.../2_research/customer_research.md（確定版）

## 次に実行

- 「02_競合調査」で競合分析を実施
- 「02_ペルソナ作成」で顧客調査結果を基にペルソナを作成
- 「02_課題定義」で顧客の課題を定義

## 参照Rule

- `.cursor/rules/basic/00_master_rules.mdc`（顧客調査）
- `.cursor/rules/basic/02_pmbok_research.mdc`

## トラブルシュート

- Web検索結果が不十分な場合は、検索キーワードを調整して再実行
- 業界特有の用語がある場合は、業界背景情報に含めてください