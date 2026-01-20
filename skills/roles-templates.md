---
name: roles-templates
description: "専門家ロールテンプレート集（36種類 - ビジネス/技術/クリエイティブ/ライフ等）"
license: "MIT"
---

# CTX_roles_templates

最終更新日時: 2026年1月20日

# ロールテンプレート集（Roles Templates）

**Claude Code Skillsとの対応**: このコンテキストはClaude Code SkillsのLevel 2（戦略・ドメイン知識）に相当します。

<aside>
💡

**Purpose**

[/aipo/01_sense](../commands/01_sense.md) のSense段階で使用される、専門家ロール（視点）のテンプレート集です。

Goalの性質に応じて適切なロールを選択することで、以降のタスク分解において質の高い判断が可能になります。

</aside>

---

## 📚 利用可能なロール（36種類）

各ロールはSkills形式で定義されており、分解原則・フェーズ構造・重要な考慮事項を含みます。

### 🏢 ビジネス/経営系（4種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [business_analyst_focus](roles-templates/business_analyst_focus.md) | 業務分析・要件定義 | As-Is/To-Be/Gap |
| [strategy_consultant_focus](roles-templates/strategy_consultant_focus.md) | 戦略立案・経営課題 | イシュードリブン/MECE |
| [growth_hacker_focus](roles-templates/growth_hacker_focus.md) | グロース施策・データ分析 | AARRR |
| [operations_manager_focus](roles-templates/operations_manager_focus.md) | 業務改善・標準化 | PDCA/SOP |

### 🎨 デザイン/UX系（2種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [ux_designer_focus](roles-templates/ux_designer_focus.md) | UXリサーチ・UI設計 | HCD/Double Diamond |
| [service_designer_focus](roles-templates/service_designer_focus.md) | サービス体験設計 | Blueprint/Journey Map |

### 💻 エンジニアリング系（4種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [system_architect_focus](roles-templates/system_architect_focus.md) | システム設計・アーキテクチャ | C4 Model |
| [devops_engineer_focus](roles-templates/devops_engineer_focus.md) | CI/CD・インフラ自動化 | Pipeline/IaC |
| [data_engineer_focus](roles-templates/data_engineer_focus.md) | データパイプライン | ETL/ELT |
| [security_engineer_focus](roles-templates/security_engineer_focus.md) | セキュリティ設計 | Defense in Depth |
| [qa_engineer_focus](roles-templates/qa_engineer_focus.md) | テスト戦略・品質管理 | Test Pyramid |

### 📊 データ/AI系（2種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [data_scientist_focus](roles-templates/data_scientist_focus.md) | データ分析・インサイト | CRISP-DM |
| [ai_ml_engineer_focus](roles-templates/ai_ml_engineer_focus.md) | MLシステム構築 | MLOps Lifecycle |

### 📣 マーケティング/セールス系（3種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [marketing_manager_focus](roles-templates/marketing_manager_focus.md) | マーケティング戦略 | STP/4P |
| [sales_operations_focus](roles-templates/sales_operations_focus.md) | セールスオペレーション | Sales Funnel |
| [customer_success_focus](roles-templates/customer_success_focus.md) | カスタマーサクセス | Customer Lifecycle |

### 📋 プロジェクト管理系（3種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [product_manager_focus](roles-templates/product_manager_focus.md) | プロダクト戦略・優先順位 | Dual Track Agile |
| [scrum_master_focus](roles-templates/scrum_master_focus.md) | スクラム運営 | Scrum Events |
| [program_manager_focus](roles-templates/program_manager_focus.md) | プログラム管理 | Portfolio Management |

### 🔬 専門職系（5種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [research_lead_focus](roles-templates/research_lead_focus.md) | リサーチ計画・分析 | Mixed Methods |
| [community_manager_focus](roles-templates/community_manager_focus.md) | コミュニティ運営 | Engagement Pyramid |
| [hr_people_ops_focus](roles-templates/hr_people_ops_focus.md) | 採用・人事 | Employee Lifecycle |
| [legal_compliance_focus](roles-templates/legal_compliance_focus.md) | 法務・コンプライアンス | Risk-based Compliance |
| [event_planner_focus](roles-templates/event_planner_focus.md) | イベント企画・運営 | Event Lifecycle |

### 🌟 一般/ライフ系（5種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [life_coach_focus](roles-templates/life_coach_focus.md) | お悩み相談・コーチング | GROW Model |
| [career_advisor_focus](roles-templates/career_advisor_focus.md) | キャリア相談 | Will-Can-Must |
| [financial_advisor_focus](roles-templates/financial_advisor_focus.md) | 家計・資産管理 | Life Plan |
| [travel_planner_focus](roles-templates/travel_planner_focus.md) | 旅行計画 | Trip Phases |
| [learning_facilitator_focus](roles-templates/learning_facilitator_focus.md) | 学習計画 | PDCA Learning |

### 🎭 エンタメ/クリエイティブ系（5種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [creative_writer_focus](roles-templates/creative_writer_focus.md) | 物語執筆 | Three-Act Structure |
| [game_designer_focus](roles-templates/game_designer_focus.md) | ゲーム企画 | MDA Framework |
| [storyteller_focus](roles-templates/storyteller_focus.md) | ストーリーテリング | Hero's Journey |
| [party_planner_focus](roles-templates/party_planner_focus.md) | パーティー企画 | Event Experience |
| [personal_trainer_focus](roles-templates/personal_trainer_focus.md) | フィットネス計画 | Progressive Overload |

### 🔧 汎用（1種）
| ロール | 説明 | フレームワーク |
|--------|------|----------------|
| [generic_focus](roles-templates/generic_focus.md) | 汎用的な問題解決 | OODA Loop |
| [content_strategist_focus](roles-templates/content_strategist_focus.md) | コンテンツ戦略 | Content Lifecycle |

---

## 🔄 使用方法

### 1. 自動選択（推奨）

[/aipo/01_sense](../commands/01_sense.md) がGoalの性質から自動判定し、最適なロールを提案します。

### 2. 明示指定

ユーザーが特定のロールを指定することも可能：

```
/aipo/01_sense を実行してください
GOAL: 新サービス開発
Role: Product Manager
```

### 3. ロール選定ガイド

| Goalの種類 | 推奨ロール |
|-----------|-----------|
| 新サービス/プロダクト開発 | product_manager_focus |
| 業務改善・効率化 | business_analyst_focus, operations_manager_focus |
| 成長施策・KPI改善 | growth_hacker_focus |
| システム構築 | system_architect_focus |
| データ分析・意思決定支援 | data_scientist_focus |
| マーケティング施策 | marketing_manager_focus |
| UX/UI改善 | ux_designer_focus |
| 人生相談・悩み整理 | life_coach_focus |
| キャリア相談 | career_advisor_focus |
| イベント企画 | event_planner_focus, party_planner_focus |
| クリエイティブ制作 | creative_writer_focus, storyteller_focus |
| 学習計画 | learning_facilitator_focus |

---

## 🛠️ ロールの追加方法

新しいロールを追加する場合：

1. `roles-templates/`配下に新しいロールファイルを作成
2. Skills形式で以下を定義：
    - name: ロール名
    - description: 概要
    - applicable_goals: 適用可能なGoal
    - decomposition_principles: 分解原則
    - phase_structure: フェーズ構造
    - key_considerations: 重要な考慮事項
3. このファイルのロール一覧テーブルに追加
4. 関連するコマンドテンプレートがあれば`command-templates/`にも追加

---

**作成日**: 2025-12-29

**最終更新**: 2026-01-20

**ステータス**: Active
