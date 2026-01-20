# CMD_data_MLシステム

最終更新日時: 2026年1月20日

## 📋 コマンド概要

```yaml
command: /data/MLシステム
alias: ["/ml", "/機械学習", "/ai-system"]
category: data_ai
related_role: ai_ml_engineer_focus

description: |
  機械学習システムの構築をサポートします。
  モデル開発からMLOps、本番運用まで
  エンドツーエンドで支援。

trigger_keywords:
  - "機械学習"
  - "ML"
  - "AI"
  - "モデル"
  - "推論"
```

---

## 📝 実行フロー

### Phase 1: 要件定義

```markdown
## 📋 ML要件定義

### ビジネス要件
- 解決したい課題: 
- 期待する効果: 
- 成功指標: 

### MLタスク
- [ ] 分類（Classification）
- [ ] 回帰（Regression）
- [ ] クラスタリング
- [ ] 推薦
- [ ] NLP
- [ ] 画像認識
- [ ] その他: 

### 制約条件
- レイテンシ要件: ms以下
- スループット: req/sec
- 精度要件: 
- 説明可能性: [ ] 必要 [ ] 不要
```

### Phase 2: モデル開発

```markdown
## 🔬 モデル開発

### データセット
| データ | 件数 | 期間 | 用途 |
|--------|------|------|------|
| 学習用 | | | Train |
| 検証用 | | | Validation |
| テスト用 | | | Test |

### 特徴量
| 特徴量名 | 型 | 説明 | 重要度 |
|---------|---|------|-------|
| | | | |

### モデル比較
| モデル | 精度 | 推論速度 | サイズ |
|--------|------|---------|-------|
| | | | |
| | | | |

### 選定モデル
- モデル: 
- 理由: 
```

### Phase 3: MLOps設計

```markdown
## 🔄 MLOps設計

### MLパイプライン
```
[Data] → [Feature] → [Train] → [Evaluate] → [Register] → [Deploy]
         Store         │          │            │
                    [Experiment  [Model       [Model
                     Tracking]   Registry]    Serving]
```

### ツールスタック
| 機能 | ツール |
|------|-------|
| 実験管理 | MLflow / W&B |
| Feature Store | Feast |
| モデルレジストリ | MLflow |
| Serving | TensorFlow Serving / Triton |
| モニタリング | Prometheus / Grafana |

### 再学習ポリシー
- トリガー: 
- 頻度: 
- 自動化レベル: 
```

### Phase 4: 本番運用

```markdown
## 🚀 本番運用

### デプロイ戦略
- [ ] Blue-Green
- [ ] Canary
- [ ] Shadow

### モニタリング
| 指標 | 閾値 | アクション |
|------|------|-----------|
| 予測精度 | | |
| レイテンシ | | |
| データドリフト | | |
| コンセプトドリフト | | |

### アラート設定
| 条件 | 通知先 |
|------|-------|
| | |

### ロールバック手順
1. 
2. 
```

---

## 📋 出力テンプレート

```markdown
# ML システム設計書

## 概要
{{overview}}

## モデル仕様
{{model_spec}}

## MLOps設計
{{mlops}}

## 運用設計
{{operations}}
```

---

**作成日**: 2026-01-20
**ステータス**: Active
