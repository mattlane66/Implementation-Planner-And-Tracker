# Example Source PRD: Saved Grocery Lists

## Problem

Shoppers often rebuild the same grocery list every week. Today, the product only supports a temporary list for the current session. If someone closes the app or wants to reuse a prior list, they have to recreate it manually.

## Desired outcome

A returning shopper can save a grocery list, find it later, and reuse it as the starting point for a new shopping trip.

## Appetite

Two weeks for a small team.

## Selected approach

Add a lightweight saved-list feature:

- A shopper can save the current list with a name.
- A shopper can view saved lists.
- A shopper can reopen a saved list and copy its items into the current active list.

## Non-goals

- No collaboration.
- No sharing.
- No list templates marketplace.
- No real-time sync across devices.
- No list version history.

## Constraints

- The current list already exists in local app state.
- Users are already authenticated.
- Backend persistence exists for user-owned resources, but there is no saved-list model yet.
- Keep the UI minimal.

## Risks / unknowns

- It is unclear whether the existing list-item shape can be persisted as-is.
- It is unclear whether copying a saved list into the active list should replace or append to the current list.
- The existing active-list state may not have a clean boundary between temporary and persisted list data.

## Success checks

- A shopper can save a current list under a name.
- A shopper can see saved lists later.
- A shopper can reuse a saved list as the starting point for a new active list.
- If the project runs out of time, saving and reopening one list is more important than polish or bulk actions.
