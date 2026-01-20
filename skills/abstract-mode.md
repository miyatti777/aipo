---
name: abstract-mode
description: "L0-L4抽象度管理とNotion擬似プログラミングガイド"
license: "MIT"
---

# CTX_abstract_mode_rules

最終更新日時: 2025年12月28日 16:43

# abstract_rules:notion_pseudo_programming - Notion擬似プログラミングガイド

<aside>
💡

**AIPOの抽象化モードは「Notionで動くシステム」を作ります**

コードではなく、**NotionのDatabase・Form・AI機能**を組み合わせて、実行可能なアプリケーションを構築します。

このページは、Notionでできること・できないことを明確にし、実装タスクの正しい進め方を定義します。

</aside>

<aside>
🚨

## **AIPOの抽象化モードの目的は「動くDatabase/システム」を作ること。**

セッション中、以下を常に確認すること：

```yaml
session_reminder:
  every_task:
    question: "このタスクで実際のDatabaseは作成/更新されたか？"
    if_no: "完了とせず、DB作成を実行する"
  
  every_completion:
    check: "ガイド/設計書だけで終わっていないか？"
    if_yes: "実際のDB作成を追加実行する"
  
  session_end:
    verify: "このセッションで作成されたDBの数を報告"
    format: |
      📊 DB作成サマリ
      - 作成したDB: X件
      - 更新したDB: Y件
      - 作成したページ（ガイド等）: Z件
      
      ⚠️ ページ数 > DB数 の場合、追加でDB作成が必要
```

**このルールはセッション全体を通じて適用される。**

</aside>

---

---

## 🤖 運用Commands方式【最重要】

<aside>
⚡

Notion擬似プログラミングで**実際に動く実行プラットフォーム**を構築する唯一の実用的方法です。

@mentionでAIを呼び出し、ページ作成・更新を自動化する実行可能なコマンドシステムです。

</aside>

### 🎯 運用Commandsとは

**運用Commands**は、Notionページとして実装された「実行可能なコマンド」です。

**特徴**：

- チャットで`@コマンド名`で呼び出し
- 変数を受け取って柔軟に実行
- DBからデータ取得・処理・更新
- ページ作成・更新を自動化
- 繰り返し実行可能（量産対応）

### 📐 実装パターン

### 1. Database設計

```yaml
# 入力DB
記事入力管理:
  properties:
    - URL情報: url
    - テーマ: text
    - 対象人物: person
    - ステータス: select [入力済み, 分析完了, 構成案作成完了]
  form: あり（ユーザーが入力）

# 出力DB
記事構成案管理:
  properties:
    - パターン名: title
    - 章構成: text
    - 文字数配分: text
    - 元入力: relation → 記事入力管理
```

### 2. 運用Commandsページ作成

```markdown
# CMD-SG1-001: 入力分析コマンド

## 📌 コマンド概要
**目的**: 入力データを分析し、YAML形式で結果を出力

## 📥 Input
- **入力データ**: @mention形式でページ指定
- **分析対象**: URL情報、テーマ、対象人物

## 📤 Output
- **形式**: YAML（ページ本文に追記）
- **内容**: URL分析結果、テーマ分析結果
- **DB更新**: ステータスを「分析完了」に変更

## 🔧 実行方法
```

@AIPO_05_operation を実行してください

Command: @CMD-SG1-001

入力データ: @ページ名

```

## 📋 処理ロジック
1. 指定ページから入力データ取得
2. URL情報を分析（サイト概要、コンテンツタイプ）
3. テーマを分析（キーワード抽出、関連トピック）
4. 結果をYAML形式でページ本文に出力
5. ステータスを「分析完了」に更新
```

### 3. 実行例

```jsx
// チャットで実行
@AIPO_05_operation @CMD-SG1-001 を実行してください

入力データ: @記事入力_20251207_001
```

**実行結果**：

- AIが指定ページを読み込み
- 分析処理を実行
- ページ本文に以下を追記：

```yaml
# 分析結果

url_analysis:
  site_name: "TechCrunch"
  content_type: "ニュース記事"
  main_topic: "AI技術動向"

theme_analysis:
  keywords: ["生成AI", "LLM", "プロダクト開発"]
  related_topics: ["API設計", "ユーザー体験"]
```

- DBのステータスを「分析完了」に更新

### 🔄 Database + 運用Commands = 実行プラットフォーム

| **要素** | **役割** | **例** |
| --- | --- | --- |
| **入力DB + Form** | データ入力・状態管理 | 記事入力管理DB |
| **運用Commands** | 処理ロジック | CMD-入力分析、CMD-構成案生成 |
| **出力DB** | 成果物管理 | 記事構成案管理DB |

**実行フロー**：

1. ユーザーがFormから入力 → 入力DB
2. `@AIPO_05_operation`で`@CMD-入力分析`実行 → 分析結果をページに追記 → ステータス更新
3. `@AIPO_05_operation`で`@CMD-構成案生成`実行 → 出力DBに3-5件のページを作成
4. ユーザーが出力DBで確認・選択

### 📚 実装ガイドライン

**1. コマンドページの構成**

```markdown
# CMD-XXX: [コマンド名]

## 📌 コマンド概要
## 📥 Input
## 📤 Output  
## 🔧 実行方法
## 📋 処理ロジック
## ⚠️ 注意事項
## 🔗 関連リソース
```

**2. 命名規則**

- `CMD-[LayerID]-[番号]`: 例 `CMD-SG1-001`
- 動詞で始める: 「入力分析」「構成案生成」

**3. フォルダ構成**

```
📁 [Layer]/
├── 📁 運用コマンド/
│   ├── 📄 CMD-SG1-001_入力分析
│   ├── 📄 CMD-SG1-002_構成案生成
│   └── 📄 ...
├── 📊 入力管理DB
└── 📊 出力管理DB
```

**4. Abstract Mode標準パターン**

Abstract Modeでプラットフォームを構築する際の標準タスク分解：

```yaml
tasks:
  - T001: Database設計・作成
      deliverable: 入力DB + 出力DB（Formを含む）
      
  - T002: 運用Commands作成
      deliverable: CMD-001, CMD-002, ...（実行ロジック）
      
  - T003: 動作検証
      deliverable: テストデータでの実行確認
```

### 🚀 AIPOでの位置づけ

**運用Commands = Abstract Modeの成果物**

- **AIPO_04_execute**（構築フェーズ）: Database + 運用Commandsを作成
- **AIPO_05_operation**（運用フェーズ）: 運用Commandsを実行して量産

```yaml
# AIPO_04で構築
Layer: SG1_アイディア収集・構成案生成
mode: abstract
成果物:
  - 記事入力管理DB
  - 記事構成案管理DB
  - CMD-SG1-001（入力分析）
  - CMD-SG1-002（構成案生成）

# AIPO_05で運用
実行: @AIPO_05_operation (Command: @CMD-SG1-001, 入力: @データ1)
実行: @AIPO_05_operation (Command: @CMD-SG1-002, 入力: @データ1)
実行: @AIPO_05_operation (Command: @CMD-SG1-001, 入力: @データ2)
実行: @AIPO_05_operation (Command: @CMD-SG1-002, 入力: @データ2)
...
```

### 💡 まとめ

<aside>
✨

**運用Commands = Notion擬似プログラミングの到達点**

NotionのDatabase、Form、AIを組み合わせて：

- ✅ データ入力・管理（Database + Form）
- ✅ 処理ロジック（運用Commands）
- ✅ 自動実行・量産（@mention実行）
- ✅ チーム共有・再利用（コマンドページ）

**コードなしで「動くシステム」を構築できます。**

</aside>

**実装例**: [SG1_アイディア収集・構成案生成](https://www.notion.so/SG1_-de193ca8dece4f8cb583c925316e7b2f?pvs=21)

---

## ✅ Notionでできること（実装可能）

### 1. データ構造・状態管理（Database）

<aside>
🗄️

**Databaseは「テーブル＋ビジネスロジック」**

単なるデータ保存ではなく、リレーション・Formula・AI自動入力機能により、リアルタイムで動作するデータ構造を実現できます。

</aside>

**できること：**

```yaml
Database機能:
  property_types:
    - Title, Text, Number, Date, Checkbox
    - Select, Multi-select, Status（ステータス遷移）
    - Person（メンバー管理）
    - Relation（他DBとの関連付け）
    - Rollup（関連DBから集計）
    - Formula（計算・条件分岐）
    
  views:
    - Table: 表形式
    - Board: Kanban形式（ステータス別）
    - Calendar: カレンダー形式
    - Gallery: カード形式
    - List: リスト形式
    - Timeline: ガントチャート
    
  filters_and_sorts:
    - 複雑な条件でフィルタリング
    - 複数条件でソート
    - Viewごとに異なる表示
```

**実装例：記事管理Database**

```yaml
Database: 記事管理DB
  properties:
    - タイトル（Title）
    - ステータス（Status: 企画中/執筆中/レビュー中/公開済み）
    - 担当者（Person）
    - 締切（Date）
    - 文字数（Number）
    - 関連記事（Relation → 記事管理DB）
    - 執筆進捗率（Formula: 文字数/目標文字数）
    
  views:
    - 執筆中ビュー（Filter: Status = 執筆中）
    - 担当者別ビュー（Group by: 担当者）
    - 締切順ビュー（Sort by: 締切）
```

---

### 2. 入力機構（Form）

<aside>
📝

**Formでデータ入力**

Notion公式のForm機能を使えば、ユーザーから構造化データを収集できます。

</aside>

**できること：**

```yaml
Form機能:
  - Databaseへのデータ入力フォーム
  - 公開URL共有可能（外部からの入力受付）
  - 必須項目設定
  - プロパティ別の入力タイプ
  
  実装例:
    - 記事入力フォーム
    - タスク登録フォーム
    - フィードバック収集フォーム
```

**公式ドキュメント：**

- Form: [https://www.notion.so/help/guides/creating-a-form-with-a-notion-database](https://www.notion.so/help/guides/creating-a-form-with-a-notion-database)

---

### 3. 処理ロジック（Formula・AI自動入力）

<aside>
🤖

**Formula と AI自動入力で簡単な処理**

DatabaseプロパティでFormula計算とAI自動入力が利用可能です。

</aside>

### Formula

```yaml
Formula機能:
  - Property値の計算
  - 条件分岐（if文的な動作）
  - 日付計算・文字列操作
  - 数値計算・集計
  
  実装例:
    進捗率: prop("完了タスク数") / prop("総タスク数") * 100
    期限ステータス: if(prop("締切") < now(), "期限切れ", "進行中")
    タグ結合: prop("タグ1") + ", " + prop("タグ2")
```

### AI自動入力

<aside>
⚠️

**制約に注意**

AI自動入力は**ページ内コンテンツのみ**を処理対象とします。

- ✅ ページ本文の要約・翻訳・重要情報抽出
- ❌ URL先の情報取得
- ❌ 外部情報ソースへのアクセス
- ❌ Web検索

**ツールなしのAI処理のみ**であることに注意してください。

</aside>

**できること：**

```yaml
AI自動入力機能:
  設定方法:
    1. Databaseの右上の「＋」をクリック
    2. 「テキスト」プロパティを作成
    3. プロパティをクリック→「AI自動入力を設定」
    
  入力対象オプション:
    - 要約: ページのコンテンツを要約
    - 翻訳: 対象コンテンツを他言語に翻訳
    - 重要情報: ページ内から重要情報を抽出
    - カスタム自動入力: カスタムプロンプトで生成
  
  制約:
    - 処理対象: ページ本文のみ
    - URL先の情報取得: 不可
    - 外部情報アクセス: 不可
    - Web検索: 不可
    
  実装例:
    要約プロパティ: ページ本文を200文字で要約
    翻訳プロパティ: 日本語→英語に翻訳
    アクションアイテム: カスタムプロンプトで抽出
```

**公式ドキュメント：**

- Formula: [https://www.notion.so/help/formulas](https://www.notion.so/help/formulas)
- AI自動入力: [https://www.notion.so/help/guides/using-ai-autofill-in-databases](https://www.notion.so/help/guides/using-ai-autofill-in-databases)

---

## ❌ Notionでできないこと（実装不可）

<aside>
🚫

**以下はNotion単体では実現できません**

これらが必要なタスクは「運用Commands方式」を使うか、「設計書作成」として処理します。

</aside>

```yaml
Notion単体で不可能なこと:
  
  1. ページ埋め込みでの複雑なAI処理:
    - AI Blocks: 実用に耐えない（使わない）
    - Button経由のAI処理: 実装不可
    → 代替案: 運用Commands方式（@mention実行）
    
  2. 自動ワークフロー:
    - ステータス変更時の自動処理
    - 条件分岐による自動タスク生成
    - トリガーベースの自動化
    → 代替案: 運用Commands方式で手動実行
    
  3. 外部情報アクセス:
    - URL先の情報取得
    - Web検索
    - 外部API呼び出し
    → 代替案: 運用Commands方式（AIの検索機能活用）
    
  4. サーバーサイドコード実行:
    - Python/JavaScript等のコード実行
    - 複雑なアルゴリズム処理
    - 大量データの一括処理
    → 代替案: 運用Commands方式（AI実行）
```

---

## 🎯 タスクタイプ別の実装方針

### Type: `implementation` - DB設計

**該当するタスク：**

- "○○DBの作成"
- "データ構造設計"
- "入力処理機能"

**実装内容：**

```yaml
成果物:
  1. Database作成:
    - プロパティ定義（型・必須項目・デフォルト値）
    - Relation設定（他DBとの関連付け）
    - Formula設定（計算ロジック）
    - AI自動入力設定（必要に応じて）
    
  2. View作成:
    - 用途別View（Board/Table/Calendar等）
    - Filter・Sort設定
    - Group by設定
    
  3. Form作成:
    - 入力フォーム設計
    - 必須項目設定
    
  4. ドキュメント作成:
    - DB設計書（プロパティ一覧・用途）
    - 運用ガイド（入力方法・注意点）
```

---

### Type: `implementation` - ロジック実装

**該当するタスク：**

- "○○分析ロジック"
- "○○生成アルゴリズム"
- "○○処理機能"

**実装内容：**

```yaml
成果物:
  1. 運用Commands作成【必須】:
    - コマンドページ作成
    - Input/Output定義
    - 実行手順定義
    - テストケース
    
  2. ドキュメント作成:
    - 処理ロジック設計書
    - 実装詳細
    - 使用方法
```

1. Operation Command: analyze_article
    
    実行フロー:
    
    1. 記事入力DBから未処理レコード取得
    2. 記事分析AI実行
    3. 分析結果を構造化して保存
    4. ステータスを「完了」に更新
2. ドキュメント: 記事分析仕様書
    - 分析項目定義
    - 出力フォーマット
    - サンプル結果

```
注意:
  - AI Blocksは使わない
  - 複雑な処理は運用Commands方式で実装
```

---

### Type: `design` - UI/フォーマット設計

**該当するタスク：**

- "○○フォーマット整備"
- "UI設計"
- "テンプレート作成"

**実装内容：**

```yaml
成果物:
  1. ページテンプレート作成:
    - 構造定義
    - セクション分け
    - スタイル統一
    
  2. サンプル作成:
    - 実際のデータで例示
    - 複数パターン用意
    
  3. ドキュメント作成:
    - デザインガイド
    - 使用方法
```

---

### Type: `validation` - 動作確認

**該当するタスク：**

- "○○検証"
- "品質チェック"
- "動作確認"

**実装内容：**

```yaml
成果物:
  1. テストケース実行:
    - 実データでの動作確認
    - エッジケースのチェック
    - パフォーマンス確認
    
  2. 検証レポート作成:
    - テスト結果一覧
    - 発見した問題点
    - 改善提案
```

---

## 🛠️ 実装時の必須チェックリスト

<aside>
✅

**AIPO_04_execute 実行時、必ず確認すること**

</aside>

```yaml
実装タスク開始前:
  - [ ] このタスクはNotion機能で実現可能か？
  - [ ] 必要なDatabase/Form/運用Commands機能は何か？
  - [ ] 参照すべきcommand_templateはあるか？

実装中:
  - [ ] Databaseを実際に作成したか？
  - [ ] プロパティ・Viewを設定したか？
  - [ ] Formを作成したか（必要な場合）？
  - [ ] 運用Commandsを作成したか（ロジック実装の場合）？
  - [ ] 実際に動作するか確認したか？

完了判定:
  - [ ] Database/Formが実在するか？
  - [ ] 運用Commandsが実在し、実行可能か？
  - [ ] 実際に入力・処理・出力ができるか？
  - [ ] ドキュメントが整備されているか？
  - [ ] 他のタスクから参照可能な状態か？

禁止事項:
  - [ ] AI Blocksを使っていないか？
  - [ ] Buttonで処理トリガーを実装していないか？
  - [ ] 自動ワークフローを実装していないか？
```

---

## 📚 参考リソース

### Notion公式ドキュメント

| 機能 | ドキュメントURL |
| --- | --- |
| Database | [https://www.notion.so/help/intro-to-databases](https://www.notion.so/help/intro-to-databases) |
| Form | [https://www.notion.so/help/guides/creating-a-form-with-a-notion-database](https://www.notion.so/help/guides/creating-a-form-with-a-notion-database) |
| Formula | [https://www.notion.so/help/formulas](https://www.notion.so/help/formulas) |
| AI | [https://www.notion.so/help/guides/using-notion-ai](https://www.notion.so/help/guides/using-notion-ai) |

<td>AI自動入力</td>

<td>[https://www.notion.so/help/guides/using-ai-autofill-in-databases](https://www.notion.so/help/guides/using-ai-autofill-in-databases)</td>

### 内部リソース

- [CTX_command_templates](command-templates.md) - 実装テンプレート集
- [CTX_execution_rules](execution-rules.md) - 実行ルール
- [aipo (AI-PO) system](../aipo%20(AI-PO)%20system.md) - AIPOシステム全体

---

**作成日**: 2025-12-07

**最終更新**: 2025-12-08

**ステータス**: 実装完了・正確性修正済み