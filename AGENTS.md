# Agent Instructions

Use this repo to turn a PRD or shaped package of work into a technical design plan that preserves intent while becoming concrete enough for humans and agents to build.

These instructions are tool-neutral. They are intended for Claude Code, Cursor, Codex, and other agentic coding or writing environments.

## Default mode

Default to implementation planning before implementation.

Do not write production code unless the user explicitly selects an implementation slice or task group to build.

When planning, prefer:

- plain language
- tables
- lightweight pseudo-structures
- Mermaid diagrams when helpful
- plain text visual boards when Mermaid is not enough
- stable IDs for requirements, surfaces, risks, tasks, task groups, slices, dependencies, layers, parallelization sets, cuts, and acceptance checks

When implementing, preserve shaped intent and update the plan if implementation discoveries change risk, sequence, scope, parallelization, visuals, or dependencies.

## Core workflow

1. Check readiness of the PRD or shaped package.
2. Restate the project boundary: appetite, outcome, selected approach, non-goals, and constraints.
3. Produce a builder-facing kickoff doc.
4. Unfold the technical design: affected surfaces, system boundaries, data/state, dependencies, integrations, and risks.
5. Dump likely work without sequencing too early.
6. Cluster tasks into vertical task groups / scopes.
7. Map interrelationships between task groups.
8. Foliate the dependency graph into layers.
9. Decide parallelization using dependencies plus unknowns and capacity.
10. Sequence by risk, dependency, and what unlocks the next useful behavior.
11. Define initial vertical implementation slices.
12. Define scope cuts and deferrals before the appetite is exhausted.
13. Write acceptance checks.
14. Produce the Visual Pack: dump board, task group grid, risk board, interrelationship diagram, foliation diagram, parallelization map, appetite snapshot, and slice sequence map.
15. Feed one active slice or task group to the implementation agent.
16. Reflect and update the plan when implementation reality changes assumptions.

## Foliation rule

Dependencies and unknowns are different dimensions.

First use the interrelationship map to answer the dependency-only question:

> If all unknowns were equal, what order is valid based on what must feed what?

Then create dependency layers. Groups in the same layer are dependency-parallel candidates, but they are not automatically safe to run in parallel.

After layering, use unknown severity, time sensitivity, scarce people, fragile code areas, external dependencies, and decision-maker bottlenecks to decide actual sequencing and parallelization.

## Visual Pack rule

When enough information exists, produce a Visual Pack as part of the implementation plan.

The Visual Pack should include:

- Dump Board
- Task Group Grid
- Risk State Board
- Interrelationship Diagram
- Foliation / Layer Diagram
- Parallelization Map
- Appetite / Progress Snapshot
- Slice Sequence Map

Use `docs/visual-pack.md` for patterns.

Rules:

- tables remain the source of truth
- visuals are projections for review and communication
- use stable IDs in visuals
- keep visuals GitHub Markdown-compatible
- use Mermaid for diagrams and plain text boards for dump/risk/appetite views
- do not invent precision when data is missing

## Skill map

Use the repo skills as reusable instructions:

- `implementation-planner/` — primary skill. Turn a PRD or shaped package into a kickoff doc, technical design plan, dependency foliation, parallelization plan, vertical slices, tracker, Visual Pack, and agent handoff packets.
- `dumplink/` — helper skill. Turn shaped work into raw task dumps, vertical task groups, dependency layers, parallelization plan, risk state, and scope cuts.

## Authority order

When artifacts disagree, use this default authority order unless the user says otherwise:

1. the user’s latest explicit instruction
2. selected implementation slice or Dumplink task group
3. technical design plan / kickoff doc
4. selected shaped project direction or PRD
5. original frame / pitch / requirements
6. raw notes and transcripts
7. rejected alternatives and brainstorming

Do not treat a newer brainstorming note as a higher-authority artifact unless it explicitly changes the selected direction.

## Mode discipline

Planning artifacts should preserve latitude while making the work concrete enough to build.

Do not collapse:

- shaped intent into a ticket pile
- requirements into implementation chores
- technical design into code before slice selection
- vertical task groups into frontend/backend silos
- unknowns into vague engineering tasks
- dependency-parallel work into automatically parallel work
- Visual Pack diagrams into source-of-truth tables
- scope cuts into failures

## Context feeding

Do not paste or load the whole planning stack by default.

Before implementation work, create or request a compact handoff packet that includes:

- active slice or task group
- source artifacts
- authority order
- must-preserve constraints
- relevant requirements
- relevant technical design decisions
- relevant tasks
- dependency layer
- parallelization decision
- known unknowns
- dependencies
- non-goals and exclusions
- acceptance checks
- stop condition

## Stable IDs

Preserve IDs such as:

- `REQ-01` for requirements / criteria
- `SURF-01` for affected surfaces
- `RISK-01` for risks or unknowns
- `T-01` for tasks
- `TG-01` for task groups
- `L1` for dependency layers
- `PSET-01` for parallelization candidate sets
- `SLICE-01` for implementation slices
- `D-01` for dependencies
- `CUT-01` for scope cuts
- `AC-01` for acceptance checks

Do not rename stable IDs just to improve wording. If the meaning changes, create a planning update or new ID.

## Drift protocol

If implementation reality conflicts with the selected plan, slice, or task group, do not silently patch around the plan.

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
3. Split the slice/task group and defer the conflicting part.

Recommended move:
- ...
```

## Completion standard

Before declaring work complete, check:

- the task stayed within the selected mode
- the shaped intent was preserved
- non-goals were preserved
- stable IDs were preserved
- technical-design assumptions were updated if implementation contradicted them
- task-group risk/dependency assumptions were updated if they changed
- dependency foliation and parallelization decisions were updated if they changed
- Visual Pack projections were updated if the underlying tables changed
- implementation work, when present, maps back to slice/task-group and acceptance-check IDs
