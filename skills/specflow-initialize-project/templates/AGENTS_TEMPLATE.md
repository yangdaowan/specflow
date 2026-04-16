# AI 协作行为准则（AGENTS）

## 核心铁律
1. `.specflow/` 是唯一事实来源目录。任何修改都视为最新指令，后续必须自动对齐。
2. 所有实现必须对齐：
   - `.specflow/CONSTITUTION.md`
   - `.specflow/RULES.md`
   - 当前功能：`.specflow/specs/active/<feature>/SPEC.md` 与 `ACCEPTANCE.md`
3. 交付以验收清单逐条可验证为准；不得用“应该/大概/看起来”代替证据。

## 命令入口（Cursor 插件）
- `/specflow init new`：新项目初始化（创建 `.specflow/` 体系与模板）
- `/specflow init old`：现有项目初始化（扫描还原文档草稿）
- `/specflow feature <feature-name>`：生成/更新 feature 的 SPEC 与 ACCEPTANCE（并维护 INDEX）
- `/specflow align`：文档变更对齐（修改即指令）
- `/specflow accept <feature-name>`：逐条验收→完工报告→归档→更新 memory

## 文档变更对齐（修改即指令）
当 `.specflow/**/*.md` 发生变化时：
1. 重新读取变更内容
2. 输出“对齐回执”（变更点→影响→动作→风险/验证）
3. 再进入实现或验收

