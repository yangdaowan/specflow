# SpecFlow — 规格驱动工作流

一套面向 **Vibe Coding** 的工程化方法论，以 Claude Code / Cursor 插件形式落地。

**核心理念**：文档是产品经理的"代码"，AI 是编译/反编译引擎。PM 修改业务文档后 git commit，AI 自动同步代码；AI 修改代码后，文档自动同步刷新。

## 三层文档体系

```
第 1 层：PM 文档 (.specflow/pm-docs/<feature>/)
   → PM_SPEC.md + PM_ACCEPTANCE.md，纯业务语言，PM 可直接修改

第 2 层：技术规格 (.specflow/specs/active/<feature>/)
   → SPEC.md + ACCEPTANCE.md，面向 AI/开发者

第 3 层：正式交付文档 (.specflow/deliverables/<feature>/)
   → 7 种 GB/T 8567 文档，手动触发
```

## 9 个技能

| 技能 | 职责 | 触发 |
|------|------|------|
| `specflow-session-bootstrap` | 会话启动注入、初始化门禁、同步触发检测 | SessionStart 自动 |
| `specflow-using-specflow` | 总览、双轨分流、Superpowers 互补规则 | 需求/验收/归档意图 |
| `specflow-initialize-project` | 创建 `.specflow/` 骨架、模板、Git Hook | `/specflow init` |
| `specflow-write-spec-and-acceptance` | 产出 SPEC + ACCEPTANCE + PM 文档 | `/specflow feature <name>` |
| `specflow-pm-doc-sync` | PM 文档 ↔ 技术规格双向同步 | Git commit 自动 或 `/specflow sync` |
| `specflow-implement-from-spec` | 按规格 TDD 实现 + 验收映射 | 规格就绪后 |
| `specflow-document-alignment` | 文档变更检测 → 对齐回执 | 文档修改后 |
| `specflow-acceptance-and-archive` | 验收 → 归档 → memory → Git | `/specflow accept <name>` |
| `specflow-generate-deliverables` | 7 种 GB/T 8567 正式文档 | `/specflow deliverables <name>`（手动） |

## 命令

```
/specflow init                        初始化文档体系
/specflow feature <name>              写规格与验收 + PM 文档
/specflow align                       文档变更后对齐
/specflow sync [--direction ...]      PM ↔ SPEC 双向同步
/specflow accept <name>               验收归档闭环
/specflow deliverables <name>         生成 GB/T 8567 正式文档
```

## 双向同步

通过 Git post-commit Hook 自动触发：

```
PM 改 PM_SPEC → commit → Hook 写标记 → SessionStart 检测 → AI 同步 SPEC + 代码
AI 改代码 → commit → Hook 写标记 → SessionStart 检测 → AI 同步 PM 文档
```

初始化时自动安装 Hook。也可手动 `/specflow sync`。

## 双轨分流

**轻量**（个人/小任务）：ACCEPTANCE.md（3-8 条）+ 至少 1 条验证，跳过完整 PRD。

**完整**（团队/长期）：三层文档 + TDD + 验收归档 + memory + 双向同步。

## 文件体系

```text
.specflow/
├── SPECFLOW.md                         # 项目章程
├── .sync-trigger.json                  # 同步标记（自动）
├── docs/
│   ├── PRD.md                          # 产品全景图
│   ├── NFR.md                          # 非功能需求
│   └── DESIGN.md                       # UI/UX 基线
├── specs/
│   ├── active/<feature>/
│   │   ├── SPEC.md                     # 技术规格
│   │   ├── ACCEPTANCE.md               # 验收清单
│   │   └── INDEX.md                    # 跨文档索引
│   └── archive/<feature>/
│       └── COMPLETION_REPORT.md        # 完工报告
├── pm-docs/<feature>/
│   ├── PM_SPEC.md                      # PM 产品规格（纯业务语言）
│   └── PM_ACCEPTANCE.md                # PM 验收标准（用户视角）
├── deliverables/<feature>/             # GB/T 8567（手动生成）
│   ├── ARCHITECTURE_OVERVIEW.md        # 概要设计
│   ├── DETAILED_DESIGN.md              # 详细设计
│   ├── DATABASE_DESIGN.md              # 数据库设计
│   ├── API_INTERFACE.md                # 接口文档
│   ├── ACCEPTANCE_TEST_REPORT.md       # 验收测试报告
│   ├── DEPLOYMENT_AND_OPS.md           # 部署运维手册
│   └── USER_MANUAL.md                  # 用户操作手册
├── memory/
│   ├── progress.md                     # 进度
│   ├── active_context.md               # 当前上下文
│   └── decisions.md                    # 关键决策（ADR）
├── scripts/
│   ├── post-commit                     # Git Hook（Bash）
│   └── post-commit.ps1                 # Git Hook（PS）
└── templates/                          # 模板标准件
```

## 项目开关

`.specflow/plugin.config.json`：
```json
{ "enabled": true, "integrationMode": "complement-superpowers", "disableSuperpowers": false }
```

- `enabled: false` → 关闭 SpecFlow
- `integrationMode: "specflow-only"` → 脱离 Superpowers 独立运行

## 约定

- **文档即中枢**：`.specflow/**` 是唯一事实来源
- **修改即指令**：人类改文档，AI 自动重新对齐
- **验收清单优先**：逐条可验证，有证据才算完成
- **Karpathy 四原则**：先澄清、求简单、手术式改动、目标驱动验证

## 与 Superpowers 并存

- Superpowers：流程纪律（头脑风暴 → 计划 → TDD → 验证）
- SpecFlow：规格治理（做什么、怎样算完成）
- SessionStart 自动注入共存规则，互补不冲突

## 学习参考

- [spec-kit](https://github.com/github/spec-kit)
- [OpenSpec](https://github.com/Fission-AI/OpenSpec)
- [superpowers](https://github.com/obra/superpowers)
- [ouroboros](https://github.com/Q00/ouroboros)
