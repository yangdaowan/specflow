# SpecFlow — 从文档驱动到按需工具

## 评估结论（2026-04-30）

### 实验背景

在 **布草洗涤管理系统**（Flask + React + SQLite + Docker，8 个功能模块）中完整走了一次 SpecFlow 工作流。项目配置：**Claude Code + DeepSeek v4-pro + Superpowers 插件**。

### 数据事实

分析 11 个对话记录文件（共 2052 行）的结论：

| 指标 | 数据 |
|------|:--:|
| 总会话数 | 8 |
| 主开发会话行数 | 1209 |
| 主开发会话工具调用 | 167 |
| Skill 工具正式调用 | 1 次（`using-superpowers`） |
| SpecFlow 技能被调用 | 仅 `session-bootstrap`（Hook 自动）×8 + `initialize-project`（手动触发）×1 |
| `write-spec-and-acceptance` 调用 | 0 |
| `implement-from-spec` 调用 | 0 |
| `acceptance-and-archive` 调用 | 0 |

### 核心结论

1. **SpecFlow 全程旁观，代码质量不降**：1209 行的 Mega Session 走的是 Superpowers 流程（brainstorming → plan → TDD → verify），SpecFlow 的文档驱动体系从未被使用，但项目仍然高效、高质量地完成了全部 8 个模块。

2. **文档产生重复而非增值**：`docs/需求文档.md` → PRD.md + NFR.md + DESIGN.md + 28 个模板，本质是格式转换，没有知识增量。PRD 中的功能清单表和 README 中的表格内容高度重复。

3. **DeepSeek v4-pro 不需要结构化 SPEC 约束**：SpecFlow 的核心假设是"AI 需要结构化 SPEC/ACCEPTANCE 来约束行为"，但强模型从口语化需求文档就能直接工作。

4. **Superpowers 已经覆盖了流程治理**：brainstorming → writing-plans → TDD → verification-before-completion 这条链路提供了完整的"怎么做"纪律。SpecFlow 试图在"做什么"层面再加一层，在实际使用中变成了纯粹的 overhead。

5. **`session-bootstrap` Hook 是噪音而非价值**：8 个会话每次 SessionStart 都注入 4788 行的 SPECFLOW.md 到上下文，但在整个开发过程中从未被回头引用。

### SpecFlow 在什么场景下还有价值

| 场景 | 价值判断 |
|------|------|
| 一人 + 强模型 + Superpowers | **负资产**（当前场景） |
| 弱模型做 code agent | 可能有用，需要结构化输入 |
| 多人协作（PM → Dev → QA） | 正式交付文档生成有独特价值 |
| 政府采购合规审计 | GB/T 8567 文档生成不可替代 |
| 大团队多项目标准化 | SPEC/ACCEPTANCE 模板统一性有价值 |
| 不使用 Superpowers 的环境 | 流程门禁有独立存在意义 |

### 插件重组策略

基于以上结论，SpecFlow 已精简为 **2 个独立技能**：

| 保留 | 原因 |
|------|------|
| `generate-deliverables`（项目级） | GB/T 8567 正式文档生成，Superpowers 做不到 |
| `chinese-commit-conventions` | 中文团队的 commit 规范，有独立实用价值 |

| 移除 | 原因 |
|------|------|
| `session-bootstrap` | 上下文噪音，零有效调用 |
| `using-specflow` | 治理规则从未被遵循 |
| `initialize-project` | 产出的文档从未被使用 |
| `write-spec-and-acceptance` | 0 次调用 |
| `implement-from-spec` | 0 次调用 |
| `pm-doc-sync` | 文档同步从未发生 |
| `document-alignment` | 对齐流程从未触发 |
| `acceptance-and-archive` | 验收闭环从未执行 |
| `specflow` 命令 | 入口路由从未被使用 |

---

## 当前功能

两个独立技能，无 Hook、无 SessionStart 注入、无命令入口。

### 1. `generate-deliverables` — 项目级 GB/T 8567 正式文档生成

从项目代码 + 已有文档直接提取信息，一次性生成 7 种 GB/T 8567 文档到 `docs/`：

| 文档 | 主要信息源 |
|------|-----------|
| 概要设计说明书 | README + PRD + DESIGN + 代码结构 |
| 详细设计说明书 | 代码（路由/模型/组件）+ decisions |
| 数据库设计文档 | ORM 模型 / SQLAlchemy 模型 |
| 接口文档 | Flask 路由 / blueprint |
| 验收测试报告 | README 功能状态 + 手工验证记录 |
| 部署运维手册 | docker-compose.yml + Dockerfile + nginx.conf |
| 用户操作手册 | 前端页面结构 + 路由 + README |

触发：说"生成正式文档"、"生成交付文档"即可。

与旧版的区别：
- 旧版依赖 SPEC/ACCEPTANCE（功能级），按功能逐个生成
- 新版直接从项目代码和文档提取，项目一次生成 7 份

### 2. `chinese-commit-conventions` — 中文 Git 提交规范

基于 Conventional Commits 1.0.0，适配国内团队。AI 提交代码时自动生成符合规范的中文 commit message。

---

## 安装

将 `specflow-minimal@local` 添加到 `~/.claude/settings.json`：

```json
{
  "enabledPlugins": {
    "specflow-minimal@local": true
  },
  "extraKnownMarketplaces": {
    "local": {
      "source": {
        "source": "directory",
        "path": "C:\\Users\\<用户名>\\.claude\\custom-plugins\\specflow-minimal"
      }
    }
  }
}
```

## 项目结构

```text
skills/
├── generate-deliverables/
│   └── SKILL.md          # 项目级 GB/T 8567 文档生成
└── chinese-commit-conventions/
    └── SKILL.md          # 中文 Git 提交规范
```
