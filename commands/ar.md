---
description: "SpecFlow AR mode: implementation from SPEC/ACCEPTANCE with plans + TDD + verification gates"
---

Use this command to run Architect/Developer implementation mode.

First response format (always):
- `Mode:` `complement-superpowers` or `specflow-only` (read from `.specflow/plugin.config.json` when available)
- `Superpowers auto-flow:` `enabled` or `disabled` (from `disableSuperpowers`)
- `Entry:` `/ar`

Behavior:
- Read the current feature's `.specflow/specs/active/<feature>/SPEC.md` and `ACCEPTANCE.md` before touching code.
- Use `specflow-implement-from-spec`.
- If no implementation plan exists, invoke `writing-plans`.
- Execute with either:
  - `executing-plans` for smaller/in-session execution, or
  - `subagent-driven-development` for independent multi-task work.
- Enforce `test-driven-development` before any production code change.
- Before any completion claim, enforce `verification-before-completion`.

Do not:
- Implement outside SPEC scope.
- Skip failing-test-first TDD cycle.
- Claim success without fresh verification evidence.
