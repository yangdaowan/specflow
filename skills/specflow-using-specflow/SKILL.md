---
name: specflow-using-specflow
description: Use when you need SpecFlow governance (scope, acceptance, archive, doc-change alignment) to complement Superpowers process skills in a repo
---

# SpecFlow for Superpowers (总览与分流)

## 核心定义

**SpecFlow = 以仓库内结构化文档为唯一事实来源（Single Source of Truth），用验收清单与 TDD 驱动实现，并在完工时归档与更新记忆。**

Superpowers 提供“纪律/流程门禁”，SpecFlow 提供“做什么/做到什么标准”。本技能负责把 SpecFlow 的标准嵌入 Superpowers 的执行方式里。

## 互补不冲突（强制规则）

本仓库的 SpecFlow 设计目标是 **补充** Superpowers，而不是替代或覆盖。为保证“绝对不冲突”，必须遵守：

### 1) 前置门禁：不绕过 Superpowers 的硬门禁

- 任何“新功能/行为变更/需求澄清”在进入实现前，必须先走 `brainstorming`（设计并获得人类认可）。
- 任何生产代码变更必须遵守 `test-driven-development`（先测试通过再写实现）。
- 在宣称“完成/通过/修复”之前必须走 `verification-before-completion`（新鲜证据）。

### 2) 双文档体系并存（不合并、不断言单一路径）

SpecFlow 与 Superpowers 的文档产物 **同时存在**，各司其职：

- `docs/superpowers/specs/**`：设计讨论与取舍（如何做、为什么这么做）
- `docs/superpowers/plans/**`：实施计划（按步骤怎么做）
- `.specflow/**`：规格治理与交付标准（做什么、做到什么算完成、如何验收与归档）

### 3) 阶段主文档（谁说了算）

当两套文档在某个点上出现表述差异时，按阶段决定“主判定来源”：

- **需求澄清/设计阶段**：以 `docs/superpowers/specs/**` 为主；但必须受 `.specflow/CONSTITUTION.md` / `.specflow/RULES.md` / `.specflow/docs/*` 约束
- **规格冻结（交付边界）阶段**：以 `.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md` 为主
- **实施阶段**：以 `docs/superpowers/plans/**` 为主，但不得越过 `.specflow/.../SPEC.md` 的 Non-Goals，且必须覆盖 `.specflow/.../ACCEPTANCE.md`
- **验收/归档阶段**：以 `.specflow/.../ACCEPTANCE.md` 为主（逐条有证据），并产出归档与 memory 更新

### 4) Feature 关联索引（强制）

为了让双文档体系长期可维护，每个 feature 必须维护一份索引文件：

- `.specflow/specs/active/<feature>/INDEX.md`

至少包含：
- 对应的 `docs/superpowers/specs/**`（设计文档路径）
- 对应的 `docs/superpowers/plans/**`（计划文档路径）
- SpecFlow 的 `SPEC.md` / `ACCEPTANCE.md`
- 当前阶段与主判定来源说明（简短即可）

### 5) 初始化硬门禁（强制，优先级高）

在任何 SpecFlow 语义已触发的会话里，必须先做以下检查：

- 若项目根目录不存在 `.specflow/`，或缺少以下关键文件：
  - `.specflow/CONSTITUTION.md`
  - `.specflow/RULES.md`
  - `.specflow/docs/PRD.md`
  - `.specflow/docs/NFR.md`
  - `.specflow/memory/progress.md`
- 则 **不得** 继续执行 SpecFlow 的写规格/实施/验收流程，必须先执行 `specflow-initialize-project`。

只有初始化完成后，才允许进入：
- `specflow-write-spec-and-acceptance`
- `specflow-implement-from-spec`
- `specflow-acceptance-and-archive`

### 6) 禁止错误映射（强制）

以下映射是错误行为，必须禁止：

- 把 `docs/superpowers/plans/**` 当作 `.specflow/docs/PRD.md`
- 把 `docs/superpowers/specs/**` 当作 `.specflow/specs/active/<feature>/SPEC.md`

规则：
- Superpowers 文档只作为“设计/计划过程文档”
- SpecFlow 文档必须真实落地在 `.specflow/**` 下（缺失就先初始化再生成）

### 7) 颗粒度分层（强制）

为保证互补而不是重叠，必须遵守以下颗粒度分层：

- **SpecFlow 颗粒度：功能点（Capability）**
  - 一个 `.specflow/specs/active/<feature>/` 对应一个可独立验收的业务功能点。
- **Superpowers 颗粒度：模块/任务执行**
  - `docs/superpowers/specs/**` 和 `docs/superpowers/plans/**` 可按模块、子模块、2-5 分钟任务拆解。

禁止：
- 用“模块级拆分”替代 SpecFlow 的 feature 能力边界
- 把一个 SpecFlow feature 写成跨多个独立功能点的“大杂烩”

### 8) 缺失规格恢复策略（强制）

当项目已有 `.specflow/` 与 PRD，但某次修改命中的 feature 缺少 `SPEC.md`/`ACCEPTANCE.md` 时，必须执行“按需补全”而非全量重建：

- **初始化阶段**：`specflow-initialize-project` 只修复项目级骨架与核心文档
- **功能/验收阶段**：若发现 feature 规格缺失，立即调用 `specflow-write-spec-and-acceptance` 进行最小补全
- **验收阶段**：`specflow-acceptance-and-archive` 先检查规格齐备性，不齐则先补后验收
- **可选巡检**：低频扫描 PRD feature 清单与 active specs 的差集，产出待补齐列表（报告即可，不阻塞当前任务）

### 9) 验收提交规则（强制）

- 每成功验收一个 `.specflow/specs/active/<feature>/`，必须立即执行一次 git 提交
- 提交信息必须使用简体中文，并遵循 Conventional Commits：`<type>(<scope>): <subject>`
- 不允许将多个 feature 的“验收归档”合并为一次提交

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

## 命令入口（统一）

在 Cursor 插件落地形态下，命令入口统一为 `/specflow ...`。

## Karpathy 四原则（作为执行风格约束层）

在不改变 SpecFlow + Superpowers 既有分工的前提下，默认叠加以下约束：

1) **Think Before Coding（先澄清再实现）**
- 有歧义先澄清，不允许静默假设后直接开工
- 若存在多种实现解释，先给出选项与取舍，再由人类确认

2) **Simplicity First（最小可行实现）**
- 只做本次需求与验收明确要求的内容
- 通过 `Non-Goals` 与验收清单共同抑制“提前抽象/提前扩展”

3) **Surgical Changes（手术式改动）**
- 改动范围仅覆盖本次目标，不做顺手重构与风格漂移
- 每一处改动都必须能追溯到 SPEC/ACCEPTANCE 的某条要求

4) **Goal-Driven Execution（目标驱动执行）**
- 将任务写成“步骤 -> 验证”的闭环
- 无验证证据不允许给出“完成/已修复”结论

## 接下来该用哪个技能（本技能的出口）

根据目标选择下一个 SpecFlow 技能：
- **初始化/改造项目文档体系**：使用 `specflow-initialize-project`
- **为某功能写 SPEC + 验收清单**：使用 `specflow-write-spec-and-acceptance`
- **按 SPEC 实施（含 TDD 与验收对照）**：使用 `specflow-implement-from-spec`
- **验收、归档、记忆更新**：使用 `specflow-acceptance-and-archive`

