# AIPO Skills / Context

> AIPOコマンド実行時に`@`メンションで参照するスキル・コンテキストファイル

## ライセンス

MIT License

---

## 🏛️ アーキテクチャ概要

AIPOのSkillsは、Claude CodeのSkillsと同じ設計思想に基づいています。

```
【Progressive Disclosure - 段階的情報開示】

Level 1: メタデータ（name, description）
    ↓ 必要に応じてロード
Level 2: SKILL.md本体（execution-rules.md等）
    ↓ 必要に応じてロード
Level 3: 追加ファイル（command-templates/配下等）
```

**なぜこの設計？** → コンテキストウィンドウの制約下で、必要な知識だけを動的にロードするため。

---

## 📏 コアスキル（Context Rules）

AIPOコマンドを補足するルールファイル

| ファイル | 用途 | いつ使う |
|----------|------|----------|
| `execution-rules.md` | 全コマンド共通の実行ルール・成果物構造標準 | 常に |
| `session-rules.md` | セッション分割・継続ルール（コンテキスト管理） | 長いタスク時 |
| `abstract-mode.md` | L0-L4抽象度管理・Notion擬似プログラミング | 実装タスク時 |
| `next-action-rules.md` | Next Action Protocol（完了後のナビゲーション） | コマンド完了時 |
| `command-templates.md` | コマンドテンプレート索引（89テンプレート / 18カテゴリ） | Discover時 |
| `roles-templates.md` | ロールテンプレート索引（PM、Architect等） | Sense時 |

---

## 🛠️ ユーティリティスキル

操作支援・自動化スキル

| ファイル | 用途 | 使用タイミング |
|----------|------|----------------|
| `task_completion_rules.md` | タスク完了時の必須ルール | `/aipo/04_deliver` 完了時 |
| `sync_progress.md` | 進捗同期スキル | 成果物確認→tasks.yaml自動更新 |
| `troubleshoot.md` | 操作相談スキル | 困ったとき全般 |

---

## 📁 サブフォルダ

### `command-templates/` - 92個のコマンドテンプレート（19カテゴリ）

ドメイン知識をカプセル化したテンプレート集

| カテゴリ | 内容 |
|----------|------|
| `project_management_templates/` | プロジェクト憲章、ステークホルダー分析（9個） |
| `task_management_templates/` | WBS、バックログ、日次タスク、OKR（11個） |
| `agile_pm_templates/` | スクラム運営（1個） |
| `communication_templates/` | 議事録、日報、Slack分析（10個） |
| `Discovery_templates/` | ペルソナ、課題定義、仮説マップ（5個） |
| `Research_templates/` | 競合調査、顧客調査、市場規模（4個） |
| `business_analysis_templates/` | 業務分析、戦略コンサル、グロース施策（4個） |
| `system_building_templates/` | アーキテクチャ、DB設計、API設計（8個） |
| `development_ax_templates/` | **🆕 DesignDoc作成、テスト計画、コードレビュー（3個）** |
| `engineering_templates/` | CI/CD、テスト戦略、データパイプライン（3個） |
| `data_ai_templates/` | データ分析、MLシステム（2個） |
| `design_ux_templates/` | UXリサーチ、サービス設計（2個） |
| `marketing_sales_templates/` | マーケ戦略、カスタマーサクセス（2個） |
| `content_creation_templates/` | コンテンツリサーチ、記事企画（6個） |
| `presentation_templates/` | プレゼン資料、技術仕様書（3個） |
| `lt_presentation_templates/` | LT構成・台本、スライドデザイン（5個） |
| `specialist_templates/` | イベント企画、コミュニティ運営、採用人事（4個） |
| `life_coaching_templates/` | お悩み整理、キャリア相談、家計診断（5個） |
| `creative_templates/` | 物語執筆、ゲーム企画、ストーリー設計（5個） |

### `roles-templates/` - 38個のロールテンプレート

| カテゴリ | ロール例 |
|----------|---------|
| ビジネス/経営系 | business_analyst, strategy_consultant, growth_hacker, operations_manager |
| デザイン/UX系 | ux_designer, service_designer |
| エンジニアリング系 | system_architect, **software_architect** 🆕, devops_engineer, data_engineer, **code_analyst** 🆕, security_engineer, qa_engineer |
| データ/AI系 | data_scientist, ai_ml_engineer |
| マーケ/セールス系 | marketing_manager, sales_operations, customer_success |
| プロジェクト管理系 | product_manager, scrum_master, program_manager |
| 専門職系 | research_lead, community_manager, hr_people_ops, legal_compliance, event_planner |
| ライフ系 | life_coach, career_advisor, financial_advisor, travel_planner, learning_facilitator |
| クリエイティブ系 | creative_writer, game_designer, storyteller, party_planner, personal_trainer |
| 汎用 | generic, content_strategist |

---

## 🚀 使い方

### 基本フロー

```
1. /aipo/01_sense   → Goalとロールを決定
2. /aipo/02_focus   → Layer構造を設計
3. /aipo/03_discover → Taskに分解
4. /aipo/04_deliver  → 実行・成果物作成
5. /aipo/05_operation → 運用・量産
```

### 困ったとき

```
@troubleshoot.md 並列実行の相談
@troubleshoot.md 次に何をすればいい？
@troubleshoot.md セッション復帰したい
```

### 進捗確認・同期

```
@sync_progress.md L001
@sync_progress.md --dry-run
```

### タスク完了時

```
@task_completion_rules.md
→ tasks.yaml を必ず更新
```

### ロール選択時

```
@roles-templates.md
→ 適切なロールを選択
```

### テンプレート探索時

```
@command-templates.md
→ 類似テンプレートを探す
```

---

## 🔗 Claude Codeとの対応関係

| AIPO Skills | Claude Code | 対応する機能 |
|-------------|-------------|--------------|
| コマンドテンプレート + Discover | **Skills** | ドメイン知識の動的ロード |
| 04_deliver | **Subagents** | 独立コンテキストでの実行 |
| 01_sense / 02_focus | **Slash Commands** | ワークフローの開始点 |

**収斂進化**: 独立に開発されたシステムが、コンテキスト制約という同じ問題に対して、同じ解に到達。

---

## 📚 コマンドファイル

場所: `commands/`

```
/aipo/01_sense      - Goal設定・ロール選択（Sense）
/aipo/02_focus      - Layer/SubGoal分解（Focus）
/aipo/03_discover   - Task分解・コマンド生成（Discover）
/aipo/04_deliver    - Task実行・成果物生成（Deliver）
/aipo/05_operation  - 運用コマンド実行（Operation）
```

詳細は [Commands README](../commands/README.md) を参照

---

**作成日**: 2025-12-25  
**最終更新**: 2026-01-20
