---
name: specflow-acceptance-and-archive
description: 当 SpecFlow 功能准备闭环时使用 — 生成逐条验收证据、归档规格、更新记忆
---

# 验收、归档、更新记忆（闭环）

## 目标

1) 对照 ACCEPTANCE.md 逐条验收（有证据）
2) 生成 COMPLETION_REPORT.md
3) 归档 active → archive
4) 更新 memory + PRD + git commit

当用户明确说"功能验收通过"，直接进入闭环，不回复"建议执行 /specflow accept ..."。

## 硬门禁

- 缺 SPEC/ACCEPTANCE → 先触发 `specflow-write-spec-and-acceptance` 最小补全
- 逐条验收，不得用"测试都过了"代替
- 每条有可重复验证证据
- 验收通过才归档；未通过回实现修正
- 未验收前禁止"已完成/可交付"声明
- 必须收到结构化确认：`APPROVE <feature>` 或 `REJECT <feature>: <reason>`

## 流程

### 1) 前置检查
确认 `active/<feature>/` 存在且 SPEC/ACCEPTANCE/INDEX 齐全。缺失 → 补全后继续。

### 2) 逐条验收 + 生成报告
对照 ACCEPTANCE 逐条验收，生成 `COMPLETION_REPORT.md`（范围回顾 / 验收对照表 / 验证命令 / 风险 / Completion Response Contract）。

补足质检基线：需求一致性、i18n/L10n、UI 可读性、状态生命周期、数据规范化、回归。

### 3) 归档
`active/<feature>/` → `archive/<feature>/`（至少含 SPEC/ACCEPTANCE/INDEX/COMPLETION_REPORT）

### 4) memory + PRD 更新
- `progress.md`：追加完成记录
- `active_context.md`：移除进行中，标记 `awaiting_user_acceptance` → 完成后更新下一聚焦点
- `decisions.md`：有重要决策写短 ADR
- `PRD.md`：更新功能清单状态

### 5) Review Packet 状态机
`.specflow/reviews/<feature>/STATUS.json`：
`draft → awaiting_human_review → approved / rejected → archived_committed`

未到 `approved` 禁止归档；收到 `REJECT` 回实现阶段。

### 6) Git 提交
验收 + 归档 + memory/PRD 更新后立即 git commit（简体中文 Conventional Commits：`<type>(<scope>): <subject>`）。每 feature 独立提交，不合并。提交前跑 `verification-before-completion`（测试/lint/build 新鲜输出）。

## 禁止事项

- 禁止"应该可以/大概率/看起来没问题"式结论
- 禁止忽略体验/布局/可读性问题
- 禁止无证据宣称完成
- 禁止用户已说"通过"却不进入闭环
