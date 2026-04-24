---
name: specflow-initialize-project
description: Use when a repo needs SpecFlow `.specflow/` structure and core docs initialized or repaired (new project or retrofit)
---

# SpecFlow 初始化 / 现有项目改造

## 目标

在仓库中建立 SpecFlow 的“唯一事实来源”文档体系（统一迁移到 `.specflow/` 中枢目录），使后续所有 AI 行为都能被 **文档约束**、被 **验收清单验证**、并能在完工时 **归档与更新记忆**。

## 职责边界（强制）

- `specflow-initialize-project` 只负责“项目级骨架初始化/修复”，不负责把所有 feature 自动还原为 `.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md`
- feature 级规格缺失的补齐，必须在功能入口/验收入口按需触发（见 `specflow-write-spec-and-acceptance` 与 `specflow-acceptance-and-archive`）
- 禁止在初始化阶段强制全项目代码深扫来推断全部 feature（成本高、噪音大、误判率高）

## 前置规则

- **文档是指令**：人类对文档的任何修改，自动视为最新指令；后续行为必须重新对齐
- **不允许空泛占位**：不得写 “TODO / TBD / 之后补充 / 适当处理边界情况”
- **先结构，后内容**：先把目录与模板落地，再逐步补全内容
- **优先复用已有 docs**：若项目已有 `/docs`（手写或 Superpowers 产物），初始化必须优先用其内容填充 `.specflow/docs/PRD.md` 与 `.specflow/docs/NFR.md`，而不是产出空白模板

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
- `.specflow/SPECFLOW.md`（单一事实来源：合并并替代 AGENTS/CONSTITUTION/RULES）

`.specflow/docs/`：
- `.specflow/docs/PRD.md`（产品全景图，面向需求拆解）
- `.specflow/docs/NFR.md`（性能/安全/可观测性/可用性/扩展性指标）
- `.specflow/docs/DESIGN.md`（UI/UX 设计基线，约束视觉、组件、交互和响应式）

**填充规则（强制，避免空模板）：**
- 若项目根目录存在 `/docs/`，则初始化时必须先尝试从 `/docs` 填充 PRD/NFR：
  - PRD 候选：`docs/PRD.md`, `docs/prd.md`, `docs/product.md`
  - NFR 候选：`docs/NFR.md`, `docs/nfr.md`, `docs/non-functional.md`
- 若存在多个候选：优先选择“最近修改时间”的文件。
- 将选中的源文档内容写入 `.specflow/docs/PRD.md` / `.specflow/docs/NFR.md`，并在文件顶部追加一行来源标记：
  - `> Source: <relative-path>, synced on YYYY-MM-DD`
- 若 `/docs` 不存在或未找到候选：才使用模板内容初始化。

`.specflow/memory/`：
- `.specflow/memory/progress.md`（整体进度）
- `.specflow/memory/active_context.md`（当前聚焦点与待办）
- `.specflow/memory/decisions.md`（关键决策记录，ADR 风格亦可）

### 3) 写入模板（.specflow/templates）

创建/同步以下模板文件，后续写规格时直接复制：
- `.specflow/templates/SPECFLOW_TEMPLATE.md`
- `.specflow/templates/PRD_TEMPLATE.md`
- `.specflow/templates/NFR_TEMPLATE.md`
- `.specflow/templates/DESIGN_TEMPLATE.md`
- `.specflow/templates/SPEC_TEMPLATE.md`
- `.specflow/templates/ACCEPTANCE_TEMPLATE.md`
- `.specflow/templates/INDEX_TEMPLATE.md`
- `.specflow/templates/COMPLETION_REPORT_TEMPLATE.md`
- `.specflow/templates/REVIEW_TEMPLATE.md`
- `.specflow/templates/STATUS_TEMPLATE.json`
- `.specflow/templates/EVIDENCE_TEMPLATE.md`
- `.specflow/templates/PROGRESS_TEMPLATE.md`
- `.specflow/templates/ACTIVE_CONTEXT_TEMPLATE.md`
- `.specflow/templates/DECISIONS_TEMPLATE.md`（可选）

模板要求：
- 必须包含：范围、非目标、接口/数据、边界与错误、可观测性、测试策略
- 验收模板必须是可逐条勾选的清单（每条可验证）

**标准件来源（强制优先）：**
- 本技能目录已内置模板：`skills/specflow-initialize-project/templates/`
- 初始化时应优先将内置模板复制到项目的 `.specflow/templates/`，以保证跨项目一致性

## 旧文件迁移与删除（强制）

若项目中已存在以下旧文件（来自早期 SpecFlow 版本），必须迁移要点并删除，避免“多事实来源”：
- `.specflow/AGENTS.md`
- `.specflow/CONSTITUTION.md`
- `.specflow/RULES.md`

迁移规则：
- 将旧文件中的“有价值且不冲突内容”合并进 `.specflow/SPECFLOW.md`
- 旧文件最终应删除（不保留薄壳重定向）

## 现有项目改造

当项目已有代码但缺文档时：
- 先扫描代码与现有 README / 配置，生成 `.specflow/docs/PRD.md / .specflow/SPECFLOW.md` 的**草稿**
- 让人类快速修正关键误解后，才开始写具体功能规格

### 代码库扫描提炼（强制，写入 SPECFLOW.md）

为避免 `SPECFLOW.md` 变成空模板，在 `init`（尤其是现有项目）时必须做一次只读扫描，提炼“项目现状/基础设施/约定”。至少覆盖：

- **目录结构与模块边界**：`src/`, `apps/`, `packages/`（若存在）
- **数据库与通用字段约定**：migrations/schema/ORM models（常见字段：`id`, `created_at`, `updated_at`, `deleted_at`, `tenant_id` 等）
- **配置与环境**：`.env*`, config files, build scripts
- **鉴权/权限**：middleware/guards/auth modules
- **日志/可观测性**：logger wrapper、日志字段约定、trace_id 传递
- **错误处理**：统一错误类型/错误码/错误页/异常捕获
- **i18n**：是否存在多语言框架与 key 约定
- **前端组件库**：是否使用 Ant Design / Tailwind / shadcn 等；若存在，写入“组件复用优先”约束

输出要求（写入 `.specflow/SPECFLOW.md` 的“项目基础设施现状”与“技术约定”）：
- 写“当前观察到的事实 + 文件证据路径”（用相对路径）
- 对不确定点显式标记“待确认”，但禁止留空

补充约束（避免职责漂移）：
- 可从历史文档恢复“项目级全景”（如 PRD/NFR），但不要求一次性恢复每个 feature 的 `SPEC.md`/`ACCEPTANCE.md`
- 若用户随后进入“某功能实施/验收”，再按该 feature 即时补齐规格文档

## 退出条件（本技能完成的证据）

以下文件/目录在仓库内真实存在，且模板不含空泛占位词：
- 目录：`.specflow/docs/`, `.specflow/specs/active/`, `.specflow/specs/archive/`, `.specflow/memory/`, `.specflow/templates/`
- 文件：`.specflow/SPECFLOW.md`, `.specflow/docs/PRD.md`, `.specflow/docs/NFR.md`
- 模板：`.specflow/templates/SPECFLOW_TEMPLATE.md`, `.specflow/templates/SPEC_TEMPLATE.md`, `.specflow/templates/ACCEPTANCE_TEMPLATE.md`, `.specflow/templates/INDEX_TEMPLATE.md`, `.specflow/templates/COMPLETION_REPORT_TEMPLATE.md`, `.specflow/templates/REVIEW_TEMPLATE.md`, `.specflow/templates/STATUS_TEMPLATE.json`, `.specflow/templates/EVIDENCE_TEMPLATE.md`
- 设计：`.specflow/docs/DESIGN.md`（由 `.specflow/templates/DESIGN_TEMPLATE.md` 初始化）

## 下一步

初始化完成后，若进入功能交付流程：
- 先按 Superpowers `brainstorming` 完成设计确认，再使用 `specflow-write-spec-and-acceptance` 落地 .specflow 规格文档。

