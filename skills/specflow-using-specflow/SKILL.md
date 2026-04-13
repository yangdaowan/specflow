---
name: specflow-using-specflow
description: Use when you want Superpowers to follow SpecFlow (spec-as-source-of-truth) — chooses lightweight vs full-flow gates, defines required artifacts and role commands
---

# SpecFlow for Superpowers (总览与分流)

## 核心定义

**SpecFlow = 以仓库内结构化文档为唯一事实来源（Single Source of Truth），用验收清单与 TDD 驱动实现，并在完工时归档与更新记忆。**

Superpowers 提供“纪律/流程门禁”，SpecFlow 提供“做什么/做到什么标准”。本技能负责把 SpecFlow 的标准嵌入 Superpowers 的执行方式里。

## 何时使用

当用户表达以下任一意图时使用：
- 需要“可控、可追踪、可长期维护”的 AI 协作开发
- 希望以 `SPEC.md` / `ACCEPTANCE.md` 约束 AI 行为
- 需要明确的验收与归档闭环

## 两条轨道（强制分流，降低小任务成本）

### 轨道 A：轻量 SpecFlow（Small Task）

**适用：** 小改动、单文件脚本、一次性工具、探索性验证。

**门禁（最小集合）：**
- 仍然要写 **ACCEPTANCE（最小验收点）**：可在 PR 描述或单个 `ACCEPTANCE.md` 中，3-8 条即可
- 允许跳过完整 PRD/宪法/规则体系
- 允许更短的 TDD 循环（至少 1 条回归测试或可复现步骤）

**产出物（最小）：**
- `.specflow/specs/active/<feature>/ACCEPTANCE.md`（可选 `SPEC.md`）
- 或者：在现有任务描述中列出等价验收清单，并在最终回执中逐条对照

### 轨道 B：完整 SpecFlow（Product / Long-term）

**适用：** 需要长期维护、多人协作、明确交付标准的项目。

**门禁（完整集合）：**
- 文档体系为唯一事实来源
- 开发前必须对齐：`.specflow/CONSTITUTION.md`、`.specflow/RULES.md`、当前功能 `SPEC.md` + `ACCEPTANCE.md`
- 实施必须遵循 TDD（写测试→见红→最小实现→见绿→重构）
- 验收通过后必须：归档 + 完工报告 + memory 更新

**产出物（完整）：**
- `.specflow/AGENTS.md`、`.specflow/CONSTITUTION.md`、`.specflow/RULES.md`
- `.specflow/docs/PRD.md`、`.specflow/docs/NFR.md`
- `.specflow/specs/active/<feature>/SPEC.md`、`.specflow/specs/active/<feature>/ACCEPTANCE.md`
- 完工后：`.specflow/specs/archive/<feature>/...` + `COMPLETION_REPORT.md`
- `.specflow/memory/progress.md`、`.specflow/memory/active_context.md`、`.specflow/memory/decisions.md`

## 角色口令（跨工具一致）

在对话中识别并遵循以下角色切换语义（不依赖具体平台实现）：
- `/pm`：产出/维护 PRD、SPEC、ACCEPTANCE
- `/ar`：产出实施计划、测试、代码，严格对齐规则与验收
- `/qa`：对照验收执行验证，产出报告，归档与更新 memory

## 接下来该用哪个技能（本技能的出口）

根据目标选择下一个 SpecFlow 技能：
- **初始化/改造项目文档体系**：使用 `specflow-initialize-project`
- **为某功能写 SPEC + 验收清单**：使用 `specflow-write-spec-and-acceptance`
- **按 SPEC 实施（含 TDD 与验收对照）**：使用 `specflow-implement-from-spec`
- **验收、归档、记忆更新**：使用 `specflow-acceptance-and-archive`

