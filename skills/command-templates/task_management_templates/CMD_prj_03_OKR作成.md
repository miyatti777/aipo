# CMD_prj_03_OKR作成

最終更新日時: 2025年12月25日 9:06

# 03 計画: OKR作成

## 最初に質問（実行前に回答してください）

- 対象のプログラム/プロジェクト名（必須）
- 期間（例：2025-Q4、月次など）（必須）
- オーナー（必須）
- フェーズ（立ち上げ/改善/拡張 など）（必須）
- Objectives（1〜3件、短文）（必須）
- 各ObjectiveのKey Results（各2〜4件、測定指標と目標値）（必須）
- 計測・レビュー運用（任意）

## 目的

Rules（`basic/03_pmbok_planning.mdc`）に準拠し、OKRドラフトを生成します。立ち上げフェーズの場合はE2E成立・計測最小・学習ループ確立を優先するテンプレを提示します。

## 必要入力

- プログラム/プロジェクト: 例）Explaza / palma
- 期間: 例）2025-Q4（Oct–Dec）
- オーナー: 例）PM Miyatti
- フェーズ: 例）立ち上げ
- Objectives: 箇条書き
- Key Results: 各Objectiveに紐づく測定可能な成果指標

## 実行手順（Rules Steps）

```yaml
- trigger: "(OKR作成|OKRドラフト)"
  priority: high
  steps:
    - name: "collect_okr_inputs"
      action: "ask_questions"
      questions:
        - key: "program"
          question: "プログラム/プロジェクト名は？"
          required: true
        - key: "period"
          question: "期間は？（例：2025-Q4）"
          required: true
        - key: "owner"
          question: "OKRオーナーは？"
          required: true
        - key: "phase"
          question: "フェーズは？（立ち上げ/改善/拡張）"
          required: true
        - key: "objectives"
          question: "Objectivesを1〜3件で入力してください（; 区切り）"
          required: true
        - key: "krs"
          question: "各ObjectiveのKey Resultsを入力してください（Objective順に | 区切り、各KRは ; 区切りで）"
          required: true
      store_as: "okr_params"

    - name: "confirm_creation"
      action: "confirm"
      message: "以下の内容でOKRドラフトを作成します：\n\nプログラム: {{okr_params.program}}\n期間: {{okr_params.period}}\nオーナー: {{okr_params.owner}}\nフェーズ: {{okr_params.phase}}\n\n実行してよろしいですか？"

    - name: "create_draft"
      action: "create_markdown_file"
      path: "{{patterns.flow_date}}/okr_{{okr_params.period | slugify}}.md"
      template_reference: "basic/03_pmbok_planning.mdc => okr_template"
      message: "OKRドラフトを作成しました: {{patterns.flow_date}}/okr_{{okr_params.period | slugify}}.md\n修正・追記後に確定反映できます。"

    - name: "notify_stock_target"
      action: "notify"
      message: |
        ✅ 確定後は以下に保存されます：
        {{dirs.stock}}/programs/{{program_id | default: okr_params.program}}/projects/{{project_id}}/documents/3_planning/okr/okr_{{okr_params.period | slugify}}.md
```

## 生成物

- Flow/.../okr_yyyyqN.md（ドラフト）
- Stock/.../3_planning/okr/okr_yyyyqN.md（確定版）

## テンプレ（参考）

```markdown
---
doc_targets: [okr, planning]
importance: 5
program: {{program}}
project: {{project_id}}
period: {{period}}
owner: {{owner}}
last_update: {{today}}
---

# OKR（{{period}}）- {{program}} / {{project_id}}

{{#if (eq phase "立ち上げ")}}
## Objective 1: MVP v0.1のE2Eを成立させる
- KR1: 主要ユースケースのE2Eデモ（動画）
- KR2: 最小ガードレール（評価ログ/監査ログ）
- KR3: 権限α実装（招待/閲覧/実行）

## Objective 2: 社内デザイナーと検証ループを回す
- KR1: プロトタイプ2ラウンド
- KR2: ユーザテスト5回 / インサイト30件 / 改善10件
- KR3: 社内パイロット計画承認

## Objective 3: アラインメントとMVP定義
- KR1: PRD v1.0 承認 / MVPスコープ凍結
- KR2: テンプレ3種の仕様合意と試作
- KR3: リスクTop10を週次更新
{{/if}}
```

## 次に実行

- 「03_ロードマップ作成」でマイルストーン化
- 「07_週次レビュー生成」で運用を定着

## 参照Rule

- `.cursor/rules/basic/03_pmbok_planning.mdc`
- `.cursor/rules/basic/00_master_rules.mdc`