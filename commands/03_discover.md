# CMD_aipo_03_discover

最終更新日時: 2025年12月25日 19:28

# aipo_discover - Discover（計画立案）

> **Jeff Pattonの「Discover（発見/検証）」フェーズを再現**
> 

> プロダクトオーナーが行う「実行計画の立案」をAIが自動化。
> 

> tasks.yaml を読み取り、各タスクの実行用コマンドページを生成します。
> 

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
</aside>

> テンプレートがあればコピー、なければ新規作成します。
> 

<aside>
⚠️

**前提条件**: [02_focus](02_focus.md) でtasks.yaml生成が完了していること

aipo_init（Context準備） → aipo_sense_and_focus（タスク分解） → **aipo_discover（コマンド生成）** → aipo_deliver（実行）

</aside>

---

## 🎯 このコマンドの責務

<aside>
💡

**aipo_discover の完全な責務**

1. **tasks.yaml の読み込み** - 各タスクの command フィールドを確認
2. **Commands フォルダの作成** - Layer配下に Commands/ を作成
3. **コマンドページの生成** - 各タスクごとに実行用ページを作成
    - テンプレート参照があれば → コピーして調整
    - テンプレート参照なし → 新規作成
4. **次アクション案内** - aipo_deliver への誘導
</aside>

---

## 📋 実行手順

### Step 0: Human Input

<aside>
💡

[03_discover](03_discover.md)  を実行してください

Layer: SL1_記事構成設計

</aside>

---

### Step 1: tasks.yaml 読み込み

```jsx
🔍 tasks.yaml を読み込み中...

【検出されたタスク】
- T1.0: コンテンツリサーチ
  command: "01_コンテンツリサーチ"
  command_template_ref: "command_templates/リサーチ系/基本調査"
  
- T1.1: タイトル確定
  command: なし
  
- T1.2: 章構成設計
  command: "02_記事企画・構成設計"
  command_template_ref: "command_templates/コンテンツ制作/記事企画"
  
- T1.3: 引用箇所リスト作成
  command: なし
```

---

### Step 2: テンプレート・既存コマンド探索

**AI自動実行**:

```jsx
🔍 関連テンプレート・既存コマンドを探索中...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【探索対象】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. command-templates 配下のテンプレート
   - Discovery_templates（企画系の基本）
   - project_management_templates
   - task_management_templates
   - Research_templates
   - presentation_templates
   - その他関連テンプレート

2. Commands/aipm_system 配下のAIPMコマンド
   📌 企画系タスクの場合は最優先で参照：
   - ペルソナ作成
   - 課題定義
   - ソリューションマップ
   - 競合調査
   - 市場調査
   - ストーリーマップ

3. Commands 配下の既存CMD系コマンド
   - 類似のタスクで既に作成されたコマンド
   - 再利用可能なパターン

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### Step 3: コマンド生成計画の提案

**AI自動実行**:

```jsx
📋 探索結果とコマンド生成計画：

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【発見されたテンプレート・参考コマンド】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 タスク分析:
• T1.0: 参加者分析 → 企画系タスク（ペルソナ特定・課題分析）
• T1.1: メニュー設計 → 企画系タスク（ソリューション設計）

📦 参考にできるコマンド:
✅ Commands/aipm_system/3_discovery/01_ペルソナ作成
   → T1.0で活用: ペルソナ作成→課題マップのフロー
   
✅ Commands/aipm_system/3_discovery/02_課題定義
   → T1.0で活用: 課題の優先度付け（Critical/High/Medium）
   
✅ Commands/aipm_system/3_discovery/03_ソリューションマップ
   → T1.1で活用: 課題→ソリューション対応表の作成

✅ Discovery_templates/command_templates
   → 共通: HITL統合型の基本構造

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【生成対象コマンド】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ T1.0: CMD_カレー企画_参加者分析
   📌 参考: aipm/01_ペルソナ作成 + aipm/02_課題定義
   構造:
   - Phase 1: AI自動実行（参加者ペルソナ生成）
   - HITL Phase 1: 人間確認・調整
   - Phase 2: AI自動実行（食の課題マップ作成）
   - HITL Phase 2: 人間承認
   Goal: 参加者ペルソナ特定、食の制約・課題分析

✅ T1.1: CMD_カレー企画_メニュー設計
   📌 参考: aipm/03_ソリューションマップ
   構造:
   - Phase 1: AI自動実行（メニュー案生成）
   - HITL Phase 1: 人間確認・調整
   - Phase 2: AI自動実行（イベントコンセプト作成）
   - HITL Phase 2: 人間承認
   - Phase 3: AI自動実行（仕様書作成）
   Goal: 課題解決メニュー設計、仕様書作成

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【スキップ】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏭️ T1.2: 予算見積もり作成（commandフィールドなし）
⏭️ T1.3: 経営承認の取得（commandフィールドなし）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### Step 4: Human Approves（参考コマンド指定）

<aside>
🙋

**人間の判断が必要**

AIが提案した参考コマンドとコマンド構造を確認してください。

**確認項目**:

- [ ]  参考コマンドは適切か？
- [ ]  コマンド構造（Phase分け）は妥当か？
- [ ]  他に参考にすべきコマンドはないか？

**アクション例**:

- 全て承認 → `OK`
- 参考コマンド変更 → `T1.0は[別のコマンド]を参考にしてください`
- 追加コマンド化 → `T1.2もコマンド化してください（参考: [コマンド名]）`
- 構造調整 → `T1.0のPhase構成を[具体的な調整]に変更してください`
</aside>

**承認例**:

```jsx
// パターン1: 全て承認
OK

// パターン2: 参考コマンド指定
OK。T1.0はaipm/02_課題定義をより重視して作成してください

// パターン3: 追加コマンド化
OK。T1.2もコマンド化してください（参考: project_management_templates/予算管理）

// パターン4: 構造調整
T1.0は Phase 2の前にもう1回HITLフェーズを追加してください
```

---

### Step 5: AI Executes（コマンド生成）

**4a. Commands フォルダ作成**

```jsx
📁 Commands/ フォルダを作成中...

📁 [Layer]/
├── 📄 layer.yaml
├── 📄 context.yaml
├── 📄 tasks.yaml
├── 📁 Commands/  ← 🆕 作成
│   ├── 📄 CMD_日程調整と確定
│   ├── 📄 CMD_会場選定と仮押さえ
│   ├── 📄 CMD_予算見積もり作成
│   └── 📄 CMD_経営承認の取得
└── ...
```

**4b. 各コマンドページ生成**

コマンドは**HITL統合型**として生成します。

**HITL統合型コマンドとは**:

- AIが自動実行できる部分（テンプレート生成、分析、レポート作成等）と人間の実行が必要な部分（判断、外部連絡、承認取得等）を明確に分離
- 各フェーズで適切にHITLポイントを設定し、人間のアクションを待つ
- aipo_deliverで実行可能なワークフロー型コマンド

**生成される各コマンドの構造**:

```markdown
# CMD_[タスク名]

<callout icon="🎯" color="blue_bg">
	**Goal**: [このコマンドで達成すること]
	**Type**: HITL統合コマンド（AI自動実行 + 人間実行）
	**Estimated**: [XX]時間（人間実行含む）
</callout>

---

## 🤖 実行フロー

このコマンドはCMD_aipo_deliverで実行可能です。

### Phase 1: AI自動実行 - [最初のAI処理]

**AI実行内容**:
1. 親LayerのContextを参照
2. [具体的な処理内容]
3. [生成物の説明]

**AI生成物**:
</callout>
```

[具体的な生成物の例]

```jsx
---
<callout icon="⏸️" color="yellow_bg">
	AIが生成した[XX]を確認してください。
	**確認項目**:
	- [ ] [確認項目1]
	- [ ] [確認項目2]
	**アクション**:
	- [パターンA] → [対応]
	- [パターンB] → [対応]
	**完了後のアクション**:
	「[完了報告の形式]」と返答してください。
</callout>
---

**AI生成物**:
</callout>
</callout>
</callout>
```

[具体的な生成物の例]

```jsx

---

### 🙋 HITL Phase 2: [人間の判断・実行内容]

<callout icon="⏸️" color="yellow_bg">
	**人間の実行が必要**
	[実行すべき内容の説明]
	**実行手順**:
	1. [ ] [ステップ1]
	2. [ ] [ステップ2]
	**完了後のアクション**:
	「[完了報告の形式]」と返答してください。
</callout>

---

[... 以下、タスクの性質に応じてPhaseを繰り返し ...]

---

## ✅ 完了条件

- [ ] [完了条件1]
- [ ] [完了条件2]
- [ ] [完了条件3]

---

## 📝 成果物

1. [成果物1]
2. [成果物2]
3. [成果物3]

---

## 🔗 次のコマンド

[次に実行すべきコマンドへのリンクと説明]

---

## ⚙️ AIへの実行指示

<callout icon="🤖" color="purple_bg">
	**このコマンドが@aipo_deliverで実行されたとき:**
	1. **Phase 1を自動実行**: [AI処理の内容]
	2. **HITL Phase 1で停止**: 「[人間への指示メッセージ]」
	3. Human完了後、**Phase 2を自動実行**: [次のAI処理]
	4. **HITL Phase 2で停止**: 「[人間への指示メッセージ]」
	[... 以下、フェーズ数に応じて継続 ...]
	N. **完了を確認し、次のコマンドを案内**
	**重要**: 各HITLフェーズでは必ず人間のアクションを待つ。人間の返答があるまで次のフェーズに進まない。
</callout>
</callout>
```

**生成例**:

```jsx
⚙️ コマンド生成中...
✅ CMD_日程調整と確定
   Type: HITL統合コマンド
   Structure:
   - Phase 1: AI自動実行（候補日程生成）
   - HITL Phase 1: 人間確認
   - HITL Phase 2: Slack投稿実行
   - HITL Phase 3: 集計待機
   - Phase 2: AI自動実行（集計分析）
   - HITL Phase 4: 最終決定
   - HITL Phase 5: 告知実行
   Goal: 候補日程の洗い出し、参加可能性の確認、最終日程の決定
   Deliverables: 候補日程リスト、Slack投稿、集計結果、最終決定日程
   Type: HITL統合コマンド
   Structure:
   - Phase 1: AI自動実行（見積依頼テンプレート生成）
   - HITL Phase 1: 確認・調整
   - HITL Phase 2: 見積依頼送信
   - HITL Phase 3: 回答収集待機
   - Phase 2: AI自動実行（見積比較分析）
   - HITL Phase 4: 業者選定
   - Phase 3: AI自動実行（総予算算出）
   - Phase 4: AI自動実行（承認資料作成）
   - HITL Phase 5: 承認資料確認
   Goal: ケータリング業者への見積もり依頼、総予算の算出、承認資料の作成
   Deliverables: 見積依頼、業者比較表、総予算見積書、承認申請資料
```

---

### Step 6: Next Step（実行へ）

<aside>
💡

🔜 Next Step

コマンド生成が完了しました。
次は aipo_deliver でタスクを実行してください。

実行例:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[CMD_aipo_04_deliver](https://www.notion.so/CMD_aipo_04_deliver-4a7d3a9ff65f4b22968540d7c979b5b5?pvs=21)  T1.0 を実行してください

Layer: @SL1_記事構成設計（対象レイヤーへのメンション）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

aipo_deliver が以下を実行します

1. Commands/01_コンテンツリサーチ を読み込み
2. コマンドの指示に従って実行
3. 成果物（DB・ドキュメント）を生成
</aside>

---

## 🔄 コマンド生成の流れ（全体像）

```jsx
Layer: SL1_記事構成設計
├── 1️⃣ aipo_01_layer_init ✅ (Context準備)
├── 2️⃣ aipo_02_decompose ✅ (タスク分解)
│   └── tasks.yaml 生成（commandフィールド含む）
│
├── 3️⃣ aipo_03_discover ✅ (コマンド生成 ← 今ここ)
│   ├── Commands/ フォルダ作成
│   ├── 01_コンテンツリサーチ 生成
│   └── 02_記事企画・構成設計 生成
│
└── 4️⃣ aipo_deliver (実行)
		├── T1.0: Commands/01_コンテンツリサーチ を実行
		├── T1.1: 直接実行（コマンドなし）
		├── T1.2: Commands/02_記事企画・構成設計 を実行
		└── T1.3: 直接実行（コマンドなし）
		💡 パターン: aipo_01 → aipo_02 → aipo_03 → @aipo_deliver
```

---

## 📝 コマンドページの標準構造（HITL統合型）

### 必須セクション

**1. ヘッダー（Goal/Type/Estimated）**

```markdown
# CMD_[タスク名]
<callout icon="🎯" color="blue_bg">
**Goal**: [このコマンドで達成すること]
**Type**: HITL統合コマンド（AI自動実行 + 人間実行）
**Estimated**: [XX]時間（人間実行含む）
</callout>
</callout>
```

**2. 実行フロー（Phase構造）**

- **Phase N: AI自動実行** - AIが自動で実行できる処理
- **🙋 HITL Phase N** - 人間の判断・実行が必要な箇所

各Phaseには以下を記載:

- AI実行内容（何を参照し、何を生成するか）
- AI生成物（具体的な出力例）
- HITL Phase: 確認項目、実行手順、完了後のアクション

**3. 完了条件**

```markdown
## ✅ 完了条件

- [ ] [完了条件1]
- [ ] [完了条件2]
```

**4. 成果物**

```markdown
## 📝 成果物

1. [成果物1]
2. [成果物2]
```

**5. 次のコマンド**

```markdown
## 🔗 次のコマンド

[このコマンド完了後に実行すべき次のコマンド]
```

**6. AIへの実行指示（最重要）**

```markdown
## ⚙️ AIへの実行指示

<callout icon="🤖" color="purple_bg">
**このコマンドが@aipo_deliverで実行されたとき:**

1. **Phase 1を自動実行**: [処理内容]
2. **HITL Phase 1で停止**: 「[人間への指示]」
3. Human完了後、次のPhaseへ
[... 全フェーズを順次記載 ...]

**重要**: 各HITLフェーズでは必ず人間のアクションを待つ。
</callout>
</callout>
```

### フェーズ設計のガイドライン

**AI自動実行Phaseの例**:

- テンプレート生成（メール、Slack投稿、チェックリスト等）
- データ分析・比較表作成
- 推奨案の提示
- レポート・資料作成

**HITL Phaseの例**:

- 生成物の確認・調整
- 外部への連絡・問い合わせ
- 実際の予約・発注
- 承認取得
- 待機（回答待ち、期限待ち）

**HITLの停止ポイント設計**:

```markdown
<callout icon="⏸️" color="yellow_bg">
**人間の[判断/実行]が必要**
[何をすべきかの説明]
- [ ] [項目1]
- [ ] [項目2]
- [選択肢B] → [対応]

</callout>
</callout>
</callout>
```

---

## 💬 使用例

### 基本的な使い方

<aside>
💡

[03_discover](03_discover.md) を実行してください

Layer: SL1_記事構成設計

</aside>

### テンプレートを指定して追加

<aside>
💡

[03_discover](03_discover.md) を実行してください

Layer: SL1_記事構成設計
T1.1もコマンド化してください（テンプレート: command_templates/汎用/簡易タスク）

</aside>

---

## ⚙️ AIへの実行指示

<aside>
🤖

**重要: 事前参照**

実行前に必ず以下を参照：

- [execution-rules](../skills/execution-rules.md) - 成果物ページ構造標準を含む共通ルール
- [session-rules](../skills/session-rules.md) - セッション分割・コンテキスト維持ルール

---

**AIへの指示（このコマンドが@メンションされたとき）**

**Phase 1: tasks.yaml 読み込み**

1. 対象Layerのtasks.yamlを読み込む
2. 各タスクのcommandフィールドを確認
3. command_template_refフィールドがあれば記録

**Phase 2: テンプレート・既存コマンド探索**

1. **command-templates を探索**:
    - Discovery_templates を優先的に確認
    - タスクの性質に応じて関連テンプレートを探す
2. **Commands/aipm_system を探索**（企画系タスクの場合）:
    - タスク内容を分析し、企画系（ペルソナ/課題/ソリューション）かを判定
    - 該当する場合、AIPMコマンドを最優先で参照:
        - 01_ペルソナ作成
        - 02_課題定義
        - 03_ソリューションマップ
        - 01_競合調査（必要に応じて）
    - **仕事関連のaipo GOALの場合は特に厳密に探索**
3. **Commands配下の既存コマンドを探索**:
    - 類似タスクで既に作成されたコマンドを検索
    - 再利用可能なパターンを特定
4. **探索結果を整理**:
    - 各タスクに最適な参考コマンドを特定
    - コマンド構造（Phase分け）を設計
    - HITL統合型の標準構造を適用

---

**Phase 3: コマンド生成計画の提案**

1. 発見されたテンプレート・参考コマンドをリスト化
2. 各タスクの構造（Phase分け）を提案
3. 参考コマンドとの対応関係を明示
4. 生成対象とスキップ対象を明確化
5. ユーザーに確認
    
    **Phase 4: Human Approval（参考コマンド確認）**
    
6. 提案した参考コマンドとコマンド構造を確認してもらう
7. 参考コマンドの変更・追加があれば反映
8. コマンド構造の調整があれば反映
9. 追加でコマンド化するタスクがあれば対応
    
    **Phase 5: Execute**
    
    1. Commands/ フォルダを作成（存在しない場合）
    2. 各コマンドページを**HITL統合型**として生成:
        - テンプレート参照あり → コピーしてタスクコンテキストで調整
        - テンプレート参照なし → HITL統合型の標準構造で新規作成
    3. 各ページに以下を記載:
        
        **必須ヘッダー**:
        
        - Goal（タスクのgoal）
        - Type: HITL統合コマンド
        - Estimated（タスクのestimated_hours）
        
        **実行フロー（Phase構造）**:
        
        - タスクの性質を分析し、適切なPhase構成を設計
        - AI自動実行できる部分を特定
        - 人間の判断・実行が必要な箇所をHITL Phaseとして明示
        - 各Phaseで生成物・確認項目・実行手順を具体的に記載
        
        **完了条件・成果物**:
        
        - 明確な完了条件のチェックリスト
        - 具体的な成果物リスト（タスクのdeliverables）
        
        **次のコマンド**:
        
        - 依存関係のある次のタスクへのリンク
        
        **AIへの実行指示**:
        
        - aipo_deliver実行時の詳細なフロー
        - 各PhaseとHITL Phaseの実行順序
        - HITLでの停止条件と再開条件
        - 「重要: 各HITLフェーズでは必ず人間のアクションを待つ」を必ず記載
    
    **Phase 6: Next Step Guidance**
    
    1. コマンド生成完了を通知
    2. aipo_deliver の実行を案内
    3. 実行例を提示
    
    **重要な原則**
    
    - commandフィールドがないタスクはスキップ
    - テンプレートがあれば必ずコピーして使用
    - 各コマンドページは実行可能な詳細度で作成
</aside>

---

## 🔗 次のコマンド

コマンド生成後の次のステップ：

1. [04_deliver](04_deliver.md) で各タスクを実行

---

**作成日**: 2025-12-07

**最終更新**: 2025-12-25

**ステータス**: Ready

**変更履歴**: aipo_03からaipo_discoverに名称変更、Jeff Patton理論との対応を明記