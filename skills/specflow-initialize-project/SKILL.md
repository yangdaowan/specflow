---
name: specflow-initialize-project
description: Use when a repo needs SpecFlow `.specflow/` structure and core docs initialized or repaired (new project or retrofit)
---

# SpecFlow 初始化 / 现有项目改造

## 目标

在仓库中建立 SpecFlow 的“唯一事实来源”文档体系（统一迁移到 `.specflow/` 中枢目录），使后续所有 AI 行为都能被 **文档约束**、被 **验收清单验证**、并能在完工时 **归档与更新记忆**。

## 前置规则

- **文档是指令**：人类对文档的任何修改，自动视为最新指令；后续行为必须重新对齐
- **不允许空泛占位**：不得写 “TODO / TBD / 之后补充 / 适当处理边界情况”
- **先结构，后内容**：先把目录与模板落地，再逐步补全内容

## 初始化动作（完整 SpecFlow）

### 1) 创建目录（若已存在则保持，不重排）

必须存在：

```text
.specflow/
.specflow/docs/
.specflow/specs/active/
.specflow/specs/archive/
.specflow/memory/
.specflow/scripts/
.specflow/templates/
```

### 2) 创建核心文档（若不存在）

根目录：
- `.specflow/AGENTS.md`（AI 行为准则 + 文档变更对齐机制 + 模式开关语义）
- `.specflow/CONSTITUTION.md`（不可变最高原则：安全、正确性、质量底线）
- `.specflow/RULES.md`（技术约束：分层、Schema、状态机、测试策略等）

`.specflow/docs/`：
- `.specflow/docs/PRD.md`（产品全景图，面向需求拆解）
- `.specflow/docs/NFR.md`（性能/安全/可观测性/可用性/扩展性指标）
- `.specflow/docs/DESIGN.md`（UI/UX 设计基线，约束视觉、组件、交互和响应式）

`.specflow/memory/`：
- `.specflow/memory/progress.md`（整体进度）
- `.specflow/memory/active_context.md`（当前聚焦点与待办）
- `.specflow/memory/decisions.md`（关键决策记录，ADR 风格亦可）

### 3) 写入模板（.specflow/templates）

创建/同步以下模板文件，后续写规格时直接复制：
- `.specflow/templates/AGENTS_TEMPLATE.md`
- `.specflow/templates/CONSTITUTION_TEMPLATE.md`
- `.specflow/templates/RULES_TEMPLATE.md`
- `.specflow/templates/PRD_TEMPLATE.md`
- `.specflow/templates/NFR_TEMPLATE.md`
- `.specflow/templates/DESIGN_TEMPLATE.md`
- `.specflow/templates/SPEC_TEMPLATE.md`
- `.specflow/templates/ACCEPTANCE_TEMPLATE.md`
- `.specflow/templates/INDEX_TEMPLATE.md`
- `.specflow/templates/COMPLETION_REPORT_TEMPLATE.md`
- `.specflow/templates/PROGRESS_TEMPLATE.md`
- `.specflow/templates/ACTIVE_CONTEXT_TEMPLATE.md`
- `.specflow/templates/DECISIONS_TEMPLATE.md`（可选）

模板要求：
- 必须包含：范围、非目标、接口/数据、边界与错误、可观测性、测试策略
- 验收模板必须是可逐条勾选的清单（每条可验证）

**标准件来源（强制优先）：**
- 本技能目录已内置模板：`skills/specflow-initialize-project/templates/`
- 初始化时应优先将内置模板复制到项目的 `.specflow/templates/`，以保证跨项目一致性

## 现有项目改造

当项目已有代码但缺文档时：
- 先扫描代码与现有 README / 配置，生成 `.specflow/docs/PRD.md / .specflow/CONSTITUTION.md / .specflow/RULES.md` 的**草稿**
- 让人类快速修正关键误解后，才开始写具体功能规格

## 退出条件（本技能完成的证据）

以下文件/目录在仓库内真实存在，且模板不含空泛占位词：
- 目录：`.specflow/docs/`, `.specflow/specs/active/`, `.specflow/specs/archive/`, `.specflow/memory/`, `.specflow/templates/`
- 文件：`.specflow/AGENTS.md`, `.specflow/CONSTITUTION.md`, `.specflow/RULES.md`, `.specflow/docs/PRD.md`, `.specflow/docs/NFR.md`
- 模板：`.specflow/templates/SPEC_TEMPLATE.md`, `.specflow/templates/ACCEPTANCE_TEMPLATE.md`, `.specflow/templates/INDEX_TEMPLATE.md`, `.specflow/templates/COMPLETION_REPORT_TEMPLATE.md`
- 设计：`.specflow/docs/DESIGN.md`（由 `.specflow/templates/DESIGN_TEMPLATE.md` 初始化）

## 下一步

初始化完成后，若进入功能交付流程：
- 先按 Superpowers `brainstorming` 完成设计确认，再使用 `specflow-write-spec-and-acceptance` 落地 .specflow 规格文档。

