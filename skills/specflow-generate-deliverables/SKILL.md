---
name: specflow-generate-deliverables
description: 从 SpecFlow 产物生成 7 种 GB/T 8567 正式交付文档。通过 /specflow deliverables <name> 手动触发。
---

# 正式文档生成（GB/T 8567）

## 目的

将 SpecFlow 规格文档转化为 7 种 GB/T 8567 正式交付文档（纯 Markdown）：

| 文档 | 模板 | 主要源 |
|------|------|--------|
| 概要设计说明书 | `ARCHITECTURE_OVERVIEW_TEMPLATE.md` | SPEC + DESIGN |
| 详细设计说明书 | `DETAILED_DESIGN_TEMPLATE.md` | SPEC + ACCEPTANCE + decisions |
| 数据库设计文档 | `DATABASE_DESIGN_TEMPLATE.md` | SPEC 领域模型 + 代码 migration |
| 接口文档 | `API_INTERFACE_TEMPLATE.md` | SPEC 接口 + 代码路由 |
| 验收测试报告 | `ACCEPTANCE_TEST_REPORT_TEMPLATE.md` | ACCEPTANCE + COMPLETION_REPORT |
| 部署运维手册 | `DEPLOYMENT_AND_OPS_TEMPLATE.md` | 项目配置 + Dockerfile 等 |
| 用户操作手册 | `USER_MANUAL_TEMPLATE.md` | PM_SPEC（用户操作流程） |

## 触发

`/specflow deliverables <feature-name>`（手动唯一入口）

## 流程

### 1) 前置检查
确认 SPEC/ACCEPTANCE 存在（active 或 archive），`deliverables/<feature>/` 目录就绪。

### 2) 信息提取
从 SPEC（目标/范围/领域模型/接口/状态机）、ACCEPTANCE（验收项/失败路径/NFR）、COMPLETION_REPORT（证据/命令/风险）、DESIGN.md（技术栈/组件库）、PM_SPEC（用户操作流程）、decisions.md（ADR）、代码（实际接口/schema）中提取信息。

### 3) 逐文档填充
按上表模板逐个生成。信息充分 → 填入；无法推断 → 标注 `[待补充]`。模板所有章节必须出现，不许跳过。

### 4) 输出
写入 `.specflow/deliverables/<feature>/`，末尾追加生成声明：
```
> 本文档由 SpecFlow 自动生成。生成时间：YYYY-MM-DD HH:MM
> 缺失信息已标注 [待补充]，请人工审核后补全。
```

## 硬门禁

- **不编造**：无信息来源 → `[待补充]`
- **不跳章**：模板所有章节必须出现
- **不覆盖人工**：已有文档中含非 `[待补充]` 的人工内容 → 只更新自动推断部分
- **中文输出**：所有填充使用简体中文
