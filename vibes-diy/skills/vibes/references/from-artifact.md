# From-Artifact: graduate an artifact or local HTML page into a vibe

Use this runbook when the user asks to turn a Claude Code artifact (or any
local self-contained HTML page) into a vibe, or accepts the one-time
suggestion after hitting a static page's limits ("the form doesn't save",
"can my team use this together", "can it remember between visits", "how do
people log in").

The contract: a **faithful port plus chosen upgrades**. The converted vibe
must be recognizably the same page — this is a port, not a redesign. The
upgrades (persistence, shared state, sign-in) are scoped to the seams the
page already has, and every visibility decision is the user's, made in one
menu before any conversion work.

## Step 0 — Preconditions

### Consent ordering

When this runbook follows an ambient limitation complaint, the limitation
complaint itself is the decision point. Before the user says yes, make only the
one concise suggestion. Do not edit/patch the artifact, add a localStorage
workaround, write files, run `scripts/ensure-cli.sh`, invoke the CLI, or start
login.

After acceptance, locate and verify the HTML source before any setup or
authentication. For explicit `/vibes-diy:vibes` or direct conversion requests,
source availability still comes first; once it is available, run the skill preflight
immediately before the first CLI call. There is no ambient suggestion gate.

### Source availability

- Locate the HTML source and verify it is available. Preference order: the
  local file (you usually wrote it this session, before publishing the
  artifact); if the file is gone but the artifact was built in this
  conversation, reconstruct the HTML from conversation context — the
  conversation is the spec; otherwise ask the user to paste or provide the
  HTML. Never fetch artifact URLs — the published page is not an input in this
  lane.

### Setup and authentication

- Run the skill preflight (`scripts/ensure-cli.sh`) and resolve login before
  presenting the upgrade menu or doing conversion work, so the user never
  invests in choices they cannot ship. `login: no` in an interactive terminal
  → `vibes-diy login` (browser authorization); headless → the
  `VIBES_DEVICE_ID` recipe in `troubleshooting.md`.

## Step 1 — Seam inventory

Read the whole HTML file. List its **state seams** — places where it fakes,
loses, or wishes for state:

- forms (submissions currently go nowhere)
- editable lists, counters, checkboxes, scores
- `localStorage`/`sessionStorage` usage or attempts
- inert "save"/"submit" buttons, TODO comments about persistence
- places implying people ("who submitted", names typed into text fields)

Also note **un-portable pieces** to surface in the menu rather than silently
transform: very large inlined datasets, CSP-era workarounds (data-URI blobs
standing in for what should be assets), anything depending on being a single
static file.

## Step 2 — Upgrade menu (one message, one beat)

Present ONE message proposing the graduation seam by seam, in the user's
terms, each with an explicit visibility choice. Shared is never the default —
it is always an explicit user choice. Shape:

> Entries in your feedback form will now actually save. Two choices:
> **shared** (everyone sees all entries) or **private** (each visitor sees
> only their own)? And should **anonymous visitors** be able to submit, or
> require **sign-in**?

Offer extras only when the page implies them: sign-in gating when it asks
"who are you", in-app AI (`callAI`) when it fakes generated content. Exactly
one menu; take the answers and convert. Do not present a second menu.

Ground the menu in platform truth (verified live, 2026-07-13):

- **Anonymous submissions are device-local.** A signed-out visitor's writes
  save on their device only ("Saved on this device — sign in to sync") and
  reach the shared database when they later sign in. Signed-out visitors DO
  see shared data live. If the user wants drive-by anonymous posting into
  the shared feed, say plainly that the shared feed fills from signed-in
  users; anonymous visitors keep a private device-local copy until sign-in.
- **"Private" means view-scoping, not secrecy.** The default deploy is
  world-readable (data is also readable through the db API); filtering by
  `authorHandle` scopes what each visitor's UI shows but is not access
  control. If the user needs hard privacy, offer an access-function
  follow-up honestly — never imply the platform hides the data.

## Step 3 — Faithful port

Transform the HTML into a single-file vibe `App.jsx` — a port, not a
redesign. Carry the markup structure and styling over so the vibe is
recognizably the same page, then wire the chosen seams to the database.

### App.jsx authoring rules (distilled)

- One file, one default export: `export default function App() { ... }`.
- Imports: `import React from "react"` and
  `import { callAI, useFireproof, useViewer, useVibe } from "use-vibes"`
  (import only what you use). Any other bare import must resolve on esm.sh —
  prefer zero extra dependencies for a port.
- Database: `const { useDocument, useLiveQuery, database } = useFireproof("dbName")`.
  Sync is automatic — no attach/toCloud step; writes reach everyone with
  access in real time.
- Form seams: `const { doc, merge, submit } = useDocument({ text: "" })`.
  `submit` saves only the internal doc fields — to save extra fields
  (author, timestamp), use `database.put({...})` directly and `merge({...})`
  to clear the input.
- List seams: `const { docs } = useLiveQuery("type", { key: "entry" })` (or a
  sort field with `{ descending: true, limit: N }`).
- Write gates: gate write UI with
  `useVibe("dbName").can.create({ type: "entry" })` → `{ ok, reason }`;
  render `.reason` when denied. **Never gate a write surface on `isOwner`
  or `viewer` presence** — anonymous-write apps must render their form for
  signed-out visitors.
- Identity (when the menu chose sign-in or per-user data):
  `const { viewer, ViewerTag } = useViewer()`; stamp
  `authorHandle: viewer.userHandle` on docs at write time; render authorship
  with `<ViewerTag userHandle={doc.authorHandle} />`. Persist only the
  handle string.
- Styling: keep the artifact's inline CSS or translate carefully. Platform
  Tailwind is **px-scaled**: `px-5` means 5px, not 1.25rem — prefer explicit
  arbitrary values (`px-[16px]`) when translating spacing.
- Keep data-URI images inline in v1; mention `put-asset` only if the user
  asks about size.
- `callAI` goes through the platform — never put an API key in app code.

## Step 4 — Ship

Pick a descriptive slug (reads like the app, e.g. `team-feedback`, not
`app1`) and push:

```bash
vibes-diy push -m "From artifact: <artifact title> — <one-line description>"
```

The literal `From artifact: ` prefix is the provenance marker — keep the
exact spelling. On success the CLI prints the live URL (exit code is ground
truth). Report the URL AND enumerate what graduated: what now saves, what is
shared vs private, what requires sign-in.

Push defaults are the open fast-path: public access (world-readable) and
auto-accept editor. For a sign-in-gated or private-leaning app, consider
`push --private` (disables both) and tell the user what that changes —
visitors then need access instead of just the link.

## Step 5 — Handoff

Say explicitly: this is a normal vibe now. Further changes go through
`vibes-diy edit <handle>/<slug> "<follow-up>"` (platform codegen) or
pull → edit locally → push. The conversion lane is one-way and one-shot —
do not re-convert from the artifact after the vibe has diverged.

## Errors

| Failure                                              | Behavior                                                                   |
| ---------------------------------------------------- | -------------------------------------------------------------------------- |
| Not logged in / no account                           | Login flow at Step 0, before any conversion work                           |
| HTML file missing, artifact built this session       | Reconstruct from conversation context, proceed                             |
| HTML file missing, no context                        | Stop honestly; ask the user to provide the HTML. Never fetch artifact URLs |
| Push/build failure                                   | Debug and re-push; CLI exit code and output are the feedback loop          |
| Un-portable content (huge datasets, CSP workarounds) | Flag in the upgrade menu; the user decides                                 |
