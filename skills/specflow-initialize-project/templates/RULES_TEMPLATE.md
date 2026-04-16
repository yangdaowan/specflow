# 技术规范（RULES）

## 架构约束（示例）
- 分层：领域逻辑与 IO/框架代码隔离
- 依赖方向：内层不依赖外层

## 状态机/异步任务（如适用）
- 必须具备字段：`status`, `retry_count`, `last_error`
- 明确状态流转与失败处理

## 测试策略
- 新增/变更行为必须先写测试（TDD）
- 回归测试必须覆盖关键验收项与失败路径

## AI 执行约束（Karpathy 风格）
- Think Before Coding：有歧义先澄清，不允许静默假设后直接实现
- Simplicity First：最小可行实现，禁止提前抽象与未来功能预埋
- Surgical Changes：仅改本次需求相关代码，每个改动需可追溯到需求/验收项
- Goal-Driven Execution：任务拆分为“步骤 -> 验证”，无证据不宣称完成

