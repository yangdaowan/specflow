---
name: specflow-write-spec-and-acceptance
description: Use when a feature needs `.specflow/specs/active/<feature>/SPEC.md` and `ACCEPTANCE.md` written or updated (scope + verifiable acceptance)
---

# 写 SPEC 与验收清单（SpecFlow 标准化产出）

## 目标

把“需求描述”转成两份可执行的唯一事实来源文件：
- `.specflow/specs/active/<feature-name>/SPEC.md`
- `.specflow/specs/active/<feature-name>/ACCEPTANCE.md`

它们必须足够具体，使实现者无需再猜测“做什么/做到什么程度”。

同时确保项目级 PRD 持续同步：
- `.specflow/docs/PRD.md` 是**项目级文档**，不是 feature 级文档
- 新增/变更 feature 时，必须同步 PRD 的功能清单与范围说明

## 约束（硬门禁）

- **先澄清再写规格**：如果需求存在歧义，必须先列出假设或备选解释，并向人类确认后再写 SPEC
- **SPEC 必须可实现**：禁止愿景化语言；每条都要能映射到实现与测试
- **验收必须可验证**：每条验收项都必须说明“如何验证/看到什么结果”
- **显式非目标**：必须写 Non-Goals，防止 AI 过度实现
- **最小复杂度优先**：不写“未来可能需要”的提前设计；仅保留当前交付所需约束
- **边界与错误路径**：必须覆盖常见失败模式（输入无效、依赖失败、权限不足等）
- **颗粒度必须是单一功能点**：一个 `<feature-name>` 只承载一个可独立验收的业务能力，不得把多个独立功能点并入同一 SPEC
- **PRD 项目级同步**：feature 建立或范围变化后，必须同步 `.specflow/docs/PRD.md` 的“功能清单/需求范围”

## 颗粒度判定（先判定再写）

写 SPEC 前先问：该需求是否可被“一个验收清单”完整覆盖且可独立上线/验收？

- 若 **是**：可作为一个 feature 写入 `.specflow/specs/active/<feature-name>/`
- 若 **否**：必须拆成多个 feature，每个 feature 各自维护 `SPEC.md` + `ACCEPTANCE.md`

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

- [ ] 关键歧义已被明确（或记录假设并获确认）
- [ ] SPEC 有明确 In Scope / Non-Goals
- [ ] 规格未引入本次需求之外的“提前扩展”条目
- [ ] SPEC 覆盖边界与错误路径
- [ ] ACCEPTANCE 每条都有验证方式
- [ ] 术语在两份文件中一致（同一概念不换词）
- [ ] 没有 “TBD / TODO / 适当处理 / 之后补充”
- [ ] `.specflow/docs/PRD.md` 已同步反映该 feature（至少有一条功能清单或范围更新）

## 验收标记

- 通过项：[√]
- 不通过项：[x]

## 下一步

规格与验收写完后，开始实施：
- 使用 `specflow-implement-from-spec`

