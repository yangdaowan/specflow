---
name: specflow-write-spec-and-acceptance
description: 当功能需要编写或更新 SPEC.md 和 ACCEPTANCE.md 时使用（范围 + 可验证验收）
---

# 写 SPEC 与验收清单

## 目标

将需求描述转为四份互为补充的唯一事实来源：
- `.specflow/specs/active/<feature>/SPEC.md` — 技术规格（面向 AI/开发者）
- `.specflow/specs/active/<feature>/ACCEPTANCE.md` — 技术验收清单
- `.specflow/pm-docs/<feature>/PM_SPEC.md` — 产品规格（纯业务语言，PM 可修改）
- `.specflow/pm-docs/<feature>/PM_ACCEPTANCE.md` — 验收标准（用户视角）

同步更新 `.specflow/docs/PRD.md` 的功能清单。

## 触发模式

- **模式 A（标准）**：新功能，按完整结构产出
- **模式 B（最小补全）**：feature 缺文档时，产出最小可用的 SPEC（Goal/In Scope/Non-Goals/关键边界）+ ACCEPTANCE（3-8 条可验证项），后续迭代补全

## 硬门禁

- 歧义先澄清再写，不假设
- SPEC 必须可映射到实现和测试，禁止愿景化
- 验收项必须有验证方式（命令/步骤/可观察输出）
- 必须写 Non-Goals，防止过度实现
- 必须覆盖常见失败路径（输入无效、依赖失败、权限不足）
- 一个 feature 只承载一个可独立验收的业务能力（kebab-case 命名）

## 颗粒度判定

写前先问：该需求能否用一个验收清单完整覆盖且可独立上线？

- 能 → 一个 feature
- 不能 → 拆成多个 feature，各自维护 SPEC + ACCEPTANCE

Superpowers 大主题（如"全链路闭环"）→ SpecFlow 必须拆为多个 capability feature。

## 产出

SPEC.md 和 ACCEPTANCE.md 格式见模板 `SPEC_TEMPLATE.md` 和 `ACCEPTANCE_TEMPLATE.md`。

写完 SPEC + ACCEPTANCE 后，同步生成 PM 文档。字段映射和过滤规则见 `specflow-pm-doc-sync` 技能的转换表。

## 自检清单

- [ ] 歧义已澄清 / 假设已确认
- [ ] In Scope / Non-Goals 明确
- [ ] 未引入"提前扩展"条目
- [ ] 边界与错误路径已覆盖
- [ ] ACCEPTANCE 每条有验证方式
- [ ] 无 "TBD / TODO / 适当处理"
- [ ] PRD 已同步该 feature
- [ ] PM_SPEC + PM_ACCEPTANCE 已生成，不含技术术语
- [ ] 大主题已拆分为独立 feature

## 下一步

→ `specflow-implement-from-spec`
