# Implementation Planner and Tracker

A tool / skill repo for turning a shaped package of work (input design doc/PRD) into a technical design plan that humans and agents can actually build from.

The tool is meant to sit between shaping and implementation. It does **not** replace shaping, an engineer's judgment, or a code-aware implementation agent. Its job is to preserve the intent of the shaped work while translating it into:

- a builder-facing kickoff doc
- a technical design outline
- a task-group map
- dependency foliation and parallelization decisions
- the first vertical implementation slices
- compact handoff packets for Codex, Claude Code, Cursor, or a human engineer
- a lightweight tracker based on unknowns, dependencies, layers, parallelization, and slice progress

## Core idea

Most planning tools turn work into to-dos too early. This repo uses a different sequence:

1. **Preserve the shaped intent** — given the plan's context, it understands the direction of the work.
2. **Unfold the technical shape** — identify affected surfaces, system boundaries, data/state, integration points, risks, and open questions.
3. **Dump the work** — list likely implementation work without sequencing too early.
4. **Cluster into task groups** — group tasks by what can be completed and judged together.
5. **Define initial slices** — make the first few slices independently judgeable and agent-handoff ready.
6. **Map interrelationships** — show which task groups feed or unlock others.
7. **Foliate dependencies** — convert the interrelationship graph into dependency layers and candidate parallel work sets.
8. **Decide parallelization** — distinguish what can run in parallel by dependency from what should run in parallel after considering unknowns and capacity.
9. **Sequence by risk, dependency, and stop condition** — start where unknowns can sink the project if discovered late.
10. **Track by what is known, unknown, done, cut, or deferred** — not by raw task count.

Dumplink's DUMP → CLUSTER → FOLIATE → SEQUENCE method is one important subroutine inside this larger implementation-planning tool.

## What this produces

Use `/implementation-planner` to create:

- readiness check for the PRD or shaped package
- project boundary and appetite
- builder-facing kickoff doc
- technical design plan
- affected system map
- assumptions and missing-information register
- raw task dump
- vertical task groups and initial implementation slices
- dependency and interrelationship map
- foliated dependency layers
- parallelization plan
- scope cuts / deferrals
- acceptance checks
- agent handoff packets
- tracker table

Use `/dumplink` when you only need the narrower DUMP → CLUSTER → FOLIATE → SEQUENCE task-grouping move.

## When to use it

Use this after a product direction has been selected and the next question is:

> How do we hand this to builders without turning it into a flat ticket pile?

It is best for deliberate build-cycle work: meaningful discrete product bets, shaped features/PRDs that need technical interpretation, and implementation plans that need to stay whole while becoming concrete enough for agents and/or engineers to build.

Do not use it as a generic ticket backlog for reactive bugs, support requests, or interrupt-driven work.

## Skill locations

```text
skills/implementation-planner/SKILL.md   # primary Claude-style skill packaging
implementation-planner/SKILL.md          # root mirror for direct skill installs or simple linking
skills/dumplink/SKILL.md                 # narrower Dumplink task-grouping helper
dumplink/SKILL.md                        # root mirror of Dumplink helper
templates/implementation-plan.md         # reusable output template
hooks/implementation-planning-ripple.sh  # optional Claude Code hook
examples/                               # worked examples
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

## Optional Claude Code hook

This repo includes a lightweight PostToolUse hook that reminds agents to keep planning artifacts aligned when code or planning docs change.

Install it:

```bash
mkdir -p ~/.claude/hooks
ln -s ~/.local/share/implementation-planner-and-tracker/hooks/implementation-planning-ripple.sh ~/.claude/hooks/implementation-planning-ripple.sh
chmod +x ~/.local/share/implementation-planner-and-tracker/hooks/implementation-planning-ripple.sh
```

Then add it to Claude settings:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/implementation-planning-ripple.sh",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

The hook is intentionally non-blocking. It prints reminders when a changed file suggests the technical design plan, slices, dependency foliation, tracker, or handoff packet may need to be updated.

## Template

Use `templates/implementation-plan.md` when you want a stable output artifact instead of a one-off response.

Example:

```text
Use the implementation-planner skill and write the result using templates/implementation-plan.md.
```

## Examples

See `examples/simple-feature-prd/` for a tiny PRD and a completed implementation plan. It shows the intended output shape for agents to imitate.

## Example prompts

```text
Use the implementation-planner skill.
Turn this PRD into a kickoff doc, technical design plan, dependency foliation, parallelization plan, initial vertical slices, and agent handoff packet for the first slice.
```

```text
Use the implementation-planner skill on this shaped package of work.
Preserve the appetite and non-goals, map the technical surface area, foliate dependencies, sequence by unknowns/dependencies, and produce the first 3 implementation slices.
```

```text
Use the Dumplink skill only.
Dump the work, cluster it into task groups, foliate dependencies, identify parallelizable groups, and sequence the groups by unknowns, risk, and dependency.
```

## Source attribution

This repo adapts ideas from Dumplink and Shape Up-style implementation planning:

- Dumplink source repo: https://github.com/klausbreyer/dump.link

Original Dumplink concept/design attribution belongs to Klaus Breyer and Matthew Lane as described in the Dumplink source project.
