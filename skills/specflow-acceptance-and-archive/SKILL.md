---
name: specflow-acceptance-and-archive
description: Use when a SpecFlow feature is ready to close and you must produce itemized acceptance evidence, archive specs, and update memory
---

# 验收、归档、更新记忆（闭环）

## 目标

在功能开发完成后，执行 SpecFlow 的闭环：
1) 对照 `ACCEPTANCE.md` 执行验收（逐条有证据）
2) 生成 `COMPLETION_REPORT.md`
3) 将 `.specflow/specs/active/<feature>/` 归档到 `.specflow/specs/archive/<feature>/`
4) 更新 `.specflow/memory/`（进度、上下文、关键决策）

当用户明确表达“某功能验收通过”时（例如“需求池功能验收通过”），应**直接进入本技能闭环执行**，不要再次只给“建议执行 /specflow accept ...”。

## 硬门禁

- **逐条验收**：不得用“测试都过了”代替验收；必须逐条对应验收项
- **证据优先**：每条验收项必须有可重复的验证命令或可观察输出
- **归档不可省**：验收通过才允许归档；未通过必须回到实现阶段修正
- **完成声明管控**：未通过验收前，禁止使用“已完成/已修复/可以交付”
- **体验与可读性同等门禁**：功能正确不足以宣称完成；必须同时满足交互稳定、信息可读、结构合理
- **PRD 项目级回写**：验收通过并归档时，必须同步 `.specflow/docs/PRD.md` 的功能清单/范围状态

## 产出物

### 1) `COMPLETION_REPORT.md`（写入到 archive 下）

路径：`.specflow/specs/archive/<feature>/COMPLETION_REPORT.md`

必须包含：
- **范围回顾**：本次实现的 In Scope / 未做的 Non-Goals（保持一致）
- **验收对照表**：每条验收项 → 证据
- **测试与验证命令**：可复现（包含命令与关键输出摘要）
- **风险与后续工作**：已知限制（必须与 Non-Goals 区分）
- **Completion Response Contract**：
  1) What changed
  2) Why
  3) How to verify
  4) Risks / Limitations

### 2) 归档动作

把目录整体移动：
- 从：`.specflow/specs/active/<feature>/`
- 到：`.specflow/specs/archive/<feature>/`

归档目录最终至少包含：
- `SPEC.md`
- `ACCEPTANCE.md`
- `COMPLETION_REPORT.md`

### 3) memory 更新（最少 3 文件）

- `.specflow/memory/progress.md`：追加一条完成记录（日期 + feature + 状态）
- `.specflow/memory/active_context.md`：移除该 feature 的进行中描述，必要时加入下一个聚焦点
- `.specflow/memory/decisions.md`：若本次有关键技术/产品决策，写一条短 ADR 记录（动机/选择/后果）

此外增加“验收等待态”与“验收完成态”可见性：
- 在等待用户验收输入时，`.specflow/memory/active_context.md` 必须写明 `awaiting_user_acceptance`
- 在验收完成后，将该等待态标记为已结束并更新下一聚焦点

### 4) PRD 同步（项目级，强制）

验收通过后，必须更新 `.specflow/docs/PRD.md`，至少包含：
- 该 feature 在“功能清单”中的记录（名称、状态、关联 SPEC/ACCEPTANCE）
- 该 feature 相关范围是否进入已交付状态

## 与 Superpowers 的验证门禁衔接

在写“验收通过/已完成”之前，必须使用 `verification-before-completion` 并运行：
- 项目测试命令（或最小验证命令）
- 如有：lint / build / e2e

只有看到 **新鲜的** 成功输出，才允许写入“通过/完成”的结论。

## 交付质量验收基线（补足纯“接口可用”偏差）

在逐条验收时，至少补充检查：

- **需求一致性**：功能行为、信息展示、交互体验、结构关系是否与需求一致
- **i18n/L10n**：无 key 泄漏、无 `Invalid Date`/`NaN`/原始对象直出、枚举值可读化
- **UI 可读性**：分组与留白、字段标签和值、空值兜底、异常值兜底
- **状态生命周期**：重复打开关闭稳定、模式切换正确、路由切换/回退可预期、异步竞态可控
- **数据规范化**：展示前完成类型与格式规范化，避免后端原始结构直出
- **回归**：主修复点 + 关联模块 + 异常路径，避免“修 A 坏 B”

## 禁止事项

- 禁止“应该可以/大概率/看起来没问题”式完成结论
- 禁止忽略用户明确提出的体验、布局、可读性问题
- 禁止无证据宣称完成
- 禁止在用户已明确“验收通过”后，仅回复“建议执行 /specflow accept ...”而不进入闭环

