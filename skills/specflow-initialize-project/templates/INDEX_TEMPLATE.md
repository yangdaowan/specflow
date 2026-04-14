# <feature-name> — INDEX

> 目标：在 “Superpowers 文档（设计/计划）” 与 “SpecFlow 文档（规格/验收）” 双体系并存时，提供单一入口索引，避免文档漂移与找不到当前版本。

## Related Superpowers Docs

- **Design (brainstorming output)**: `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- **Plan (writing-plans output)**: `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

## Related SpecFlow Docs

- **Spec**: `.specflow/specs/active/<feature-name>/SPEC.md`
- **Acceptance**: `.specflow/specs/active/<feature-name>/ACCEPTANCE.md`

## Stage Authority (Conflict Resolution)

When the documents disagree, decide the source of truth by stage:

- **Design / Clarification**: `docs/superpowers/specs/**` (constrained by `.specflow/CONSTITUTION.md`, `.specflow/RULES.md`, `.specflow/docs/*`)
- **Spec Freeze (Delivery Boundary)**: `.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md`
- **Implementation**: `docs/superpowers/plans/**` (must not violate Spec Non-Goals; must cover Acceptance)
- **Acceptance / Archive**: `.specflow/specs/active/<feature>/ACCEPTANCE.md` (evidence per item)

## Notes

- Keep this file updated whenever you create or rename the linked docs.
- If `.specflow/specs/active/<feature>/SPEC.md` or `ACCEPTANCE.md` changes, treat it as “修改即指令” and re-align plan/tests/implementation.
