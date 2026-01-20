---
name: session-rules
description: "セッション分割ルール - コンテキスト管理と完了前チェック"
license: "MIT"
---

# CTX_session_rules

最終更新日時: 2025年12月29日 16:35

# session_rules - セッション分割ルール

---

## ⚠️ なぜセッション分割が必要か

<aside>
🚨

**問題**

- 1セッションでたくさんのタスクを処理
- 後半になるほど品質が劣化
- 原因：コンテキストウィンドウから初期の指示が押し出された
- 結果：最後の方のタスクは「適当に」処理された
</aside>

### コンテキスト劣化のメカニズム

```
セッション開始: コンテキスト100% → 高品質
     ↓ (長時間経過・多くのやり取り)
セッション後半: コンテキスト30%残存 → 低品質
     ↓
原因: トークン制限で古い情報が押し出される
```

---

## 📏 分割トリガー

以下のいずれかに該当する場合、**新しいスレッドでの実行を推奨**：

| 条件 | 閾値 |
| --- | --- |
| SubLayerの数 | **3つ以上** |
| タスク総数 | **10タスク以上** |
| 見積時間 | **2時間超** |
| 階層の深さ | **3階層以上** |

---

## 🔄 分割方法

### 方法1: SubLayerごとに分割（推奨）

```
親スレッド: Root Layer
  ├── 子スレッド1: SG1
  ├── 子スレッド2: SG2
  └── 子スレッド3: SG3
```

### 方法2: フェーズごとに分割

```
スレッド1: 構造構築（AIPO_01 → AIPO_02）
スレッド2: タスク実行（AIPO_05）
```

---

## 📋 分割時のコンテキスト引き継ぎ

### 新スレッドに渡す必須コンテキスト

```yaml
fork_context:
  # 必須: 毎回@mentionで読み込む
  always_mention:
    - "@AIPO_commands"       # システム全体
    - "@AIPO_execution_rules" # 全コマンド共通の実行ルール
    - "@command_templates"    # コマンドテンプレート集
    - "@session_rules"        # セッション分割ルール
    - "対象Layerのlayer.yaml" # Goal定義
    - "対象Layerのcontext.yaml" # 背景情報
  
  # 条件付き: SubLayerの場合
  if_sublayer:
    - "親Layerのlayer.yaml"   # 親の目標
    - "親Layerのtasks.yaml"   # 兄弟との関係
```

### 新スレッド起動テンプレート

**パターン1: SubLayerを新スレッドで開始（AIPO_01から）**

<aside>
💡

[CMD_aipo_01_init](https://www.notion.so/CMD_aipo_01_init-acc666cf6da743e99def2c1bbff0e6e7?pvs=21) を実行してください

Goal: [SubLayerのGoal]
親Layer: @[親LayerのURL]

追加読み込み:

- @[親Layerのcontext.yaml]
</aside>

**パターン2: 既存SubLayerのタスク実行を新スレッドで継続**

<aside>
💡

[CMD_aipo_04_deliver](https://www.notion.so/CMD_aipo_04_deliver-4a7d3a9ff65f4b22968540d7c979b5b5?pvs=21) を実行してください

Layer: @[対象SubLayerのURL]

読み込み:

- @[対象Layerのlayer.yaml]
- @[対象Layerのcontext.yaml]
- @[対象Layerのtasks.yaml]
</aside>

**パターン3: 親スレッドへの報告用（子スレッド完了時）**

```
【親スレッドに以下を貼り付け】

📤 子スレッド完了報告
━━━━━━━━━━━━━━━━━━━━
Layer: [Layer ID]
Status: completed / blocked / partial

📋 完了サマリー
- 完了タスク数: X/Y
- 主な成果物: [URL]

⚠️ ブロッカー（あれば）
- [タスクID]: [理由]

💡 学び
- [重要な気づき]

🔜 次のアクション
- [推奨アクション]
```

---

## 📤 親スレッドへの報告

子スレッド完了時、以下を親スレッドに報告：

<aside>
💡

return_report:
layer_id: "L001-SG1"
status: "completed"  # completed / blocked / partial

summary: "22タスク中20完了"

deliverables:
- url: "[ページURL]"
title: "Sprint Planningテンプレート"
status: "検証済み"

blockers:  # あれば
- task_id: "T008"
reason: "Sprint 7でのファシリ検証待ち"

learnings:  # 重要な学び
- "ガイドだけでは属人化は解消しない"

next_actions:
- "T008完了後に再評価"

</aside>

---

## ⏱️ 時間効率の比較

### Before（1スレッド直列）

```
SG1 → SG2 → SG3 → SG4
  合計: 2-3時間
  品質: 後半劣化 📉
```

### After（マルチスレッド並列）

```
┌── SG1スレッド ──┐
├── SG2スレッド ──┤  並列実行
├── SG3スレッド ──┤  各30-45分
└── SG4スレッド ──┘
  合計: 45分（最長に依存）
  品質: 全体で高品質 📈
```

---

## 🤖 AIへの指示

<aside>
🤖

**セッション分割判定**

AIPO_02_decompose完了時に以下を判定：

1. SubLayer数、タスク数、見積時間を計算
2. 分割トリガーに該当するか確認
3. 該当する場合、**分割を推奨するメッセージを出力**
4. fork_contextを生成してユーザーに提示
</aside>

---

**作成日**: 2025-11-28

**ステータス**: Ready

---

## 🛑 セッション完了前チェック（必須）

<aside>
🚨

**重要: セッション終了前に必ず実行**

SubLayerやTaskが完了しても、それだけでセッションを終了してはいけません。

以下のチェックを必ず実行してください。

</aside>

### チェックリスト

```yaml
session_completion_check:
  # 必須確認項目
  required_checks:
    - name: "親Layer確認"
      action: "親Layerの全SubLayerステータスを確認"
      question: "他に未着手/pending_initのSubLayerはないか？"
    
    - name: "兄弟SubLayer確認"
      action: "同階層の他SubLayerの状態を確認"
      question: "今すぐ着手可能なSubLayerはないか？"
    
    - name: "ペンディングTask確認"
      action: "T301, T302などの管理系Taskを確認"
      question: "実行可能な残Taskはないか？"
    
    - name: "次フェーズSubLayer確認"
      action: "SG4, SG5など後続SubLayerを確認"
      question: "先行して構造構築できるSubLayerはないか？"

  # 確認後のアクション
  on_remaining_work_found:
    action: "残タスクを列挙し、次のアクションを提案"
    format: |
      📋 残タスク一覧
      | SubLayer | Status | 次のアクション |
      |----------|--------|---------------|
      | SG4      | pending_init | 構造構築可能 |
      
      どれを実行しますか？
  
  on_no_remaining_work:
    action: "全完了を確認し、セッション終了を提案"
    format: |
      ✅ 全タスク完了確認
      - 親Layer: 全SubLayer完了
      - 残Task: なし
      
      セッションを終了してよろしいですか？
```

### AIへの指示

<aside>
🤖

**セッション完了判定ルール**

1. **自動終了禁止**: ユーザーが明示的に「終了」と言わない限り、セッションを終了提案しない
2. **完了時の探索義務**: SubLayerまたはTask完了時、以下を自動実行：
    - 親Layerをviewして全SubLayerを確認
    - 実行可能な次タスクを特定
    - 残タスクがあれば「次は○○を実行します」と提案
3. **終了前チェック**: セッション終了を提案する前に：
    - session_completion_checkを実行
    - 残タスク一覧を明示
    - ユーザーに確認を取る
4. **proactive提案**: 「他にありますか？」と聞くのではなく、
    
    自分で残タスクを見つけて「次は○○です」と提案する
    
</aside>

### 禁止パターン

```yaml
prohibited_patterns:
  - pattern: "お疲れ様でした！セッションを終了します"
    reason: "残タスクの確認なしに終了している"
    correct: "残タスクを確認します → [一覧] → どれを実行しますか？"
  
  - pattern: "他にタスクはありますか？"
    reason: "ユーザーに探索を委ねている"
    correct: "親Layerを確認 → 残タスク特定 → 提案"
  
  - pattern: "SG2完了です。SG3も完了です。終了します。"
    reason: "SG4, SG5の確認をしていない"
    correct: "SG2/SG3完了 → 親Layerで残SubLayer確認 → SG4/SG5を提案"
```

---

**作成日**: 2025-11-28

**ステータス**: Ready

**更新日**: 2025-12-07（5コマンド構成・command_templates対応）

---

---

## 🔁 再初期化（Update）時のルール

<aside>
🔄

**再初期化とは？**

既存のLayer構造に対して、新しいGoal（UI改善、機能追加など）を追加する操作。

既存のSubLayerや成果物を保持しながら、段階的に改善を行う。

</aside>

### 再初期化の鉄則

```yaml
reinit_rules:
  principle: "トップダウン・再帰的・段階的"
  
  must_do:
    - "トップレベルのみ実行し、SubLayerは別タスクとして分解"
    - "tasks.yamlに再帰タスクを記録してから実行"
    - "1階層ずつ確認しながら進める"
    - "既存成果物は保持（上書きしない）"
  
  must_not_do:
    - "一気に全SubLayerを処理する"
    - "確認なしでSubLayerに手を出す"
    - "既存の成果物を削除・上書きする"
```

### Updateフロー

```jsx
📍 Updateの正しいフロー

1. 親LayerのトップページをUpdate
   ↓ ✅ 完了確認
2. tasks.yamlにSubLayer用タスクを追加
   ↓ ✅ 完了確認
3. ユーザーにNext Step Optionsを提示
   ↓ ユーザーが選択
4. 選択されたSubLayerに対して再帰的に実行
   ↓ ✅ 完了確認
5. 3-4を繰り返し
```

### 禁止パターン（再初期化時）

```yaml
prohibited_patterns_reinit:
  - pattern: "全SubLayerを一気にWiki化しました"
    reason: "再帰的処理の原則に違反"
    correct: "トップのみ実行 → SubLayerはNext Stepで選択"
  
  - pattern: "SG1〜SG5のページを更新しました"
    reason: "一気に処理している"
    correct: "まずトップ → 確認 → SG1 → 確認 → SG2..."
  
  - pattern: "既存のコンテンツを置き換えました"
    reason: "既存成果物の保持原則に違反"
    correct: "構造改善のみ行い、既存コンテンツは保持"
```

### テンプレート5: 再初期化（AIPO_01_layer_init Re-init）

<aside>
💡

[CMD_aipo_01_init](https://www.notion.so/CMD_aipo_01_init-acc666cf6da743e99def2c1bbff0e6e7?pvs=21)  で更新してください

🔴 更新の鉄則:

- トップレベルのみ実行（SubLayerには手を出さない）
- SubLayerは別タスクとして tasks.yaml に記録
- 1階層ずつ確認しながら進める
- 既存成果物は保持

Layer: @[対象LayerのURL]

Goal: [新しい目標 - 何を改善/追加したいか]

期待する成果:

- トップページの改善内容
- SubLayerへの展開計画（tasks.yamlに記録）
</aside>

### AIへの指示（Update時）

<aside>
🤖

**更新コマンドを受けたときの動作**

1. **モード判定**: layer.yamlが存在するか確認
2. **既存構造読み込み**: SubLayers、成果物を把握
3. **差分分析**: 新Goalとのギャップを特定
4. **トップレベルのみ実行**: SubLayerは tasks.yaml に記録
5. **Next Step Options提示**: ユーザーに選択させる
6. **再帰的実行**: 選択されたSubLayerに対して同じフローを実行

**🚨 絶対に一気に全SubLayerを処理しないこと**

</aside>

---

**更新日**: 2025-11-29（再初期化ルール追加）