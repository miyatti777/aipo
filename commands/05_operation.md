# CMD_aipo_05_operation

最終更新日時: 2025年12月25日 19:29

# aipo_operation - Operation（継続運用）

<aside>
📚

**必須コンテキスト（このコマンド実行時に自動読み込み）**

以下のページを事前に参照してください：

1. [aipo (AI-PO) system](../aipo%20(AI-PO)%20system.md)
2. [execution-rules](../skills/execution-rules.md)
3. [command-templates](../skills/command-templates.md)
4. [session-rules](../skills/session-rules.md)
5. [04_deliver](04_deliver.md)
6. [abstract-mode](../skills/abstract-mode.md)
7. [troubleshoot](../skills/troubleshoot.md) - 操作相談スキル
</aside>

> **構築済みの実行プラットフォームで、運用Commandsを実行します**
> 

> Abstract Modeで構築したシステムの「運用フェーズ」で使用するコマンドです。
> 

> 運用Commandsを呼び出し、データ処理・ページ生成などを自動実行します。
> 

<aside>
⚠️

**前提条件**: Abstract Modeで実行プラットフォームが構築済みであること

- Database（データ構造）が作成済み
- 運用Commands/フォルダにコマンドページが配置済み
- Layer完了後の「運用フェーズ」で使用
</aside>

---

## 🎯 このコマンドの責務

<aside>
💡

**aipo_init の完全な責務**

1. **運用Commandの実行** - 指定されたコマンドページの指示に従って処理
2. **変数の受け渡し** - 入力データやパラメータを渡して実行
3. **Database操作** - データ取得・処理・更新・ページ作成
4. **実行結果の報告** - 処理内容と成果物を明示
</aside>

---

## 📋 実行手順

### Step 0: Human Input

<aside>
💡

@aipo_init を実行してください

Command: CMD-SG1-001（入力分析）
入力データ: 入力ページURL

</aside>

---

### Step 1: コマンド読み込み

```jsx
🔍 運用Commandを読み込み中...

【コマンド情報】
Command: CMD-SG1-001（入力分析コマンド）
Goal: 入力データからURL・テーマ・人物情報を分析
Input: 記事入力管理DBのページ
Output: YAML形式の分析結果 + ステータス更新

【実行準備】
✅ 入力データページ: 確認済み
✅ 対象Database: 記事入力管理
✅ 必要な権限: OK

実行してよろしいですか？
```

---

### Step 2: Human Approves

```jsx
OK
```

---

### Step 3: AI Executes（コマンド実行）

```jsx
⚙️ CMD-SG1-001 を実行中...

【処理内容】
1. 入力データページを読み込み
   - URL情報: [https://note.com/yagikei/](https://note.com/yagikei/)...
   - テーマ: 「叩きのめすvs気がついたら世界変わってる」
   - 対象人物: 柳川慶太

2. URL分析を実行
```

url_analysis:

title: "CTOが記事を書く理由"

author: "柳川慶太"

key_themes:

- 技術経営
- リーダーシップ

```

3. テーマ分析を実行
```

theme_analysis:

core_question: "対立する2つのスタイルの本質は何か"

target_insights:

- リーダーシップの多様性
- 状況に応じた使い分け

```

4. ページ本文に分析結果を追記

5. ステータスを「分析完了」に更新

✅ 実行完了
```

---

### Step 4: 実行結果の報告

```jsx
✅ CMD-SG1-001 実行完了

【成果物】
- 分析結果YAML: ページ本文に追記済み
- ステータス: 「入力済み」→「分析完了」に更新

【次のステップ】
次は CMD-SG1-002（構成案生成）を実行できます：

```

@aipo_init_operation を実行してください

Command: @CMD-SG1-002

入力データ: @分析済みページ

```

```

---

## 🔄 運用Commandsの実行フロー

```jsx
【実行プラットフォーム構築完了後】

1️⃣ データ入力（Formまたは手動）
   ↓
2️⃣ aipo_init で運用Command実行
   例: @CMD-入力分析
   ↓
3️⃣ AIが自動処理
   - DBからデータ取得
   - 分析・加工・生成
   - DB更新・ページ作成
   ↓
4️⃣ 次の運用Command実行
   例: @CMD-構成案生成
   ↓
5️⃣ 成果物完成

💡 このサイクルを繰り返すことで、システムを「運用」できる
```

---

## 💬 使用例

### 基本的な使い方

<aside>
💡

[05_operation](05_operation.md) を実行してください

Command: CMD-SG1-001
入力データ: page-123

</aside>

### 変数を指定して実行

<aside>
💡

[05_operation](05_operation.md) を実行してください

Command: CMD-記事生成
Variables:
  target_person: "山田太郎"
  theme: "AIプロダクト開発"
  word_count: 10000

</aside>

### 複数データを一括処理

<aside>
💡

[05_operation](05_operation.md) を実行してください

Command: CMD-構成案生成
入力データ:
  - page-123
  - page-124
  - page-125

</aside>

---

## ⚙️ AIへの実行指示

<aside>
🤖

**重要: 事前参照**

実行前に必ず以下を参照：

- [execution-rules](../skills/execution-rules.md) - 共通ルール
- [abstract-mode](../skills/abstract-mode.md) - 実装ガイド

---

**AIへの指示（このコマンドが@メンションされたとき）**

**Phase 1: Command読み込み**

1. 指定された運用Commandページを読み込む
2. コマンドの以下の情報を確認：
    - Goal（このコマンドの目的）
    - Input（必要な入力データ）
    - Output（生成する成果物）
    - 処理手順（ステップバイステップの指示）

**Phase 2: 入力データ確認**

1. 指定された入力データを読み込む
2. 必要な変数が全て揃っているか確認
3. Database接続を確認

**Phase 3: Human Approval**

1. 実行内容をユーザーに確認
2. 承認後に実行開始

**Phase 4: Execute**

1. コマンドの処理手順に従って実行：
    - Databaseからデータ取得（query-data-sources）
    - AIによる分析・加工・生成
    - ページ作成・更新（create-pages, update-page-v2）
    - Database更新（update-page-v2でプロパティ更新）
2. 各ステップの実行結果を記録

**Phase 5: Report**

1. 実行完了を報告
2. 成果物を明示（作成されたページ、更新されたDB等）
3. 次に実行可能な運用Commandを提案

**重要な原則**

- 運用Commandの指示に忠実に従う
- Database操作は必ず実行する（設計書だけにしない）
- エラー時は明確にエラー内容を報告
- 実行結果は具体的に記録（「〇〇ページを作成」「ステータスを更新」等）
</aside>

---

## 🔗 関連コマンド

- [04_deliver](04_deliver.md) - プラットフォーム構築時のタスク実行
- [03_discover](03_discover.md) - 運用Commands作成

---

## 📊 aipo_sense_and_focus と aipo_init の違い

| 観点 | aipo_sense_and_focus_execute | aipo_init_operation |
| --- | --- | --- |
| **フェーズ** | 構築フェーズ | 運用フェーズ |
| **実行対象** | Tasks（プロジェクトタスク） | 運用Commands |
| **目的** | 実行プラットフォームを作る | 実行プラットフォームを使う |
| **成果物** | Database、運用Commands、ドキュメント | データ処理結果、生成コンテンツ |
| **実行頻度** | 一度（構築時） | 繰り返し（運用時） |
| **使用例** | 記事制作システム構築 | 記事を量産する |

---

**作成日**: 2025-11-27

**最終更新**: 2025-12-25

**ステータス**: Ready

**変更履歴**: aipo_05からaipo_operationに名称変更、Jeff Patton理論との対応を明記