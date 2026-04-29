---
name: specflow-using-specflow
description: 当需要 SpecFlow 治理（范围、验收、归档、文档变更对齐）来补充 Superpowers 流程技能时使用
---

# SpecFlow 总览与分流

## 核心定义

**SpecFlow = 以仓库内结构化文档为唯一事实来源，用验收清单 + TDD 驱动实现，并在完工时归档与更新记忆。** Superpowers 提供"怎么执行"，SpecFlow 提供"做什么/做到什么标准"。

## 三轨分流

### 轨道 A：轻量（个人项目 / 小任务）
- 只需 `ACCEPTANCE.md`（3-8 条可验证验收项）
- 允许跳过完整 PRD 和完整 SPEC
- 至少 1 条回归测试或可复现验证步骤

### 轨道 B：完整（团队 / 长期维护）
- 完整文档体系 + TDD + 验收归档 + memory 更新
- 三层文档：PM 文档（`.specflow/pm-docs/`）→ 技术规格（`.specflow/specs/`）→ 交付文档（`.specflow/deliverables/`，手动触发）

## 核心规则（5 条）

### 1) Superpowers 前置门禁
实现前必须走 `brainstorming`（设计澄清），代码变更前必须走 `test-driven-development`，完成声明前必须走 `verification-before-completion`。

### 2) 双文档体系，各司其职
- `docs/superpowers/specs/**` = 设计过程（如何做、为什么）
- `docs/superpowers/plans/**` = 实施计划（分步执行）
- `.specflow/**` = 交付治理（做什么、验收标准、归档）

禁止将 Superpowers 文档当作 SpecFlow 的 SPEC/PRD 使用。

### 3) 按阶段判定主文档
| 阶段 | 主判定来源 | 约束 |
|------|-----------|------|
| 需求/设计 | Superpowers specs | 受 `.specflow/docs/*` 约束 |
| 规格冻结 | `.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md` | 不可变交付边界 |
| 实施 | Superpowers plans | 不越 SPEC Non-Goals，必须覆盖 ACCEPTANCE |
| 验收/归档 | `.specflow/.../ACCEPTANCE.md` | 逐条有证据 |

### 4) 颗粒度隔离
- SpecFlow feature = 一个可独立验收的业务能力（kebab-case 命名）
- Superpowers 可按模块/子任务拆解
- 禁止将多独立功能点合并为一个 feature

### 5) 缺失补全 + 验收提交
- feature 缺 SPEC/ACCEPTANCE → `specflow-write-spec-and-acceptance` 最小补全
- 每验收归档一个 feature → 立即 git commit（简体中文 Conventional Commits）

## 何时使用

用户表达以下意图时触发：需要可控可追踪的 AI 协作、希望用 SPEC/ACCEPTANCE 约束 AI、需要明确的验收归档闭环。

## 技能出口

- 初始化 → `specflow-initialize-project`
- 写规格 → `specflow-write-spec-and-acceptance`
- 双向同步 → `specflow-pm-doc-sync`
- 实施 → `specflow-implement-from-spec`
- 文档对齐 → `specflow-document-alignment`
- 验收归档 → `specflow-acceptance-and-archive`
- 正式文档 → `/specflow deliverables <name>`（手动）
