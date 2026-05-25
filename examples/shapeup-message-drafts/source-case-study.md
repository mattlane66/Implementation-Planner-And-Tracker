# Source Case Study: Message Drafts

This example is adapted from two sources:

- Shape Up Chapter 12 case study, “Message drafts”: https://basecamp.com/shapeup/3.3-chapter-12#case-study-message-drafts
- A Dumplink demo transcript supplied by the user for the video: https://www.youtube.com/watch?v=CSEhIJ7safA

## Source summary

A designer and programmer were building a feature to create and save drafts of messages in a new app.

At first, they had a bunch of seemingly unrelated tasks in an unscoped list. As the end of the first week approached, some tasks were done, but there was no integrated piece of work they could point to as finished.

They decided to get one key interaction done first: creating a new draft. They named that scope `Start New` and moved the relevant tasks into it.

After finishing `Start New`, they looked at the remaining work and discovered more natural scopes:

- `Locate` — finding drafts
- `Trash` — deleting drafts
- `Save/Edit` — saving and editing draft content

As work continued, `Save/Edit` turned out to be too broad. The team discovered more specific scopes inside it:

- `Send` — sending the drafted message
- `Store` — storing draft information
- `Reply` — special handling for drafts when replying to another message

The final scope map gave the team a high-level language for the project:

- `Start New`
- `Locate`
- `Send`
- `Store`
- `Reply`
- `Trash`

The key lesson: scopes are not arbitrary categories. They emerge from the interdependencies of the real work. Good scopes are integrated pieces of the project that can be finished independently and discussed at a higher level than individual tasks.

## Dumplink transcript notes

The Dumplink demo adds implementation-planning mechanics on top of the Shape Up case:

- The project starts from a named Dumplink project and an **appetite**. The appetite acts like a fixed time budget, not an estimate.
- Setting the appetite creates a visible timepiece/progress bar with start date, end date, and days left.
- The team begins with **The Dump**: a rough list of implementation details from the shaped package, without structure or order.
- The team then drags dumped tasks into up to **10 empty task-group buckets**. The bucket limit intentionally constrains project size; needing more groups may mean the work should be split into a separate modular project.
- Groups are named only after related tasks cluster together. In the demo, tasks such as manual draft creation, invalid draft creation, and draft wrapper labels become a non-arbitrary group like `Create a New Draft`.
- Task groups track risk using two key states: **figuring out** / **figured out**. This lets the team talk about uncertainty at the task-group level instead of micromanaging individual tasks.
- A task group should not be treated as done while any important task inside it is still in the figuring-out state.
- The sequencer screen wires task groups by asking where one group enables another.
- The arranger screen shows those relationships as layers over time, then lets the team manually adjust sequence and parallelization.
- Some work may be independent from core product development, such as a marketing blog post, and can be scoped separately.
- The macro view combines appetite time remaining with task-group states so the team can discuss scope hammering, delegation, ownership, extension, cancellation, or moving on.

## Constraints from the case

- Do not organize by role, such as designer tasks vs programmer tasks.
- Do not stay with a flat unscoped task list.
- Prefer integrated scopes that combine front-end and back-end work when needed.
- Rename and redraw scopes as the team learns the real structure.
- Avoid grab-bag scope names like `frontend`, `backend`, `bugs`, or `misc`.
- If a scope is too big or hard to call done, split it.
- Mark nice-to-haves separately instead of letting them blur must-have scope.
- Track uncertainty explicitly: do not confuse task completion with risk reduction.
- Treat dependency-parallel work as only a candidate for parallelization; unknowns and capacity still decide actual sequence.
- Keep the appetite visible as a forcing function for scope decisions.

## Intended use in this repo

This example shows how the implementation-planner skill can translate a Shape Up-style case study plus Dumplink mechanics into:

- appetite-aware project boundary
- task groups / scopes
- unknown vs known risk states
- interrelationship map
- dependency foliation
- parallelization judgment
- build sequence
- initial vertical slices
- tracker
- agent handoff packet
