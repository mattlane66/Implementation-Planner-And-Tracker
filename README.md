# Implementation Planner and Tracker

A tool / skill repo for turning a PRD or shaped package of work into a technical design plan that humans and agents can actually build from.

The tool is meant to sit between shaping and implementation. It does **not** replace shaping, Spec Kit, an engineer's judgment, or a code-aware implementation agent. Its job is to preserve the intent of the shaped work while translating it into:

- a builder-facing kickoff doc
- a technical design outline
- a scope / task-group map
- the first vertical implementation slices
- compact handoff packets for Codex, Claude Code, Cursor, or a human engineer
- a lightweight tracker based on unknowns, dependencies, and slice progress

## Core idea

Most planning tools turn work into to-dos too early. This repo uses a different sequence:

1. **Preserve the shaped intent** — restate the problem, appetite, outcome, selected approach, non-goals, and constraints.
2. **Unfold the technical shape** — identify affected surfaces, system boundaries, data/state, integration points, risks, and open questions.
3. **Dump the work** — list likely implementation work without sequencing too early.
4. **Cluster into scopes / task groups** — group tasks by what can be completed and judged together.
5. **Map interrelationships** — show which task groups feed or unlock others.
6. **Sequence by risk and dependency** — start where unknowns can sink the project if discovered late.
7. **Define initial slices** — make the first few slices independently judgeable and agent-handoff ready.
8. **Track by what is known, unknown, done, cut, or deferred** — not by raw task count.

Dumplink's DUMP → CLUSTER → SEQUENCE method is one important subroutine inside this larger implementation-planning tool.

## What this produces

Use `/implementation-planner` to create:

- readiness check for the PRD or shaped package
- project boundary and appetite
- builder-facing kickoff doc
- technical design plan
- affected system map
- assumptions and missing-information register
- raw task dump
- vertical task groups / scopes
- dependency and interrelationship map
- initial implementation slices
- scope cuts / deferrals
- acceptance checks
- agent handoff packets
- tracker table

Use `/dumplink` when you only need the narrower DUMP → CLUSTER → SEQUENCE task-grouping move.

## When to use it

Use this after a product direction has been selected and the next question is:

> How do we hand this to builders without turning it into a flat ticket pile?

It is best for deliberate build-cycle work: meaningful product bets, shaped features, PRDs that need technical interpretation, and implementation plans that need to stay whole while becoming concrete enough for agents or engineers to build.

Do not use it as a generic ticket backlog for reactive bugs, support requests, or interrupt-driven work.

## Skill locations

```text
skills/implementation-planner/SKILL.md   # primary Claude-style skill packaging
implementation-planner/SKILL.md          # root mirror for direct skill installs or simple linking
skills/dumplink/SKILL.md                 # narrower Dumplink task-grouping helper
dumplink/SKILL.md                        # root mirror of Dumplink helper
AGENTS.md                                # tool-neutral agent instructions
```

## Claude Code install

Clone this repo and link the primary skill:

```bash
git clone https://github.com/mattlane66/Implementation-Planner-And-Tracker.git ~/.local/share/implementation-planner-and-tracker
ln -s ~/.local/share/implementation-planner-and-tracker/skills/implementation-planner ~/.claude/skills/implementation-planner
```

Optional Dumplink helper:

```bash
ln -s ~/.local/share/implementation-planner-and-tracker/skills/dumplink ~/.claude/skills/dumplink
```

Then reload skills/plugins in Claude Code.

## Example prompts

```text
Use the implementation-planner skill.
Turn this PRD into a kickoff doc, technical design plan, initial vertical slices, and agent handoff packet for the first slice.
```

```text
Use the implementation-planner skill on this shaped package of work.
Preserve the appetite and non-goals, map the technical surface area, sequence by unknowns/dependencies, and produce the first 3 implementation slices.
```

```text
Use the Dumplink skill only.
Dump the work, cluster it into task groups, and sequence the groups by risk and dependency.
```

## Source attribution

This repo adapts ideas from Dumplink and Shape Up-style implementation planning:

- Dumplink source repo: https://github.com/klausbreyer/dump.link
- Dumplink site: https://dump.link
- Ryan Singer on systemizing kickoff: https://www.ryansinger.co/systemizing-kick-off/
- Ryan Singer on done being relative to what comes next: https://www.ryansinger.co/done-is-relative-to-what-comes-next/
- Ryan Singer on going beyond to-dos: https://www.ryansinger.co/beyond-to-dos/
- Ryan Singer on interrelationship diagrams: https://www.ryansinger.co/unfolding-the-interrelationship-diagram/

Original Dumplink concept/design attribution belongs to Klaus Breyer and Matthew Lane as described in the Dumplink source project.
