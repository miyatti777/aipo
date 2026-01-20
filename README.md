# AIPO (AI Product Owner)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docswell Views](https://img.shields.io/badge/Docswell-12.1K_Views-blue)](https://www.docswell.com/s/miyatti/5DWR6D-2025-12-25-231637)
[![Platform](https://img.shields.io/badge/Platform-Cursor%20%7C%20Claude_Code-green)](https://cursor.sh)

> **「GOALだけ伝えれば、AIが勝手に仕事を進めてくれる」**

---

## 🎯 これは何？

**AIPO（AI Product Owner）** は、Jeff Pattonが定義するプロダクトオーナーの思考プロセス **Sense → Focus → Discover → Deliver** をAIが再現し、再帰的にタスク分解・実行を行う**汎用問題解決システム**です。

### 解決する問題

| 従来のAI利用 | AIPOなら |
|-------------|---------|
| ❌ 途中でコンテキストを忘れられた | ✅ Context Cascadeで文脈継承 |
| ❌ 長いチャットで前の話を覚えていない | ✅ layer.yaml/context.yamlで永続化 |
| ❌ 一つ一つはやってくれるが全体の一貫性がない | ✅ フラクタル構造で一貫した分解 |
| ❌ 結局「次これやって」と指示し続けるのが大変 | ✅ GOALだけ伝えれば自動で進む |

---

## 📺 解説スライド・関連コンテンツ

### メインスライド

[![AIPOシステム紹介](https://img.shields.io/badge/Docswell-AIPOシステム紹介-blue?style=for-the-badge)](https://www.docswell.com/s/miyatti/5DWR6D-2025-12-25-231637)

**[AIPOシステム紹介 「GOALを伝えれば、AIが勝手に仕事を進める」](https://www.docswell.com/s/miyatti/5DWR6D-2025-12-25-231637)** (12.1K Views)

### 関連講座スライド

| タイトル | 内容 |
|----------|------|
| [Cursorエージェント講座 超入門＋実践編](https://www.docswell.com/s/miyatti/Z6VDGV-2025-03-30-192815) | ノンエンジニア向け。Prompt・Ruleの使い方から実務活用まで (562K Views) |
| [Cursorエージェント講座 超応用編](https://www.docswell.com/s/miyatti/KN182G-2025-03-21-202746) | AIエージェントに「心」を理解させる高度な設計 (276K Views) |
| [ノンエンジニアのCursor活用術](https://www.docswell.com/s/miyatti/KJ4DXM-2025-06-06-193814) | Cursorで人生が変わった話 (140K Views) |
| [令和トラベル Dify講座](https://www.docswell.com/s/miyatti) | 生成AIワークフロー構築の実践 (746K Views) |

---

## 📦 インストール

```bash
# リポジトリをクローン
git clone https://github.com/miyatti777/aipo.git
cd aipo

# Cursor用にインストール
./install.sh .cursor

# または Claude Code用にインストール
./install.sh .claude
```

---

## 💡 5つのコア原理

```
┌─────────────────────────────────────────────────────────┐
│  1. PO思考の再現                                         │
│     Sense → Focus → Discover → Deliver サイクル         │
├─────────────────────────────────────────────────────────┤
│  2. Fractal Decomposition（フラクタル分解）              │
│     どの階層も同じパターンで分解（全員がPO的に動く）     │
├─────────────────────────────────────────────────────────┤
│  3. Context Cascade（文脈の滝）                          │
│     親から子へ文脈を継承・拡張（途中で忘れない）         │
├─────────────────────────────────────────────────────────┤
│  4. Self-Describing Executable Task                      │
│     タスク自体が実行命令を内包（何をすべきか明確）       │
├─────────────────────────────────────────────────────────┤
│  5. Feedback Loop                                        │
│     Deliver → 次のSenseへ学習をフィードバック           │
└─────────────────────────────────────────────────────────┘
```

---

## 🧬 5つのコアコマンド

```
┌──────────┐    ┌──────────┐    ┌───────────┐    ┌──────────┐    ┌───────────┐
│  SENSE   │ → │  FOCUS   │ → │ DISCOVER  │ → │ DELIVER  │ → │ OPERATION │
│ Goal設定 │    │ 調査分解 │    │ 計画生成  │    │ 実行     │    │ 運用      │
└──────────┘    └──────────┘    └───────────┘    └──────────┘    └───────────┘
```

| コマンド | フェーズ | 役割 | 出力 |
|----------|----------|------|------|
| `/aipo/01_sense` | **Sense** | Goal設定・コンテキスト収集 | layer.yaml, context.yaml |
| `/aipo/02_focus` | **Focus** | 調査とGoal分解 | tasks.yaml, SubLayerフォルダ |
| `/aipo/03_discover` | **Discover** | 計画・コマンド生成 | Commandsフォルダ |
| `/aipo/04_deliver` | **Deliver** | タスク実行・成果物生成 | Database, 運用Commands |
| `/aipo/05_operation` | **Operation** | 運用コマンド実行 | 成果物（量産） |

---

## 🚀 使い方の例

### 例1: プロダクト開発

```
/aipo/01_sense を実行してください

Goal: Palma v1.0をリリースする
```

### 例2: 学習計画

```
/aipo/01_sense を実行してください

Goal: 3ヶ月でPythonをマスターする
```

### 例3: イベント運営

```
/aipo/01_sense を実行してください

Goal: カレーパーティをEXPLAZAで懇親会として開く
```

---

## 🍛 実例：カレーパーティ企画（1日で完成）

> **「60人規模のカレーパーティを、GOALを伝えるだけで企画から運用DBまで1日で構築」**

### 📊 生成されたDatabase

- **参加者管理DB**: 60名の参加可否・アレルギー・好みを管理
- **物資管理DB**: 13プロパティ、4ビュー、初期データ21件

### 📄 生成されたドキュメント

- イベント企画書（日程・予算・参加者分析）
- メニュー設計書（4種類のカレー×60人分のレシピ）
- 食材リスト・購入計画書・調達チェックリスト

### 📁 生成されたフォルダ構造

```
📁 カレーパーティ懇親会/
├── 📄 layer.yaml          ← /aipo/01_sense で生成
├── 📄 context.yaml        ← /aipo/01_sense で生成
├── 📄 tasks.yaml          ← /aipo/02_focus で生成
├── 📁 Context/            ← 4件の調査ドキュメント
├── 📁 sublayers/          
│   ├── 📁 SG1_イベント企画/
│   ├── 📁 SG2_物資調達/
│   └── 📁 SG3_当日運営/
├── 📁 Commands/           ← 20個の実行コマンド
└── 📊 [実際のDB]          ← 動くDatabase！
```

---

## ⚙️ なぜうまくいくのか

### 1. コンテキストマネジメント

```
親LayerのContext
  ↓ 継承
SG1, SG2, SG3のContext
  ↓ さらに継承
各タスクのコマンド実行時にも参照

→ 途中でコンテキストを忘れない！
```

### 2. ワークフローマネジメント

- 「コマンド」として構造化
- HITL（Human In The Loop）で人間と協働
- 過去のテンプレートを参照・再利用

### 3. 再帰的実行

- どの階層も同じパターン
- 無限に分解可能
- フラクタル構造

---

## 🔗 Claude Codeとの対応関係

AIPOとClaude Codeは独立に開発されたにも関わらず、**同じアーキテクチャパターンに収斂**しています。

| AIPO | Claude Code | 役割 |
|------|-------------|------|
| command-templates + Discover | **Skills** | ドメイン知識 + タスク分解 |
| 04_deliver | **Subagents** | 確実な実行 |
| 01_sense / 02_focus | **Slash Commands** | ワークフロー開始 |

---

## 📁 ディレクトリ構造

```
aipo/
├── SKILL.md              ← メタデータ
├── README.md             ← このファイル
├── install.sh            ← インストールスクリプト
├── commands/             ← 5つのコアコマンド
│   ├── 01_sense.md
│   ├── 02_focus.md
│   ├── 03_discover.md
│   ├── 04_deliver.md
│   ├── 05_operation.md
│   └── README.md
└── skills/               ← スキル・テンプレート
    ├── execution-rules.md
    ├── session-rules.md
    ├── abstract-mode.md
    ├── next-action-rules.md
    ├── command-templates/  ← 89テンプレート（18カテゴリ）
    ├── roles-templates/    ← 36ロール
    ├── troubleshoot.md
    ├── sync_progress.md
    ├── task_completion_rules.md
    └── README.md
```

---

## 🎭 Roles（専門家視点）- 36種類

AIPOは**Goalの性質に応じて最適な専門家視点（Role）を選択**し、その視点からタスクを分解します。

### ロールカテゴリ

| カテゴリ | ロール例 | 代表フレームワーク |
|----------|---------|-------------------|
| **ビジネス/経営** | 業務分析、戦略コンサル、グロースハック、業務改善 | As-Is/To-Be, MECE, AARRR |
| **デザイン/UX** | UXデザイナー、サービスデザイナー | Double Diamond, Blueprint |
| **エンジニアリング** | システムアーキテクト、DevOps、QA、セキュリティ | C4 Model, Test Pyramid |
| **データ/AI** | データサイエンティスト、ML/AIエンジニア | CRISP-DM, MLOps |
| **マーケ/セールス** | マーケティング、セールスオペレーション、CS | STP/4P, Customer Lifecycle |
| **プロジェクト管理** | プロダクトマネージャー、スクラムマスター、プログラムマネージャー | Dual Track Agile, Scrum |
| **専門職** | リサーチャー、コミュニティマネージャー、HR、法務 | Mixed Methods |
| **ライフ** | ライフコーチ、キャリアアドバイザー、FP、旅行、学習 | GROW Model, Will-Can-Must |
| **クリエイティブ** | 作家、ゲームデザイナー、ストーリーテラー、トレーナー | Three-Act, MDA Framework |

### 使用例

```
/aipo/01_sense を実行してください

Goal: 新規事業の市場参入戦略を立てる
Role: Strategy Consultant  ← 明示指定も可能
```

> 💡 ロールを指定しない場合、AIPOがGoalの性質から自動判定します

詳細: [skills/roles-templates.md](skills/roles-templates.md)

---

## 📝 コマンドテンプレート - 89種類（18カテゴリ）

AIPOは**タスクの性質に応じて最適なテンプレートを選択**し、高品質な成果物を生成します。

### テンプレートカテゴリ

| カテゴリ | 数 | 内容 |
|----------|---|------|
| **プロジェクト管理** | 21 | 憲章、ステークホルダー、WBS、バックログ、OKR、スクラム |
| **調査・分析** | 13 | ペルソナ、課題定義、仮説マップ、競合調査、市場規模、業務分析 |
| **技術** | 13 | アーキテクチャ、DB設計、API、CI/CD、テスト、データパイプライン |
| **コンテンツ/プレゼン** | 14 | 記事企画、スライド作成、LT準備、技術仕様書 |
| **コミュニケーション** | 10 | 議事録、日報、Slack分析、スプリントゴール |
| **専門職/ライフ** | 14 | イベント企画、採用、お悩み相談、キャリア、旅行、学習 |
| **デザイン/マーケ** | 4 | UXリサーチ、サービス設計、マーケ戦略、CS |

### 使用例

```
# Discoverフェーズで自動選択
/aipo/03_discover を実行

# または直接参照
@CMD_prj_01_プロジェクト憲章.md を参照してタスクを実行
```

詳細: [skills/command-templates.md](skills/command-templates.md)

---

## 🛠️ ユーティリティスキル

| ファイル | 用途 |
|----------|------|
| `troubleshoot.md` | 困ったときの相談 |
| `sync_progress.md` | 進捗同期 |
| `task_completion_rules.md` | タスク完了ルール |

### 使い方

```
@troubleshoot.md 次に何をすればいい？
@sync_progress.md L001
@task_completion_rules.md
```

---

## 🌐 関連プロジェクト

### AIPM (AI × Product Management)

AIPOは **AIPMシステム** の一部として開発されました。AIPMは、AIを用いてプロダクトマネジメント（PM／PO）の思考・プロセスをアップデートするためのフレームワークです。

- 仮説の言語化
- MVP設計支援
- 週次RYGレポート
- PRD／バックログ雛形作成

詳細: [note.com/miyatad](https://note.com/miyatad)

---

## ライセンス

MIT License

---

## 👤 作者

### miyatti (宮田大督)

**株式会社エクスプラザ** 生成AIエバンジェリスト / CPO

> 「AIを使ったワークショップや内部勉強会、講座を通じて、AIエージェントを含むツールの社内・社会実装に取り組んでいます」

#### リンク

- X (Twitter): [@miyatti](https://x.com/miyatti)
- note: [note.com/miyatad](https://note.com/miyatad)
- Docswell: [docswell.com/user/miyatti](https://www.docswell.com/user/miyatti)
- Podcast: [Product AI Talks](https://creators.spotify.com/pod/profile/productai-talks)

#### 主な登壇・発表

| タイトル | Views |
|----------|-------|
| 令和トラベル Dify講座 | 746K |
| Cursorエージェント講座 超入門＋実践編 | 562K |
| Cursorエージェント講座 超応用編 | 276K |
| Dify講座 超入門 | 159K |
| ノンエンジニアのCursor活用術 | 140K |
| AIPOシステム紹介 | 12K |

---

## ⚠️ 免責事項

- 本ソフトウェアは「現状のまま」提供され、明示的または黙示的な保証はありません
- AIによる自動生成結果の正確性・完全性・有用性について、作者は一切の責任を負いません
- 本ソフトウェアの使用によって生じたいかなる損害についても、作者は責任を負いません
- 重要な意思決定や業務利用の際は、必ず人間による確認・検証を行ってください
- AIの出力内容は参考情報として扱い、最終判断は利用者の責任で行ってください

---

## 🤝 コントリビューション

Issue・Pull Requestは大歓迎です。

---

**作成日**: 2025-11-27  
**最終更新**: 2026-01-20
