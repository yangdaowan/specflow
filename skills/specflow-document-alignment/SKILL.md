---
name: specflow-document-alignment
description: Use when `.specflow/**` docs changed and you must re-align plans/tests/code to the new document constraints (modification is instruction)
---

# 文档变更对齐（修改即指令）

## 核心原则

**文档是唯一事实来源。** 人类对任何规格/规则/记忆文档的修改，自动视为对 AI 的最新指令；后续所有行动必须重新对齐。

## 何时使用（触发条件）

当出现任一信号就必须使用本技能：
- 用户说“我改了/更新了/补充了”某份文档
- 你检测到以下文件发生变化（新增/修改/重命名均算）：
  - `.specflow/CONSTITUTION.md`
  - `.specflow/RULES.md`
  - `.specflow/docs/PRD.md`, `.specflow/docs/NFR.md`（或 `.specflow/docs/**/*.md`）
  - `.specflow/specs/active/**/SPEC.md`
  - `.specflow/specs/active/**/ACCEPTANCE.md`
  - `.specflow/memory/**/*.md`

## 硬门禁（必须按顺序执行）

### 1) 识别变更范围

- 列出发生变化的文档文件清单
- 若支持 git：优先通过 `git status --porcelain` 与 `git diff` 获取变更点
- 若不支持 git：要求用户给出变更片段或直接读取文件最新内容

### 2) 重新读取并提取“变更点”

对每个变更文档，输出 3 段信息（简洁但具体）：
- **变更点**：新增/删除/修改了什么规则或需求
- **新约束**：新增的门禁/禁止项/标准
- **受影响对象**：可能影响到的模块、测试、实现、计划、验收

### 3) 影响评估（只做必要动作）

把影响分成三类并明确落点：
- **必须改代码**：哪些行为与新文档冲突
- **必须改测试/验收**：哪些测试/验收项需要新增或调整（保持可验证）
- **必须改计划/记忆**：计划步骤是否需要重排；`memory/` 是否需要更新

> 原则：**DRY / YAGNI**。只做让实现重新与文档一致所必需的最小修改。

补充（feature 规格缺失场景）：
- 若 `.specflow/docs/PRD.md` 新增/修改了某 feature，但 `.specflow/specs/active/<feature>/SPEC.md` 或 `ACCEPTANCE.md` 缺失，必须把“补齐规格文档”列为 **必须改测试/验收** 的前置动作
- 补齐动作应调用 `specflow-write-spec-and-acceptance`（最小补全模式），而不是尝试在本技能内直接跳到实现或归档

### 4) 产出“对齐回执”（强制）

在开始写代码前，必须输出一段对齐回执（可在回复中，或写入 `.specflow/memory/active_context.md`）：

```text
对齐回执：
- 文档变更：<file>（摘要）
- 影响：<哪些地方会受影响>
- 动作：<将要修改的文件/测试/计划>
- 风险：<是否有不确定点；若有，如何验证>
```

### 5) 才允许进入实现

对齐回执完成后：
- 若需要改规格：回到 `specflow-write-spec-and-acceptance`
- 若需要改实现：进入 `specflow-implement-from-spec`
- 若准备关闭：进入 `specflow-acceptance-and-archive`

## 常见失败模式（必须避免）

- **只读了文档但没对齐**：没有把变更点映射到代码/测试/计划
- **用“应该没影响”跳过评估**：没有证据的推断一律不允许
- **改了代码但没更新验收**：验收清单与真实行为脱节
- **过度实现**：把变更当成重构借口，偏离 SPEC Non-Goals

