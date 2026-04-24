---
name: specflow-session-bootstrap
description: Use at session start when SpecFlow plugin is installed — establishes SpecFlow↔Superpowers coexistence rules and initialization hard gates
---

# SpecFlow Session Bootstrap (Cursor)

## Purpose

This is the minimal bootstrap skill injected at session start. It must stay short.

## Hard Gates (Non-Negotiable)

### 1) Initialization hard gate

If the project is missing `.specflow/` or any core files, **stop** and run `specflow-initialize-project` before doing SpecFlow spec/implementation/acceptance work.

Core files (minimum):
- `.specflow/SPECFLOW.md`
- `.specflow/docs/PRD.md`
- `.specflow/docs/NFR.md`
- `.specflow/memory/progress.md`

### 2) No wrong mapping

Never treat Superpowers documents as SpecFlow documents:
- `docs/superpowers/specs/**` is NOT `.specflow/specs/active/**/SPEC.md`
- `docs/superpowers/plans/**` is NOT `.specflow/docs/PRD.md`

Superpowers docs are design/plan process artifacts only.
SpecFlow docs under `.specflow/**` are the delivery spec, acceptance, archive, and memory system.

## Coexistence Rules (Complement Mode)

- Superpowers provides process discipline (brainstorming → plan → execution → TDD → verification).
- SpecFlow provides scope/acceptance/archive governance (what to deliver, what is “done”).
- PRD is project-level source (`.specflow/docs/PRD.md`), not feature-level; feature closure must sync PRD feature list.

When both are installed, use both:
- Keep Superpowers for process gates.
- Keep SpecFlow for scope/acceptance/archival gates.

## What to do next

Pick the next SpecFlow skill by need (invoke via Skill tool):
- `specflow-using-specflow` for the full SpecFlow overview and rules
- `specflow-initialize-project` to initialize `.specflow/` in this repo
- `specflow-write-spec-and-acceptance` to create SPEC/ACCEPTANCE for a feature
- `specflow-implement-from-spec` to implement from SPEC/ACCEPTANCE (with Superpowers TDD)
- `specflow-document-alignment` when `.specflow/**` docs change
- `specflow-acceptance-and-archive` to close a feature with evidence and archiving

## Workflow Snapshot (Superpowers + SpecFlow)

Use this as the default sequence:

1) Initialize project docs if needed
- Run `specflow-initialize-project` when `.specflow` core files are missing.

2) Feature entry
- Run Superpowers `brainstorming` first for design clarification and approval.
- Then create/update `.specflow/specs/active/<feature>/SPEC.md` + `ACCEPTANCE.md` + `INDEX.md`.

3) Plan
- After brainstorming, invoke `writing-plans` (required by Superpowers).
- Keep plan tasks aligned to `.specflow` SPEC/ACCEPTANCE boundaries.

4) Implement
- Execute via `subagent-driven-development` (preferred) or `executing-plans`.
- Enforce `test-driven-development` before production code changes.

5) Align when docs change
- Run `specflow-document-alignment` and produce alignment receipt first.

6) Accept and close
- Run `specflow-acceptance-and-archive`.
- Require evidence per acceptance item and `verification-before-completion`.

