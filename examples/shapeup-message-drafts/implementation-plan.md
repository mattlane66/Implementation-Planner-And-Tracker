# Implementation Plan: Message Drafts

This example is adapted from the Shape Up Chapter 12 case study, “Message drafts.”

Source: https://basecamp.com/shapeup/3.3-chapter-12#case-study-message-drafts

## 1. Readiness check

| Dimension | Status | Evidence | Concern | Needed before build? |
|---|---|---|---|---|
| Problem / outcome | clear | Users need to create, find, edit, send, and discard message drafts. | The original case begins from a task list, not a formal PRD. | no |
| Appetite | partial | Case study describes work unfolding over a cycle. | Exact appetite not specified in this example. | no, example only |
| Selected approach | clear | Drafts are created, stored, located, edited, sent, replied to, and trashed. | Scopes emerge during work. | no |
| Non-goals | partial | Nice-to-haves are separated from must-have work. | Exact non-goals are inferred from the case. | no |
| User-visible behavior | clear | Start new draft, locate drafts, save/edit, send, reply, trash. | None. | no |
| System context | partial | Message drafting in an app with message/reply behavior. | No codebase details. | yes for real implementation |
| Risks / unknowns | clear | Scope boundaries are unknown at first; `Save/Edit` is too broad. | Need to redraw scopes as understanding improves. | yes |

## 2. Project boundary

- Source artifact: `examples/shapeup-message-drafts/source-case-study.md`
- Appetite: Not specified in the case; assume one Shape Up-style build cycle for example purposes.
- Target user / operator: User composing messages and replies.
- Desired outcome: User can start a draft, find it later, edit/save it, send it, reply with it, or trash it.
- Selected approach: Organize work into emergent integrated scopes rather than a flat task list.
- Non-goals: Role-based task buckets, arbitrary frontend/backend split, grab-bag scope names, unbounded nice-to-haves.
- Must-preserve constraints: Scopes must represent meaningful integrated work and be redrawable as the team learns.
- Success definition: The team can point to finished, named scopes rather than isolated completed tasks.

## 3. Kickoff doc

### Shape in one paragraph

Build message drafts as a set of integrated scopes that let a user start a draft, find it later, preserve edits, send it, reply from an existing message context, and trash unwanted drafts. The project should be planned around emergent scopes of real work, not role-based or layer-based tasks.

### What we are building

- Start new draft flow.
- Draft location / finding behavior.
- Draft save/edit behavior.
- Send drafted message behavior.
- Store draft state.
- Reply-specific draft behavior.
- Trash draft behavior.

### What we are not building

- A generic task backlog.
- Separate frontend/backend project silos.
- Nice-to-have polish that obscures must-have draft behavior.
- Final scope names before the work reveals its real structure.

### Key user/system behaviors

- User starts a new draft.
- System stores draft information.
- User locates an existing draft.
- User edits and saves a draft.
- User sends a draft.
- User creates or resumes a reply draft.
- User trashes a draft.

### Technical surfaces likely touched

- Message composer UI.
- Draft persistence model.
- Draft listing / locating surface.
- Draft save/edit service.
- Send service.
- Reply-message context.
- Trash/delete affordance.

### Known risks and unknowns

- The first task list may not reveal real scope boundaries.
- `Save/Edit` may be too broad and need to split.
- Reply drafts may have special context requirements.
- Send behavior may depend on persisted draft state.

### First thing to learn or prove

Can the team finish the integrated `Start New` behavior end to end, proving that a new draft can be created and entered as a real object in the system?

### What can happen in parallel

After `Start New` establishes the draft object and basic path, `Locate` and `Trash` may be parallel candidates because they operate on existing drafts differently. `Send`, `Store`, and `Reply` need more caution because they may share draft state and message-context dependencies.

### What to show after the first slice

A user can create a new draft and see that the system treats it as a draft object rather than a temporary composer state.

### Cut lines if time gets tight

- Cut nice-to-have draft polish.
- Cut advanced draft search/filtering.
- Cut bulk trash.
- Defer reply-specific edge cases if basic drafting is not done.

## 4. Technical design plan

### Affected surfaces

| ID | Surface | Existing/New | Why it matters | Notes |
|---|---|---|---|---|
| SURF-01 | Composer / new draft UI | existing/new | Entry point for `Start New`. | Must create draft as a real object. |
| SURF-02 | Draft persistence | new/modified | Needed for `Store`, `Locate`, `Reply`, and `Send`. | Central dependency. |
| SURF-03 | Draft locator/list | new | Needed for `Locate`. | Can be simple. |
| SURF-04 | Draft edit/save behavior | new/modified | Keeps content after creation. | Initially grouped as `Save/Edit`, later split. |
| SURF-05 | Send pipeline | existing/modified | Converts draft to sent message. | Depends on draft data. |
| SURF-06 | Reply context | existing/modified | Drafts attached to replies may need parent message context. | Risky special case. |
| SURF-07 | Trash/delete affordance | new/modified | Removes unwanted draft. | Can be independent after draft exists. |

### Data / state

| ID | Data or state | Created/Read/Updated/Deleted | Owner/source | Persistence | Notes |
|---|---|---|---|---|---|
| STATE-01 | Draft record | Created/Read/Updated/Deleted | Draft model/service | db | Core object for all scopes. |
| STATE-02 | Draft content | Created/Updated/Read | Composer/editor | db | Used by save/edit and send. |
| STATE-03 | Draft status | Updated | Draft service | db | draft / sent / trashed. |
| STATE-04 | Reply parent context | Created/Read | Message/reply system | db | Needed for reply drafts. |

### Interfaces / contracts

| ID | Interface | Producer | Consumer | Contract / payload / behavior | Open question |
|---|---|---|---|---|---|
| IF-01 | Create draft | Composer UI | Draft service | Creates draft record and opens composer. | When is empty draft persisted? |
| IF-02 | List/locate drafts | Draft service | Locator UI | Returns draft summaries. | How much metadata is enough? |
| IF-03 | Save draft | Composer/editor | Draft service | Persists content changes. | Autosave or explicit save? |
| IF-04 | Send draft | Composer/editor | Send service | Sends draft content and updates status. | What validates sendability? |
| IF-05 | Trash draft | UI | Draft service | Marks or deletes draft. | Soft delete vs hard delete? |
| IF-06 | Reply draft | Reply composer | Draft service | Draft includes parent message context. | Special handling required? |

### Technical decisions

| ID | Decision | Rationale | Reversible? | Risk |
|---|---|---|---|---|
| TD-01 | Treat draft as a first-class record after `Start New`. | Makes locate, store, reply, trash possible. | hard-ish | Empty draft handling. |
| TD-02 | Split broad `Save/Edit` once real dependencies are visible. | Prevents huge ambiguous scope. | yes | Requires active scope management. |
| TD-03 | Model reply context separately from ordinary drafts. | Reply likely has extra parent-message dependency. | yes | Could overcomplicate if done too early. |

## 5. Assumptions, unknowns, and risks

| ID | Unknown / risk | Why it matters | Earliest way to learn | Related surfaces | Must resolve before |
|---|---|---|---|---|---|
| RISK-01 | Where draft persistence begins. | Affects `Start New`, `Locate`, and `Store`. | Build `Start New` end to end. | SURF-01, SURF-02 | TG-02, TG-03 |
| RISK-02 | `Save/Edit` is too broad. | Could hide multiple scopes and prevent visible completion. | Split after first integrated behavior is done. | SURF-04 | SLICE-02 |
| RISK-03 | Reply drafts need special parent context. | Could break reuse of ordinary draft flow. | Spike reply-context data path. | SURF-06 | TG-05 |
| RISK-04 | Send depends on stored draft state. | Send cannot be safely finished before storage is clear. | Confirm draft send payload. | SURF-05, SURF-02 | TG-04 |

## 6. Raw task dump

| ID | Task | Type | Known/Unknown | Notes |
|---|---|---|---|---|
| T-01 | Add start-new draft affordance. | design/code | known | First integrated behavior. |
| T-02 | Create draft record. | code/data | unknown | When/how to persist empty draft? |
| T-03 | Open composer on new draft. | design/code | known | User-visible path. |
| T-04 | Save draft content. | code | unknown | Part of broad Save/Edit. |
| T-05 | Edit existing draft. | design/code | known | Depends on locate/store. |
| T-06 | Show drafts in locator. | design/code | known | Locate scope. |
| T-07 | Fetch draft details. | code | known | Needed for edit/send/reply. |
| T-08 | Send draft. | code | unknown | Depends on stored content. |
| T-09 | Update draft status after send. | code/data | known | Sent state. |
| T-10 | Store draft metadata/content. | code/data | unknown | Split from Save/Edit. |
| T-11 | Handle reply draft parent context. | code/data | unknown | Special case. |
| T-12 | Trash draft. | design/code | known | Can be independent after record exists. |
| T-13 | Separate nice-to-haves. | planning | known | Prevent scope blur. |
| T-14 | Update tracker as scopes split. | planning | known | Core method behavior. |

## 7. Task groups / scopes

| ID | Name | Included tasks | Behavior / output produced | Risk state | Cuttable? | Notes |
|---|---|---|---|---|---|---|
| TG-01 | Start New | T-01, T-02, T-03 | User can start a new draft as a real object. | figuring-it-out | no | First anchor scope. |
| TG-02 | Locate | T-06, T-07 | User can find and open existing drafts. | not-started | no | Needs draft records. |
| TG-03 | Store | T-04, T-10 | Draft content and metadata persist. | figuring-it-out | no | Split from broad Save/Edit. |
| TG-04 | Send | T-08, T-09 | Draft can become sent message. | not-started | no | Depends on stored content. |
| TG-05 | Reply | T-11 | Reply draft keeps parent message context. | figuring-it-out | maybe | Special case; cuttable if basic drafts not done. |
| TG-06 | Trash | T-12 | User can discard draft. | not-started | yes | Independent after draft exists. |
| TG-07 | Scope hygiene | T-13, T-14 | Nice-to-haves separated and tracker updated. | executing-down | no | Planning/control scope. |

## 8. Interrelationship map

| ID | From | To | Relationship | Why it matters |
|---|---|---|---|---|
| D-01 | TG-01 | TG-02 | unlocks | Cannot locate drafts until drafts exist. |
| D-02 | TG-01 | TG-03 | unlocks | Cannot store content until draft object exists. |
| D-03 | TG-03 | TG-04 | enables | Send requires stored draft content. |
| D-04 | TG-03 | TG-05 | enables | Reply drafts need stored draft data plus parent context. |
| D-05 | TG-01 | TG-06 | unlocks | Cannot trash drafts until drafts exist. |
| D-06 | TG-07 | all | governs | Scope hygiene keeps nice-to-haves and splits visible. |

```mermaid
flowchart LR
  TG07["TG-07: Scope hygiene"] -. governs .-> TG01["TG-01: Start New"]
  TG07 -. governs .-> TG02["TG-02: Locate"]
  TG07 -. governs .-> TG03["TG-03: Store"]
  TG07 -. governs .-> TG04["TG-04: Send"]
  TG07 -. governs .-> TG05["TG-05: Reply"]
  TG07 -. governs .-> TG06["TG-06: Trash"]
  TG01 --> TG02
  TG01 --> TG03
  TG01 --> TG06
  TG03 --> TG04
  TG03 --> TG05
```

## 9. Foliated dependency layers

| Layer | Task groups | Dependency reason | Can start when... | Dependency-parallel candidates |
|---|---|---|---|---|
| L1 | TG-01, TG-07 | Start New has no unmet functional dependency; scope hygiene starts immediately. | project starts | yes, but TG-01 should get build focus |
| L2 | TG-02, TG-03, TG-06 | Locate, Store, and Trash need draft object from Start New. | TG-01 stop condition met | yes |
| L3 | TG-04, TG-05 | Send and Reply depend on stored draft content/context. | TG-03 stop condition met | yes, with caution |

## 10. Parallelization plan

| Candidate set | Groups | Dependency status | Unknown profile | Capacity conflict? | Decision | Rationale |
|---|---|---|---|---|---|---|
| PSET-01 | TG-01, TG-07 | Same layer | TG-01 has core unknown; TG-07 is planning hygiene | no | Run TG-07 lightly alongside TG-01. | Scope hygiene should not distract from finishing Start New. |
| PSET-02 | TG-02, TG-03, TG-06 | Same layer after TG-01 | TG-03 has higher unknown; TG-02/TG-06 are more bounded | possible shared draft model | Prioritize TG-03; parallelize TG-02/TG-06 if capacity allows. | Store determines what Locate and later Send/Reply need. |
| PSET-03 | TG-04, TG-05 | Same layer after TG-03 | TG-05 reply context is riskier | likely shared message area | Start TG-04 first; spike TG-05 if appetite allows. | Send is core; Reply may be special-case scope. |

## 11. Build sequence

| Order | Task group | Layer | Why now | What it must enable next | Parallel with | Stop when... |
|---|---|---|---|---|---|---|
| 1 | TG-01 | L1 | Anchor integrated scope; proves draft exists. | Locate, Store, Trash. | TG-07 lightly | A user can start a draft and the system has a draft object. |
| 2 | TG-03 | L2 | Biggest unknown after draft exists. | Send and Reply. | TG-02/TG-06 if capacity allows | Draft content and metadata persist reliably. |
| 3 | TG-02 | L2 | User needs to find drafts. | Edit/send from existing draft. | TG-06 | User can locate and open drafts. |
| 4 | TG-04 | L3 | Core completion path. | Ship basic draft lifecycle. | none or TG-05 spike | Draft can be sent and status updates. |
| 5 | TG-06 | L2 | Useful bounded cleanup behavior. | Complete basic lifecycle. | TG-02 | User can trash a draft. |
| 6 | TG-05 | L3 | Special-case behavior. | Reply-specific completeness. | none | Reply draft context works or is explicitly cut. |

## 12. Initial vertical slices

| ID | Slice | Purpose | Included task groups | Demo / proof | Acceptance checks | Non-goals |
|---|---|---|---|---|---|---|
| SLICE-01 | Start New | derisk/core behavior | TG-01, TG-07 | User starts a new draft; tracker has named scope. | AC-01 | No locate/send/reply yet. |
| SLICE-02 | Store and Locate | core behavior | TG-03, TG-02 | User saves content and finds draft later. | AC-02, AC-03 | No reply special case. |
| SLICE-03 | Send Draft | core behavior | TG-04 | User sends stored draft. | AC-04 | No advanced send options. |
| SLICE-04 | Trash / Reply Finish | finishing / optional | TG-06, TG-05 | User trashes draft; reply behavior works or is cut. | AC-05, AC-06 | No bulk trash. |

## 13. Scope cuts and deferrals

| ID | Remove/defer | Preserved behavior | Cost of cutting | Decision trigger |
|---|---|---|---|---|
| CUT-01 | Reply-specific drafts | Basic new draft, locate, store, send, trash still work. | Reply messages lack draft support. | If reply context is larger than expected. |
| CUT-02 | Trash | Start, store, locate, and send still work. | Users cannot discard drafts in v1. | If lifecycle work overruns appetite. |
| CUT-03 | Nice-to-have draft polish | Core lifecycle remains. | Less refined UI. | If scope starts to blur. |

## 14. Acceptance checks

| ID | Check | Applies to | Verification method |
|---|---|---|---|
| AC-01 | User can start a new draft and the system treats it as a draft object. | SLICE-01 / TG-01 | manual/dev test |
| AC-02 | User can save draft content and metadata. | SLICE-02 / TG-03 | manual/integration test |
| AC-03 | User can locate and open a saved draft. | SLICE-02 / TG-02 | manual/integration test |
| AC-04 | User can send a stored draft and draft status changes. | SLICE-03 / TG-04 | manual/integration test |
| AC-05 | User can trash a draft if included. | SLICE-04 / TG-06 | manual test |
| AC-06 | Reply draft either works with parent context or is explicitly cut. | SLICE-04 / TG-05 / CUT-01 | review/test |

## 15. Tracker

| Item | Type | State | Layer | Current unknown | Next visible proof | Blocked by | Parallelization note |
|---|---|---|---|---|---|---|---|
| SLICE-01 | slice | figuring-it-out | L1 | When/how draft object is created | Start New demo | none | Do first. |
| SLICE-02 | slice | not-started | L2 | Store shape | Save and locate draft | TG-01 | TG-02 can follow TG-03. |
| SLICE-03 | slice | not-started | L3 | Send payload/status | Draft sends | TG-03 | Prioritize before Reply. |
| SLICE-04 | slice | not-started | L2/L3 | Reply context | Trash/reply decision | TG-03 | Cut Reply if risky. |

## 16. Agent handoff packet

```text
Active slice: SLICE-01 — Start New
Source artifacts: examples/shapeup-message-drafts/source-case-study.md and Shape Up Chapter 12 Message Drafts case study
Authority order: user instruction > this implementation plan > source case study
Must preserve: scopes emerge from real interdependencies; do not split by frontend/backend; Start New is first anchor scope
Do not build: Locate, Send, Reply, Trash, or nice-to-have polish in the first slice
Relevant requirements: user can start a new draft; system treats draft as a real object
Relevant technical design decisions: TD-01 draft is first-class record after Start New
Relevant surfaces/files/modules, if known: composer/new draft UI, draft persistence surface
Included task groups: TG-01, light TG-07 scope hygiene
Relevant tasks: T-01, T-02, T-03, T-14
Dependency layer: L1
Parallelization decision: focus on TG-01; run TG-07 only as lightweight planning hygiene
Known unknowns: RISK-01 where draft persistence begins
Dependencies: none
Acceptance checks: AC-01
Stop condition: user can start a draft and the system has a draft object suitable for Locate/Store/Trash to build on
```
