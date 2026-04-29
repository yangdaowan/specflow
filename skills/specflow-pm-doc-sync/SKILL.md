---
name: specflow-pm-doc-sync
description: PM 可读文档与 SPEC/ACCEPTANCE 之间的双向同步。由同步触发标记或 /specflow sync 驱动。
---

# PM 文档双向同步

## 目的

维护两层文档的一致性：
- **PM 层**：`.specflow/pm-docs/<feature>/` — 纯业务语言，PM 可直接修改
- **技术层**：`.specflow/specs/active/<feature>/` — 面向 AI/开发者

核心原则：**文档是 PM 的"代码"，AI 是编译/反编译引擎。**

## 触发

1. SessionStart 注入 sync trigger 上下文 → 自动
2. `/specflow sync [--direction doc-to-code|code-to-doc]` → 手动

## 流程

### 1) 识别方向

- `doc-to-code`：PM 文档变更 → 对齐 SPEC + 代码
- `code-to-doc`：SPEC 变更 → 对齐 PM 文档
- `both`：先 doc-to-code，再 code-to-doc

### 2) 差异分析

逐字段对比变更文档与对应文档，输出"差异清单"（只列变更点）。

### 3) 转换执行

#### 方向 A：doc-to-code

**映射表**（方向 A 从左到右，方向 B 从右到左）：

| # | PM_SPEC 字段 | ⇄ | SPEC/ACCEPTANCE 字段 |
|---|-------------|---|---------------------|
| 1 | 业务目标 | ⇄ | 背景与目标（Goal） |
| 2 | 功能描述 > 用户操作流程 | ⇄ | 用户故事 / 使用场景 |
| 3 | 功能描述 > 核心业务规则 | ⇄ | 范围（In Scope） |
| 4 | 明确不做 | ⇄ | 非目标（Non-Goals） |
| 5 | 前置条件与依赖 | ⇄ | 接口与交互（鉴权/权限） |
| 6 | 数据说明（业务视角） | ⇄ | 领域模型 / 数据 |
| 7 | 页面/界面说明 | ⇄ | 接口与交互（UI 形态） |
| 8 | 验收标准（PM 版） | ⇄ | ACCEPTANCE 功能验收项 |

**技术字段处理**（不映射到 PM 文档，doc-to-code 方向 AI 补充并标记 `[AI-generated]`）：
状态机、幂等性、重试策略、安全与隐私（技术性）、可观测性、测试策略

#### 方向 B：code-to-doc

按上表反向映射。PM 文档只反映"做什么"，过滤掉上述技术字段。纯技术性变更（重构/优化）标注 `[内部优化，用户无感]`。

### 4) 对齐回执

```
## 同步回执
- 方向：doc-to-code / code-to-doc
- 涉及功能：<name>
- 变更摘要：PM 文档 / 技术规格 / 两者
- 受影响：代码[是/否] 测试[是/否] PM文档[是/否]
- 下一步：→ implement-from-spec / → acceptance-and-archive
```

### 5) 清理

删除 `.specflow/.sync-trigger.json`（如存在），更新 `active_context.md`。

## 硬门禁

- 禁止跳过差异分析直接覆盖
- 禁止丢弃 PM 业务约束
- 禁止 PM 文档出现技术术语
- 同步回执必须输出
