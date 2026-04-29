---
name: specflow-initialize-project
description: 当仓库需要初始化或修复 SpecFlow 的 `.specflow/` 目录结构和核心文档时使用（新项目或改造）
---

# SpecFlow 初始化 / 项目改造

## 目标

建立 `.specflow/` 文档中枢，使 AI 行为受文档约束、验收清单验证、完工时归档可更新记忆。

## 职责边界

- 只负责**项目级骨架**初始化/修复
- feature 级规格缺失在功能入口/验收入口按需触发（`specflow-write-spec-and-acceptance`）
- 禁止全项目代码深扫推断全部 feature

## 前置规则

- 文档即指令；人类修改文档视为最新 AI 指令
- 不得写 "TODO / TBD / 之后补充"
- 优先复用已有 `/docs`（如存在）填充 PRD/NFR

## 初始化步骤

### 1) 创建目录

```
.specflow/  .specflow/docs/  .specflow/specs/active/  .specflow/specs/archive/
.specflow/pm-docs/  .specflow/pm-docs/archive/  .specflow/deliverables/
.specflow/memory/  .specflow/scripts/  .specflow/templates/
```

### 2) 创建核心文档

- `.specflow/SPECFLOW.md` — 合并 AGENTS/CONSTITUTION/RULES 的单一事实来源
- `.specflow/docs/PRD.md` — 产品全景图
- `.specflow/docs/NFR.md` — 非功能性需求
- `.specflow/docs/DESIGN.md` — UI/UX 设计基线
- `.specflow/memory/progress.md`、`active_context.md`、`decisions.md`

**填充规则**：若项目存在 `/docs/`，优先从中提取 PRD/NFR（候选：`docs/PRD.md`、`docs/product.md`），仅无匹配时用模板。

### 3) 复制模板

将 `skills/specflow-initialize-project/templates/` 下所有模板复制到 `.specflow/templates/`。涵盖：核心模板（SPEC/ACCEPTANCE/PRD 等 14 个）、PM 模板（2 个）、GB/T 8567 模板（7 个）、Git Hook 模板（2 个）。

### 4) 安装 Git post-commit Hook

若 `.git/hooks/` 存在：复制 `.specflow/scripts/post-commit` → `.git/hooks/post-commit`，执行 `chmod +x`（Unix）或使用 `.ps1` 版本（PowerShell）。功能：检测 commit 中 `.specflow/pm-docs/**` 和 `.specflow/specs/**` 变更 → 写入 `.sync-trigger.json`。若项目非 Git，跳过并提示手动 `/specflow sync`。

### 5) 代码库扫描提炼

对于已有代码的存量项目，做只读扫描写入 `SPECFLOW.md`：目录结构、数据库/字段约定、配置环境、鉴权/权限、日志/可观测性、错误处理、i18n、前端组件库。写"事实 + 文件路径"，不确定点标记"待确认"。

### 6) 旧文件迁移

删除旧文件 `.specflow/AGENTS.md`、`.specflow/CONSTITUTION.md`、`.specflow/RULES.md`，有价值内容合并进 `SPECFLOW.md`。

## 退出条件

以上目录和核心文件全部真实存在，模板不含空泛占位词。

## 下一步

初始化完成 → Superpowers `brainstorming`（如有）→ `specflow-write-spec-and-acceptance`