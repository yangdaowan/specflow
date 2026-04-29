---
name: specflow-document-alignment
description: 当 `.specflow/**` 文档变更时使用，需重新对齐计划/测试/代码以符合新的文档约束（修改即指令）
---

# 文档变更对齐（修改即指令）

## 核心原则

**文档是唯一事实来源。** 人类对任何 `.specflow/**` 文档的修改，自动视为对 AI 的最新指令。

## 触发条件

- 用户说"我改了某文档"
- SessionStart 注入 sync trigger 上下文
- 检测到以下文件变更：
  - `.specflow/SPECFLOW.md`、`.specflow/docs/**`、`.specflow/memory/**`
  - `.specflow/specs/active/**/SPEC.md`、`ACCEPTANCE.md`
  - `.specflow/pm-docs/**/PM_SPEC.md`、`PM_ACCEPTANCE.md`（→ 触发 doc→code 同步）

## 流程

### 1) 识别变更
用 `git status --porcelain` + `git diff`（或直接读取）列出变更文件。

### 2) 提取变更点
每个变更文档输出：变更点（新增/删除/修改）、新约束、受影响对象。

### 3) 影响评估
三类影响：必须改代码 / 必须改测试验收 / 必须改计划记忆。

**PM 文档变更**：先调 `specflow-pm-doc-sync`（doc-to-code）→ 更新 SPEC/ACCEPTANCE → 再评估。

**技术规格变更**：评估完成后调 `specflow-pm-doc-sync`（code-to-doc）→ 反向同步 PM 文档。

**feature 规格缺失**：调 `specflow-write-spec-and-acceptance` 最小补全，再继续。

### 4) 对齐回执（强制）
```
对齐回执：
- 文档变更：<file>（摘要）
- 影响：<受影响范围>
- 动作：<将修改的文件/测试/计划>
- 风险：<不确定点及验证方式>
```

### 5) 进入实现
- 需改规格 → `specflow-write-spec-and-acceptance`
- 需实现 → `specflow-implement-from-spec`
- 准备关闭 → `specflow-acceptance-and-archive`

## 禁止事项

- 读了文档但没对齐（没映射到代码/测试/计划）
- 用"应该没影响"无证据跳过评估
- 改了代码但未更新验收
- 把变更当重构借口
