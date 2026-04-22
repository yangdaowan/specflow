## Vibe Coding 之 SpecFlow 方法论指南

**名称**：SpecFlow（规格驱动工作流）

**口号**：*Write the Spec, Flow with AI.*

> 核心理念：**以结构化文档为唯一事实来源，人类与 AI 协作生成规格，AI 自动对齐执行，人类保留最终验收权。**

---

## SpecFlow 与 Vibe Coding 的关系

“Vibe Coding”一词最初指“不审查 AI 生成的代码，完全依赖氛围构建软件”。

SpecFlow 是 **Vibe Coding 的约束工程学派**。

我们保留了 Vibe Coding 的核心优势：
- 用自然语言快速驱动 AI
- 在探索阶段保持高带宽的思维流动

同时引入了软件工程的纪律：
- 用结构化文档固化“氛围”，使其可追踪、可复用
- 用验收清单和 TDD 确保产出质量
- 用 Git 实现人机协作的变更感知

如果你想要的是“完全放任 AI 写代码，碰运气跑通”——SpecFlow 不适合你。
如果你想要的是“用 AI 加速，但依然能交付生产级软件”——欢迎使用 SpecFlow。

---

### 一、核心理念

| 要素 | 说明 |
| :--- | :--- |
| **文档即中枢** | 所有需求、架构、验收标准均以 Markdown 文档形式存在于项目仓库中，构成唯一事实来源。 |
| **协作生成** | 文档由人类与 AI 共同产出：人类提想法，AI 出草稿，人类修改定稿。 |
| **修改即指令** | 人类对任何文档的修改，即视为对 AI 的最新指令，AI 必须在后续行为中自动对齐。 |
| **AI 驱动执行** | AI 负责根据文档生成测试、代码、验收报告，并执行归档与记忆更新。 |
| **人类保留终裁权** | 人类可随时查看 AI 的执行细节，指出不符之处，打回重做。 |

---

### 二、适用场景

- ✅ 需要长期维护、多人协作的产品级项目。
- ✅ 有明确交付标准和验收要求的商业项目。
- ✅ 有架构经验、希望精准控制交付质量的开发者。
- ⚠️ 快速原型验证、一次性脚本、探索性 Demo：不建议使用“完整 SpecFlow”，但可以使用 **轻量 SpecFlow**（最小验收点 + 最小可复现验证），以避免完全失控的氛围编程。

---

### 三、文件体系（唯一事实来源）

> 本文件体系设计为**工具无关**，适用于 Claude Code、Cursor、OpenCode、GitHub Copilot 等任何支持读取项目文件的 AI 编码工具。

```text
项目根目录/
│
├── .specflow/                          # SpecFlow 中枢目录（统一迁移）
│   ├── AGENTS.md                       # AI 行为准则（每次会话自动加载，部分工具需手动引用）
│   ├── CONSTITUTION.md                 # 项目宪法（不可变最高原则）
│   ├── RULES.md                        # 技术架构与规范（Schema、状态机、分层约束）
│   │
│   ├── docs/
│   │   ├── PRD.md                      # 产品需求全景图
│   │   ├── NFR.md                      # 非功能性需求（性能、安全、可观测性）
│   │   └── DESIGN.md                   # UI/UX 设计基线（视觉、组件、交互、响应式）
│   │
│   ├── specs/
│   │   ├── active/                     # 进行中的功能
│   │   │   └── [feature-name]/
│   │   │       ├── SPEC.md             # 需求规格说明书
│   │   │       ├── ACCEPTANCE.md       # 验收标准清单
│   │   │       └── plan.md             # 实施计划（AI 生成，可选）
│   │   └── archive/                    # 已完成归档
│   │       └── [feature-name]/
│   │           ├── SPEC.md
│   │           ├── ACCEPTANCE.md
│   │           └── COMPLETION_REPORT.md
│   │
│   ├── memory/
│   │   ├── progress.md                 # 整体进度追踪
│   │   ├── active_context.md           # 当前聚焦任务与待办
│   │   └── decisions.md                # 架构决策记录（ADR）
│   │
│   ├── scripts/                        # 自动化工具链（可选）
│   │   ├── new-feature.sh
│   │   └── archive-feature.sh
│   └── templates/                      # 文档模板（与 scripts 同级）
│       ├── SPEC_TEMPLATE.md
│       └── ACCEPTANCE_TEMPLATE.md
│
└── tests/                              # 测试用例（AI 生成，人类可修改）
    └── [feature-name]_test.xx
```

---

### 3.1 与 Superpowers 的关系（互补不冲突）

SpecFlow 的定位是 **补充** Superpowers：

- **Superpowers**：提供流程纪律（brainstorming → plan → 执行 → TDD → review → verification）
- **SpecFlow**：提供规格治理（文档即中枢、修改即指令、验收清单、归档与记忆）

两者同时启用时必须做到“绝对不冲突”，因此采用 **双文档体系并存 + 阶段主文档** 的规则。

#### A) 双文档体系并存（分工明确）

SpecFlow 与 Superpowers 的文档产物同时存在，且不强行合并到单一路径：

- `docs/superpowers/specs/**`：设计讨论与取舍（如何做/为什么这么做）
- `docs/superpowers/plans/**`：实施计划（按步骤怎么做）
- `.specflow/**`：交付标准与治理（做什么/做到什么算完成/验收与归档）

#### B) 阶段主文档（谁说了算）

当两套文档对同一问题存在差异时，以当前阶段的“主判定来源”为准：

- **需求澄清/设计阶段**：`docs/superpowers/specs/**` 为主，但必须受 `.specflow/CONSTITUTION.md` / `.specflow/RULES.md` / `.specflow/docs/*` 的约束
- **规格冻结阶段（交付边界）**：`.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md` 为主
- **实施阶段**：`docs/superpowers/plans/**` 为主，但不得越过 `.specflow/.../SPEC.md` 的 Non-Goals，并必须覆盖 `.specflow/.../ACCEPTANCE.md`
- **验收/归档阶段**：`.specflow/.../ACCEPTANCE.md` 为主（逐条证据），并生成 `COMPLETION_REPORT.md`、归档与 memory 更新

#### C) 不绕过 Superpowers 的硬门禁

为确保过程纪律不被稀释：

- 在进入实现前：必须先走 `brainstorming` 并获得人类认可
- 任何生产代码变更：必须遵守 `test-driven-development`（先见红后写实现）
- 在宣称“完成/通过/修复”前：必须走 `verification-before-completion`（新鲜证据）

#### D) Feature 关联索引（强制）

为避免“双文档体系”长期维护困难，每个 feature 必须维护索引：

- `.specflow/specs/active/<feature-name>/INDEX.md`

索引至少包含：
- 对应的 `docs/superpowers/specs/**`（设计文档路径）
- 对应的 `docs/superpowers/plans/**`（计划文档路径）
- SpecFlow 的 `SPEC.md` / `ACCEPTANCE.md`
- 当前阶段与主判定来源说明

#### E) 颗粒度分层（强制）

为保证 Superpowers 与 SpecFlow 互补，采用分层颗粒度：

- **SpecFlow：功能点颗粒度（Capability）**
  - 一个 `.specflow/specs/active/<feature>/` 必须对应一个可独立验收的业务功能点。
- **Superpowers：模块/任务颗粒度**
  - 在 `docs/superpowers/specs/**` 与 `docs/superpowers/plans/**` 中按模块与任务细化实现路径。

不要把两者做成同一颗粒度：SpecFlow 不负责模块级任务拆分，Superpowers 不替代 SpecFlow 的功能点交付边界。

**文件命名规范：**
- 核心规则文件：大写蛇形命名（`CONSTITUTION.md`, `RULES.md`）。
- 功能级文档：目录使用小写短横线命名（`user-points`），文件大写（`SPEC.md`, `ACCEPTANCE.md`）。
- 动态记忆库：小写蛇形命名（`progress.md`, `active_context.md`）。

---

### 四、命令入口（统一）

在 Cursor 插件落地形态下，命令入口统一为 `/specflow ...`，避免多入口造成工作流偏移。

---

### 五、双轨工作流

#### 🚀 轨道一：从零开始的新项目

```mermaid
graph TD
    A[人类提出想法] --> B(AI 辅助分析进行头脑风暴)
    B --> C[AI 生成 PRD 草稿]
    C --> D{人类审阅/修改}
    D --> E[AI 生成 CONSTITUTION 草稿]
    E --> F{人类审阅/修改}
    F --> G[AI 生成 RULES 草稿]
    G --> H{人类审阅/修改}
    H --> I[AI 拆解功能, 生成 SPEC & ACCEPTANCE 草稿]
    I --> J{人类审阅/修改}
    J --> K[AI 执行 TDD: 先生成测试用例]
    K --> L{人类查看及验收功能测试, 可修改}
    L --> M{AI 运行测试, 若失败则沟通}
    M -- 存在变更（需求/技术等） --> N[人类手动修改相关文档，并发给AI。或者和AI讨论后确定新技术方案，自动同步相关文档]
    N --> I
    M -- 测试通过 --> O[AI 实施完整开发]
    O --> P[AI 自动对照 ACCEPTANCE 执行验收]
    P --> Q{人类查看验收报告}
    Q -- 不符 --> R[人类指出不符点]
    R --> O
    Q -- 通过 --> S[AI 自动归档 & 更新 memory]
```

**人类手动介入点：**
- 每个文档草稿生成后，均可直接编辑修改。
- 测试用例生成后，可手动修改以强化边界。
- 验收报告中任何不符，可打回重做。
- 技术选型变更时，手动修改 `.specflow/RULES.md` 或 `.specflow/CONSTITUTION.md`。

#### 🔄 轨道二：现有项目改造（OpenSpec 风格）

```mermaid
graph TD
    A[人类提供现有项目代码] --> B(AI 扫描代码库)
    B --> C[AI 还原生成 PRD/CONSTITUTION/RULES 草稿]
    C --> D{人类审阅/修正}
    D --> E[人类提出修改需求]
    E --> F(AI 扫描相关代码, 生成变更 SPEC 草稿)
    F --> G{人类审阅/修改 SPEC & ACCEPTANCE}
    G --> H[后续流程同轨道一的步骤 K~S]
```

---

### 五点五、交付质量验收基线（通用）

为补足“只追求接口通/功能通”的常见偏差，SpecFlow 默认要求在收尾阶段执行以下验收基线：

- **需求一致性**：功能行为、信息展示、交互体验、结构关系逐条对齐
- **i18n/L10n**：无 key 泄漏；日期/数字/状态码可读化；禁止 `Invalid Date`、`NaN`、原始对象直出
- **UI 可读性**：分组清晰、留白合理、空值与异常值有兜底显示
- **状态生命周期**：重复打开关闭、模式切换、路由切换/回退、异步竞态行为可预期
- **数据规范化**：展示前做格式与类型规范化，不把后端原始结构直接展示给用户
- **回归检查**：主修复点 + 关联模块 + 至少一个异常路径，避免“修 A 坏 B”

完成声明必须遵守：
- 未通过验收，禁止说“已完成/已修复/可交付”
- 最终输出必须包含：What changed、Why、How to verify、Risks/Limitations

---

### 五点六、执行风格约束（融合 Karpathy 四原则）

为进一步降低“氛围编程”常见偏差，SpecFlow 默认叠加以下执行风格：

- **Think Before Coding**：先澄清再实现。遇到歧义时列出假设或备选解释并向人类确认。
- **Simplicity First**：最小可行实现。只做当前需求与验收明确要求，禁止提前抽象。
- **Surgical Changes**：手术式改动。每处改动都必须可追溯到 SPEC/ACCEPTANCE 的具体条目。
- **Goal-Driven Execution**：目标驱动执行。任务采用“步骤 -> 验证”闭环，无证据不下完成结论。

该约束层与既有分工关系：
- 不替代 Superpowers 的流程门禁（brainstorming / writing-plans / TDD / verification）
- 不替代 SpecFlow 的文档治理（SPEC/ACCEPTANCE/归档/memory）
- 仅用于约束 AI 在每一步中的思考与改动方式

---

### 五点七、设计基线前置（UI 质量前移）

为避免“实现完成后才发现前端质量失控”，SpecFlow 增加前置设计约束：

- 若任务涉及前端/UI，实现前必须读取 `.specflow/docs/DESIGN.md`
- 可在设计阶段参考外部设计模板（如 DESIGN.md 风格库），但最终必须固化回项目内 `DESIGN.md`
- 页面级偏离规则应记录在 feature 文档中，并在验收中逐条核对
- 验收时除功能正确外，还需检查 Design Conformance（颜色、字阶、组件、交互、响应式）

---

### 六、操作口令表（工具通用版）

| 场景 | 口令模板 |
| :--- | :--- |
| **初始化项目** | `“/specflow init（通用初始化，覆盖新项目与现有项目）。”` |
| **拆解功能** | `“/specflow feature <feature-name>。根据 .specflow/docs/PRD.md 与规则，生成/更新 SPEC.md 与 ACCEPTANCE.md（并维护 INDEX.md）。”` |
| **开始开发** | `“在 SPEC/ACCEPTANCE 完整且 INDEX 已就位后，按 specflow-implement-from-spec 实施；需要计划时使用 writing-plans。”` |
| **执行验收** | `“/specflow accept <feature-name>。逐条对照 ACCEPTANCE.md 生成证据与完工报告，并归档与更新 memory。”` |
| **指出不符** | `“验收项 X.X 与 ACCEPTANCE.md 不符，具体表现为 [描述]，请修正代码并重新验收。”` |
| **技术变更** | `“我修改了 .specflow/RULES.md 中的 [某部分]，请先产出对齐回执并按需对齐相关代码/测试，不做不必要全量重扫。”` |
| **现有项目** | `“先执行 /specflow init（通用初始化），完成 .specflow 项目级骨架与核心文档草稿，然后我将提出修改需求。”` |
| **归档功能** | `“/specflow accept <feature-name>。验收通过后生成完工报告，归档至 .specflow/specs/archive，更新 .specflow/memory。”` |

---

### 七、模板文件

为避免 README 过长，模板已拆分到 `.specflow/templates/`：

- `AGENTS_TEMPLATE.md`（AI 行为准则模板）
- `CONSTITUTION_TEMPLATE.md`（项目宪法模板）
- `RULES_TEMPLATE.md`（技术规范模板）
- `PRD_TEMPLATE.md`（产品需求模板）
- `NFR_TEMPLATE.md`（非功能性需求模板）
- `DESIGN_TEMPLATE.md`（UI/UX 设计基线模板）
- `SPEC_TEMPLATE.md`（功能规格模板）
- `ACCEPTANCE_TEMPLATE.md`（验收清单模板）
- `PROGRESS_TEMPLATE.md`（进度追踪模板）
- `ACTIVE_CONTEXT_TEMPLATE.md`（当前上下文模板）
- `DECISIONS_TEMPLATE.md`（架构决策记录模板，可选）

---

### 八、Superpowers 技能包（自动构建与部署）

本仓库支持将 SpecFlow 方法论封装为可分发的 **Superpowers 技能包**：

- **源码（单一事实来源）**：
  - 技能源码：`skills/`
  - 模板源码：`.specflow/templates/`
- **构建产物**：`superpowers-skills/specflow/`
- **部署目标**：任意项目的 `.superpowers/skills/specflow/`

#### 构建
- Windows（PowerShell）：
  - 运行：`scripts/build-superpowers-skill.ps1`
- macOS/Linux（bash）：
  - 运行：`scripts/build-superpowers-skill.sh`

#### 部署到任意项目
- Windows（PowerShell）：
  - 在目标项目根目录运行：`<此仓库>/install.ps1`
- macOS/Linux（bash）：
  - 在目标项目根目录运行：`<此仓库>/install.sh`

#### 使用
- `/specflow init new`：新项目初始化
- `/specflow init old`：现有项目初始化
- `/specflow <需求>`：直接进入工作流编排
- 命令入口统一为：`/specflow ...`

> 注：上述“口令”是跨工具通用的 **语义触发方式**。在 Cursor 中可以通过插件命令映射实现真正的内置命令；未实现映射前，仍可通过自然语言或以“/xxx”开头的文本触发同等语义流程。
