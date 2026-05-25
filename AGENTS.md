# Agent Instructions

Use this repo to turn shaped product work into implementation plans that preserve intent while becoming concrete enough to build.

These instructions are tool-neutral. They are intended for Claude Code, Cursor, Codex, and other agentic coding or writing environments.

## Default mode

Default to implementation planning before implementation.

Do not write production code unless the user explicitly selects a Dumplink task group to build or asks for implementation.

When planning, prefer:

- plain language
- tables
- lightweight pseudo-structures
- Mermaid diagrams when helpful
- stable IDs for tasks, task groups, dependencies, cuts, and acceptance checks

When implementing, preserve shaped intent and update the plan if implementation discoveries change risk, sequence, scope, or dependencies.

## Core workflow

1. Restate the shaped project boundary.
2. Dump likely tasks without sequencing too early.
3. Cluster tasks into vertical task groups.
4. Mark unknown / known / done risk states.
5. Map dependencies between task groups.
6. Sequence by risk, dependency, and what unlocks the next useful behavior.
7. Define scope cuts before the appetite is exhausted.
8. Write acceptance checks.
9. Feed one active task group to the implementation agent.
10. Reflect and update the plan when implementation reality changes the assumptions.

## Skill map

Use the repo skills as reusable instructions:

- `dumplink/` — turn shaped work into raw task dumps, vertical task groups, dependency sequence, risk state, scope cuts, and agent handoff packets.

## Authority order

When artifacts disagree, use this default authority order unless the user says otherwise:

1. the user’s latest explicit instruction
2. selected Dumplink task group / active implementation slice
3. selected shaped project direction
4. original frame / pitch / requirements
5. raw notes and transcripts
6. rejected alternatives and brainstorming

Do not treat a newer brainstorming note as a higher-authority artifact unless it explicitly changes the selected direction.

## Mode discipline

Planning artifacts should preserve latitude while making the work concrete enough to build.

Do not collapse:

- shaped intent into a ticket pile
- requirements into implementation chores
- vertical task groups into frontend/backend silos
- unknowns into vague engineering tasks
- scope cuts into failures

## Context feeding

Do not paste or load the whole planning stack by default.

Before implementation work, create or request a compact handoff packet that includes:

- active task group
- source artifacts
- must-preserve constraints
- relevant tasks
- known unknowns
- dependencies
- non-goals and exclusions
- acceptance check
- stop condition

## Stable IDs

Preserve IDs such as:

- `T-01` for tasks
- `TG-01` for task groups
- `D-01` for dependencies
- `CUT-01` for scope cuts
- `AC-01` for acceptance checks

Do not rename stable IDs just to improve wording. If the meaning changes, create a planning update or new ID.

## Drift protocol

If implementation reality conflicts with the selected task group or sequence, do not silently patch around the plan.

Return:

```md
## Planning drift found

The selected plan says:
- ...

The implementation reality is:
- ...

Options:
1. Update the implementation to match the plan.
2. Update the plan because the original assumption was wrong.
3. Split the task group and defer the conflicting part.

Recommended move:
- ...
```

## Completion standard

Before declaring work complete, check:

- the task stayed within the selected mode
- the shaped intent was preserved
- non-goals were preserved
- stable IDs were preserved
- task-group risk/dependency assumptions were updated if they changed
- implementation work, when present, maps back to task-group and acceptance-check IDs
