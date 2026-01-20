# CMD_aipo_01_sense

最終更新日時: 2025年12月29日 13:18

# aipo_sense - プロジェクト/Layer初期化（統合版）

<aside>
📚

**必須コンテキスト（このコマンド実行時に自動読み込み）**

このコマンドは以下のページを前提とします：

1. [aipo (AI-PO) system](../aipo%20(AI-PO)%20system.md) - aipoシステム全体
2. [execution-rules](../skills/execution-rules.md) - 全コマンド共通の実行ルール
3. [command-templates](../skills/command-templates.md) - コマンドテンプレート集
4. [session-rules](../skills/session-rules.md) - セッション分割ルール
5. [next-action-rules](../skills/next-action-rules.md) - Next Action Protocol
6. [abstract-mode](../skills/abstract-mode.md) - Notion擬似プログラミングガイド
7. [roles-templates](../skills/roles-templates.md) - ロールテンプレート集
8. [troubleshoot](../skills/troubleshoot.md) - 操作相談スキル
</aside>

> **GoalとLayer名を伝えるだけで、新規プロジェクトもSubLayerも同じコマンドで初期化できます**
> 

---

## 🎯 このコマンドでできること

**このコマンドは3つのシーンで使えます：**

**Jeff Pattonの「Sense」フェーズに対応** - プロダクトオーナーが最初に行う「現状把握」と「Context収集」を自動化します。

1. **新規プロジェクト開始** - プロジェクト構造 + 初期Layerを一気に作成
2. **SubLayer追加** - 既存Layerの配下に新しいSubLayerを追加
3. **Layer再初期化** - 既存LayerのGoalやContextを再設定

<aside>
💡

**自動判定で使い分け不要**

- Parent Layerの指定なし → 新規プロジェクト開始
- Parent Layerの指定あり → SubLayer追加
- 既存Layer指定 → 再初期化

ユーザーは使い分けを意識する必要なし。すべて`aipo_init`で対応します。

</aside>

---

## 📋 実行手順

### Step 0: Human Input（最小限の情報だけ）

<aside>
💡

[01_sense](01_sense.md) を実行してください

Layer名: EXPLAZA業務基盤構築

Goal: 各部門の業務基盤を整備する

</aside>

**これだけでOK！** その他の情報は次のステップで確認します。

---

### Step 1: モード判定と情報収集

AIが以下を自動判定します：

**=== モード判定 ===**

```yaml
if Parent Layer指定なし and 新規作成:
  モード: プロジェクト初期化
  
elif Parent Layer指定あり:
  モード: SubLayer作成
  
elif 既存Layer指定:
  モード: Layer再初期化
```

**=== 収集する情報 ===**

1. **Layer名**（例: EXPLAZA業務基盤構築）
2. **Goal**（何を達成したいか）
3. **Mode**（concrete / abstract）※デフォルト: concrete
4. **Owner**（担当者名。例: miyatti）
5. **期間**（開始→終了。例: 2025-12-01 → 2025-12-31）
6. **Parent Layer**（親Layerがある場合。例: L001）※オプション

---

### Step 2: プロジェクト構造の作成（新規プロジェクトの場合のみ）

**新規プロジェクト開始時のみ実行：**

### Flow側のページ階層

デフォルトでは**既存のFlowページ**配下に作成されます。

```
Flow/
└── [YYYYMM]/
    └── [YYYY-MM-DD]/
        └── [Layer名]/
            ├── layer.yaml（ページ）
            ├── context.yaml（ページ）
            ├── tasks.yaml（ページ）
            ├── 📁 sublayers/
            └── 📁 Documents/
```

```jsx
Flow/
└── [YYYYMM]/
    └── [YYYY-MM-DD]/
        └── [Layer名]/
            ├── 📄 layer.yaml
            ├── 📄 context.yaml
            ├── 📁 Context/
            ├── 📁 sublayers/
            └── 📁 Documents/
```

---

### Step 3: Layer初期化（全モード共通）

### 3a. layer.yaml生成

<aside>
💡

```yaml
# Layer基本情報
layer_id: "L001"  # 自動採番
layer_name: "[Layer名]"
    status: "completed"       # pending / in_progress / completed
    completed_at: "2025-12-25"
    notes: "予算承認取得完了（123,750円・全額会社負担）"

# Goal定義
goal:
  description: "[Goal]"
  success_criteria: []  # 成功基準（Context収集後に設定）
  
# 実行モード
mode: "concrete"  # concrete / abstract

# 責任者と期限
owner: "[Owner]"
deadline: "[終了日]"

# 階層関係
parent_layer: "[親LayerID]"  # なければnull
sublayers: []  # aipo_sense_and_focusで生成

# パス情報
paths:
  flow: "Flow/[YYYYMM]/[YYYY-MM-DD]/[Layer名]"
```

</aside>

### 3b. Context収集 + Contextフォルダ生成

<aside>
📚

**Context情報の二層構造**

Context情報は以下の2つで構成されます：

1. **Contextフォルダ（実体）** - 収集した情報を整理したドキュメント群
2. **context.yaml（Index）** - Contextフォルダへのリンク + 要約情報

**なぜこの構造が重要か：**

- SubLayerに継承したときに、詳細情報が失われない
- 親Layerで収集した情報を子Layerでも参照できる
- context.yamlはシンプルに保ちつつ、詳細はドキュメントで管理
</aside>

**自動Context収集の流れ：**

1. **ワークスペース検索** - Goal関連の情報を自動収集
    - 関連プロジェクト、チーム構成、既存資料など
    - 技術スタック、制約条件、ポリシーなど
2. **Contextフォルダに整理保存**
    
    ```
    📁 Context/
    ├── 📄 01_[チーム構成.md](http://チーム構成.md)
    ├── 📄 02_[関連リンク集.md](http://関連リンク集.md)
    ├── 📄 03_[技術スタック.md](http://技術スタック.md)
    ├── 📄 04_制約条件・[ポリシー.md](http://ポリシー.md)
    └── 📄 05_[既存資料まとめ.md](http://既存資料まとめ.md)
    ```
    
3. **context.yamlに参照とサマリーを記録**

### 3c. context.yaml生成（Indexとして機能）

<aside>
💡

```yaml
# context.yaml
version: "1.0"
layer_id: "L001"
generated_at: "2025-12-25"

# 親Contextフォルダへの参照（SubLayer用）
parent_context_folder: "@親Layer/Context/"  # 親がある場合

# このLayerのContextドキュメント（詳細はContextフォルダ参照）
context_documents:
  - name: "チーム構成"
    url: "@Context/01_[チーム構成.md](http://チーム構成.md)"
    summary: "miyatti lead, 大川泰河(DG), 大島航(PM/BizDev)"
    
  - name: "関連リンク集"
    url: "@Context/02_[関連リンク集.md](http://関連リンク集.md)"
    summary: "メンバーDB、組織図、既存プロジェクト等"
    
  - name: "技術スタック"
    url: "@Context/03_[技術スタック.md](http://技術スタック.md)"
    summary: "Notion, Palma, TypeScript, React"
    
  - name: "制約条件・ポリシー"
    url: "@Context/04_制約条件・[ポリシー.md](http://ポリシー.md)"
    summary: "既存Notion活用、新規ツール最小限"

# 継承ルール（子Layerへの伝播制御）
inheritance_rules:
  global_immutable: ["vision", "tech_stack"]
  overridable: ["deadline", "budget"]
  local_only: ["team", "tools"]
```

</aside>

<aside>
🔑

**SubLayer継承の仕組み**

SubLayerを作成すると：

1. 親のContextフォルダへの参照が自動設定される
2. SubLayer独自のContextフォルダも新規作成される
3. context.yamlで両方を参照できる

**例：**

```
親Layer: L001/Context/ （全社方針、技術スタック等）
↓ 継承
SubLayer: L001-SG1/Context/ （部門固有の情報）
+ 親のContext/も参照可能
```

これにより、階層が深くなってもコンテキスト情報が薄まらない。

</aside>

### 3d. variables.yaml生成（Abstract Modeの場合のみ）

Abstract Modeの場合、変数化可能なポイントを特定してvariables.yamlを生成：

<aside>
💡

```yaml
# variables.yaml (Abstract Mode用)
version: "1.0"
layer_id: "L001"

# 変数定義
variables:
  target_person:
    type: "string"
    description: "対象人物名"
    required: true
    
  theme:
    type: "string"
    description: "記事テーマ"
    required: true
    
  deadline:
    type: "date"
    description: "締切日"
    default: "+7days"

# 変数使用箇所のマッピング
variable_mappings:
  - task_id: "T001"
    variables: ["target_person"]
  - task_id: "T002"
    variables: ["theme", "target_person"]
```

</aside>

---

### Step 4: 完了報告と次のステップ

1. 作成した構造を確認表示
2. 次のコマンド（[02_focus](02_focus.md)）の実行を提案

---

## 💡 使用例

### 例1: 新規プロジェクト開始

<aside>
💡

[01_sense](01_sense.md) を実行してください

Layer名: EXPLAZA経営基盤

Goal: 経営の意思決定を可視化・高速化する

</aside>

→ プロジェクト構造 + 初期Layerが一気に完成

### 例2: SubLayer追加

<aside>
💡

[01_sense](01_sense.md) を実行してください

Parent Layer: L001

Layer名: Product部門基盤

Goal: プロダクト開発の業務基盤を整備

</aside>

→ L001配下にSG1として追加

### 例3: Abstract Modeで基盤構築

<aside>
💡

[01_sense](01_sense.md) を実行してください

Layer名: ノッカリ記事制作システム

Goal: インタビュー記事を量産できる仕組みを作る

Mode: abstract

</aside>

→ variables.yamlも生成され、量産用基盤として構築

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

### Phase 0: モード判定

```python
if parent_layer is None and existing_layer is None:
    mode = "project_init"  # 新規プロジェクト
elif parent_layer is not None:
    mode = "sublayer_create"  # SubLayer作成
elif existing_layer is not None:
    mode = "layer_reinit"  # 再初期化
```

### Phase 1: 情報収集

1. Layer名、Goal、Ownerを確認（ユーザー入力から取得）
2. Modeを確認（concrete / abstract、デフォルト: concrete）
3. 期間を確認（デフォルト: 本日から1ヶ月後）
4. Parent Layerを確認（オプション）

### Phase 2: プロジェクト構造作成（project_initの場合のみ）

1. 現在の日付から`YYYYMM`と`YYYY-MM-DD`を生成
2. Flow/[YYYYMM]/[YYYY-MM-DD]/[Layer名]/ の階層を作成
3. 基本フォルダを作成：
    - sublayers/
    - Documents/
    - Context/

### Phase 3: Layer初期化（全モード共通）

**3a. layer.yaml生成**

- Layer ID自動採番（L001, L001-SG1, L001-SG1-1 等）
- ステータス: active
- 上記テンプレートに従って生成

**3b. Context収集 + Contextフォルダ生成**

1. ワークスペース検索で関連情報を自動収集：
    - チーム構成、メンバー情報
    - 関連プロジェクト、既存資料
    - 技術スタック、制約条件
    - 業界標準、ベストプラクティス
2. 収集した情報をContextフォルダに整理保存：
    - 01_[チーム構成.md](http://チーム構成.md)
    - 02_[関連リンク集.md](http://関連リンク集.md)
    - 03_[技術スタック.md](http://技術スタック.md)
    - 04_制約条件・[ポリシー.md](http://ポリシー.md)
    - 05_[既存資料まとめ.md](http://既存資料まとめ.md)
3. 親LayerのContextフォルダがあれば参照設定

**3c. context.yaml生成（Index）**

- Contextフォルダ内の各ドキュメントへの参照
- 各ドキュメントのサマリー（3-5行）
- 親Contextフォルダへの参照（SubLayerの場合）
- 継承ルールの定義

**3d. variables.yaml生成（Abstract Modeのみ）**

- 変数化可能なポイントを特定
- 変数定義とデフォルト値
- 変数使用箇所のマッピング

### Phase 4: 完了報告と次のステップ

1. 作成した構造を確認表示
2. 次のコマンド（[02_focus](02_focus.md)）の実行を提案

---

**🚨 重要ルール**

- **既存のFlowを使用する**（新規作成しない）
- **日付フォルダは毎回新しく作成**（既存の日付フォルダには追加しない）
- **Context収集は必須**（Contextフォルダ + context.yaml）
- **親Contextは必ず参照**（SubLayerの場合）
- **variables.yamlはAbstract Modeのみ**（Concrete Modeでは作成しない）
</aside>

---

## 📁 生成されるフォルダ構造

```
📁 [Layer]/
├── 📄 layer.yaml          ← このコマンドで生成
├── 📄 context.yaml        ← このコマンドで生成（Index）
├── 📁 Context/            ← このコマンドで生成（実体）
│   ├── 📄 01_[チーム構成.md](http://チーム構成.md)
│   ├── 📄 02_[関連リンク集.md](http://関連リンク集.md)
│   ├── 📄 03_[技術スタック.md](http://技術スタック.md)
│   └── 📄 04_制約条件・[ポリシー.md](http://ポリシー.md)
├── 📄 variables.yaml      ← abstract時のみ生成
├── 📁 sublayers/          ← フォルダのみ作成
├── 📁 Documents/          ← フォルダのみ作成
└── （tasks.yamlはrogos_02で生成）
```

---

---

**作成日**: 2025-12-25

**最終更新**: 2025-12-25

**ステータス**: Active

**統合元**: CMD_rogos_00_project_init + CMD_rogos_01_layer_init → aipo統合版