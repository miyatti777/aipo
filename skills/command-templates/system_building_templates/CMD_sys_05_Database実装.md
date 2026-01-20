# CMD_sys_05_Database実装

最終更新日時: 2025年12月25日 9:06

# 05_Database実装 - Notion Database構築テンプレート

<aside>
🗄️

**このテンプレートの目的**

NotionのDatabase機能を使って、データ構造・状態管理・ビジネスロジックを持つ「動くDB」を実装します。

単なるデータ保存ではなく、リレーション・Formula・Viewにより実行可能なシステムを構築します。

</aside>

---

## 📋 適用対象タスク

**タスクタイプ**: `implementation`

**該当するタスク名の例**:

- "○○DBの作成"
- "データ構造設計・実装"
- "○○管理システムの実装"
- "リレーション設計"

---

## 🎯 完了条件

<aside>
✅

**必須成果物**

1. **実在するDatabase** - 実際に作成されたNotionのDatabase
2. **完全なプロパティ設計** - 全プロパティ（型・必須・デフォルト値）が設定済み
3. **複数のView** - 用途別に2つ以上のView（Table/Board/Calendar等）
4. **サンプルデータ** - 最低3件の実データ登録済み
5. **運用ドキュメント** - DB設計書・運用ガイド
</aside>

---

## 📝 実行フロー（5 Phase）

### Phase 1: 要件確認・DB設計（10分）

**目的**: 何を管理するDBか、どんなプロパティが必要かを明確化

**実行内容**:

```yaml
確認事項:
  - 管理対象: 何を管理するDBか？（記事/タスク/メンバー/イベント等）
  - 必須プロパティ: 絶対に必要な項目は？
  - リレーション: 他のDBと関連付けが必要か？
  - ステータス管理: 状態遷移が必要か？（例: 未着手→進行中→完了）
  - 集計・計算: Formulaで自動計算する項目は？

設計書作成:
  - プロパティ一覧表（名前/型/必須/説明）
  - リレーション図（他DBとの関係）
  - View設計（何のためのViewか）
```

**チェックポイント**:

- [ ]  管理対象が明確に定義されている
- [ ]  プロパティ一覧が完成している
- [ ]  リレーションが必要な場合、対象DBが特定されている

---

### Phase 2: Database作成・プロパティ設定（15分）

**目的**: 実際にNotionでDatabaseを作成し、全プロパティを設定

**実行内容**:

```yaml
Database作成:
  tool: create-database
  設定項目:
    - Database名
    - アイコン
    - 説明文
    
プロパティ設定:
  基本プロパティ:
    - Title（必須）
    - Text（説明・メモ等）
    - Number（数値管理）
    - Date（期限・日時）
    - Checkbox（フラグ管理）
    
  選択系プロパティ:
    - Select（単一選択）
    - Multi-select（複数選択）
    - Status（ステータス遷移）
    
  関連系プロパティ:
    - Person（担当者）
    - Relation（他DBとの関連）
    - Rollup（関連DBから集計）
    
  計算系プロパティ:
    - Formula（自動計算・条件分岐）
```

**Notion公式ドキュメント参照**:

- Database: [https://www.notion.com/ja/help/intro-to-databases](https://www.notion.com/ja/help/intro-to-databases)
- Properties: [https://www.notion.com/ja/help/database-properties](https://www.notion.com/ja/help/database-properties)

**チェックポイント**:

- [ ]  Databaseが実際に作成されている
- [ ]  設計書の全プロパティが設定済み
- [ ]  Formula/Rollupが正しく動作する

---

### Phase 3: View作成・表示設計（15分）

**目的**: 用途別のViewを作成し、Filter/Sort/Groupを設定

**実行内容**:

```yaml
View設計:
  
  1. Table View（一覧管理用）:
    - 全プロパティ表示
    - Sort: 優先度/締切順
    - Filter: 不要
    
  2. Board View（ステータス管理用）:
    - Group by: Status
    - Filter: 完了済み以外
    - Card表示項目: 担当者、締切
    
  3. Calendar View（日時管理用）:
    - Date property: 締切
    - Filter: 未完了のみ
    
  4. Gallery View（カード一覧用）:
    - Card size: Medium
    - 表示項目: タイトル、説明、画像
    
  5. List View（シンプル一覧用）:
    - 最小限の表示
    - Filter: 特定条件
```

**チェックポイント**:

- [ ]  2つ以上のViewが作成されている
- [ ]  各Viewに適切なFilter/Sort/Groupが設定されている
- [ ]  Viewの用途が明確に定義されている

---

### Phase 4: サンプルデータ登録・動作確認（10分）

**目的**: 実データを登録してDBが正しく動作することを確認

**実行内容**:

```yaml
サンプルデータ作成:
  tool: create-pages
  parentDataSourceUrl: [作成したDBのdata-source URL]
  
  最低3件:
    - 標準ケース（典型的なデータ）
    - エッジケース（極端な値）
    - 空データ（最小限の入力）

動作確認:
  - [ ] Formulaが正しく計算されるか
  - [ ] Relationが正しくリンクされるか
  - [ ] Rollupが正しく集計されるか
  - [ ] Viewのフィルタが正しく動作するか
  - [ ] ステータス遷移が正しく動作するか
```

**チェックポイント**:

- [ ]  最低3件のサンプルデータが登録済み
- [ ]  全プロパティが正しく動作する
- [ ]  Viewで意図した表示がされている

---

### Phase 5: ドキュメント整備・運用ガイド作成（10分）

**目的**: DB設計書と運用ガイドを作成し、誰でも使える状態にする

**実行内容**:

```yaml
DB設計書:
  内容:
    - Database概要（何を管理するDBか）
    - プロパティ一覧表（名前/型/説明/必須）
    - リレーション図（他DBとの関係）
    - View一覧（名前/用途/Filter/Sort）
    - Formula/Rollup定義（計算式の説明）

運用ガイド:
  内容:
    - データ入力方法（Form/手動入力）
    - 各Viewの使い分け
    - ステータス更新ルール（状態遷移のタイミング）
    - 検索・フィルタ方法
    - よくある問題と対処法
```

**チェックポイント**:

- [ ]  DB設計書が完成している
- [ ]  運用ガイドが完成している
- [ ]  他のメンバーが使える状態になっている

---

## 🔗 関連テンプレート

- **06_Form・入力UI実装** - このDBへの入力フォームを作成
- **07_AI処理ロジック実装** - このDBを使ったAI処理を実装
- **04_Wiki構築** - このDBの使い方をWikiで公開

---

## 📚 参考リソース

### Notion公式ドキュメント

- Database入門: [https://www.notion.com/ja/help/intro-to-databases](https://www.notion.com/ja/help/intro-to-databases)
- Properties: [https://www.notion.com/ja/help/database-properties](https://www.notion.com/ja/help/database-properties)
- Formula: [https://www.notion.com/ja/help/formulas](https://www.notion.com/ja/help/formulas)
- Relations & Rollups: [https://www.notion.com/ja/help/relations-and-rollups](https://www.notion.com/ja/help/relations-and-rollups)

### 内部リソース

- [CTX_abstract_mode_rules](../../abstract-mode.md) - Notion実装ガイド
- [CTX_execution_rules](../../execution-rules.md) - 実行ルール

---

**作成日**: 2025-12-07

**カテゴリ**: システム構築

**タスクタイプ**: implementation