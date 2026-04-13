---
name: specflow-write-spec-and-acceptance
description: Use when turning a feature request into SPEC.md + ACCEPTANCE.md — produces unambiguous scope, non-goals, edge cases, and verifiable acceptance checklist
---

# 写 SPEC 与验收清单（SpecFlow 标准化产出）

## 目标

把“需求描述”转成两份可执行的唯一事实来源文件：
- `.specflow/specs/active/<feature-name>/SPEC.md`
- `.specflow/specs/active/<feature-name>/ACCEPTANCE.md`

它们必须足够具体，使实现者无需再猜测“做什么/做到什么程度”。

## 约束（硬门禁）

- **SPEC 必须可实现**：禁止愿景化语言；每条都要能映射到实现与测试
- **验收必须可验证**：每条验收项都必须说明“如何验证/看到什么结果”
- **显式非目标**：必须写 Non-Goals，防止 AI 过度实现
- **边界与错误路径**：必须覆盖常见失败模式（输入无效、依赖失败、权限不足等）

## 产出模板（必须遵守）

### SPEC.md 结构

```markdown
# <Feature Name> — SPEC

## 背景与目标（Goal）
- 一句话目标：
- 业务背景：

## 范围（In Scope）
- [ ] ...

## 非目标（Non-Goals）
- [ ] ...

## 用户故事 / 使用场景
- 场景 1：
- 场景 2：

## 领域模型 / 数据（如适用）
- 实体：
- 字段：
- 约束：

## 接口与交互（如适用）
- API / CLI / UI 行为：
- 输入：
- 输出：

## 状态机与异步任务（如适用）
- 状态字段：
- 状态流转：
- 重试与失败处理：

## 错误处理与边界情况
- ...

## 安全与隐私（如适用）
- ...

## 可观测性（如适用）
- 日志：
- 指标：
- 追踪：

## 测试策略
- 单元测试：
- 集成测试：
- 关键回归用例：
```

### ACCEPTANCE.md 结构（可逐条验证）

```markdown
# <Feature Name> — ACCEPTANCE

> 验收原则：每条都必须可验证（命令/步骤/可观察输出）。

## 功能验收
- [ ] A1. ...（验证方式：...）
- [ ] A2. ...（验证方式：...）

## 失败路径验收
- [ ] F1. ...（验证方式：...）

## 非功能性验收（如适用）
- [ ] N1. 性能：...（验证方式：...）
- [ ] N2. 安全：...（验证方式：...）

## 兼容性/迁移（如适用）
- [ ] C1. ...（验证方式：...）
```

## 命名规范

`<feature-name>` 必须为小写短横线（kebab-case），例如 `user-points`。

## 自检清单（写完必须自查）

- [ ] SPEC 有明确 In Scope / Non-Goals
- [ ] SPEC 覆盖边界与错误路径
- [ ] ACCEPTANCE 每条都有验证方式
- [ ] 术语在两份文件中一致（同一概念不换词）
- [ ] 没有 “TBD / TODO / 适当处理 / 之后补充”

## 下一步

规格与验收写完后，开始实施：
- 使用 `specflow-implement-from-spec`

