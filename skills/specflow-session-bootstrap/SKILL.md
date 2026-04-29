---
name: specflow-session-bootstrap
description: 会话启动时自动注入 — 建立 SpecFlow 与 Superpowers 的共存规则和初始化硬门禁
---

# SpecFlow 会话引导

## 用途

会话启动时注入的最小引导技能，必须保持简短。

## 硬门禁

### 1) 初始化检查

若项目缺少 `.specflow/` 或以下任一文件：`.specflow/SPECFLOW.md`、`.specflow/docs/PRD.md`、`.specflow/docs/NFR.md`、`.specflow/memory/progress.md` → **停止**，先运行 `specflow-initialize-project`。

### 2) 禁止错误映射

- `docs/superpowers/specs/**` 不是 `.specflow/specs/active/**/SPEC.md`
- `docs/superpowers/plans/**` 不是 `.specflow/docs/PRD.md`

Superpowers 文档 = 设计/计划过程。SpecFlow 文档 = 交付规格、验收、归档。

## 共存规则（互补模式）

- Superpowers = 流程纪律（头脑风暴 → 计划 → TDD → 验证）
- SpecFlow = 范围/验收/归档治理（交付什么、怎样算完成）
- 两者同时安装 → 同时使用，不互相替代

## 同步触发

若上下文中包含 `--- SYNC TRIGGER DETECTED ---`：
1. 读取 `direction`：`doc-to-code`（PM 改了文档）或 `code-to-doc`（代码变更）
2. 在任何其他操作前先运行 `specflow-pm-doc-sync`
3. 按同步回执的下一步指引继续

## 技能索引

| 技能 | 使用场景 |
|------|----------|
| `specflow-using-specflow` | 需要完整概览和规则 |
| `specflow-initialize-project` | `.specflow/` 缺失或损坏 |
| `specflow-write-spec-and-acceptance` | 新功能，需要 SPEC/ACCEPTANCE + PM 文档 |
| `specflow-pm-doc-sync` | 文档和代码不同步 |
| `specflow-implement-from-spec` | SPEC 就绪，开始 TDD 实现 |
| `specflow-document-alignment` | `.specflow/**` 文档变更 |
| `specflow-acceptance-and-archive` | 功能完成，准备闭环 |
| `specflow-generate-deliverables` | 需要 GB/T 8567 正式文档（`/specflow deliverables`） |

## 默认工作流

```
初始化（如需要）→ 头脑风暴 → 写 SPEC + PM 文档 → 计划 → 实现（TDD）
  → [如文档/代码漂移则同步] → 验收 → 归档 → [如需要则生成正式文档]
```
