# CMD_マニャーナ_日次タスク作成

最終更新日時: 2025年12月25日 9:06

## 📌 コマンド概要

**目的**: 「今日やること」を自律的に収集して、✅ Tasks（マニャーナ）DBに反映し、**WillDo (Today)** を作る。

- コア思想
    - **前日に決めたWillDoを淡々と実行する**
    - **差し込みはUrgent以外は明日に回す**

**従来版（CMD_日次タスク作成）との違い**

- Flowページ内に“新しいタスク表”は作らない
- 代わりに、[](https://www.notion.so/0c0cc7f825a04baba77f761c43f15853?pvs=21) に登録・更新する

---

## ✅ このコマンドの「必須挙動」

このコマンドが実行されたら、**必ず**以下の順で動く。

1. **自律検索（Notion→Slack→Google Drive）**を先に実行して候補を集める
2. **候補を3分類（WillDo Today / Diary Tomorrow / Urgent）**で提示する
3. **HITL**でユーザーに最終確認を取る
4. **✅ Tasks（マニャーナ）へ反映**する（WillDo Today / Diary Tomorrow / Urgent）

---

## 📥 Input

- なし（自動実行）
- ユーザー入力は **ステップ2（HITL）でのみ**要求する

---

## 📤 Output（反映先）

対象DB: [](https://www.notion.so/0c0cc7f825a04baba77f761c43f15853?pvs=21)

### A. 今日やるもの（WillDo Today）

- ListType = WillDo
- Scheduled For = today
- 原則 Urgent=false

### B. 差し込み（基本は明日へ）

- ListType = Diary
- Scheduled For = tomorrow

### C. 例外（Urgent）

- Urgent = true
- Notes に理由を1行
- ルール参照: [variables.yaml](https://www.notion.so/variables-yaml-a40d5a2daf544c3e8f51453b594d3ea4?pvs=21)

---

## 🔧 実行方法

```
@CMD_マニャーナ_日次タスク作成 を実行してください
```

---

## 📋 処理ロジック（ステップ式 / 実行保証版）

### Step 1: 自律リサーチ（必ず先にやる）

**ここではユーザーに質問しない。まず自分で探す。**

### 1-1. Notion（最優先）

- Flow直近（日付ページ）にある「タスク/要対応/返事/提出/締切」系のページを探す
- 直近の「📋 今日のタスク - YYYY-MM-DD」系ページがあれば、そこから"未完了"を拾う
- 直近1週間のFlowから「今日/本日/締切/至急/急ぎ/返信/依頼」などの語で探す

### 1-2. Slack（次）

- 自分へのメンション
- TODO/対応/確認/依頼 などの語を含むメッセージ

### 1-3. Google Drive（次）

- 最近編集したドキュメント
- "TODO" / "[ ]" を含むもの

### 1-4. 候補の整形

候補タスクは以下の形式に揃える。

- title（短い行動）
- source（Notion/Slack/Drive）
- suggested_bucket（WillDo Today / Diary Tomorrow / Urgent）
- note（1行）

※この段階では「迷ったら Diary Tomorrow」に倒す。

---

### Step 2: HITL（ユーザー確認）

Step1で集めた候補を、必ずこの3枠で提示して確認を取る。

```
👤 ユーザー確認（HITL）

以下の候補を見つけました：

【今日やる（WillDo Today）候補】
- ...

【明日に回す（Diary Tomorrow）候補】
- ...

【Urgent（例外）候補】
- ...

他に今日やるべきタスクはありますか？
あれば追記してください。なければ「ない」と入力してください。
```

```jsx
👤 ユーザーヒアリング

【WillDo Today（今日やる）】
- ...

【Diary Tomorrow（明日に回す）】
- ...

【Urgent（例外：今日中に悪影響）】
- ...

修正があれば教えてください。
なければ「OK」で進めます。
```

---

### Step 3: DB反映（✅ Tasks（マニャーナ）へ）

HITL確定後に、✅ Tasks（マニャーナ）へ登録する。

### 3-1. WillDo Today

- ListType=WillDo
- Scheduled For=today
- 上限: [variables.yaml](https://www.notion.so/variables-yaml-a40d5a2daf544c3e8f51453b594d3ea4?pvs=21) の willdo.max_items
- 超過: [variables.yaml](https://www.notion.so/variables-yaml-a40d5a2daf544c3e8f51453b594d3ea4?pvs=21) の willdo.overflow_rule に従い、Diary Tomorrowへ

### 3-2. Diary Tomorrow

- ListType=Diary
- Scheduled For=tomorrow

### 3-3. Urgent

- Urgent=true
- Notes に理由（1行）

---

## 🔗 関連ビュー

- WillDo (Today): [view://5c580a09-49e5-4622-809f-dc0345ac25d7](view://5c580a09-49e5-4622-809f-dc0345ac25d7)
- WillDo (Tomorrow): [view://ab28c017-efad-430b-ae88-e48255e46e77](view://ab28c017-efad-430b-ae88-e48255e46e77)
- Diary (Tomorrow default): [view://5ea8be8e-dbb7-467d-8007-89587b7d66f1](view://5ea8be8e-dbb7-467d-8007-89587b7d66f1)
- Diary (Today): [view://3a9cc3c4-a7ad-4678-9e80-d4ec9e53492f](view://3a9cc3c4-a7ad-4678-9e80-d4ec9e53492f)
- Daily: [view://55706360-ce3d-4b1b-9d66-082aa02cddb2](view://55706360-ce3d-4b1b-9d66-082aa02cddb2)
- First: [view://c0061ef5-5d51-4624-8974-0d7576160846](view://c0061ef5-5d51-4624-8974-0d7576160846)
- TODO: [view://fa89e2a9-5596-4872-b137-4d59bb953ebb](view://fa89e2a9-5596-4872-b137-4d59bb953ebb)

---

## ⚙️ 併用する運用コマンド（既存）

- [operation_capture](https://www.notion.so/operation_capture-f818d40481df4f3f97ae8d55bd428615?pvs=21)（operation_capture）
- [operation_plan_willdo（前夜/当日）](https://www.notion.so/operation_plan_willdo-d3b0c8102d4349f7b5cf0048d18ef21f?pvs=21)（operation_nightly_plan）
- [operation_mark_urgent](https://www.notion.so/operation_mark_urgent-17551bd2db8b4379bed900ac7e5be2d1?pvs=21)（operation_mark_urgent）