# CMD_prj_01_プロダクト定義

最終更新日時: 2025年12月25日 9:06

# 01 初期化: プロダクト定義

## 最初に質問（実行前に回答してください）

- プロダクト（プログラム）定義書を作成するか（はい/いいえ）
- プロダクト（プログラム）名（必須）
- 関連するテーマ/戦略（必須）
- Mission/Vision/Value（必須）
- プロダクトビジョン（必須）
- プロダクトポジションステートメント（必須）
- 目標とOKR（必須）
- 体制情報（必須）

## 目的

Rules（`basic/01_pmbok_initiating.mdc`）に準拠し、プロダクト（プログラム）定義書を作成します。会話コンテキストから関連情報を自動抽出し、回答を事前入力します。

## 必要入力

- プロダクト名: プロダクト（プログラム）の正式名称
- テーマ/戦略: 関連する事業テーマや戦略
- Mission: 使命・存在意義（何のために存在するか）
- Vision: 目指す姿・目標（どんな状態を目指すか）
- Value: 信念・価値観（何を大切にするか）
- プロダクトビジョン: 数年後の理想的な姿
- ポジションステートメント: いつ・なにを・どのように・どこの・なぜ・だれに
- Objective: 単一の定性的ゴール
- Key Results: 測定可能な成果指標（1-3個）
- 体制: PO・PM・ステークホルダーの役割

## 実行手順（Rules Steps）

```
- trigger: "(プロダクト定義|プロダクト目標定義|Product定義|プログラム定義|プログラム目標定義|Program定義)(作成|つくって|)"
  priority: high
  steps:
    - name: "analyze_conversation_context"
      action: "analyze_context"
      store_as: "context_analysis"
      message: "会話コンテキストから関連情報を抽出しています..."
    
    - name: "prefill_question_answers"
      action: "prefill_from_context"
      source: "{{context_analysis}}"
      questions_reference: "kcom/01_kcom_initiating.mdc => program_definition_questions"
      store_as: "prefilled_answers"
    
    - name: "start_info_collection"
      action: "call_with_suggestions"
      target: "kcom/01_kcom_initiating.mdc => program_definition_questions"
      suggestions: "{{prefilled_answers}}"
      message: "【プロダクト（プログラム）定義】の作成に必要な情報を収集します。会話からの推測に基づく提案も含めています。\n提案内容が適切であれば確定し、修正が必要であれば編集してください。"
    
    - name: "wait_user_responses"
      action: "wait_for_all_answers"
      message: "必要な回答が揃うまで先に進みません。"
    
    - name: "confirm_document_creation"
      action: "confirm"
      message: "収集した情報で「プロダクト（プログラム）定義」のドラフトのファイルを実際に作成してよろしいですか？（はい/いいえ）"
    
    - name: "create_draft"
      action: "edit_file"
      path: "{{patterns.flow_date}}/draft_program_definition.md"
      template_reference: "kcom/01_kcom_initiating.mdc => program_definition_template"
      message: "プロダクト（プログラム）定義のドラフトのファイルを作成しました: {{patterns.flow_date}}/draft_program_definition.md\n必要に応じて修正・追記した後、Stockディレクトリへ確定反映できます。"
    
    - name: "notify_storage_location"
      action: "notify"
      message: |
        ✅ プロダクト（プログラム）定義のドラフトのファイルを作成しました。
        確定後は以下のパスに保存されます：
        {{dirs.programs}}/{{program_id}}/program_definition.md
```

## 生成物

- Flow/.../draft\_program\_definition.md（ドラフト）
- Stock/programs/\[プログラム名\]/program\_definition.md（確定版）

## プロダクト定義の構成要素

### 🎯 Mission/Vision/Value

- *Mission: 使命・存在意義（なぜ存在するのか）*
- *Vision: 目指す姿・目標（どんな状態を目指すのか）*
- *Value: 信念・価値観（何を大切にするのか）*

### 🚀 プロダクトビジョン

- 数年後の理想的な姿とそれによる世界の変化
- 感情的で刺激的、モチベートされる内容

### 📍 プロダクトポジションステートメント

- *いつ: どのような現在（時代）において*
- *なにを: 世界（日本）で唯一の何か*
- *どのように: 特徴的機能*
- *どこの: 対象の地理的範囲*
- *なぜ: 解決するニーズ（問題）*
- *だれに: 対象ユーザー*

### 🎯 目標とOKR

- *Objective: 単一の定性的ゴール*
- *Key Results: 測定可能な成果指標（1-3個）*

## 次に実行

- 「01\_憲章\_\_プロジェクト憲章」でプロダクト配下のプロジェクト憲章を作成
- 「03\_計画\_\_ロードマップ作成」でプロダクトロードマップを作成
- 「07\_管理\_\_日次タスク作成」で日常管理を開始

## 参照Rule

- `.cursor/rules/basic/01_pmbok_initiating.mdc`（プロダクト定義）
- `.cursor/rules/basic/00_master_rules.mdc`

## トラブルシュート

- 会話コンテキストからの自動抽出が不正確な場合は手動で修正
- Mission/Vision/Valueが不明な場合は「TBD」として後で決定
- OKRの数値目標が設定できない場合は定性的な指標から開始