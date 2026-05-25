---
name: implementation-planner
description: Turn a PRD or shaped package of work into a kickoff doc, technical design plan, initial vertical slices, tracker, and agent handoff packets.
planning: true
implementation_planning: true
technical_design: true
---

# Implementation Planner and Tracker

Use this skill when a PRD, pitch, or shaped package of work needs to become a technical design plan that humans and agents can build from.

The skill sits between shaping and implementation. It preserves the intent of the product work while translating it into a builder-facing kickoff doc, a technical design outline, initial slices, and compact implementation handoff packets.

It is not a generic ticket generator. It is a tool for working on what the work is before doing the work.

## Goal

Produce a plan that answers:

- What are we building, and why this bounded version?
- What technical surfaces, data, state, APIs, integrations, and risks are implicated?
- What has to be figured out first because later work depends on it?
- What can be completed together and judged as a vertical slice?
- What does done mean relative to the next thing this slice must enable?
- What can be cut or deferred if the appetite runs out?
- What exact packet should a human or coding agent receive for the first slice?

## Inputs

Accept any of these:

- PRD
- Shape Up pitch
- shaped package of work
- kickoff notes
- breadboard
- design doc
- transcript or planning notes
- issue / project description
- implementation discovery notes

Prefer source material that includes:

- appetite / time budget
- desired outcome
- selected approach
- non-goals
- constraints
- user-facing behavior
- known risks
- existing system context

If the input is not ready, do not fake certainty. Run the readiness check and label assumptions.

## Output

Create these sections:

1. Readiness check
2. Project boundary
3. Kickoff doc
4. Technical design plan
5. Assumptions, unknowns, and risks
6. Raw task dump
7. Task groups / scopes
8. Interrelationship map
9. Build sequence
10. Initial vertical slices
11. Scope cuts and deferrals
12. Acceptance checks
13. Tracker
14. Agent handoff packet

## Method

### 1. Readiness check

Before planning implementation, determine whether the input is shaped enough.

Use this table:

| Dimension | Status | Evidence | Concern | Needed before build? |
|---|---|---|---|---|
| Problem / outcome | clear / partial / missing |  |  | yes/no |
| Appetite | clear / partial / missing |  |  | yes/no |
| Selected approach | clear / partial / missing |  |  | yes/no |
| Non-goals | clear / partial / missing |  |  | yes/no |
| User-visible behavior | clear / partial / missing |  |  | yes/no |
| System context | clear / partial / missing |  |  | yes/no |
| Risks / unknowns | clear / partial / missing |  |  | yes/no |

If core shaping is missing, produce a planning-risk warning and continue with explicit assumptions.

### 2. Restate the project boundary

Preserve the shaped intent before technical decomposition.

Include:

- Source artifact
- Appetite / time budget
- Target user or operator
- Desired outcome
- Selected approach
- Non-goals
- Must-preserve constraints
- Success definition

Do not turn the project into tasks until this boundary is clear.

### 3. Write the kickoff doc

The kickoff doc is the builder-facing interpretation of the package.

It should answer the anxieties at handoff:

- Is this possible in the appetite?
- What pieces fit together?
- What should be worked on first?
- What happens if part of it is harder than expected?
- How will progress be visible without micromanagement?

Kickoff doc format:

```md
# Kickoff Doc

## Shape in one paragraph

## Appetite

## What we are building

## What we are not building

## Key user/system behaviors

## Technical surfaces likely touched

## Known risks and unknowns

## First thing to learn or prove

## What to show after the first slice

## Cut lines if time gets tight
```

### 4. Create the technical design plan

Translate the product shape into technical territory without overbuilding.

Use these tables.

Affected surfaces:

| ID | Surface | Existing/New | Why it matters | Notes |
|---|---|---|---|---|
| SURF-01 |  | existing/new |  |  |

Data / state:

| ID | Data or state | Created/Read/Updated/Deleted | Owner/source | Persistence | Notes |
|---|---|---|---|---|---|
| STATE-01 |  |  |  | none/temp/db/external |  |

Interfaces / contracts:

| ID | Interface | Producer | Consumer | Contract / payload / behavior | Open question |
|---|---|---|---|---|---|
| IF-01 |  |  |  |  |  |

Technical decisions:

| ID | Decision | Rationale | Reversible? | Risk |
|---|---|---|---|---|
| TD-01 |  |  | yes/no |  |

Do not write production code here. Keep this at design-plan fidelity unless the user explicitly asks to implement a slice.

### 5. Register assumptions, unknowns, and risks

Unknowns are not defects. They are the main scheduling signal.

| ID | Unknown / risk | Why it matters | Earliest way to learn | Related surfaces | Must resolve before |
|---|---|---|---|---|---|
| RISK-01 |  |  |  | SURF-01 | TG-01 / SLICE-01 |

### 6. Dump likely work

Dump everything that may be needed. Do not sequence yet.

Include product, design, code, data, migration, QA, instrumentation, docs, launch, and cleanup when relevant.

| ID | Task | Type | Known/Unknown | Notes |
|---|---|---|---|---|
| T-01 |  | product/design/code/data/QA/launch | unknown |  |

### 7. Cluster into task groups / scopes

Group tasks by what can be completed together and judged in isolation from the rest.

Rules:

- use no more than about 10 groups initially
- do not name the groups before clustering
- name them after seeing what belongs together
- avoid frontend/backend buckets unless that is the real separable concern
- prefer vertical slices of behavior, state, and system consequence

| ID | Name | Included tasks | Behavior / output produced | Risk state | Cuttable? | Notes |
|---|---|---|---|---|---|---|
| TG-01 |  | T-01, T-04 |  | not-started / figuring-it-out / executing-down / done / cut | no |  |

### 8. Map interrelationships

Draw arrows where one task group provides input to another or reduces uncertainty for another.

| ID | From | To | Relationship | Why it matters |
|---|---|---|---|---|
| D-01 | TG-01 | TG-02 | input / unlocks / derisks / blocks |  |

Optional Mermaid:

```mermaid
flowchart LR
  TG01["TG-01: Name"] --> TG02["TG-02: Name"]
```

Use the map to find groups with more outgoing than incoming dependencies. These often need to happen earlier because they unlock the rest.

### 9. Sequence by right-to-left thinking

For each task group, define what it must enable next. Done is relative to what comes next.

| Order | Task group | Why now | What it must enable next | Stop when... |
|---|---|---|---|---|
| 1 | TG-01 |  |  |  |

The stop condition should be narrower than “everything eventually needed.” It should say what output the next task group needs as input.

### 10. Define initial vertical slices

A slice is a buildable, judgeable increment. It may contain one task group or a path through several groups.

Each slice should produce a concrete demonstration or proof:

| ID | Slice | Purpose | Included task groups | Demo / proof | Acceptance checks | Non-goals |
|---|---|---|---|---|---|---|
| SLICE-01 |  | derisk / core behavior / finishing | TG-01 |  | AC-01 |  |

Prefer 2–4 initial slices. Do not create a full backlog when the next slice is enough.

### 11. Define scope cuts and deferrals

Variable scope is a feature of the process.

| ID | Remove/defer | Preserved behavior | Cost of cutting | Decision trigger |
|---|---|---|---|---|
| CUT-01 |  |  |  |  |

### 12. Write acceptance checks

Acceptance checks should verify behavior and plan alignment.

| ID | Check | Applies to | Verification method |
|---|---|---|---|
| AC-01 |  | SLICE-01 / TG-01 / project | manual / automated / review |

Good checks:

- prove a user/system behavior end to end
- verify a risk was resolved
- confirm a cut line still leaves a usable version
- keep non-goals out

### 13. Create a tracker

Track at the level of slices and task groups, not individual chores.

| Item | Type | State | Current unknown | Next visible proof | Blocked by | Notes |
|---|---|---|---|---|---|---|
| SLICE-01 | slice | not-started / figuring-it-out / executing-down / done / cut |  |  |  |  |

### 14. Prepare agent handoff packet

End with a compact implementation packet for only the first selected slice.

```text
Active slice:
Source artifacts:
Authority order:
Must preserve:
Do not build:
Relevant requirements:
Relevant technical design decisions:
Relevant surfaces/files/modules, if known:
Included task groups:
Relevant tasks:
Known unknowns:
Dependencies:
Acceptance checks:
Stop condition:
```

## Quality bar

A good output:

- preserves the shaped intent before technical decomposition
- answers kickoff anxieties
- makes technical surfaces and risks visible
- avoids a flat to-do backlog
- clusters work into vertical scopes / task groups
- sequences by unknowns, dependency, and right-to-left stop conditions
- defines initial slices that can be judged end to end
- gives agents one bounded slice at a time
- includes cut lines before scope pressure arrives

## Common failure modes

- Treating the PRD as implementation truth without checking readiness
- Producing a ticket list instead of a technical design plan
- Starting with easy UI work while core unknowns remain hidden
- Overdesigning infrastructure because it will be needed “later later”
- Missing the stop condition for the next slice
- Creating too many slices too early
- Sending the whole plan to the agent instead of a compact first-slice packet
- Treating cut scope as failure instead of appetite discipline
