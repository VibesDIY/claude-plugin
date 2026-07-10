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

Pushed vibes default to public access with auto-accept editor grants — any
signed-in visitor can request edit access and get it automatically. This is
usually what a user wants for a collaborative app, but mention `--private`
on `vibes-diy push` when they want to opt out of that fast path (private or
gated apps).
