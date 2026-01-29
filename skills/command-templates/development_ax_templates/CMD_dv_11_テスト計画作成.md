# CMD_dv_11_テスト計画作成

最終更新日時: 2026年1月29日

# テスト計画自動生成テンプレート

> **設計書からテスト計画・テストケースを自動生成（リスクベース・HITL対応）**

---

## 🎯 このテンプレートでできること

- 設計書からテスト対象を抽出
- リスクベースでテスト優先度を設定
- テストケースの自動生成（等価分割・境界値分析）
- テストレベル（Unit/Integration/E2E）の割り当て
- テスト自動化戦略の策定
- CI/CD統合設計
- **Human-in-the-Loop（HITL）で人間レビューを挟む**

---

## 📋 実行前の質問（必須回答）

### 1. 設計書情報
- 設計書ファイルパス: 
- 機能名: 
- 機能概要: 

### 2. 既存テスト情報
- 既存テストコードの有無: （Yes/No）
- テストフレームワーク: （Vitest, Jest, Playwright等）
- 現在のテストカバレッジ: （%）

### 3. テスト環境
- CI/CDツール: （GitHub Actions, GitLab CI等）
- テスト環境: （Docker, ローカル等）
- テストデータ管理方法: 

---

## 🔄 実行手順

### Phase 1: テスト対象分析（15分）【自動】

```yaml
実行内容:
  - 設計書から機能を抽出
  - リスク評価（影響度 × 発生確率）
  - テストレベル割り当て
  - テストスコープ定義

使用Role: role_qa_engineer

成果物:
  - test_scope_analysis.md
  - risk_assessment_matrix.md
  - test_level_mapping.md
```

**AIの動作:**
```
🔍 設計書を分析しています...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# テスト対象分析レポート

## 1. 機能抽出
### 1.1 主要機能
- F001: ポイント付与機能
- F002: ポイント利用機能
- F003: ポイント残高表示
- F004: ポイント履歴表示

### 1.2 技術コンポーネント
- API: /api/points
- Service: PointService
- Repository: PointRepository
- Database: points, point_balances テーブル

## 2. リスク評価
| 機能 | 影響度 | 発生確率 | リスクレベル | 優先度 |
|------|--------|----------|--------------|--------|
| ポイント付与 | 高 | 中 | 高 | P0 |
| ポイント利用 | 高 | 中 | 高 | P0 |
| 残高表示 | 中 | 低 | 中 | P1 |
| 履歴表示 | 低 | 低 | 低 | P2 |

## 3. テストレベル割り当て
### Unit Test（60%）
- PointService（ビジネスロジック）
- バリデーション関数
- ユーティリティ関数

### Integration Test（30%）
- API Routes
- Service + Repository連携
- DB操作

### E2E Test（10%）
- ポイント付与→利用フロー
- エラーハンドリング

## 4. テスト観点
### 機能正確性
- [ ] 正しい計算式でポイントが付与される
- [ ] 残高を超えるポイント利用はエラー
- [ ] トランザクション整合性

### セキュリティ
- [ ] 他ユーザーのポイント操作不可
- [ ] ポイント改ざん防止
- [ ] 入力値検証

### パフォーマンス
- [ ] レスポンスタイム200ms以内
- [ ] 同時実行時の整合性

### エラーハンドリング
- [ ] 不正な入力値
- [ ] DB接続エラー
- [ ] タイムアウト

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 test_scope_analysis.md を生成しました
```

---

### HITL-1: テスト範囲確認（5分）【人間】

**プロンプト:**
```
📋 テスト対象と優先度を確認してください

【確認事項】
✓ テスト対象機能は網羅されているか
✓ リスク評価は適切か
✓ テストレベルの配分は適切か

【質問】
1. 追加でテストすべき観点はありますか？
2. 優先度の調整が必要な箇所はありますか？
3. 特に重点的にテストすべき箇所はありますか？

次のステップに進むには「続行」と入力してください。
修正が必要な場合は、具体的に指示してください。
```

---

### Phase 2: テストケース生成（30分）【自動】

```yaml
実行内容:
  - 等価分割・境界値分析
  - 正常系・異常系ケース作成
  - テストデータ定義
  - 期待結果の明確化

使用Role: role_qa_engineer

成果物:
  - test_cases_draft.md
  - test_data_definition.md
  - test_scenarios.md
```

**AIの動作:**
```
📝 テストケースを生成しています...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# テストケース一覧

## Unit Test: PointService.earnPoints()

### TC-U001: ポイント付与（正常系）
| 項目 | 内容 |
|------|------|
| テストID | TC-U001 |
| テスト名 | 正常にポイントが付与される |
| 優先度 | P0 |
| テストレベル | Unit |
| 前提条件 | ユーザーID: user-123, 購入金額: 10,000円 |
| 入力 | userId: "user-123", amount: 10000 |
| 期待結果 | 100ポイント付与される（付与率1%） |
| 自動化 | Yes |

### TC-U002: ポイント付与（境界値：最小）
| 項目 | 内容 |
|------|------|
| テストID | TC-U002 |
| テスト名 | 最小購入金額でポイント付与 |
| 優先度 | P1 |
| テストレベル | Unit |
| 前提条件 | ユーザーID: user-123 |
| 入力 | userId: "user-123", amount: 1 |
| 期待結果 | 0ポイント（小数点切り捨て） |
| 自動化 | Yes |

### TC-U003: ポイント付与（異常系：負の金額）
| 項目 | 内容 |
|------|------|
| テストID | TC-U003 |
| テスト名 | 負の金額でエラー |
| 優先度 | P0 |
| テストレベル | Unit |
| 前提条件 | なし |
| 入力 | userId: "user-123", amount: -1000 |
| 期待結果 | ValidationError: "金額は0以上である必要があります" |
| 自動化 | Yes |

## Integration Test: POST /api/points/earn

### TC-I001: API経由でポイント付与（正常系）
| 項目 | 内容 |
|------|------|
| テストID | TC-I001 |
| テスト名 | API経由で正常にポイント付与 |
| 優先度 | P0 |
| テストレベル | Integration |
| 前提条件 | 認証済みユーザー |
| 入力 | POST /api/points/earn { "amount": 5000 } |
| 期待結果 | 200 OK, { "points": 50, "balance": 50 } |
| DB確認 | points テーブルに1レコード追加 |
| 自動化 | Yes |

### TC-I002: 未認証でエラー
| 項目 | 内容 |
|------|------|
| テストID | TC-I002 |
| テスト名 | 未認証アクセスで401エラー |
| 優先度 | P0 |
| テストレベル | Integration |
| 前提条件 | 認証トークンなし |
| 入力 | POST /api/points/earn { "amount": 5000 } |
| 期待結果 | 401 Unauthorized |
| 自動化 | Yes |

## E2E Test: ポイント付与→利用フロー

### TC-E001: ポイント獲得から利用まで
| 項目 | 内容 |
|------|------|
| テストID | TC-E001 |
| テスト名 | ポイント獲得→残高確認→利用の一連フロー |
| 優先度 | P0 |
| テストレベル | E2E |
| 前提条件 | ログイン済みユーザー |
| テストステップ | 1. 商品購入（10,000円）<br>2. ポイント残高確認（100pt）<br>3. ポイント利用（50pt）<br>4. 残高確認（50pt） |
| 期待結果 | 各ステップが正常に完了する |
| 自動化 | Yes |

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 test_cases_draft.md を生成しました（全35件）
```

---

### HITL-2: テストケースレビュー（10分）【人間】

**プロンプト:**
```
📋 テストケースをレビューしてください

【確認観点】
✓ テストケースは網羅的か
✓ 期待結果は明確か
✓ テストデータは適切か
✓ 優先度は適切か

【レビュー項目】
1. 不足しているテストケースはありますか？
2. テスト観点で追加すべき項目はありますか？
3. 期待結果が曖昧なテストケースはありますか？

次のステップに進むには「承認」と入力してください。
修正が必要な場合は、具体的に指示してください。
```

---

### Phase 3: 自動化計画（20分）【自動】

```yaml
実行内容:
  - 自動化対象選定
  - テストコード生成（サンプル）
  - CI/CD組み込み設計
  - カバレッジ目標設定

使用Role: role_qa_engineer

成果物:
  - automation_plan.md
  - ci_cd_integration.yaml
  - sample_test_code/
```

**AIの動作:**
```
🤖 テスト自動化計画を策定しています...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# テスト自動化戦略

## 1. 自動化スコープ
### 自動化対象（90%）
- Unit Test: 100%（全テストケース）
- Integration Test: 100%（全APIエンドポイント）
- E2E Test: 80%（重要フロー3シナリオ）

### 手動テスト対象（10%）
- UI/UX確認
- 探索的テスト
- アクセシビリティテスト

## 2. テストフレームワーク
- Unit/Integration: Vitest
- E2E: Playwright
- API: Supertest

## 3. CI/CD統合
### GitHub Actions ワークフロー

```yaml
name: Test

on:
  pull_request:
  push:
    branches: [main, develop]

jobs:
  unit-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm run test:unit
      - uses: codecov/codecov-action@v3

  integration-test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm run db:migrate
      - run: npm run test:integration

  e2e-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run test:e2e
```

## 4. カバレッジ目標
| レベル | 目標 | ゲート条件 |
|--------|------|-----------|
| 全体 | 80%+ | 75%未満でCI失敗 |
| Services | 90%+ | 85%未満でCI失敗 |
| Repositories | 80%+ | 75%未満でCI失敗 |
| API Routes | 70%+ | 65%未満でCI失敗 |

## 5. サンプルテストコード

### Unit Test例
```typescript
// tests/unit/services/point.service.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { PointService } from '@/services/point.service'
import { pointRepository } from '@/repositories/point.repository'

vi.mock('@/repositories/point.repository')

describe('PointService', () => {
  let service: PointService

  beforeEach(() => {
    service = new PointService()
    vi.clearAllMocks()
  })

  describe('earnPoints', () => {
    it('正常にポイントが付与される', async () => {
      const userId = 'user-123'
      const amount = 10000
      
      vi.mocked(pointRepository.create).mockResolvedValue({
        id: 'point-1',
        userId,
        amount: 100,
        type: 'EARN',
        createdAt: new Date(),
      })

      const result = await service.earnPoints(userId, amount)

      expect(result.amount).toBe(100)
      expect(pointRepository.create).toHaveBeenCalledWith({
        userId,
        amount: 100,
        type: 'EARN',
        description: '購入による付与',
      })
    })

    it('負の金額でエラー', async () => {
      await expect(
        service.earnPoints('user-123', -1000)
      ).rejects.toThrow('金額は0以上である必要があります')
    })
  })
})
```

### Integration Test例
```typescript
// tests/integration/api/points.test.ts
import { describe, it, expect } from 'vitest'
import { POST } from '@/app/api/points/earn/route'
import { prisma } from '@/lib/db'

describe('POST /api/points/earn', () => {
  it('ポイントを付与できる', async () => {
    const request = new Request('http://localhost/api/points/earn', {
      method: 'POST',
      body: JSON.stringify({ amount: 5000 }),
      headers: { 'Content-Type': 'application/json' },
    })

    const response = await POST(request)
    const data = await response.json()

    expect(response.status).toBe(200)
    expect(data.points).toBe(50)
  })
})
```

### E2E Test例
```typescript
// tests/e2e/point-flow.spec.ts
import { test, expect } from '@playwright/test'

test('ポイント付与→利用フロー', async ({ page }) => {
  // ログイン
  await page.goto('/login')
  await page.fill('input[name="email"]', 'test@example.com')
  await page.fill('input[name="password"]', 'password')
  await page.click('button[type="submit"]')

  // 商品購入
  await page.goto('/products/1')
  await page.click('button:has-text("購入")')
  
  // ポイント付与確認
  await page.goto('/points')
  await expect(page.locator('text=100ポイント獲得')).toBeVisible()

  // ポイント利用
  await page.goto('/checkout')
  await page.check('input[name="usePoints"]')
  await page.fill('input[name="pointsToUse"]', '50')
  await page.click('button:has-text("決済")')

  // 残高確認
  await expect(page.locator('text=残高: 50pt')).toBeVisible()
})
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 automation_plan.md を生成しました
📄 ci_cd_integration.yaml を生成しました
📁 sample_test_code/ を生成しました

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ テスト計画作成が完了しました！

【生成ファイル】
1. test_plan.md               ← テスト計画書
2. test_cases.md              ← テストケース一覧（35件）
3. automation_strategy.md     ← 自動化戦略
4. ci_cd_integration.yaml     ← CI/CD設定
5. sample_test_code/          ← サンプルテストコード

【テストサマリ】
- Unit Test: 20件（自動化100%）
- Integration Test: 12件（自動化100%）
- E2E Test: 3件（自動化100%）
- カバレッジ目標: 80%+

【次のステップ】
- テスト実装開始
- CI/CDパイプラインへの組み込み
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## ✅ 完了条件チェックリスト

- [ ] テスト対象が網羅的に洗い出されている
- [ ] リスクベースで優先度付けされている
- [ ] テストケースが等価分割・境界値分析で作成されている
- [ ] 期待結果が明確に定義されている
- [ ] 自動化戦略が策定されている
- [ ] CI/CD統合設計が完了している
- [ ] カバレッジ目標が設定されている
- [ ] レビューが完了し承認されている

---

## 📊 テストケーステンプレート

```markdown
## テストケース: [TC-XXX]

| 項目 | 内容 |
|------|------|
| テストID | TC-XXX |
| テスト名 | [テスト名] |
| 優先度 | P0/P1/P2 |
| テストレベル | Unit/Integration/E2E |
| テストタイプ | 正常系/異常系/境界値 |
| 前提条件 | [前提条件] |
| 入力 | [入力値] |
| 期待結果 | [期待する出力・動作] |
| 自動化 | Yes/No |
| 備考 | [その他の情報] |
```

---

## 🎯 テスト観点チェックリスト

### 機能正確性
- [ ] 正常系が正しく動作するか
- [ ] エッジケースが考慮されているか
- [ ] エラーハンドリングが適切か

### セキュリティ
- [ ] 認証・認可が適切か
- [ ] 入力値検証が行われているか
- [ ] 機密情報が漏洩しないか

### パフォーマンス
- [ ] レスポンスタイムが要件を満たすか
- [ ] 同時実行時の挙動が適切か
- [ ] リソース使用量が適切か

### 可用性
- [ ] エラー時のリカバリが適切か
- [ ] タイムアウト処理が適切か

---

## 🔗 関連テンプレート

- [CMD_dv_10_DesignDoc作成](./CMD_dv_10_DesignDoc作成.md)
- [CMD_sys_06_テスト設計](../system_building_templates/CMD_sys_06_テスト設計.md)
- [CMD_dv_12_コードレビューチェックリスト](./CMD_dv_12_コードレビューチェックリスト.md)

---

## 📊 所要時間の目安

| フェーズ | 自動 | HITL | 合計 |
|---------|------|------|------|
| Phase 1 | 15分 | - | 15分 |
| HITL-1 | - | 5分 | 5分 |
| Phase 2 | 30分 | - | 30分 |
| HITL-2 | - | 10分 | 10分 |
| Phase 3 | 20分 | - | 20分 |
| **合計** | **65分** | **15分** | **80分** |

---

**作成日**: 2026-01-29
**カテゴリ**: 開発AX（Developer Experience）
**タスクタイプ**: testing
**関連Role**: role_qa_engineer, role_software_architect
