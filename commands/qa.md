---
description: "SpecFlow QA mode: acceptance evidence, completion report, archive, and memory updates"
---

Use this command to run acceptance and closure mode.

First response format (always):
- `Mode:` `complement-superpowers` or `specflow-only` (read from `.specflow/plugin.config.json` when available)
- `Superpowers auto-flow:` `enabled` or `disabled` (from `disableSuperpowers`)
- `Entry:` `/qa`

Behavior:
- Use `specflow-acceptance-and-archive`.
- Verify each item in `.specflow/specs/active/<feature>/ACCEPTANCE.md` with reproducible evidence.
- Require `verification-before-completion` before any "pass/done/fixed" statement.
- Generate `.specflow/specs/archive/<feature>/COMPLETION_REPORT.md`.
- Archive from `.specflow/specs/active/<feature>/` to `.specflow/specs/archive/<feature>/`.
- Update memory files:
  - `.specflow/memory/progress.md`
  - `.specflow/memory/active_context.md`
  - `.specflow/memory/decisions.md` (when decisions changed)

Do not:
- Accept "tests passed" as a substitute for itemized acceptance evidence.
- Archive when acceptance has unresolved items.
