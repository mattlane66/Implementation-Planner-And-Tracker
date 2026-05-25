# Source Case Study: Message Drafts

This example is adapted from the Shape Up Chapter 12 case study, “Message drafts.”

Source: https://basecamp.com/shapeup/3.3-chapter-12#case-study-message-drafts

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

## Constraints from the case

- Do not organize by role, such as designer tasks vs programmer tasks.
- Do not stay with a flat unscoped task list.
- Prefer integrated scopes that combine front-end and back-end work when needed.
- Rename and redraw scopes as the team learns the real structure.
- Avoid grab-bag scope names like `frontend`, `backend`, `bugs`, or `misc`.
- If a scope is too big or hard to call done, split it.
- Mark nice-to-haves separately instead of letting them blur must-have scope.

## Intended use in this repo

This example shows how the implementation-planner skill can translate a Shape Up-style case study into:

- task groups / scopes
- interrelationship map
- dependency foliation
- parallelization judgment
- build sequence
- initial vertical slices
- tracker
- agent handoff packet
