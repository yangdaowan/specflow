---
description: "SpecFlow workflow entry command (init/feature/align/accept) with Superpowers-compatible gates"
---

Use this command as the SpecFlow workflow router.

First response format (always):
- `Mode:` `complement-superpowers` or `specflow-only` (read from `.specflow/plugin.config.json` when available)
- `Superpowers auto-flow:` `enabled` or `disabled` (from `disableSuperpowers`)
- `Selected route:` one of `init`, `feature <name>`, `align`, `accept <name>`, `approve <name>`, `reject <name>`

Argument parsing rules:
- Trim leading/trailing spaces.
- Treat multiple spaces as one separator.
- Case-insensitive match for `init`, `feature`, `align`, `accept`, `approve`, `reject`.
- Preserve `<name>` as kebab-case feature name; if invalid, ask user to provide a kebab-case name.

Interpret user arguments in this order:

1) `init`:
- Use `specflow-initialize-project` as a universal initializer for both new and existing projects.
- Keep Superpowers compatibility: do not introduce steps that bypass `brainstorming`, `test-driven-development`, or `verification-before-completion`.
- Initialize/repair only project-level SpecFlow skeleton and core docs; do not force full feature-level reconstruction during init.

2) `feature <name>`:
- If `.specflow/` is missing or core files are missing, run `specflow-initialize-project` first.
- Ensure feature path is `.specflow/specs/active/<name>/`.
- Start from `specflow-write-spec-and-acceptance` unless SPEC and ACCEPTANCE already exist.
- Ensure `.specflow/specs/active/<name>/INDEX.md` exists using the SpecFlow index template and links the related Superpowers design/plan docs.
- Never substitute `docs/superpowers/specs/**` for `.specflow/specs/active/<name>/SPEC.md`.
- If SPEC/ACCEPTANCE exist but INDEX is missing, create INDEX before continuing.

3) `align`:
- Use `specflow-document-alignment`.
- Produce a concise alignment receipt before implementation changes.

4) `accept <name>`:
- Check `.specflow/specs/active/<name>/SPEC.md`, `ACCEPTANCE.md`, and `INDEX.md` before acceptance flow.
- If any are missing, trigger `specflow-write-spec-and-acceptance` in minimal patch-recovery mode, then continue acceptance.
- Use `specflow-acceptance-and-archive`.
- Enforce evidence-per-item acceptance and verification-before-completion before any success claim.

5) `approve <name>`:
- Treat this as human acceptance confirmation contract (`APPROVE <feature-name>`).
- Update `.specflow/reviews/<name>/STATUS.json` decision to `approved`, then continue `specflow-acceptance-and-archive`.

6) `reject <name>`:
- Treat this as human rejection contract (`REJECT <feature-name>: <reason>`).
- Update `.specflow/reviews/<name>/STATUS.json` decision to `rejected`.
- Stop closure flow and return to `specflow-implement-from-spec` with explicit remediation items.

If no recognized subcommand is provided:
- Ask one concise clarifying question with options:
  - `init`
  - `feature <name>`
  - `align`
  - `accept <name>`
  - `approve <name>`
  - `reject <name>`
- Also print this help-style block:

```text
SpecFlow Command Help

Usage:
  /specflow init
  /specflow feature <feature-name>
  /specflow align
  /specflow accept <feature-name>
  /specflow approve <feature-name>
  /specflow reject <feature-name>

Subcommands:
  init                  Initialize/repair project SpecFlow structure
  feature <name>        Start or continue feature spec workflow
  align                 Re-align code/tests/plan to changed docs
  accept <name>         Run acceptance, archive, and memory updates
  approve <name>        Human confirms acceptance decision and continues closure
  reject <name>         Human rejects acceptance decision and sends feature back

Examples:
  /specflow init
  /specflow feature user-points
  /specflow align
  /specflow accept user-points
  /specflow approve user-points
  /specflow reject user-points
```

Note:
- SpecFlow uses `/specflow ...` as the single command entrypoint.

If arguments are malformed, respond with:
- A one-line error
- A valid usage list:
  - `/specflow init`
  - `/specflow feature <feature-name>`
  - `/specflow align`
  - `/specflow accept <feature-name>`
  - `/specflow approve <feature-name>`
  - `/specflow reject <feature-name>`
- And include the same `SpecFlow Command Help` block.
