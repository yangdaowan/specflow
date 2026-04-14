---
description: "SpecFlow workflow entry command (init/feature/align/accept) with Superpowers-compatible gates"
---

Use this command as the SpecFlow workflow router.

First response format (always):
- `Mode:` `complement-superpowers` or `specflow-only` (read from `.specflow/plugin.config.json` when available)
- `Superpowers auto-flow:` `enabled` or `disabled` (from `disableSuperpowers`)
- `Selected route:` one of `init new`, `init old`, `feature <name>`, `align`, `accept <name>`

Argument parsing rules:
- Trim leading/trailing spaces.
- Treat multiple spaces as one separator.
- Case-insensitive match for `init`, `new`, `old`, `feature`, `align`, `accept`.
- Preserve `<name>` as kebab-case feature name; if invalid, ask user to provide a kebab-case name.

Interpret user arguments in this order:

1) `init new`:
- Use `specflow-initialize-project` to initialize a new project with `.specflow/` structure and templates.
- Keep Superpowers compatibility: do not introduce steps that bypass `brainstorming`, `test-driven-development`, or `verification-before-completion`.

2) `init old`:
- Use `specflow-initialize-project` in existing-project mode.
- Reconstruct draft docs from current codebase, then ask user to review and correct.

3) `feature <name>`:
- Ensure feature path is `.specflow/specs/active/<name>/`.
- Start from `specflow-write-spec-and-acceptance` unless SPEC and ACCEPTANCE already exist.
- Ensure `.specflow/specs/active/<name>/INDEX.md` exists using the SpecFlow index template and links the related Superpowers design/plan docs.

4) `align`:
- Use `specflow-document-alignment`.
- Produce a concise alignment receipt before implementation changes.

5) `accept <name>`:
- Use `specflow-acceptance-and-archive`.
- Enforce evidence-per-item acceptance and verification-before-completion before any success claim.

If no recognized subcommand is provided:
- Ask one concise clarifying question with options:
  - `init new`
  - `init old`
  - `feature <name>`
  - `align`
  - `accept <name>`
- Also print this help-style block:

```text
SpecFlow Command Help

Usage:
  /specflow init new
  /specflow init old
  /specflow feature <feature-name>
  /specflow align
  /specflow accept <feature-name>

Subcommands:
  init new              Initialize new project SpecFlow structure
  init old              Initialize SpecFlow for existing project
  feature <name>        Start or continue feature spec workflow
  align                 Re-align code/tests/plan to changed docs
  accept <name>         Run acceptance, archive, and memory updates

Examples:
  /specflow init new
  /specflow feature user-points
  /specflow align
  /specflow accept user-points
```

If arguments are malformed, respond with:
- A one-line error
- A valid usage list:
  - `/specflow init new`
  - `/specflow init old`
  - `/specflow feature <feature-name>`
  - `/specflow align`
  - `/specflow accept <feature-name>`
- And include the same `SpecFlow Command Help` block.
