# CMD_eng_データパイプライン

最終更新日時: 2026年1月20日

## 📋 コマンド概要

```yaml
command: /eng/データパイプライン
alias: ["/etl", "/data-pipeline", "/データ基盤"]
category: engineering
related_role: data_engineer_focus

description: |
  データパイプラインの設計・構築をサポートします。
  ETL/ELT、データウェアハウス、
  データレイクの構築を支援。

trigger_keywords:
  - "ETL"
  - "データパイプライン"
  - "DWH"
  - "データ基盤"
```

---

## 📝 実行フロー

### Phase 1: データアーキテクチャ設計

```markdown
## 📐 データアーキテクチャ

### データソース一覧
| ソース | 種別 | 形式 | 頻度 | 件数/日 |
|--------|------|------|------|--------|
| | DB | | | |
| | API | JSON | | |
| | ファイル | CSV | | |

### アーキテクチャ図
```
[Source]      [Ingestion]    [Storage]     [Transform]    [Serve]
    │              │             │              │            │
DB ─┤          ┌───┴───┐    ┌───┴───┐     ┌───┴───┐    ┌───┴───┐
API ┼──────→ │Airflow│──→│Data   │──→ │ dbt   │──→│ DWH   │──→BI
File─┤         │Kafka  │    │Lake   │     │Spark  │    │       │
    │          └───────┘    └───────┘     └───────┘    └───────┘
```

### 技術スタック
| レイヤー | 技術 | 理由 |
|---------|------|------|
| Orchestration | | |
| Storage | | |
| Transform | | |
| Serving | | |
```

### Phase 2: パイプライン設計

```markdown
## 🔄 パイプライン設計

### パイプライン一覧
| パイプライン名 | ソース | 宛先 | 頻度 | SLA |
|---------------|-------|------|------|-----|
| | | | 日次 | |

### DAG設計
```
[extract_source_a] ──┐
                    ├──→ [transform] ──→ [load_dwh]
[extract_source_b] ──┘
```

### データモデル（DWH）
```
Fact Tables:
├── fact_sales
├── fact_orders
└── fact_pageviews

Dimension Tables:
├── dim_customer
├── dim_product
├── dim_date
└── dim_location
```
```

### Phase 3: データ品質

```markdown
## ✅ データ品質管理

### 品質チェック
| チェック | 対象 | 閾値 | アクション |
|---------|------|------|-----------|
| 欠損率 | | <5% | アラート |
| 重複率 | | <1% | 自動除去 |
| 遅延 | | <1h | アラート |

### データリネージ
- ソース追跡
- 変換ログ
- 影響分析

### データカタログ
| テーブル | 説明 | オーナー | 更新頻度 |
|---------|------|---------|---------|
| | | | |
```

---

## 📋 出力テンプレート

```markdown
# データパイプライン設計書

## アーキテクチャ
{{architecture}}

## パイプライン一覧
{{pipelines}}

## データモデル
{{data_model}}

## 品質管理
{{quality}}
```

---

**作成日**: 2026-01-20
**ステータス**: Active
