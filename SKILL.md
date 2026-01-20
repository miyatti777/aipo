---
name: aipo
version: 1.0.0
description: "AI Product Owner - GOALだけ伝えればAIが勝手に仕事を進める汎用問題解決システム"
author: miyatti (@miyatti)
author_url: https://x.com/miyatti
license: MIT
repository: https://github.com/miyatti777/aipo
keywords:
  - product-owner
  - task-decomposition
  - project-management
  - dual-track-agile
  - automation
---

# AIPO (AI Product Owner)

> **「GOALだけ伝えれば、AIが勝手に仕事を進めてくれる」**

## 概要

AIPOは、Jeff Pattonが定義するプロダクトオーナーの思考プロセス **Sense → Focus → Discover → Deliver** をAIが再現する汎用問題解決システムです。

## 特徴

- **PO思考の再現**: Sense/Focus/Discover/Deliverサイクルの自動実行
- **再帰的分解**: どの階層も同じパターンで分解（フラクタル構造）
- **コンテキスト継承**: 親から子へ文脈を継承、途中で忘れない
- **HITL協働**: Human In The Loopで人間と協働

## 5つのコマンド

| コマンド | 役割 |
|----------|------|
| `/aipo/01_sense` | Goal設定・コンテキスト収集 |
| `/aipo/02_focus` | 調査とGoal分解 |
| `/aipo/03_discover` | 計画・コマンド生成 |
| `/aipo/04_deliver` | タスク実行・成果物生成 |
| `/aipo/05_operation` | 運用コマンド実行 |

## インストール

```bash
# Cursor用
./install.sh .cursor

# Claude Code用
./install.sh .claude
```

## 使い方

```
/aipo/01_sense を実行してください

Goal: [あなたのゴール]
```

## 詳細

詳細は [README.md](README.md) を参照してください。
