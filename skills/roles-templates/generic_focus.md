# generic_focus

最終更新日時: 2025年12月29日 16:15

# Generic Focus Strategy

## 📋 Skill Definition

```yaml
name: Generic Focus
type: focus_strategy
version: 1.0

# 概要
description: |
  汎用的なタスク分解戦略。
  Senseで収集したコンテキストから動的に判断し、
  特定のフレームワークに縛られない柔軟な分解を行う。

# 適用シーン
applicable_goals:
  - 上記3つの戦略に当てはまらないすべてのGoal
  - 複合的な性質を持つGoal
  - 新しいドメイン・未知の領域
  keywords:
    - default: true  # デフォルト戦略
```

---

## 🎯 分解原則（Decomposition Principles）

### 1. コンテキスト駆動型分解

**Senseフェーズの情報を最大活用**

- layer.yaml, context.yamlの情報を読み込み
- 関連プロジェクト・類似事例を参照
- 組織の慣習・ベストプラクティスを考慮

### 2. Goal性質の多角的分析

**複数の視点から分解アプローチを検討**

- 時系列分解: フェーズ・ステージごと
- 機能分解: 機能単位・モジュール単位
- 組織分解: 部門・チームごと
- 技術分解: 技術スタック・レイヤーごと

### 3. 柔軟な構造化

**固定フレームワークに依存しない**

- Goalに応じて最適な分解軸を選択
- 必要に応じて複数の分解軸を組み合わせ
- 階層的な再帰分解を活用

---

## 📐 フェーズ構造（Phase Structure）

汎用戦略では、固定的なフェーズ構造は定義しません。

代わりに、以下の分解パターンから最適なものを選択します。

### パターン1: 時系列分解

**適用例**: プロジェクト全体、段階的な展開

- Phase 1: 準備・計画
- Phase 2: 実行・構築
- Phase 3: 検証・改善
- Phase 4: 運用・展開

### パターン2: 機能分解

**適用例**: システム開発、機能追加

- 機能A: ユーザー管理
- 機能B: データ処理
- 機能C: レポート生成
- 機能D: 通知

### パターン3: 組織分解

**適用例**: 全社展開、部門別施策

- 部門A: エンジニアリング
- 部門B: セールス
- 部門C: カスタマーサポート
- 横断: 共通基盤

### パターン4: 技術スタック分解

**適用例**: 技術基盤構築、アーキテクチャ設計

- Layer 1: インフラ
- Layer 2: バックエンド
- Layer 3: フロントエンド
- Layer 4: データ

### パターン5: ハイブリッド分解

**複数パターンの組み合わせ**

例: Phase 1内で機能分解、Phase 2で組織分解

---

## 🔑 重要な考慮事項（Key Considerations）

### 動的判断のプロセス

1. **Goal分析**
    - Goalの文言から性質を推測
    - 制約条件・期限を考慮
    - 成功条件を明確化
2. **Context参照**
    - 組織構造・チーム体制
    - 既存プロジェクト・類似事例
    - 技術スタック・ツール
    - ドメイン知識・業界標準
3. **分解軸の選定**
    - 最も自然な分解軸を優先
    - 依存関係・並行可能性を考慮
    - 階層の深さを適切に設定
4. **検証**
    - MECE（Mutually Exclusive, Collectively Exhaustive）チェック
    - 適切な粒度か確認
    - 実行可能性の検証

### SubLayer判定基準

**汎用的な判定ルール**:

- **複数のTaskで構成**: 3個以上のTaskが必要
- **独立した責務**: 明確な目的・成果物がある
- **委譲可能**: 他者に任せられる単位
- **並行実行可能**: 依存関係が少ない

### Task判定基準

**汎用的な判定ルール**:

- **1-2日で完了**: 短期間で完結
- **単純明快**: これ以上分解不要
- **実行単位**: 実際に作業できるレベル
- **成果物明確**: 何を作るか明確

### 注意点

- **過度な複雑化を避ける**: シンプルさを優先
- **パターン適用の柔軟性**: 状況に応じて変更
- **ドメイン知識の活用**: 業界・組織固有の知見を反映
- **イテレーション前提**: 完璧を求めず、改善を重ねる

---

## 💡 使用例

### 例1: 全社業務改善プロジェクト

**Goal**: 全社の業務効率を30%向上させる

**SubLayer分解例（組織軸）**:

- SG1: エンジニアリング部門の業務改善
- SG2: セールス部門の業務改善
- SG3: バックオフィスの業務改善
- SG4: 横断的な共通基盤整備

各部門の特性に応じて、さらにサブ分解。

### 例2: 新規事業立ち上げ

**Goal**: 新規SaaS事業を6ヶ月で立ち上げ

**SubLayer分解例（時系列 + 機能）**:

- SG1: Phase 0 - 市場調査・事業計画（時系列）
- SG2: Phase 1 - MVP開発（機能分解）
    - SG2-1: コア機能開発
    - SG2-2: 決済・認証機能
- SG3: Phase 2 - β版リリース・検証（時系列）
- SG4: Phase 3 - 本番リリース・運用（時系列）

### 例3: イベント企画・運営（Task分解例）

**Goal**: 社内カンファレンスを開催

**Task分解例（末端Layer）**:

- T001: 企画立案・テーマ設定
- T002: 登壇者リストアップ・交渉
- T003: 会場手配
- T004: タイムテーブル作成
- T005: 集客・広報
- T006: 当日運営マニュアル作成
- T007: リハーサル実施
- T008: 当日運営
- T009: アンケート収集・振り返り

---

## 🤖 AI実装ガイド

**汎用戦略でのAI判断フロー**:

```python
def generic_decompose(goal, context):
    # 1. Goal性質の分析
    goal_nature = analyze_goal(goal)
    
    # 2. Context情報の抽出
    org_structure = extract_org_structure(context)
    similar_projects = find_similar_projects(context)
    domain_knowledge = extract_domain_knowledge(context)
    
    # 3. 最適な分解軸の選定
    if goal_nature.has_clear_phases:
        decomposition_axis = "timeline"
    elif goal_nature.has_multiple_functions:
        decomposition_axis = "functional"
    elif org_structure.has_multiple_departments:
        decomposition_axis = "organizational"
    else:
        decomposition_axis = "hybrid"
    
    # 4. 分解の実行
    return decompose_by_axis(goal, context, decomposition_axis)
```

---

**作成日**: 2025-12-29

**ステータス**: Active