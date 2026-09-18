# Writing good vibes.diy prompts

`vibes-diy generate` and `vibes-diy edit` both take a natural-language prompt.
The prompt quality is most of what separates a great first app from a
mediocre one. This reference covers the habits that matter.

## Brevity wins

Keep generate and edit prompts under **50 words**. Long, kitchen-sink prompts
overflow the server-side prompt budget and produce muddier results than a
short prompt followed by focused edits. State **one job** per prompt — if the
user describes several features in one breath, split them into a generate
plus a sequence of edits rather than trying to cram everything into a single
call.

```
Bad (one prompt, three jobs, 24+ words trying to do too much):
  "a recipe app with meal planning and a shopping list and sharing recipes
   with friends and a rating system"

Better (generate + follow-up edits, one job each):
  vibes-diy generate "a recipe app with a weekly meal planner" --app-slug meal-planner --handle jane
  vibes-diy edit meal-planner "add a shopping list generated from the week's recipes"
  vibes-diy edit meal-planner "let a signed-in user rate a recipe 1-5 stars"
```

## Slug hygiene

`--app-slug` becomes part of the public URL, so pick a short, descriptive
kebab-case name — something a person could read aloud and recognize later.
Never hand it a uuid-ish or auto-generated-looking string.

```
Bad:  --app-slug a8f3c1e0-vibe
Good: --app-slug pizza-quiz
Good: --app-slug team-standup-board
```

## Design autonomy

Don't art-direct in the prompt. The model owns styling — colors, layout,
spacing, typography — and does noticeably better work when it isn't
constrained by prose trying to describe a look. If the user cares about
look-and-feel, steer it through **themes** instead of prompt adjectives:

```
Bad:  "make it use a dark navy background with rounded cards and a subtle
       drop shadow and a serif heading font"

Better:
  vibes-diy themes            # list available themes
  vibes-diy themes <slug>     # inspect one before applying it
  vibes-diy generate "a workout log" --app-slug workout-log --theme <slug>
```

### Pinning the variety — only for a comparison

Every build is also given a **layout archetype** and three **flourishes**, drawn
at random by the server so the catalog stays evenly measured. `vibes-diy variety`
prints both lists, and `--variety "<archetype>:<a>,<b>,<c>"` holds them still:

```
vibes-diy variety                                    # the names, with what each one does
vibes-diy generate "a workout log" --app-slug workout-log \
  --variety "card-grid:accent-rule,caps-label,inset-divider"
```

Reach for it only when two builds are being COMPARED and the comparison would
otherwise be partly about two random draws. For an ordinary app, omit it — the
draw is what gives neighbouring apps different shapes, and pinning one is asking
for a build that looks like the last one. A name that is not in the catalogs is
refused before anything is built, with the valid names listed.

### Changing the look of an app that already exists

Don't regenerate an app to restyle it. `vibes-diy app look get <owner>/<slug>`
prints its theme, style and current archetype + flourishes, and `app look set
<owner>/<slug> [--theme <slug>] [--variety "<archetype>:<a>,<b>,<c>"]` changes
them in place — the app keeps its URL, its data and its code. A theme is served,
so colours change without a build; a variety only ARMS the next build, so the app
keeps its current layout until the user's next edit restructures it (or until you
pass `--relayout`, which dispatches that edit immediately and spends a turn —
so ask first). Prefer this over `vibes-diy generate` for any "can it look
different" request: regenerating mints a new app and abandons the old one's data
and public URL, which is almost never what the user meant. Reach for `edit`
instead when the ask is about specific markup rather than the app's overall look.

## Platform skills

`vibes-diy skills` lists platform capabilities the generator can lean on —
things like auth, image uploads, or realtime sync — and `vibes-diy skills
<name>` shows detail on one. When a prompt needs one of these, name the
capability rather than pasting in implementation detail; the generator
already knows how to wire the skill up correctly.

```
Bad:  "add a users table, a sessions table, bcrypt password hashing, and a
       login form that sets a cookie"

Good: "add sign-in" (let vibes-diy skills auth do the wiring)
```

## Iterating: edit vs. regenerate

Prefer `vibes-diy edit <vibe> "<one change>"` over regenerating from scratch.
Edits preserve the app's existing data and its public URL; a fresh
`vibes-diy generate` does not. Use `--focus <path>` to point an edit at one
file when the app has grown past a single component:

```
vibes-diy edit team-standup-board "add a due-date field to each task" --focus TaskList.jsx
```

Before spending a real turn, preview the exact request with `--dry-run`
(add `--transcript` for a human-readable rendering instead of raw JSON):

```
vibes-diy edit team-standup-board "add a due-date field to each task" --dry-run --transcript
```

## Multi-user by default

A push states the app's access posture in one word: `--access open` (the
default) means anyone can reach it, with the app's own `access.js` governing
what each visitor may do with its documents — not "all your data is public".
`--access gated` lets anyone view but only members write; `--access private`
(also spelled `--private`) is members only.

Taking an app to `open` or `gated` with no `access.js` in the directory
**refuses the push**: opening an app to people who are not you with nothing
governing what they may do with its documents is a decision, not a default.
The two ways through are write an `access.js` (`vibes-diy edit` will, if you
ask it to), or pass `--no-access-fn` to publish with nothing governing
visitors. The CLI no longer generates the rules for you mid-push — that was a
special server turn and it is gone.

**That refusal is a `push` refusal only.** `generate` no longer pushes
anything: it opens a chat on the same lane as a first prompt on the web, the
server names and builds the app, and that build is released **live and
private** — reachable by you, exactly as a web first build is. So a first
build never hits the no-`access.js` refusal, and `--no-access-fn` on
`generate` is a deprecated no-op. To open it up afterwards, either
`vibes-diy push --access open` from the directory (with an `access.js`) or
the Share sheet on the app's page — the same two doors the web has.

## `generate` stays in the conversation

`generate` follows the chat it opened. It prints the agent's own evidence
lines — the same words the web chat shows — and re-materializes the files
when the agent runs a second build (adding `access.js`, for instance), so
the directory ends up holding what the app actually serves. In a terminal it
then drops into a prompt loop: type a follow-up to ride the same chat,
`/exit` or Ctrl-D to leave. Under `--json`, or when driven from MCP, there is
no loop — it reads until the agent goes idle and returns.

Add `--record <dir>` to keep a raw wire transcript of the run (the deduped
events plus your own messages). It is a debugging artifact, not the eval
harness's judged record.
