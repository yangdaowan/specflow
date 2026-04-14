---
description: "SpecFlow PM mode: requirements and acceptance authoring, compatible with Superpowers brainstorming gate"
---

Use this command to run Product/Spec authoring mode.

First response format (always):
- `Mode:` `complement-superpowers` or `specflow-only` (read from `.specflow/plugin.config.json` when available)
- `Superpowers auto-flow:` `enabled` or `disabled` (from `disableSuperpowers`)
- `Entry:` `/pm`

Behavior:
- If request is a new feature or behavior change, run `brainstorming` first and get user approval of design.
- Then use `specflow-write-spec-and-acceptance` to produce:
  - `.specflow/specs/active/<feature>/SPEC.md`
  - `.specflow/specs/active/<feature>/ACCEPTANCE.md`
- Ensure terms are consistent, Non-Goals are explicit, and each acceptance item is verifiable.
- Ensure `.specflow/specs/active/<feature>/INDEX.md` exists and links related Superpowers docs.

Do not:
- Start implementation code in this mode.
- Bypass the brainstorming approval gate for behavior-changing work.
