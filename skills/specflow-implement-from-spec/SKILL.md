---
name: specflow-implement-from-spec
description: Use when implementing a feature from `.specflow` SPEC/ACCEPTANCE and you must map acceptance items to evidence (tests/commands/manual steps)
---

# 按规格实施（Spec → TDD → 验收对照）

## 目标

把 `SPEC.md` + `ACCEPTANCE.md` 转成：
- 通过测试的实现
- 可对照的验收证据（逐条对应）

## 硬门禁

- **先读文档再动代码**：实现前必须完整读取当前 feature 的 `SPEC.md` 与 `ACCEPTANCE.md`
- **前端任务先读 DESIGN**：若本次改动涉及 UI/前端，必须先读取 `.specflow/docs/DESIGN.md`（若存在页面级覆盖规则则优先页面规则）
- **memory 不得是空模板**：开始实施前，必须确保 `.specflow/memory/active_context.md` 与 `.specflow/memory/progress.md` 已写入当前 feature 与状态（至少 `in-progress`）；若仍是空模板，先补齐再进入实现
- **TDD 强制**：任何生产代码变更前必须先写测试并确认失败（见红），且失败原因与预期变更一致
- **验收映射**：每条验收项必须能指向：测试 / 命令 / 手工步骤（至少其一）
- **禁止过度实现**：严格遵守 SPEC 的 Non-Goals
- **手术式改动**：只改本次目标所需代码；禁止顺手重构、风格漂移、无关优化
- **步骤即验证**：实现计划中的每一步都必须绑定验证检查（step -> verify）
- **组件复用优先**：优先复用项目既有组件库（如 Ant Design）；无明确理由不手写基础控件

## 推荐执行路径（与 Superpowers 技能衔接）

1) 若还没有实现计划（plan），先生成计划  
   - 使用 `writing-plans`：把 SPEC 分解成 2-5 分钟粒度的小步骤（包含具体文件路径、测试代码、命令与预期输出）

2) 执行计划  
   - 小规模：使用 `executing-plans`（同会话逐步执行）  
   - 多任务且相对独立：使用 `subagent-driven-development`（每任务一个子智能体 + 双审）

3) 完成前验证  
   - 使用 `verification-before-completion`：在任何“完成/修复/通过”声明前必须跑验证命令并阅读输出

## memory 写入最小规范（用于避免流程卡住）

在开始实施时写入（或更新）：
- `.specflow/memory/active_context.md`
  - Feature: `<feature-name>`
  - 状态：`in-progress`
- `.specflow/memory/progress.md`
  - 将 `<feature-name>` 记录到 `进行中`

当进入等待用户验收输入阶段（实现完成但未验收）时，应把状态更新为：
- `awaiting_human_review`

同时生成跨平台“验收会话包”（Review Packet）：
- `.specflow/reviews/<feature>/REVIEW.md`
- `.specflow/reviews/<feature>/STATUS.json`
- `.specflow/reviews/<feature>/EVIDENCE.md`

`STATUS.json` 状态流转最小集合：
- `draft` -> `awaiting_human_review` -> `approved` / `rejected` -> `archived_committed`

## Goal-Driven 执行模板（推荐）

将实现步骤写成以下形式，避免“大步快跑后统一补测”：

```text
1. [实现步骤] -> verify: [测试/命令/可观察结果]
2. [实现步骤] -> verify: [测试/命令/可观察结果]
3. [实现步骤] -> verify: [测试/命令/可观察结果]
```

## 验收对照输出（必交付）

在实现完成后，必须生成一段“验收对照表”（可写入 `COMPLETION_REPORT.md` 或回复中）：

```text
A1 → 证据：test ... / 命令 ... / 截图/日志 ...
A2 → 证据：...
F1 → 证据：...
```

## 下一步

当所有验收项都有证据后：
- 使用 `specflow-acceptance-and-archive`

