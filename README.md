# Implementation Planner and Tracker

A Claude Code / agent-friendly skill repo for turning shaped product work into implementation plans that preserve intent.

This repo adapts the Dumplink method into a reusable planning skill:

1. **DUMP** — list all likely work from a shaped project without sequencing too early.
2. **CLUSTER** — group the work into vertical task groups that produce judgeable behavior.
3. **SEQUENCE** — order task groups by risk, dependency, and what unlocks the next useful slice.

The goal is to avoid the default agent failure mode: turning a coherent shaped project into a horizontal pile of disconnected tasks.

## What this skill produces

Use `/dumplink` to create:

- project boundary
- raw task dump
- vertical task groups
- unknown / known / done risk states
- dependency map
- build sequence
- scope cuts
- acceptance checks
- compact agent handoff packet

## When to use it

Use this after a project has been framed, shaped, and selected for a fixed time budget.

It is best for deliberate build-cycle work: meaningful product bets, shaped features, and implementation plans that need to stay whole while still becoming concrete enough for agents or engineers to build.

Do not use it as a generic ticket backlog for reactive bugs, support requests, or interrupt-driven work.

## Skill locations

```text
skills/dumplink/SKILL.md   # Claude-style skill packaging
dumplink/SKILL.md          # root mirror for direct skill installs or simple linking
AGENTS.md                  # tool-neutral agent instructions
```

## Claude Code install

Clone this repo and link the skill:

```bash
git clone https://github.com/mattlane66/Implementation-Planner-And-Tracker.git ~/.local/share/implementation-planner-and-tracker
ln -s ~/.local/share/implementation-planner-and-tracker/skills/dumplink ~/.claude/skills/dumplink
```

Then reload skills/plugins in Claude Code.

## Example prompt

```text
Use the Dumplink skill.
Turn this shaped project into vertical task groups, sequence them by risk and dependency, identify scope cuts, and produce an agent handoff packet for the first task group.
```

## Source attribution

This skill is adapted from Dumplink:

- Source repo: https://github.com/klausbreyer/dump.link
- Product/site: https://dump.link

Original concept/design attribution belongs to Klaus Breyer and Matthew Lane as described in the Dumplink source project.
