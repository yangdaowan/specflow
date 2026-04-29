# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

SpecFlow 是一套面向 AI 辅助编码（Vibe Coding）的规格驱动工作流方法论，以 Superpowers 技能包形式落地。本仓库本身不包含应用代码——它维护 SpecFlow 的技能源码、插件清单、Hook 和模板标准件。

## 双平台插件架构

本仓库同时作为 Claude Code 和 Cursor 的插件发布：

- `.claude-plugin/plugin.json` — Claude Code 插件清单
- `.cursor-plugin/plugin.json` — Cursor 插件清单
- `hooks/hooks.json` — Claude Code 的 Hook 配置（`"${CLAUDE_PLUGIN_ROOT}"` 语法）
- `hooks/hooks-cursor.json` — Cursor 的 Hook 配置（`"${CURSOR_PLUGIN_ROOT}"` 语法）
- `hooks/session-start` — Bash 版 SessionStart hook 脚本
- `hooks/session-start.ps1` — PowerShell 版 SessionStart hook（Windows 回退）
- `hooks/run-hook.cmd` — 跨平台 polyglot 包装器（检测 Git Bash → 回退到 PowerShell）

**Hook 链**：`hooks.json` → `run-hook.cmd` → `session-start`（bash）或 `session-start.ps1`（PowerShell 回退）

SessionStart hook 的逻辑：
1. 读取 `.specflow/plugin.config.json`（enabled / integrationMode / disableSuperpowers）
2. 检查 `.specflow/` 核心文件是否存在（SPECFLOW.md / PRD.md / NFR.md / progress.md）
3. 注入 `specflow-session-bootstrap` 技能内容到会话上下文

## 技能体系（6 个技能包）

所有技能源码在 `skills/specflow-*/SKILL.md`，每个技能有独立的 `name` 和 `description` frontmatter：

| 技能 | 职责 | 触发时机 |
|------|------|----------|
| `specflow-session-bootstrap` | 会话启动注入、初始化硬门禁、Superpowers 共存规则 | SessionStart 自动注入 |
| `specflow-using-specflow` | 总览、轻量/完整双轨分流、Superpowers 互补规则、Karpathy 四原则 | 用户表达需求/验收/归档意图时 |
| `specflow-initialize-project` | 创建 `.specflow/` 目录体系与核心文档、模板同步、旧文件迁移 | `/specflow init` 或缺核心文件时 |
| `specflow-write-spec-and-acceptance` | 为 feature 产出 SPEC.md + ACCEPTANCE.md | `/specflow feature <name>` |
| `specflow-implement-from-spec` | 按规格实施（TDD 门禁 + 验收映射 + Step→Verify） | 规格就绪后进入实现 |
| `specflow-document-alignment` | 文档变更检测 → 对齐回执 → 受影响对象评估 | 文档修改后、实现前 |
| `specflow-acceptance-and-archive` | 逐条验收 → COMPLETION_REPORT → 归档 → memory 更新 → Git 提交 | `/specflow accept <name>` |

## 命令入口

`commands/specflow.md` 是统一的 `/specflow` 命令路由，支持子命令：`init` / `feature <name>` / `align` / `accept <name>` / `approve <name>` / `reject <name>`。

## 模板标准件

`skills/specflow-initialize-project/templates/` 包含 14+ 模板文件（SPECFLOW、PRD、NFR、SPEC、ACCEPTANCE、DESIGN、INDEX、COMPLETION_REPORT、REVIEW、STATUS.json、EVIDENCE 等）。初始化项目时从源码模板复制到目标 `.specflow/templates/`，保证跨项目一致性。

## 修改核心规则

- **技能源码是唯一事实来源**：修改技能行为只改 `skills/*/SKILL.md`，不要改构建产物
- **模板标准件**在 `skills/specflow-initialize-project/templates/`，修改模板需同步更新技能中引用模板的部分
- **Hook 脚本**（bash + PowerShell 回退）必须保持功能等价，改动时需要同步两端
- **版本号**在 `.claude-plugin/plugin.json` 和 `.cursor-plugin/plugin.json` 中维护
- **命令行为**在 `commands/specflow.md` 中定义，改命令路由时改此文件

## 设计原则

- SpecFlow 负责"做什么、做到什么标准"（规格、验收、归档）
- Superpowers 负责"按什么流程执行"（brainstorming → plan → TDD → verification）
- 互补不覆盖：两者同时安装时，SpecFlow 自动注入互补模式规则
- 文档即指令：人类修改任何 `.specflow/**` 文档即视为最新指令，实现必须重新对齐