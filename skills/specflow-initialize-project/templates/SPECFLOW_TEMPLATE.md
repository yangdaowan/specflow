# SPECFLOW

> 单一事实来源：本文件合并并替代 `AGENTS.md` + `CONSTITUTION.md` + `RULES.md`。  
> 所有规范/门禁/开发约定以此为准；修改即指令。

## 1) 工作流门禁（Agent Behavior + Gates）

- **命令入口（Cursor 插件）**：只使用 `/specflow ...`
  - `/specflow init`：初始化/修复 `.specflow/`
  - `/specflow feature <feature-name>`：生成/更新 SPEC + ACCEPTANCE + INDEX
  - `/specflow align`：文档变更对齐（输出对齐回执后才可改代码）
  - `/specflow accept <feature-name>`：验收→证据→归档→memory→PRD→git commit

- **文档是指令**：人类修改 `.specflow/**` 任一文档即视为最新指令，必须重新对齐。
- **不绕过 Superpowers**：brainstorming → writing-plans → TDD → verification-before-completion。

## 2) 项目级规格（Project-level Source of Truth）

- **PRD（项目级）**：`.specflow/docs/PRD.md`，必须维护“功能清单/范围/状态”。feature 验收归档后必须回写。
- **NFR（项目级）**：`.specflow/docs/NFR.md`。
- **DESIGN（项目级，若有 UI）**：`.specflow/docs/DESIGN.md`（颜色/字阶/组件/交互/响应式）。

## 3) 颗粒度分层（Superpowers vs SpecFlow）

- **Superpowers specs/plans** 可以覆盖“大主题/全链路闭环”（例如 EventPulse V1 MVP 全链路闭环）。
- **SpecFlow feature** 必须拆成可独立验收的 capability：
  - `newsnow-api-integration`
  - `web-search-event-details`
  - `event-value-judgement`
  - `event-dedup-and-ranking`

规则：
- 一个 `.specflow/specs/active/<feature>/` 只承载一个能力点。
- 禁止把多能力点塞进一个 SPEC。

## 4) 不可妥协条款（Constitution）

- 禁止伪造验证结果或无证据宣称“已完成/已修复”。
- 验收通过后必须归档并 **git commit**，未提交不得宣称闭环完成。
- UI 交付必须满足“功能正确 + 展示可读 + 交互稳定 + 证据充分”。

## 5) 技术约定（Rules）

### 5.1 命名与目录

- feature 名：kebab-case（如 `event-value-judgement`）
- 业务模块命名：
- 路由命名：

### 5.2 数据与数据库（示例占位，初始化时应从代码提炼补全）

- 通用字段（建议）：`id`, `created_at`, `updated_at`, `deleted_at?`, `tenant_id?`, `created_by?`
- 时间/时区：
- 软删除策略：

### 5.3 架构与分层

- 分层：领域逻辑与 IO/框架代码隔离
- 依赖方向：内层不依赖外层

### 5.4 状态机/异步任务（如适用）

- 必备字段：`status`, `retry_count`, `last_error`
- 明确状态流转与失败处理

### 5.5 测试策略

- 新增/变更行为必须先写测试（TDD）
- 回归测试必须覆盖关键验收项与失败路径

### 5.6 AI 执行约束（Karpathy 风格）

- Think Before Coding：有歧义先澄清，不允许静默假设后直接实现
- Simplicity First：最小可行实现，禁止提前抽象与未来功能预埋
- Surgical Changes：仅改本次需求相关代码，每个改动需可追溯到需求/验收项
- Goal-Driven Execution：任务拆分为“步骤 -> 验证”，无证据不宣称完成

## 6) 项目基础设施现状（初始化时从代码扫描提炼）

- 前端技术栈：
- 后端技术栈：
- 认证/鉴权：
- 日志与可观测性：
- 配置管理：
- i18n：
- UI 组件库（如 Ant Design）：
