# Data, secrets, assets, and MCP

Operational reference for reading and writing a deployed vibe's data. Every
command here talks to the LIVE app — there is no separate sandbox database.

## Databases

Every vibe has one or more Firefly databases (the default one is named
`default`). Reads and writes hit the live app's data, so treat production
vibes with care — a `db put` or `db del` against someone's real app changes
what their users see.

**Always pass `--vibe <handle>/<slug>` to target explicitly.** When the
target is omitted, the CLI falls back to `VIBES_APP_SLUG` or the current
directory's basename — outside a pulled vibe directory that either fails or,
worse, silently resolves to a different live app's database.

- List database names: `vibes-diy db list --vibe <handle>/<slug>`
- Read a document: `vibes-diy db get <id> --vibe <handle>/<slug>`
- Write a document (from an argument or from stdin with `-`, optionally
  pinning the id):
  `vibes-diy db put '{"text":"hello"}' --id my-doc --vibe <handle>/<slug>`
- Delete a document: `vibes-diy db del <id> --vibe <handle>/<slug>`
- Query by index: `vibes-diy db query <field> --key <value> --vibe <handle>/<slug>`
  (also `--prefix`, `--range`, `--limit`, `--descending`)
- Watch a live stream of changes: `vibes-diy db subscribe --vibe <handle>/<slug>`

## Secrets

Secrets are owner-only, write-only values. You can set them but never read
them back through the CLI — the running vibe's `backend.js` reads them via
`ctx.secrets` at request time.

- Set a secret (value from an argument or stdin): `vibes-diy secrets set <name>`
- List secret names (not values): `vibes-diy secrets ls`
- Remove a secret: `vibes-diy secrets rm <name>`

## Assets

Upload a binary asset (image, file) and get back a content-addressed URL:

```
vibes-diy put-asset --file <path> [--content-type <type>] [--verify]
```

This prints the asset's CID and its URL, ready to reference from the vibe's
code.

## MCP (optional, power users)

`vibes-diy mcp --app-slug <slug>` runs a stdio MCP server that exposes the
same data operations above (db, secrets, assets) as typed tools instead of
CLI subcommands. The plugin does not auto-register this server — nothing in
this skill wires it up for you. If a user wants it, register it manually:

```
claude mcp add vibes-diy -- vibes-diy mcp --app-slug <slug>
```

The Bash commands in this file are equally capable, so treat MCP as a
convenience for direct-API workflows, not a required step.

## Reducing permission prompts

Read-only `vibes-diy` subcommands are safe to allowlist so Claude Code stops
asking for permission on every call. Add this to `settings.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(vibes-diy list*)",
      "Bash(vibes-diy versions*)",
      "Bash(vibes-diy db get*)",
      "Bash(vibes-diy db list*)",
      "Bash(vibes-diy db query*)",
      "Bash(vibes-diy skills*)",
      "Bash(vibes-diy themes*)"
    ]
  }
}
```

Do not add write commands (`db put`, `db del`, `secrets set`, `push`,
`publish`) to this allowlist — those should stay confirmable.
