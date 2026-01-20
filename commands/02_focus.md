# CMD_aipo_02_focus

最終更新日時: 2025年12月29日 14:11

# aipo_focus - Focus（PO思考の再現）

> **Jeff Pattonの「Focus（焦点化）」フェーズを再現**
> 

> プロダクトオーナーが行う「優先順位付け」をAIが自動実行。
> 

> GoalをSub-Goals（SubLayer）とTasks（実行単位）に分解し、tasks.yamlを生成します。
> 

<aside>
📚

**必須コンテキスト（このコマンド実行時に自動読み込み）**

以下のページを事前に参照してください：

1. [aipo (AI-PO) system](../aipo%20(AI-PO)%20system.md)
2. [execution-rules](../skills/execution-rules.md)
3. [command-templates](../skills/command-templates.md)
4. [roles-templates](../skills/roles-templates.md)
5. [session-rules](../skills/session-rules.md)
6. [04_deliver](04_deliver.md)
7. [abstract-mode](../skills/abstract-mode.md)
</aside>

<aside>
⚠️

**前提条件**: [01_sense](01_sense.md) でContext準備が完了していること

aipo_01（Context準備） → **aipo_02（タスク分解）** → aipo_03（コマンド設計）→ aipo_04 （コマンド実行）

</aside>

<aside>
🚨

**【重要】tasks.yaml生成時の必須要件**

**全てのTaskに`command`フィールドと`command_template_ref`フィールドを設定すること**

- `command: null` は管理系タスク（type: management, coordination, verification）**のみ**許可
- 実行系タスク（research, content, implementation等）には**必ず**適切なテンプレート参照を設定
- テンプレートが存在しない場合でも、`command: "TXXX_タスク名"` の形式で設定

**commandフィールドがないタスクは[03_discover](03_discover.md)でコマンドページが生成されません**

</aside>

---

## 🎯 核心コンセプト：真のRecursive分解

<aside>
💡

**重要な設計原則**

- **Sub-Goal = SubLayer** → 複雑な目標は新しいLayerとして独立
- **Task = 実行可能な単純作業** → このLayerで完結
- **詳細タスクは親で作らない** → SubLayerの中で`aipo_02`を実行したときに生成

これにより**無限再帰**が可能になり、どんな複雑なGoalも同じパターンで分解できます。

</aside>

---

## 📋 分解の判断基準

### Sub-Goal（→ SubLayer化）

以下に該当するものは**SubLayer**として独立させる：

| 判断基準 | 例 |
| --- | --- |
| 複数のTaskで構成される | 「Scrum運用プロセスの文書化」 |
| 独自のContextが必要 | 「Product部門の業務基盤構築」 |
| 他人に委譲できる単位 | 「デザインプロセス標準化」 |
| 独立したスケジュール管理が必要 | 「Phase 2: 横断チーム展開」 |

### Task（→ このLayerで完結）

以下に該当するものは**Task**としてこのLayerに残す：

| 判断基準 | 例 |
| --- | --- |
| 1人で1〜2日で完了 | 「READMEの作成」 |
| これ以上分解不要 | 「Slackチャンネル作成」 |
| 管理・統括系の作業 | 「全体進捗モニタリング」 |
| SubLayer間の調整 | 「完了条件の検証」 |

---

## 🔄 処理フロー

```jsx
┌─────────────────────────────────────────┐
│ aipo_02_focus 実行                  │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│ Phase 1: init:Auto-Research                   │
│  - layer.yaml, context.yaml Contextsフォルダ を読み込み   │
│  - 関連情報を検索                        │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│ Phase 1.5: 専門家ロール選択（必須）      │
│  - GOALの性質を判定                      │
│  - Focus戦略を確定（ユーザー指定優先）   │
│  - 確定結果を tasks.yaml に必ず記録      │
│                                          │
│  🚨 tasks.yaml 追記フィールド（必須）    │
│  - focus_strategy:                      │
│    "system_architect" |                │
│    "product_manager" |                 │
│    "content_strategist" | "generic"    │
│  - focus_strategy_reason: "1〜2行"      │
│  - focus_strategy_confirmed_by:         │
│    "user" | "ai"                        │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│ Phase 2: Focus:分解 & 判定                     │
│                                          │
│  Goal を分析し、以下に分類:              │
│                                          │
│  【SubLayers】複雑 → 新Layer化           │
│   - SG1: Product部門の業務基盤構築       │
│   - SG2: 横断チームの業務基盤構築        │
│   - SG3: 他部門への展開準備              │
│                                          │
│  【Tasks】単純 → このLayerで完結         │
│   - T001: 全体進捗モニタリング設定       │
│   - T002: 完了条件チェックリスト作成     │
│                                          │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│ Phase 3: Human Approves                  │
│  「OK」or 「SG2はTaskでいい」            │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│ Phase 4: 構造生成                        │
│                                          │
│  ① tasks.yaml を更新                     │
│     - sublayers: [SG1, SG2, SG3]        │
│     - tasks: [T001, T002]               │
│                                          │
│  ② 各SubLayerに対して:                   │
│     → aipo_01_layer_init を案内        │
│     → 再帰的にLayer構造を生成           │
│                                          │
└─────────────────────────────────────────┘
</callout>
```

---

## 📋 実行手順

### Step 0: Human Input

<aside>
💡

[02_focus](02_focus.md) を実行してください

Layer: EXPLAZA業務基盤構築

</aside>

---

### Step 1: Sense:AI Auto-Research

```jsx
🔍 Layer情報を読み込み中...
- layer.yaml: Goal、制約条件、期限
- context.yaml: 組織情報、リソース
- 関連ページ: 類似プロジェクト、業界標準
```

---

### Step 1.5: 専門家ロール選択（必須）

<aside>
🎯

**Claude Code Skillsとの対応**

このフェーズは、Claude Code SkillsのLevel 2（戦略・ドメイン知識）に相当します。

Goalの性質に応じて、適切な「専門家視点」でのタスク分解を支援します。

</aside>

**Step 1.5a: ロールテンプレート探索**

**AI自動実行**:

```jsx
🔍 ロールテンプレートを探索中...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【探索対象】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

roles-templates 配下のロールページ:
✅ product_manager_focus
   適用シーン: プロダクト開発・改善
   分解特徴: Discovery→Delivery、MVP思考
   
✅ system_architect_focus
   適用シーン: システム構築・基盤整備
   分解特徴: 設計→実装→運用、モジュール分割
   
✅ content_strategist_focus
   適用シーン: コンテンツ制作・発信
   分解特徴: 企画→制作→配信、品質管理
   
✅ generic_focus
   適用シーン: その他すべて
   分解特徴: Senseコンテキストから動的判断

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Step 1.5b: Goal分析とロール選択提案**

**AI自動実行**:

<aside>
💡

🎯 Goal分析結果とロール選択:

━━━━━━━━━━━━━━━━━━━━━━━
【Goal分析】
━━━━━━━━━━━━━━━━━━━━━━━

Goal: EXPLAZA業務基盤構築
性質: システム・基盤構築
キーワード: 業務基盤、プロセス、標準化

━━━━━━━━━━━━━━━━━━━━━━━
【推奨ロール】
━━━━━━━━━━━━━━━━━━━━━━━

🎯 推奨: system_architect_focus

理由:

- システム基盤構築に特化したロール
- 設計→実装→運用の3層構造で分解
- モジュール分割と再利用性を重視

分解方針（このロールを適用した場合）:
✓ 設計フェーズ: 要件定義、アーキテクチャ設計
✓ 実装フェーズ: モジュール実装、統合テスト
✓ 運用フェーズ: 運用手順、保守体制

━━━━━━━━━━━━━━━━━━━━━━━

このロールで進めますか？（省略時は推奨ロールを使用）
📚 他のロール候補: [roles-templates](../skills/roles-templates.md) 
別のロールを指定する場合は明示してください。

</aside>

**利用可能な戦略テンプレート：**

| 戦略 | 適用シーン | 分解の特徴 |
| --- | --- | --- |
| Product Manager | プロダクト開発・改善 | Discovery→Delivery、MVP思考 |
| System Architect | システム構築・基盤整備 | 設計→実装→運用、モジュール分割 |
| Content Strategist | コンテンツ制作・発信 | 企画→制作→配信、品質管理 |
| 汎用（デフォルト） | その他すべて | Senseコンテキストから動的判断 |

**ユーザーによる明示指定も可能：**

```jsx
// 実行時に指定
@CMD_aipo_02_focus を実行してください
Layer: EXPLAZA業務基盤構築
Focus戦略: Product Manager視点で分解
```

---

### Step 2: Focus:AI Proposes（分解結果の提案）

<aside>
💡

📋 Goalを以下のように分解しました。確認してください：

【Goal】EXPLAZAの業務基盤を構築する

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【SubLayers】→ 各々 aipo_01 から再帰開始
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

| ID | Sub-Goal | 優先度 | 備考 |
| --- | --- | --- | --- |
| SG1 | Product部門の業務基盤構築 | P0 | ⭐ 初期スコープ |
| SG2 | 横断チームの業務基盤構築 | P1 | Dev/Design |
| SG3 | 他部門への展開準備 | P2 | PS/DG/Corp |
| SG4 | 部門間Context継承の確立 | P1 | 全体統合 |

※ 各SubLayerの詳細タスクは、そのSubLayerで
aipo_02_focus を実行したときに生成されます。

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【Tasks】→ このLayerで完結する単純作業
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

| ID | Task | 日数 | 備考 |
| --- | --- | --- | --- |
| T001 | 全体進捗モニタリング設定 | 1日 | 管理系 |
| T002 | SubLayer間の依存関係整理 | 1日 | 調整系 |
| T003 | 完了条件の検証チェックリスト | 1日 | 検証系 |

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ この分解でよろしいですか？
• 「OK」→ tasks.yaml を生成し、SG1の aipo_01 を開始
• 「SG2はTaskでいい」→ SubLayerからTaskに変更

</aside>

---

### Step 3: Human Approves

```jsx
// 承認（全SubLayerを進める）
OK
// 特定のSub-GoalをTaskに変更
OK。ただしSG2はSubLayerではなくTaskとして扱ってください。

OK。まずSG1だけ aipo_01 を開始してください。
```

---

### Step 4: AI Executes

**tasks.yaml を更新：**

<aside>
💡

# tasks.yaml（Recursive版 + Template Integration + Command Generation）

version: "2.2"
layer_id: "L001"
generated_at: "2025-12-06"
decomposition_type: "recursive"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# SubLayers: 各々が独立したLayerとして再帰

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

sublayers:

- id: "SG1"
goal: "Product部門（Palma）の業務基盤構築"
priority: "P0"
status: "pending_init" # aipo_01待ち
mode: "abstract" # 親から継承
layer_url: null # 生成後に更新
- id: "SG2"
goal: "横断チーム（Dev/Design）の業務基盤構築"
priority: "P1"
status: "pending_init"
mode: "abstract" # 親から継承
layer_url: null

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Tasks: このLayerで完結する単純作業

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

tasks:

# 🚨 重要: 全タスクにcommandフィールドを設定すること

# - 管理系（management/coordination/verification）→ command: null でOK

# - 実行系（research/content/implementation等）→ 必須

- id: "T001"
name: "全体進捗モニタリング設定"
type: "management"
status: "pending"
command: null # 管理系タスクのみnull許可
command_template_ref: null
- id: "T002"
name: "ペルソナ作成"
type: "research"
status: "pending"
command: "T002_ペルソナ作成" # 🚨必須: aipo_03で生成されるコマンドページ名
command_template_ref: "command_templates/02_ペルソナ作成" # 🚨必須: テンプレート参照
- id: "T003"
name: "競合調査"
type: "research"
status: "pending"
command: "T003_競合調査" # 🚨必須
command_template_ref: "command_templates/02_競合調査" # 🚨必須
- id: "T004"
name: "記事構成設計"
type: "content"
status: "pending"
command: "T004_記事構成設計" # 🚨必須
command_template_ref: "command_templates/09_記事企画・構成設計" # 🚨必須

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Command Generation 設定

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

command_generation:
enabled: true
target_folder: "Commands/"  # このLayer配下にCommandsフォルダを作成
template_folder: "command_templates/"  # テンプレート参照先
naming_pattern: "{task_id}_{task_name}"  # コマンドページ名の命名規則

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# サマリー

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

summary:
sublayer_count: 2
task_count: 4
next_action: "aipo_03_command_gen を実行してコマンドページを生成"

</aside>

**Documentsフォルダを生成：**

```jsx
📁 Documents/ を作成中...
収集したコンテキストを整理して以下のドキュメントを生成：
- 戦略分析（外部調査結果）
- 競合調査（ベンチマーク情報）
- 既存アセット整理（社内リソース）
- ...
```

**次のアクションを案内：**

<aside>
💡

✅ tasks.yaml を生成しました。

📁 Layer構造:
EXPLAZA業務基盤構築/
├── 📄 layer.yaml
├── 📄 layer.yaml（aipo_01で作成済み）
├── 📄 context.yaml（aipo_01で作成済み）
├── 📄 [README.md](http://README.md)（aipo_01で作成済み）
├── 📁 tasks/
│   └── 📄 tasks.yaml（✅ 今作成）
├── 📁 sublayers/
│   ├── 📁 SG1_Product部門/ ← aipo_01で初期化
│   ├── 📁 SG2_横断チーム/ ← aipo_01で初期化
├── 📁 Documents/（コンテキスト整理）
└── 📁 Documents/（オプション）

🔜 次のステップ:
	各SubLayerに対して [01_sense](01_sense.md) を実行してください

</aside>

---

## 🔄 コマンド実行の流れ（全体像）

```jsx
Layer_Root: EXPLAZA業務基盤構築
├── 1️⃣ aipo_01_layer_init ✅ (Context準備)
├── 2️⃣ aipo_02_focus ✅ (タスク分解 ← 今ここ)
│   ├── SubLayers: [SG1, SG2, SG3, SG4]
│   └── Tasks: [T001, T002, T003]
│
├── SubLayer_SG1: Product部門の業務基盤構築
│   ├── 1️⃣ aipo_01_layer_init (Context準備)
│   ├── 2️⃣ aipo_02_focus (タスク分解)
│   │   ├── SubLayers: [SG1-1, SG1-2] ← さらに分解が必要なら
│   │   └── Tasks: [T1-001, T1-002, ...]
│   │
│   └── SubLayer_SG1-1: Scrum運用プロセス文書化
│       ├── 1️⃣ aipo_01_layer_init (Context準備)
│       ├── 2️⃣ aipo_02_focus (タスク分解)
│       │   └── Tasks: [T1-1-001, ...] ← 最終的にTaskに到達
│       └── 3️⃣ aipo_03 (コマンド設計)& aipo_04 (コマンド実行)
│
├── SubLayer_SG2: 横断チームの業務基盤構築
│   └── ... (同様の再帰)
│
└── Tasks: [T001, T002, T003] ← Root Layerで完結
└── 3️⃣ aipo_03 (コマンド設計)& aipo_04 (コマンド実行)
```

---

## 💬 使用例

### 基本的な使い方

<aside>
💡

[02_focus](02_focus.md) を実行してください

Layer: EXPLAZA業務基盤構築

</aside>

### SubLayerの優先順位を指定

<aside>
💡

[02_focus](02_focus.md) を実行してください

Layer: EXPLAZA業務基盤構築
優先順位: SG1だけP0、他はP2でOK

</aside>

### Focus戦略を明示指定

<aside>
💡

[02_focus](02_focus.md) を実行してください

Layer: 新サービス開発
Focus戦略: Product Manager視点で分解してください

</aside>

→ Discovery→Delivery思考でタスク分解される

### 特定のSub-GoalをTaskに変更

<aside>
💡

[02_focus](02_focus.md) を実行してください

Layer: EXPLAZA業務基盤構築
SG3とSG4はSubLayerではなくTaskとして扱ってください
（単純なので分解不要）

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

**Phase 1: Sense - Auto-Research**

1. layer.yaml, context.yaml を読み込む
2. 関連情報を検索（類似プロジェクト、業界標準）

**Phase 1.5: Focus戦略選択（必須）**

1. **ロールテンプレート探索**
    - [roles-templates](../skills/roles-templates.md) を参照し、利用可能なロール一覧を取得
    - 各ロールの適用シーンと分解特徴を把握
    - ロール一覧をユーザーに提示する際は、roles-templatesへのメンションも含める
2. **Goal性質の判定**
    
    ```python
    if "プロダクト" in goal or "サービス" in goal or "開発" in goal:
        strategy = "product_manager"
    elif "システム" in goal or "基盤" in goal or "インフラ" in goal:
        strategy = "system_architect"
    elif "コンテンツ" in goal or "記事" in goal or "発信" in goal:
        strategy = "content_strategist"
    else:
        strategy = "generic"  # 汎用（Senseコンテキストから動的判断）
    ```
    
3. **ユーザー指定の確認（必須）**
    - ユーザーが「Focus戦略: XXX」を指定している場合は、それを優先
    - 指定がない場合は、Phase 1.5.1で判定した推奨戦略を **提示→そのまま採用（暗黙OK）** とする
    - ただし、**必ず tasks.yaml に `focus_strategy_confirmed_by: "ai"` を記録**する
4. **戦略に応じた分解方針の設定**
    - **Product Manager戦略**:
        - Discovery（調査・検証）→ Delivery（実装・提供）の流れ
        - MVP思考: 最小単位での価値提供を優先
        - ユーザー中心: ペルソナ・課題・ソリューション
    - **System Architect戦略**:
        - 設計 → 実装 → 運用の3層構造
        - モジュール分割: 独立性・再利用性を重視
        - 技術制約: スタック・パフォーマンス・保守性
    - **Content Strategist戦略**:
        - 企画 → 制作 → 配信・効果測定
        - 品質管理: レビュー・編集プロセス
        - 継続性: コンテンツカレンダー・運用体制
    - **汎用戦略**:
        - Senseで収集したコンテキストから動的に判断
        - 特定のフレームワークに縛られない柔軟な分解
5. **提案の出力**
    - Focus戦略の提案を出力
    - Goal性質、推奨戦略、分解方針を示す
    - 「この戦略で進めますか？」と確認
    - 📚 他のロール候補: [roles-templates](../skills/roles-templates.md) へのリンクを含める
    - ユーザーが「OK」または省略した場合は提案戦略を適用

**Phase 2: Mode継承の確認**

1. 親layer.yamlのmodeフィールドを確認
2. mode=abstractの場合、全SubLayerにmode=abstractを継承
3. mode=concreteの場合、SubLayerもmode=concreteを継承

**Phase 3: 分解 & 判定**

1. Goalを分析し、以下の2種類に分類：
    
    **SubLayers（複雑 → 新Layer化）**
    
    - 複数のTaskで構成されるもの
    - 独自のContextが必要なもの
    - 他人に委譲できる単位
    
    **Tasks（単純 → このLayerで完結）**
    
    - 1〜2日で完了
    - これ以上分解不要
    - 管理・統括・調整系の作業
2. **重要**: 詳細タスクは親Layerで作らない
    - 例: 「SG1の中のTask一覧」は作成しない
    - 詳細タスクはSubLayerで aipo_02 を実行したときに生成
3. **Mode継承**: SubLayerは親のmodeを継承
    - 親がabstract → 全SubLayerもabstract
    - 親がconcrete → 全SubLayerもconcrete
    - これにより、階層全体で一貫したモード運用が可能
4. **Abstract Mode時の標準タスク分解パターン**
    - mode=abstractの場合、実行プラットフォーム構築を前提とした分解を行う
    - 必ず以下の2要素に分解：
        - **Database作成タスク** - データ構造・Form・View設計
        - **運用Commands作成タスク** - DB操作ロジック・実行コマンド群
    - 例: 記事制作システム構築
        - T-SG1-001: 入力処理（DB + Form作成）
        - T-SG1-002: 構成案生成（DB作成）
        - T-SG1-003: 運用Commands作成（CMD-入力分析、CMD-構成案生成）
5. **🚨【必須】全タスクにcommandフィールドを設定**
    
    **重要**: tasks.yaml生成時、以下のルールを厳守すること：
    
    **A. 管理系タスク（command: null でOK）**
    
    - type: management, coordination, verification のみ
    - 例: 全体進捗モニタリング、依存関係整理、完了検証
    
    **B. 実行系タスク（command必須）**
    
    - type: research, content, implementation, design 等
    - **必ず以下の2フィールドを設定**：
        - `command: "TXXX_タスク名"` の形式
        - `command_template_ref: "command_templates/カテゴリ/テンプレート名"`
    
    **C. タスクタイプ別のテンプレート自動設定**
    
    - タスクの `type` に応じて、適切な `command_template_ref` を自動設定
    - **実装系タスク（type: implementation）**には必ず以下のいずれかを設定：
        - Database作成 → `command_templates/システム構築/05_Database実装`
        - Form/入力UI → `command_templates/システム構築/06_Form・入力UI実装`
        - AI処理ロジック → `command_templates/システム構築/07_AI処理ロジック実装`
        - **運用Commands作成** → `command_templates/システム構築/08_運用Commands作成`
    - **リサーチ系タスク（type: research）**:
        - ペルソナ作成 → `command_templates/Discovery_templates/01_ペルソナ作成`
        - 課題定義 → `command_templates/Discovery_templates/02_課題定義`
        - 競合調査 → `command_templates/Research_templates/01_競合調査`
    - **コンテンツ系タスク（type: content）**:
        - 記事企画 → `command_templates/content_creation_templates/記事企画・構成設計`
        - プレゼン作成 → `command_templates/presentation_templates/プレゼン作成`
    - タスク名から実装内容を推測してテンプレートを選択
    - **テンプレートが見つからない場合でも、commandフィールドは必ず設定する**
        - `command: "TXXX_タスク名"`
        - `command_template_ref: null` （aipo_03で新規作成される）

**Phase 3.5: セッション分割判定（必須）**

提案を出す前に以下を計算し、閾値チェックを行う：

```jsx
📊 分割判定
- SubLayers数: X個（閾値: 3以上）
- タスク総数: Y個（閾値: 10以上）
- 見積時間: Z時間（閾値: 2時間超）
```

**閾値超過の場合**、提案に以下を含める：

```jsx
⚠️ セッション分割推奨
SubLayers数が3以上のため、SubLayerごとに
別スレッドでの実行を推奨します。
```

**Phase 4: Propose**

1. SubLayersとTasksの一覧を提案
2. 各SubLayerについて：
- Goal（そのSubLayerで達成すること）
- 優先度
- 備考（なぜSubLayerにするか）
1. 各Taskについて：
- 名前、推定日数、type（management/coordination/verification等）
1. ユーザーに確認を求める

**Phase 5: Execute**

1. 承認されたら tasks.yaml を生成（version: 2.2 形式）
2. **🚨 tasks.yaml生成時の検証**:
    - **`focus_strategy` が存在すること（必須）**
    - **`focus_strategy_reason` が存在すること（必須）**
    - **`focus_strategy_confirmed_by` が存在すること（必須）**
    - 全Taskの`type`を確認
    - type=management/coordination/verification 以外のTaskに`command`フィールドが設定されているか検証
    - 未設定があれば自動で`command: "TXXX_タスク名"`を追加
    - 可能な限り適切な`command_template_ref`を設定
    - **上記3フィールドが欠けていたら、Phase 1.5 に戻って補完してから再生成する**
3. SubLayerフォルダを作成（中身は空）
4. **各SubLayerのlayer.yamlに親のmodeを記録**
5. **SubLayerページを生成する際、以下の「次のステップ」セクションを必ず含める：**
    
    ```jsx
    ## 🔗 次のステップ
    このSubLayerを展開するには以下を順に実行してください：
    1. `aipo_01_layer_init` でLayer構造を初期化
    ```
    
6. 次のステップとして、優先度P0のSubLayerの aipo_01 を案内

**重要な原則**

- SubGoalの詳細タスクは**このフェーズでは作らない**
- SubLayerの中で aipo_02 を実行したときに初めて詳細タスクが生成される
- これにより**真のRecursive構造**を実現
</aside>

---

## 🔜 Next Step Options（完了時の選択肢）

aipo_02_focus 完了後、AIは以下の形式で**次のアクションを選択肢形式で提案**します。

### SubLayerが生成された場合

<aside>
💡

🔜 Next Step

次のアクションを選択してください：

| オプション | コマンド | 説明 |
| --- | --- | --- |
| **A** | [03_discover](03_discover.md) TXXX | 管理系Taskのコマンド設計 |
| **B** | [01_sense](01_sense.md) @対象サブレイヤーへのメンション | 次のSubLayerを初期化 |
| **C** | 一括処理 | 残りのSubLayerを一括初期化 |

どれを実行しますか？

</aside>

| オプション | アクション | 推奨シーン |
| --- | --- | --- |
| **A** | 管理系Task実行 | 先に全体管理を整備したい |
| **B** | 次のSubLayer init | 一つずつ丁寧に進めたい |
| **C** | 残りSubLayer一括init | **推奨**: 全体像を先に把握 |

### 末端Layer（Tasksのみ）の場合

<aside>
💡

🔜 Next Step

次のアクションを選択してください：

| オプション | コマンド | 説明 |
| --- | --- | --- |
| **A** | [03_discover](03_discover.md) | P0タスクからコマンド設計 |
| **B** | 親Layerに戻る | 他のSubLayerを先に構築 |
| **C** | タスク一覧の詳細表示 | 作業計画を立てたい |

どれを実行しますか？

</aside>

| オプション | アクション | 推奨シーン |
| --- | --- | --- |
| **A** | P0タスクから実行 | すぐ作業を始めたい |
| **B** | 親Layerに戻る | 他のSubLayerを先に構築 |
| **C** | タスク詳細表示 | 作業計画を立てたい |

### 推奨アクションの提示

AIは状況に応じて**推奨オプション**と**その理由**を明示します：

```jsx
💡 推奨: **C（一括init）**
理由:
- 構造設計を先に完成させた方が全体像が見える
- 依存関係を把握してから実行に移れる
- 並行作業の可能性を事前に特定できる
```

---

## 🔗 次のコマンド

分解後の次のステップ：

**SubLayerが生成された場合:**

1. 各SubLayerに対して [01_sense](01_sense.md) を実行（Context準備）
2. その後、各SubLayerで再度 **aipo_02_focus** を実行（タスク分解）
3. 最終的に [04_deliver](04_deliver.md) で実行

**Tasksのみの場合:**

1. [04_deliver](04_deliver.md) で直接実行開始

---

**作成日**: 2025-11-27

## 📋 tasks.yaml のフィールド定義

### Task フィールド

| **フィールド** | **説明** | **例** |
| --- | --- | --- |
| `id` | タスクID（一意） | T001, T002 |
| `name` | タスク名 | ペルソナ作成 |
| `type` | タスク種別 | research, management, content |
| `status` | ステータス | pending, in_progress, completed |
| `command` | 生成するコマンドページ名 | T002_ペルソナ作成 |
| `command_template_ref` | 参照するテンプレートURL | command_templates/02_ペルソナ作成 |

<aside>
💡

**commandフィールドの役割**

- [03_discover](03_discover.md) がこのフィールドを読み取り、実行用コマンドページを自動生成
- `command_template_ref` があればテンプレートをコピー、なければ新規作成
- `command: null` の場合はコマンドページ不要（管理系タスクなど）
</aside>

---

**更新日**: 2025-12-06

**ステータス**: Ready（Recursive版 + Next Action Protocol）