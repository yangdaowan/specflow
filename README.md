# ycf-vibe-coding

本仓库用于沉淀一套可在 **Vibe Coding**中复用的工程化方法论 **SpecFlow（规格驱动工作流）**，并将其“标准体系”以 **Superpowers 技能包**的形式落地。

- **Superpowers**：提供“按什么流程、用什么纪律”的执行框架（如 TDD、代码审查、计划执行等）
- **SpecFlow**：提供“做什么、做到什么标准”的规格体系（文档即中枢、验收清单、归档与记忆）

## 仓库内容

- `Vibe Coding 之 SpecFlow 方法论指南`：SpecFlow 方法论主文档（理念、文件体系、角色、双轨工作流、口令模板）
- `superpowers/`：Superpowers 源码与文档
  - `superpowers/skills/`：Superpowers 原始技能库（上游源码）
- `skills/`：本仓库维护的 **SpecFlow 技能源码**（已从 `superpowers/skills/` 迁移）

## SpecFlow（以 Superpowers 技能包形式落地）

目前已落地的 SpecFlow 技能：

- `specflow-using-specflow`：SpecFlow 总览与**轻量/完整双轨分流**
- `specflow-initialize-project`：初始化/改造 SpecFlow 文档体系（并内置模板标准件）
- `specflow-write-spec-and-acceptance`：将需求固化为 `SPEC.md` + `ACCEPTANCE.md`
- `specflow-document-alignment`：**修改即指令**：检测文档变更并强制对齐计划/测试/代码
- `specflow-implement-from-spec`：按规格实施（文档对齐 + TDD 门禁 + 验收映射）
- `specflow-acceptance-and-archive`：验收→完工报告→归档→memory 更新（闭环）

这些技能都在：
- `skills/specflow-*/SKILL.md`

## 构建与部署（指南同步）

新版 SpecFlow 约定将“源码（单一事实来源）”与“部署产物”分离：

- **源码（单一事实来源）**：
  - `skills/`
  - `.specflow/templates/`
- **构建产物**：`superpowers-skills/specflow/`
- **部署目标**：任意项目的 `.superpowers/skills/specflow/`

## 快速开始（推荐路径）

### 轻量 SpecFlow（小任务，低成本）

1. 用简短的验收清单约束目标（3-8 条即可）
2. 按验收清单做最小实现（推荐至少 1 条回归测试或可复现验证步骤）
3. 完成时逐条对照验收项给出证据

对应技能参考：
- `specflow-using-specflow`
- `specflow-write-spec-and-acceptance`（可只写 `ACCEPTANCE.md`）
- `specflow-implement-from-spec`

### 完整 SpecFlow（长期维护 / 多人协作）

1. 初始化文档体系与模板：`specflow-initialize-project`
2. 为功能写规格与验收：`specflow-write-spec-and-acceptance`
3. 文档变更自动对齐：`specflow-document-alignment`
4. 按规格实施并严格 TDD：`specflow-implement-from-spec`
5. 验收通过后归档与记忆更新：`specflow-acceptance-and-archive`

## SpecFlow 文件体系（标准形态）

（详见主文档；这里给出目录速览）

```text
项目根目录/
├── .specflow/
│   ├── AGENTS.md                       # AI 行为准则/口令/门禁（修改即指令、对齐回执等）
│   ├── CONSTITUTION.md                 # 不可变最高原则（质量底线/价值排序/不可妥协条款）
│   ├── RULES.md                        # 技术规范（架构约束/分层/状态机/测试策略等）
│   ├── docs/
│   │   ├── PRD.md                      # 产品需求全景图（目标/范围/非目标/场景）
│   │   ├── NFR.md                      # 非功能性需求（性能/安全/可观测性/可用性）
│   │   └── DESIGN.md                   # UI/UX 设计基线（颜色/字阶/组件/交互/响应式）
│   ├── specs/
│   │   ├── active/<feature>/
│   │   │   ├── SPEC.md                 # 功能规格（In Scope/Non-Goals/数据与接口/边界与错误）
│   │   │   ├── ACCEPTANCE.md           # 验收清单（逐条可验证的验收标准 + 验证方式）
│   │   │   └── plan.md                 # 实施计划（可选：从 SPEC 拆成可执行步骤）
│   │   └── archive/<feature>/
│   │       ├── SPEC.md                 # 归档后的最终规格（不可再漂移）
│   │       ├── ACCEPTANCE.md           # 归档后的最终验收清单
│   │       └── COMPLETION_REPORT.md    # 完工报告（验收对照表 + 证据 + 验证命令）
│   ├── memory/
│   │   ├── progress.md                 # 全局进度追踪（完成/进行中/待办）
│   │   ├── active_context.md           # 当前上下文（聚焦目标/待办/阻塞/对齐回执摘要）
│   │   └── decisions.md                # 关键决策记录（ADR：背景/决策/取舍/后果）
│   ├── scripts/
│   │   ├── new-feature.sh              # 新建功能脚手架（创建 active/<feature> 与模板拷贝等）
│   │   └── archive-feature.sh           # 归档脚本（active → archive + 生成报告/更新 memory）
│   └── templates/
│       ├── SPEC_TEMPLATE.md            # SPEC 标准模板
│       └── ACCEPTANCE_TEMPLATE.md      # ACCEPTANCE 标准模板
└── tests/
    └── <feature-name>_test.xx          # 测试用例（与验收项映射；优先自动化可重复验证）
```

## 约定与原则（简版）

- **文档即中枢**：`CONSTITUTION.md` / `RULES.md` / `SPEC.md` / `ACCEPTANCE.md` 是唯一事实来源
- **修改即指令**：人类修改文档后，后续实现必须自动重新对齐
- **验收清单优先**：交付以验收项逐条可验证为准
- **纪律由 Superpowers 提供**：TDD、计划、审查、验证门禁等尽量交给技能流程托底
- **颗粒度分层**：SpecFlow 以“功能点”建 feature；Superpowers 以“模块/任务”做设计与计划拆分
- **交付质量基线**：完成必须同时满足“功能正确 + 展示可读 + 交互稳定 + 证据充分”
- **执行风格约束**：默认采用 Karpathy 四原则（先澄清、求简单、手术式改动、目标驱动验证）
- **设计基线前置**：前端实现前必须对齐 `.specflow/docs/DESIGN.md`，避免“实现后再修 UI”

## 可借鉴经验融合（Karpathy Guidelines）

已将以下经验作为 SpecFlow 的“执行风格层”融合，不替代现有 SpecFlow/Superpowers 分工：

- **Think Before Coding**：需求有歧义时先澄清，不做静默假设
- **Simplicity First**：最小可行实现，严格受 `Non-Goals` 约束
- **Surgical Changes**：只改本次目标所需范围，避免无关重构
- **Goal-Driven Execution**：把任务写成 `step -> verify`，无证据不宣称完成

## 作为 Cursor 插件安装（自动触发）

本仓库已提供 Cursor 插件清单与启动 Hook：

- `.cursor-plugin/plugin.json`
- `hooks/hooks-cursor.json`
- `hooks/session-start`
- `commands/`（内置命令入口：`/specflow`）

安装后，`SessionStart` 会自动注入 SpecFlow 上下文（默认开启），无需每次手动显式触发技能。

### 与 Superpowers 并存（推荐）

同时安装 `Superpowers` 与 `SpecFlow` 时，默认策略为互补：

- `Superpowers`：流程纪律（如何执行）
- `SpecFlow`：规格与验收门禁（做什么、什么算完成）

SpecFlow 默认会在会话启动时注入“互补模式”规则，尽量避免与 Superpowers 冲突。

### 插件命令（内置）

本插件提供真正的命令入口（非仅语义约定）。命令入口统一为 `/specflow ...`：

- `/specflow`：总入口（支持 `init new`、`init old`、`feature <name>`、`align`、`accept <name>`）

常用示例：
- `/specflow init new`
- `/specflow feature user-points`
- `/specflow align`
- `/specflow accept user-points`

说明：
- 当 `/specflow` 参数缺失或不合法时，命令会返回统一的 help 风格用法说明（Usage/Subcommands/Examples）。
- 当检测到 `.specflow/` 不存在或核心文件缺失时，命令会先触发初始化门禁，不会把 `docs/superpowers/*` 误当作 SpecFlow 的 PRD/SPEC/ACCEPTANCE。
- 即使用户未使用命令、仅用自然语言提出需求，SpecFlow 也要求先通过初始化门禁（缺 `.specflow` 核心文件即先初始化）。

### 项目内开关（手动关闭/切换）

项目级配置文件：`.specflow/plugin.config.json`

默认内容：

```json
{
  "enabled": true,
  "integrationMode": "complement-superpowers",
  "disableSuperpowers": false
}
```

可选值：

- `enabled: false`：关闭 SpecFlow 自动触发（保留已安装插件）
- `integrationMode: "complement-superpowers"`：与 Superpowers 互补（默认）
- `integrationMode: "specflow-only"`：本项目中优先只走 SpecFlow 工作流
- `disableSuperpowers: true`：项目级关闭 Superpowers 自动工作流（仅在本项目生效；用户显式要求时仍可使用）

## Superpowers + SpecFlow 完整工作流

以下是推荐的唯一主流程（避免多入口偏移）：

### 0) 会话启动（自动）

- Superpowers 注入 `using-superpowers`
- SpecFlow 注入 `specflow-session-bootstrap`
- 若缺 `.specflow` 核心文件，触发初始化硬门禁（先初始化，再继续）

### 1) 项目基建阶段（一次性 / 按需）

- 使用：`/specflow init new` 或 `/specflow init old`
- 目标：落地 `.specflow/` 文档体系与模板（含 `INDEX_TEMPLATE.md`）

### 2) 功能规格阶段（Feature Entry）

- 使用：`/specflow feature <feature-name>`
- 先走 Superpowers `brainstorming`（设计澄清 + 人类确认）
- 再落地 SpecFlow 文档：
  - `.specflow/specs/active/<feature>/SPEC.md`
  - `.specflow/specs/active/<feature>/ACCEPTANCE.md`
  - `.specflow/specs/active/<feature>/INDEX.md`
  - `.specflow/docs/DESIGN.md`（若涉及前端/UI）

### 3) 计划阶段（Superpowers 强制）

- `brainstorming` 结束后，必须调用 `writing-plans`
- 计划文档通常位于 `docs/superpowers/plans/**`
- 计划必须受 `.specflow` 的 `SPEC.md` + `ACCEPTANCE.md` 约束

### 4) 实施阶段

- 使用：`specflow-implement-from-spec`
- 执行方式：
  - `subagent-driven-development`（优先）
  - 或 `executing-plans`
- 质量门禁：
  - `test-driven-development`
  - `verification-before-completion`
  - 不得超出 Spec 的 Non-Goals

### 5) 文档变更对齐阶段（随时触发）

- 文档变更即指令：使用 `specflow-document-alignment`
- 先输出对齐回执，再继续实现或验收

### 6) 验收与收尾阶段

- 使用：`/specflow accept <feature-name>`
- 逐条对照 `ACCEPTANCE.md` 提供证据
- 产出 `COMPLETION_REPORT.md`
- 归档 active feature 并更新 memory

### 颗粒度分层（强制）

- **SpecFlow 颗粒度：功能点（Capability）**
  - 一个 `.specflow/specs/active/<feature>/` 对应一个可独立验收的功能点
- **Superpowers 颗粒度：模块/任务**
  - 在 `docs/superpowers/specs/**` 与 `docs/superpowers/plans/**` 做模块设计与任务拆分

## 学习仓库

### 方法论与规格工程

- [vibe-coding-cn](https://github.com/2025Emma/vibe-coding-cn)
- [spec-kit](https://github.com/github/spec-kit)
- [OpenSpec](https://github.com/Fission-AI/OpenSpec)

### 执行流程与技能体系

- [superpowers](https://github.com/obra/superpowers)
- [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)

### 设计系统参考

- [awesome-design-md](https://github.com/VoltAgent/awesome-design-md)

