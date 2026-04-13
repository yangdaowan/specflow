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
│   │   └── NFR.md                      # 非功能性需求（性能/安全/可观测性/可用性）
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

