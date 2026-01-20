# CMD_aipo_04_deliver

最終更新日時: 2025年12月25日 19:28

# aipo_deliver - Deliver（提供/実行）

> **Jeff Pattonの「Deliver（提供）」フェーズを再現**
> 

> プロダクトオーナーが行う「本番環境への提供」をAIが実行。
> 

> 実行可能なTaskを処理し、**Database + 運用Commands**を生成します。
> 

> Abstractモード時は、Layer完了時に自動的にOperation Commandを生成します。
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
7. [task-completion-rules](../skills/task_completion_rules.md) - タスク完了時の必須ルール
8. [sync-progress](../skills/sync_progress.md) - 進捗同期スキル
9. [troubleshoot](../skills/troubleshoot.md) - 操作相談スキル
</aside>

---

## 🎯 このコマンドでできること

1. **Task実行の支援** - agent_promptに基づいて作業をガイド
2. **成果物の生成** - ドキュメント、コード、設計書等を出力
3. **進捗の更新** - tasks.yamlのステータスを更新
4. **フィードバック** - 親Layerへの完了報告

---

## 📋 実行手順（Auto-Research Protocol）

### Step 0: Human Input

<aside>
💡

[04_deliver](04_deliver.md) を実行してください

Layer: [Layerへのメンション]

</aside>

---

### Step 1: AI Auto-Research（実行可能Task特定）

AIが自動でTaskを分析：

```jsx
🔍 tasks.yamlを分析中...

【実行可能なTask】（依存解決済み・未着手）
1. T001: Context収集（推定2日）
2. T004: テンプレート整備（推定3日）

【実行中】
3. T005: README作成（残り1日）

【ブロック中】
4. T006: 統合テスト（T004の完了待ち）

どのTaskを実行しますか？
```

---

### Step 2: Human Selects

```jsx
T001を実行してください
```

---

### Step 3: AI delivers（agent_prompt実行）

<aside>
📚

**Context収集と更新**

タスク実行時に、関連するContext情報を自動収集し、LayerのContext/フォルダに保存します：

1. **タスク実行に必要な情報を検索・収集**
2. **収集した情報をドキュメント化**
3. **Context/フォルダに保存**（例：Context/T001_[部門情報.md](http://部門情報.md)）
4. **context.yamlを更新**（新しいドキュメントへの参照を追加）

これにより、タスク実行を通じてContextが充実し、SubLayerに継承する情報が豊かになります。

</aside>

AIがTaskのagent_promptに従って作業支援：

**3a. Context収集（タスク実行前）**

```jsx
=== T001: Context収集 を実行します ===

【agent_promptの内容】
DemandGeneration部門のContext情報を収集してください。
1. 部門のミッション・役割
2. チーム構成とリード
3. 現在の業務フロー
4. 使用ツール
5. 課題・改善点

【Step 3a: Context情報の検索・収集】
🔍 DemandGeneration部門の情報を検索中...

📋 収集したContext:

【ミッション】
リード獲得から商談化、受注までの営業プロセスを最適化

【チーム構成】
- リード: 大川泰河
- メンバー: 大島航、増田勇

【業務フロー】
1. リード獲得（展示会、Paidメディア）
2. IS商談設定
3. 提案・見積
4. 受注・キックオフ

【使用ツール】
- Notion（情報管理）
- Slack（コミュニケーション）
- HubSpot（CRM）
- Google Sheets（案件管理）

【課題】
- 案件情報がスプレッドシートに分散
- フォローアップが属人化
- 提案資料の品質にばらつき

【外部参照】
- 業界標準：営業プロセス管理のベストプラクティス
- ベンチマーク：類似企業の事例
```

**3b. Contextドキュメントの保存**

```jsx
📁 Context/T001_[DemandGen部門情報.md](http://DemandGen部門情報.md) を作成中...

✅ 以下の情報を保存しました：

---
# DemandGeneration部門 - Context情報

**収集日**: 2025-12-25
**関連タスク**: T001
**収集者**: AI (aipo_04)

## ミッション
リード獲得から商談化、受注までの営業プロセスを最適化

## チーム構成
- **リード**: 大川泰河
- **メンバー**:
  - 大島航（PM / BizDev）
  - 増田勇（BizDev / Consultant）

## 業務フロー
1. リード獲得（展示会、Paidメディア、紹介）
2. IS商談設定
3. 提案・見積
4. 受注・キックオフ

## 使用ツール
| ツール | 用途 |
|--------|------|
| Notion | 情報管理 |
| Slack | コミュニケーション |
| HubSpot | CRM |
| Google Sheets | 案件管理 |

## 課題・改善点
- 案件情報がスプレッドシートに分散
- フォローアップが属人化
- 提案資料の品質にばらつき

## 外部参照
- [営業プロセス管理BP] ...
- [類似企業事例] ...

---
```

**3c. context.yaml更新**

<aside>
💡

# context.yaml に新しいドキュメント参照を追加

context_documents:

- name: "チーム構成"
url: "@Context/01_[チーム構成.md](http://xn--7ck2c0dz60vyci.md/)"
summary: "miyatti lead, 各部門構成"

# ↓ 新規追加

- name: "DemandGen部門詳細"
url: "@Context/T001_[DemandGen部門情報.md](http://xn--demandgen-jj7p186e965k2qm.md/)"
summary: "DG部門のミッション、チーム、業務フロー、課題"
created_by: "aipo_04"
task_id: "T001"
created_at: "2025-12-25"
</aside>

**3d. タスク実行**

```jsx
【AIの実行】
収集したContext情報をもとに、タスクを実行します...

✅ department_context.yamlを生成
✅ Context情報をContext/フォルダに保存
✅ context.yamlを更新

タスク実行を完了しますか？

```

---

### Step 4: AI Generates（成果物生成）

<aside>
🧩

**agent_commandの実行**

aipo_02でタスク分解時に生成された`agent_command`を実行して成果物を生成します：

1. **tasks.yamlからagent_commandを読み込み**
2. **該当コマンドを実行**（aipo_03で生成されたコマンド）
3. **成果物を生成**（DB、ページ、ドキュメント等）

**agent_commandがない場合**：

- agent_promptの内容に従って柔軟に対応
- テンプレート（[command-templates](../skills/command-templates.md)）を参照
</aside>

**4a. agent_commandの確認**

```jsx
🔍 tasks.yamlからT001の実行情報を読み込み中...

【T001: Context収集】
agent_command: "CMD_context_collection"
agent_prompt: "DemandGeneration部門のContext情報を収集..."

✅ agent_commandが設定されています
→ CMD_context_collection を実行します
```

**4b. agent_command実行**

```jsx
🛠️ CMD_context_collection を実行中...

【コマンド内容】
- 部門情報を収集
- context.yaml形式で出力
- Context/フォルダに保存

【実行結果】
✅ 部門情報収集完了
✅ department_context.yaml 生成
✅ Context/T001_[DemandGen部門情報.md](http://DemandGen部門情報.md) 作成
```

**4c. 成果物例**

```yaml
# department_context.yaml
department:
  name: "DemandGeneration"
  mission: "リード獲得から受注までの営業プロセス最適化"
  
  team:
    lead: "大川泰河"
    members:
      - name: "大島航"
        role: "PM / BizDev"
      - name: "増田勇"
        role: "BizDev / Consultant"
```

<aside>
💡

**agent_commandがない場合のフォールバック**

aipo_03でagent_commandが生成されていない場合：

1. agent_promptの内容を直接実行
2. [command-templates](../skills/command-templates.md) から類似テンプレートを探す
3. 柔軟に対応して成果物を生成
</aside>

---

### Step 5: 完了処理

**tasks.yaml更新**

<aside>
💡

tasks:

- id: "T001"
name: "Context収集"
status: "completed" # 更新
completed_at: "2025-11-27"
deliverables:
    - "department_context.yaml"
</aside>

**進捗ダッシュボード**

```jsx
=== Layer: DemandGen業務基盤構築 ===

進捗: ████░░░░░░ 40%

[完了] ✅
- T001: Context収集

[未着手] ⏳
- T002: 案件管理DB構築（→ SubLayer）
- T003: ワークフロー設計（→ SubLayer）
- T004: テンプレート整備
- T005: README作成

次に実行可能: T004, T005
```

---

### Step 6: Abstract Mode処理（Layer完了時）

Layer内の全Task完了時、modeがabstractの場合は自動的にOperation Commandを生成：

<aside>
💡

=== Layer完了検出 ===

✅ 全Task完了
✅ mode: abstract 検出

📊 変数化ポイントを分析中...

【実行結果から抽出された変数】

- target_person: "柳川慶太" （記事対象人物）
- theme: "叩きのめすvs気がついたら世界変わってる" （記事テーマ）
- deadline: "2025-12-06" （締切日）
- word_count: 10000 （文字数）

【作成されたDatabase/システム】

- 記事管理DB（Articles）
- フィードバックDB（Feedback）
- 執筆テンプレート
- レビューワークフロー

---

🔧 Operation Command を自動生成します...

✅ operation_nokkari_article を作成しました

【使用方法】
次回から、以下のコマンドで同じ構造の記事を量産できます：

@operation_nokkari_article を実行してください

Variables:

target_person: "山田太郎"

theme: "AIプロダクト開発の極意"

deadline: "2025-12-31"

word_count: 10000

</aside>

```

→ 確立された型を使って、**数時間で記事が完成**
```

---

## 💬 使用例

### 基本的な使い方

<aside>
💡

[04_deliver](04_deliver.md) を実行してください

Layer: [LayerのURL]

</aside>

---

### Taskを指定

<aside>
💡

[04_deliver](04_deliver.md) を実行してください

Layer: [LayerのURL]
Task: T001

</aside>

### 完了報告

<aside>
💡

[04_deliver](04_deliver.md) を実行してください

Task: T002
ステータス: 完了
成果物: 案件管理DBを作成しました

</aside>

---

## 🔄 フィードバックループ

Task完了時、親Layerに自動報告：

```jsx
Task完了
  ↓
SubLayer進捗更新
  ↓
親Layer進捗更新
  ↓
ルートLayer KPI更新
```

---

## 🔗 関連コマンド

- [CMD_rogos_layer_init](https://www.notion.so/CMD_rogos_layer_init-ff94c8e6761045beb91c452f9c97507d?pvs=21) - 新しいLayerを作成
- [02_focus](02_focus.md) - Taskを再分解

---

## ⚙️ AIへの実行指示

<aside>
🤖

**重要: 事前参照**

実行前に必ず以下を参照：

- [execution-rules](../skills/execution-rules.md) - 成果物ページ構造標準を含む共通ルール
- [abstract-mode](../skills/abstract-mode.md) - Notion実装ガイド（実装系タスク時は必須）

---

**AIへの指示（このコマンドが@メンションされたとき）**

**Phase 1: Auto-Research**

1. 対象Layerのtasks.yamlを読み込む
2. 実行可能なTask（依存解決済み・未着手）を特定
3. 一覧表示してユーザーに選択を求める

**Phase 2: deliver**

1. 選択されたTaskのagent_promptを読み込む
2. **Context収集と保存**：
    
    a. タスク実行に必要な情報をワークスペース/Web検索で収集
    
    b. 収集した情報をドキュメント化：
    
    - ファイル名：`Context/T[タスクID]_[タスク名].md`
    - 内容：収集日、関連タスク、収集者、詳細情報
    
    c. LayerのContext/フォルダにページを作成
    
    d. context.yamlを更新（新しいドキュメント参照を追加）
    
3. **タスクタイプ判定と実装方針の決定**：
    - `type: implementation` の場合 → [abstract-mode](../skills/abstract-mode.md) を参照
    - タスク名から実装内容を判定：
        - "DB作成"/"データ構造" → Database実装
        - "フォーム"/"入力UI" → Form・入力UI実装
        - "AI処理"/"分析ロジック" → AI処理ロジック実装
    - 該当するテンプレートを参照して実装
4. agent_promptに従って作業を支援
5. **成果物を生成（実装系タスクの場合は必ずNotion機能で実装）**：
    - ✅ Database作成（create-database）
    - ✅ Form作成（Database View → Form）
    - ✅ AI Block/Operation Command作成
    - ❌ 設計書だけで終わらない
    - ✅ Contextドキュメントの保存

**Phase 3: Feedback**

1. tasks.yamlのステータスを更新
2. 進捗ダッシュボードを表示
3. 次に実行可能になったTaskを案内

**Phase 4: Abstract Mode処理（Layer完了時のみ）**

1. layer.yamlのmodeを確認
2. mode=abstractの場合、以下を実行:
    
    a. **変数抽出**: 実行結果から変数化ポイントを特定
    
    b. **variables.yaml更新**: 抽出した変数を記録
    
    c. **Operation Command生成**: operation_[layer_name]コマンドページを自動作成
    
    d. **使用例の提示**: 生成されたOperation Commandの使い方を案内
    
3. mode=concreteの場合、通常完了
</aside>

---

**作成日**: 2025-11-27

**最終更新**: 2025-12-25

**ステータス**: Ready

**変更履歴**: aipo_04からaipo_deliverに名称変更、Jeff Patton理論との対応を明記