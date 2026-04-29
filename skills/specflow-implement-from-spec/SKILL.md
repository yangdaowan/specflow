---
name: specflow-implement-from-spec
description: 当按 SPEC/ACCEPTANCE 实施功能时使用，需将验收项映射到证据（测试/命令/手工步骤）
---

# 按规格实施（SPEC → TDD → 验收对照）

## 目标

将 SPEC.md + ACCEPTANCE.md 转为通过测试的实现 + 验收证据。

## 硬门禁

- **先读文档再动代码**：实现前完整读 SPEC/ACCEPTANCE；前端任务加读 DESIGN.md
- **memory 非空**：开始前确认 `active_context.md` 和 `progress.md` 已写入当前 feature 状态（`in-progress`）
- **TDD 强制**：先写测试确认失败（见红），再生产代码
- **验收映射**：每条验收项指向测试 / 命令 / 手工步骤
- **禁止过度实现**：严格遵守 Non-Goals
- **手术式改动**：只改本次目标代码，不顺手重构
- **步骤即验证**：每步绑定验证检查（step → verify）
- **组件复用优先**：优先用项目既有组件库

## 执行路径

1) 无计划 → `writing-plans`（2-5 分钟粒度步骤）
2) 执行 → `executing-plans`（小规模）或 `subagent-driven-development`（多任务并行）
3) 完成前 → `verification-before-completion`（新鲜输出）

## 验收对照

实现完成后生成验收对照表：
```
A1 → 证据：test ... / 命令 ... / 截图 ...
A2 → 证据：...
F1 → 证据：...
```

## memory 与 Review Packet

- 开始：写入 `active_context.md`（状态 `in-progress`），`progress.md` 记录进行中
- 等待验收：状态 → `awaiting_human_review`，生成 `.specflow/reviews/<feature>/REVIEW.md` + `STATUS.json` + `EVIDENCE.md`
- STATUS 流转：`draft → awaiting_human_review → approved/rejected → archived_committed`

## 下一步

→ `specflow-acceptance-and-archive`
