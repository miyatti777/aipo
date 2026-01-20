# product_manager_focus

最終更新日時: 2025年12月29日 16:14

# Product Manager Focus Strategy

## 📋 Skill Definition

```yaml
name: Product Manager Focus
type: focus_strategy
version: 1.0

# 概要
description: |
  プロダクトマネージャー視点でのタスク分解戦略。
  ユーザー価値を中心に、Discovery→Deliveryの流れで段階的に構築。
  MVP思考で最小単位での価値提供を優先。

# 適用シーン
applicable_goals:
  - プロダクト開発・改善
  - 新サービス立ち上げ
  - 機能追加・改修
  - ユーザー体験向上
  keywords:
    - "プロダクト"
    - "サービス"
    - "開発"
    - "ユーザー"
    - "機能"
```

---

## 🎯 分解原則（Decomposition Principles）

### 1. Jeff Patton流Product Discovery

**Discovery（調査・検証） → Delivery（実装・提供）**

- **Discovery**: ユーザーニーズ・課題を理解する
- **Delivery**: 学びを元に価値を実装・提供する

### 2. MVP思考

**最小単位での価値提供を優先**

- 複雑な機能は段階的にリリース
- 早期のフィードバックループ構築
- 仮説検証サイクルの高速化

### 3. ユーザー中心設計

**ペルソナ → 課題 → ソリューション**

- ユーザー理解から始める
- 課題の本質を見極める
- ソリューションは複数検討

---

## 📐 フェーズ構造（Phase Structure）

### Phase 1: Discovery（発見）

**目的**: ユーザーニーズと課題の理解

**典型的なタスク分解**:

- ペルソナ定義
- ユーザーインタビュー
- 課題仮説の検証
- 競合調査・ベンチマーク
- ソリューション仮説の立案

### Phase 2: Design（設計）

**目的**: ソリューションの具体化

**典型的なタスク分解**:

- 要件定義
- UI/UXデザイン
- 技術選定・アーキテクチャ設計
- MVP範囲の決定

### Phase 3: Delivery（実装・提供）

**目的**: 価値の実装と提供

**典型的なタスク分解**:

- 実装（フロント・バック・インフラ）
- テスト・QA
- リリース準備
- ドキュメント作成

### Phase 4: Measure & Learn（測定・学習）

**目的**: 提供価値の測定と学び

**典型的なタスク分解**:

- KPI設定・計測
- ユーザーフィードバック収集
- データ分析
- 改善仮説の立案
- 次のDiscoveryサイクルへ

---

## 🔑 重要な考慮事項（Key Considerations）

### SubLayer判定基準

以下の場合はSubLayer化を推奨：

- **異なるペルソナ向け機能**: 各ペルソナごとにDiscovery→Deliveryサイクルが必要
- **大きな機能群**: 単独でMVPとして成立する単位
- **段階的リリース**: Phase 1, Phase 2のように明確に分離できる
- **独立チーム運用**: 別チームに委譲できる単位

### Task判定基準

以下の場合はTask化を推奨：

- **調査・リサーチ系**: ペルソナ作成、競合調査、ユーザーインタビュー
- **設計・企画系**: 要件定義、UI設計、技術選定
- **実装系（小規模）**: 1-2週間で完了する実装タスク
- **運用系**: モニタリング、ドキュメント整備

### 注意点

- **過度な分解を避ける**: MVP精神で最小単位から開始
- **仮説検証を優先**: 完璧を目指さず、早期にフィードバックを得る
- **ユーザー価値を軸に**: 技術的な都合ではなく、ユーザー価値で分解

---

## 💡 使用例

### 例1: 新サービス開発

**Goal**: ECサイトの購買体験を改善する

**SubLayer分解例**:

- SG1: 商品検索体験の改善（Discovery → Delivery）
- SG2: 購入フロー最適化（Discovery → Delivery）
- SG3: レコメンド機能追加（Discovery → Delivery）

各SubLayerで再帰的にDiscovery→Deliveryサイクルを回す。

### 例2: 新機能追加

**Goal**: チャット機能を追加する

**Task分解例（末端Layer）**:

- T001: ユーザーインタビュー（Discovery）
- T002: 競合チャット機能調査（Discovery）
- T003: UI/UX設計（Design）
- T004: MVP範囲決定（Design）
- T005: バックエンド実装（Delivery）
- T006: フロントエンド実装（Delivery）
- T007: リリース・KPI設定（Measure）

---

**作成日**: 2025-12-29

**ステータス**: Active