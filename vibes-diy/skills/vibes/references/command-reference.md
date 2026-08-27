# vibes-diy command reference

<!-- GENERATED FILE — do not edit by hand. Regenerate with:
       pnpm --dir vibes-diy run docs:cli
     Source: the CLI's own --help output. -->

Every command, subcommand, and flag below is generated from the CLI's own
`--help` output, so it cannot diverge from what the installed CLI does.
When this file and the live `vibes-diy --help` disagree, trust the live CLI.

## `vibes-diy`

```text
vibes-diy CLI <subcommand>
> vibes-diy cli

where <subcommand> can be one of:

- app - Operate a deployed vibe: scheduled-task health, recovery, its ctx.log diagnostics, and its visitor-facing chips
- app-chats - List or read the runtime in-app chats stored by a deployed vibe (the app's own chat/image messages, NOT the codegen build transcript).
- chats - (removed) Use 'codegen-log' or 'app-chats' instead.
- claim-handle - Claim the handle your published apps carry (vibes.diy/<handle>/<app>) and make it your default. Run with no name to see suggestions — nothing is claimed until you name it.
- codegen-log - Inspect a vibe's codegen build transcript (the builder↔LLM conversation that generated its source). List chats, or show one chat's prompts / reconstructed model output.
- db - Read and write Fireproof documents
- secrets - Manage per-vibe secrets readable by backend.js via ctx.secrets (owner-only; values are write-only)
- recommend - Manage a vibe's recommended-apps chips (owner-only; the picks shown on its vibe card)
- retention - Audition lifecycle mail: preview one retention step in a real inbox, and reset its claim to preview it again
- developer - Delegate code push/edit/publish/codegen on a vibe to another account (owner-only; you keep revoke, unpublish/delete, and ownership)
- edit - Send a follow-up prompt to an existing vibe, write files to disk, and push live.
- generate - Generate a vibe from a text prompt, write it to disk, and push it live.
- list - List your vibes (ownerHandle/appSlug). Use --json for NDJSON output.
- login - Authenticate this device with vibes.diy cloud.
- mcp - Start an MCP server for AI agent data access (stdio transport)
- pull - Download source files of a deployed vibe to disk.
- push - Upload files from the current directory to a vibe.
- publish - Make a vibe live: promote its latest draft (or --fsId) to a new production release, and clear any unpublish tombstone. Use after editing in dev mode, or to bring an unpublished vibe back.
- unpublish - Take a deployed vibe down (reversible). De-indexes the slug and blocks its public URL/remix/version listing; code, data, and grants are kept. Bring it back with `publish`.
- versions - List every version of a vibe (fsId, mode, releaseSeq). Owner sees drafts; pull any with `pull --fsId`.
- put-asset - Stream a file to the asset endpoint and print the resulting CID + URL.
- skills - List available skills or show a skill's content.
- themes - List available themes or show a theme's design markdown.
- system - Emit the base system prompt to stdout.
- user-settings - Ensure/refresh user settings for the logged-in device.

For more help, try running `vibes-diy CLI <subcommand> --help`
## CLI Quickstart

### Deploy workflow

1. Run `npx vibes-diy system` to get the coding rules
2. Write `App.jsx` following the rules above
3. Run `npx vibes-diy push` to deploy — prints a live HTTPS URL
4. Edit and push again to iterate

### Other Commands

- `npx vibes-diy push --access gated` — deploy so anyone can view but only members write (`open` is the default, `private` is members-only)
- `npx vibes-diy push --no-access-fn` — skip the access wizard (a codegen turn) when going public without an `access.js`
- `npx vibes-diy push --app-slug other-name` — deploy to a different app slug instead of the directory name
- `npx vibes-diy unpublish <vibe>` — take a deployed vibe down (reversible; code and data are kept)
- `npx vibes-diy publish <vibe>` — make it live again, or promote a `--mode dev` draft to production
- `npx vibes-diy login` — authenticate this device (run once before first push)
- `npx vibes-diy mcp --help` — start an MCP server for AI agent data access (Claude Desktop / Cowork)
- `npx vibes-diy help` — show all available commands
```

## `vibes-diy app`

```text
vibes-diy CLI app <subcommand>
> Operate a deployed vibe: scheduled-task health, recovery, its ctx.log diagnostics, and its visitor-facing chips

where <subcommand> can be one of:

- status - Show a vibe's scheduled-task health: last tick, next tick, failures. Re-arms a dead timer if it finds one.
- rearm - Re-arm a vibe's scheduled task from its live release (a no-op when the schedule is already running).
- logs - Show what a vibe reported with ctx.log — its own diagnostics over a recent window, oldest line first. --tail follows.
- chips - Set the suggestion chips visitors see on a vibe's edit card (up to 3). --clear shows none. This is a publish: it changes what strangers see, not your own card. Publishing the vibe again re-derives the chips from your chat and overwrites what you set here — so set them after you publish.

For more help, try running `vibes-diy CLI app <subcommand> --help`
```

### `vibes-diy app status`

```text
vibes-diy CLI app status
> Show a vibe's scheduled-task health: last tick, next tick, failures. Re-arms a dead timer if it finds one.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

### `vibes-diy app rearm`

```text
vibes-diy CLI app rearm
> Re-arm a vibe's scheduled task from its live release (a no-op when the schedule is already running).

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

### `vibes-diy app logs`

```text
vibes-diy CLI app logs
> Show what a vibe reported with ctx.log — its own diagnostics over a recent window, oldest line first. --tail follows.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --since <str>       - How far back to read: a duration (30m, 2h, 1d, 1w) or an ISO timestamp. Default 1h. [default: 1h]
  --level <str>       - Only this level: debug, info, warn or error [default: ]
  --limit <number>    - Maximum events per read (max 500) [default: 100]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --tail     - Keep following new events until interrupted (Ctrl-C) [optional]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

### `vibes-diy app chips`

```text
vibes-diy CLI app chips
> Set the suggestion chips visitors see on a vibe's edit card (up to 3). --clear shows none. This is a publish: it changes what strangers see, not your own card. Publishing the vibe again re-derives the chips from your chat and overwrites what you set here — so set them after you publish.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --fs-id <str>       - Stamp this published version instead of the live release [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --clear    - Show visitors no chips at all [optional]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe]    - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
  [...chip] - The chip labels, in order. More than 3 are trimmed to the first 3.
```

## `vibes-diy app-chats`

```text
vibes-diy CLI app-chats
> List or read the runtime in-app chats stored by a deployed vibe (the app's own chat/image messages, NOT the codegen build transcript).

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe]   - App slug or handle/app-slug [optional]
  [chatId] - Chat ID to read (omit to list all runtime chats) [optional]
```

## `vibes-diy chats`

```text
vibes-diy CLI chats
> (removed) Use 'codegen-log' or 'app-chats' instead.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - ignored [default: ]
  --handle <str>      - ignored [default: ]
  --turn <str>        - ignored [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --response, -r - ignored [optional]
  --raw          - ignored [optional]
  --files        - ignored [optional]
  --jsonl        - ignored [optional]
  --user         - ignored [optional]
  --help, -h     - show help [optional]

ARGUMENTS:
  [vibe]   - ignored [optional]
  [chatId] - ignored [optional]
```

## `vibes-diy claim-handle`

```text
vibes-diy CLI claim-handle
> Claim the handle your published apps carry (vibes.diy/<handle>/<app>) and make it your default. Run with no name to see suggestions — nothing is claimed until you name it.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [name] - The handle to claim. Omit to list suggestions instead of claiming. [optional]
```

## `vibes-diy codegen-log`

```text
vibes-diy CLI codegen-log
> Inspect a vibe's codegen build transcript (the builder↔LLM conversation that generated its source). List chats, or show one chat's prompts / reconstructed model output.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --turn <str>        - With --response: select a specific turn by promptId (default: newest) [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --response, -r - Show the model's reply, block-faithfully reconstructed from stored block events, instead of the user prompt [optional]
  --raw          - With --response: byte-faithful raw model text captured upstream of the parser (preserves consumed labels & blank lines; new generations only) [optional]
  --files        - With --response: the resolved path→content map (via the generate/edit resolver) [optional]
  --jsonl        - With --response: the raw block events, one JSON object per line [optional]
  --user         - With --response: also print the user prompt(s) so the full transcript reads top-down [optional]
  --help, -h     - show help [optional]

ARGUMENTS:
  [vibe]   - App slug or handle/app-slug [optional]
  [chatId] - Chat ID to show prompt history for (omit to list all codegen chats) [optional]
```

## `vibes-diy db`

```text
vibes-diy CLI db <subcommand>
> Read and write Fireproof documents

where <subcommand> can be one of:

- list - List database names for an app
- get - Get a document by ID
- put - Put (create or update) a document. Pass JSON on argv or '-' to read from stdin.
- del - Delete a document by ID
- query - Query documents by field value with optional key/prefix/range/limit filters
- subscribe - Tail real-time doc-changed events for a database (Ctrl+C to exit). Reconnects mid-stream; events that fire during the gap are not backfilled.

For more help, try running `vibes-diy CLI db <subcommand> --help`
```

### `vibes-diy db list`

```text
vibes-diy CLI db list
> List database names for an app

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Request platform-admin elevation for a read of ANOTHER owner's vibe (bypasses per-user channel filtering). Not needed for your own vibes; honored only for allowlisted platform admins [optional]
  --help, -h - show help [optional]
```

### `vibes-diy db get`

```text
vibes-diy CLI db get
> Get a document by ID

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID — same as positional, kept for symmetry with `db put --id` [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Request platform-admin elevation for a read of ANOTHER owner's vibe (bypasses per-user channel filtering). Not needed for your own vibes; honored only for allowlisted platform admins [optional]
  --help, -h - show help [optional]

ARGUMENTS:
  [docId] - Document ID (or pass --id) [optional]
```

### `vibes-diy db put`

```text
vibes-diy CLI db put
> Put (create or update) a document. Pass JSON on argv or '-' to read from stdin.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID (_id); falls back to the body _id, else generated [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Write with admin override: bypasses the legacy db ACL. The vibe's access function still runs and can still refuse — --admin is only a hint it may honor, and a refused write stays refused (unlike `db del --admin`, which forces the delete). Works for the vibe owner or a platform admin [optional]
  --help, -h - show help [optional]

ARGUMENTS:
  <json> - JSON document to store, or '-' to read from stdin
```

### `vibes-diy db del`

```text
vibes-diy CLI db del
> Delete a document by ID

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID — same as positional, kept for symmetry with `db put --id` [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Delete with admin override: bypasses the legacy db ACL, and — deletes only — proceeds even when the vibe's access function refuses. Every forced delete is audited. Note the asymmetry: `db put --admin` is NOT forced past the access function. Works for the vibe owner or a platform admin [optional]
  --help, -h - show help [optional]

ARGUMENTS:
  [docId] - Document ID (or pass --id) [optional]
```

### `vibes-diy db query`

```text
vibes-diy CLI db query
> Query documents by field value with optional key/prefix/range/limit filters

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --key <str>         - Exact key match (JSON value) [default: ]
  --prefix <str>      - Prefix match (JSON value) [default: ]
  --range <str>       - Range filter as JSON two-element array [start, end] [default: ]
  --limit <number>    - Maximum number of results (0 = no limit) [default: 0]

FLAGS:
  --json, -j   - selects json output format [optional]
  --text, -t   - select text output format [default: true]
  --descending - Return results in descending order [optional]
  --admin      - Request platform-admin elevation for a read of ANOTHER owner's vibe (bypasses per-user channel filtering). Not needed for your own vibes; honored only for allowlisted platform admins [optional]
  --help, -h   - show help [optional]

ARGUMENTS:
  <field> - Field name to index on
```

### `vibes-diy db subscribe`

```text
vibes-diy CLI db subscribe
> Tail real-time doc-changed events for a database (Ctrl+C to exit). Reconnects mid-stream; events that fire during the gap are not backfilled.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy secrets`

```text
vibes-diy CLI secrets <subcommand>
> Manage per-vibe secrets readable by backend.js via ctx.secrets (owner-only; values are write-only)

where <subcommand> can be one of:

- set - Set or rotate a secret. Value from the arg, or stdin when omitted.
- ls - List secret keys (metadata only — values never come back)
- rm - Remove a secret

For more help, try running `vibes-diy CLI secrets <subcommand> --help`
```

### `vibes-diy secrets set`

```text
vibes-diy CLI secrets set
> Set or rotate a secret. Value from the arg, or stdin when omitted.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <KEY>   - a string
  [value] - a string [optional]
```

### `vibes-diy secrets ls`

```text
vibes-diy CLI secrets ls
> List secret keys (metadata only — values never come back)

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

### `vibes-diy secrets rm`

```text
vibes-diy CLI secrets rm
> Remove a secret

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <KEY> - a string
```

## `vibes-diy recommend`

```text
vibes-diy CLI recommend <subcommand>
> Manage a vibe's recommended-apps chips (owner-only; the picks shown on its vibe card)

where <subcommand> can be one of:

- add - Recommend another vibe (prepended to the strip). TARGET is handle/app-slug.
- ls - List the vibe's curated recommended entries (id + handle/app-slug)
- rm - Remove a curated entry by its ID (from 'recommend ls')
- mask - Hide one of YOUR OWN vibes from this vibe's auto recommendations. TARGET is handle/app-slug.
- unmask - Undo a mask — let an auto-recommended own vibe reappear. TARGET is handle/app-slug.

For more help, try running `vibes-diy CLI recommend <subcommand> --help`
```

### `vibes-diy recommend add`

```text
vibes-diy CLI recommend add
> Recommend another vibe (prepended to the strip). TARGET is handle/app-slug.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <TARGET> - a string
```

### `vibes-diy recommend ls`

```text
vibes-diy CLI recommend ls
> List the vibe's curated recommended entries (id + handle/app-slug)

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

### `vibes-diy recommend rm`

```text
vibes-diy CLI recommend rm
> Remove a curated entry by its ID (from 'recommend ls')

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <ID> - a string
```

### `vibes-diy recommend mask`

```text
vibes-diy CLI recommend mask
> Hide one of YOUR OWN vibes from this vibe's auto recommendations. TARGET is handle/app-slug.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <TARGET> - a string
```

### `vibes-diy recommend unmask`

```text
vibes-diy CLI recommend unmask
> Undo a mask — let an auto-recommended own vibe reappear. TARGET is handle/app-slug.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <TARGET> - a string
```

## `vibes-diy retention`

```text
vibes-diy CLI retention <subcommand>
> Audition lifecycle mail: preview one retention step in a real inbox, and reset its claim to preview it again

where <subcommand> can be one of:

- preview - Send yourself (or a @vibes.diy teammate) one lifecycle-mail step, through the real send path. Admin-gated.
- reset - Clear a retention step's already-sent claim so it can be previewed again (admin-gated, same recipient rule).

For more help, try running `vibes-diy CLI retention <subcommand> --help`
```

### `vibes-diy retention preview`

```text
vibes-diy CLI retention preview
> Send yourself (or a @vibes.diy teammate) one lifecycle-mail step, through the real send path. Admin-gated.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --step <str>        - Retention step id (e.g. day3-first-app) [default: ]
  --user <str>        - Target Clerk userId — defaults to your own account [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

### `vibes-diy retention reset`

```text
vibes-diy CLI retention reset
> Clear a retention step's already-sent claim so it can be previewed again (admin-gated, same recipient rule).

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --user <str>        - Target Clerk userId [default: ]
  --step <str>        - Retention step id — omit to clear every claim on the account [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy developer`

```text
vibes-diy CLI developer <subcommand>
> Delegate code push/edit/publish/codegen on a vibe to another account (owner-only; you keep revoke, unpublish/delete, and ownership)

where <subcommand> can be one of:

- add - Grant a developer the right to edit this vibe's code (they can read all its data and secrets)
- rm - Revoke a developer grant
- ls - List developer grants on this vibe

For more help, try running `vibes-diy CLI developer <subcommand> --help`
```

### `vibes-diy developer add`

```text
vibes-diy CLI developer add
> Grant a developer the right to edit this vibe's code (they can read all its data and secrets)

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <HANDLE> - a string
```

### `vibes-diy developer rm`

```text
vibes-diy CLI developer rm
> Revoke a developer grant

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <HANDLE> - a string
```

### `vibes-diy developer ls`

```text
vibes-diy CLI developer ls
> List developer grants on this vibe

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged). Addresses the vibe too when --vibe is absent [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy edit`

```text
vibes-diy CLI edit
> Send a follow-up prompt to an existing vibe, write files to disk, and push live.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Publish under this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --user-slug <str>   - a string [default: ]
  --dir <str>         - Directory to write resolved files and push from (defaults to cwd) [default: ]
  --focus <str>       - Path to focus first in slot rendering (e.g. Card.jsx for multi-file edits) [optional]
  --model <str>       - Ephemeral model override for this run (e.g. qwen/qwen3-coder-480b-a35b-instruct); not persisted [optional]
  --api-key <str>     - Per-call BYOK provider key for this run (overrides any stored key, bills your own key); defaults to env VIBES_LLM_API_KEY. Not persisted. [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --instant-join - [Deprecated: no-op. Auto-accept editor is now always enabled by default.] [optional]
  --verbose, -v  - Stream AI response to stderr as it arrives [optional]
  --dry-run      - Inspect the prompt the server would dispatch; do not write files or push [optional]
  --transcript   - With --dry-run, render the payload as a human-readable transcript instead of JSON [optional]
  --help, -h     - show help [optional]

ARGUMENTS:
  [vibe]   - App slug or handle/app-slug [optional]
  [prompt] - Follow-up prompt describing what to change [optional]
```

## `vibes-diy generate`

```text
vibes-diy CLI generate
> Generate a vibe from a text prompt, write it to disk, and push it live.

OPTIONS:
  --api-url, -u <str>  - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --app-slug, -a <str> - App slug (server generates one if omitted) [default: ]
  --handle <str>       - Publish under this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --user-slug <str>    - a string [default: ]
  --vibe <str>         - Vibe identifier as handle/app-slug [default: ]
  --focus <str>        - Path to focus first in slot rendering (e.g. Card.jsx for multi-file edits) [optional]
  --model <str>        - Ephemeral model override for this run (e.g. qwen/qwen3-coder-480b-a35b-instruct); not persisted [optional]
  --api-key <str>      - Per-call BYOK provider key for this run (overrides any stored key, bills your own key); defaults to env VIBES_LLM_API_KEY. Not persisted. [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --instant-join - [Deprecated: no-op. Auto-accept editor is now always enabled by default.] [optional]
  --no-access-fn - Publish without running the access wizard (a second codegen turn) when the generated app has no access.js. Nothing will govern what visitors do with its documents. [optional]
  --verbose, -v  - Stream AI response to stderr as it arrives [optional]
  --dry-run      - Inspect the prompt the server would dispatch; writes no files, pushes nothing, and creates nothing server-side (no vibe metadata, no chat/app-slug bookkeeping row) [optional]
  --transcript   - With --dry-run, render the payload as a human-readable transcript instead of JSON [optional]
  --help, -h     - show help [optional]

ARGUMENTS:
  <prompt> - Describe the app you want to create
```

## `vibes-diy list`

```text
vibes-diy CLI list
> List your vibes (ownerHandle/appSlug). Use --json for NDJSON output.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy login`

```text
vibes-diy CLI login
> Authenticate this device with vibes.diy cloud.

OPTIONS:
  --api-url, -u <str>      - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --timeout <str>          - Seconds to wait for browser auth callback [default: 120]
  --common-name, -cn <str> - Common name for the device certificate (defaults to random ID) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --force    - Re-register even if a certificate already exists [optional]
  --help, -h - show help [optional]
```

## `vibes-diy mcp`

```text
vibes-diy CLI mcp
> Start an MCP server for AI agent data access (stdio transport)

OPTIONS:
  --app-slug <str>    - App slug; defaults to env VIBES_APP_SLUG or basename(cwd) [default: <current directory name>]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]

FLAGS:
  --help, -h - show help [optional]
## MCP Server Setup

Tools: vibes_list_apps, vibes_list_databases, vibes_get, vibes_put, vibes_delete, vibes_query, vibes_generate

`vibes_generate` builds a brand-new vibe from a text prompt and deploys it live —
it takes minutes and spends your AI credits. The new app is separate from the
`--app-slug` this server was started with; the data tools keep pointing at that
one.

Requires: npx vibes-diy login (one time)

### Claude Desktop / Cowork

Add to ~/Library/Application Support/Claude/claude_desktop_config.json:

```json
{
  "mcpServers": {
    "my-vibe": {
      "command": "npx",
      "args": ["vibes-diy", "mcp", "--app-slug", "APP", "--handle", "USER"]
    }
  }
}
```

### Claude Code

Add to .mcp.json in your project root:

```json
{
  "mcpServers": {
    "my-vibe": {
      "command": "npx",
      "args": ["vibes-diy", "mcp"]
    }
  }
}
```

### Test interactively

    npx @modelcontextprotocol/inspector npx vibes-diy mcp --app-slug APP
```

## `vibes-diy pull`

```text
vibes-diy CLI pull
> Download source files of a deployed vibe to disk.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --user-slug <str>   - a string [default: ]
  --dir <str>         - Directory to write files into (defaults to ./<appSlug>/) [default: ]
  --fsId <str>        - Pull a specific version by fsId (use instead of --version / --published / --draft) [default: ]
  --version <str>     - Pull a specific version by the label the version menu shows, e.g. v3 (or 3) [default: ]

FLAGS:
  --json, -j  - selects json output format [optional]
  --text, -t  - select text output format [default: true]
  --published - Pull the published (production) version instead of your latest draft [optional]
  --draft     - Pull the owner's latest unreleased draft. Already the default for your own vibes; on a platform-admin pull of someone else's vibe this is the explicit, separately audited opt-in to their unreleased work (a bare pull serves the published release) [optional]
  --help, -h  - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

## `vibes-diy push`

```text
vibes-diy CLI push
> Upload files from the current directory to a vibe.

OPTIONS:
  --api-url, -u <str>     - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --mode <str>            - Deploy mode: production or dev [default: production]
  --app-slug, -a <str>    - App slug (defaults to directory name) [default: ]
  --handle <str>          - Publish under this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --user-slug <str>       - a string [default: ]
  --vibe <str>            - Vibe identifier as handle/app-slug [default: ]
  --access <str>          - Deployment posture: open (anyone can reach it; your access.js governs its documents), gated (anyone can view, members write), private (members only). Defaults to open. [default: ]
  --api-key <str>         - Provider API key for a wizard turn triggered by this push (BYOK): bills your own key instead of your Vibes credits. Not persisted. [optional]
  --message, -m <str>     - Context for the seeded chat: describe what the app is / the request behind it. Becomes the opening message of the vibe's chat instead of a generic 'Initial push' note. [default: ]
  --idle-timeout <number> - Idle timeout in ms (resets on any incoming message). Defaults to api-impl's 30s; bump higher for very large pushes that exceed post-storage DB-write windows. [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --private      - Alias for --access private. [optional]
  --no-access-fn - Publish to a public posture with no access.js instead of running the access wizard (a codegen turn). Nothing will govern what visitors do with your app's documents. [optional]
  --help, -h     - show help [optional]
```

## `vibes-diy publish`

```text
vibes-diy CLI publish
> Make a vibe live: promote its latest draft (or --fsId) to a new production release, and clear any unpublish tombstone. Use after editing in dev mode, or to bring an unpublished vibe back.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --fsId <str>        - Publish a specific version (fsId from `vibes-diy versions`) instead of the latest draft. [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

## `vibes-diy unpublish`

```text
vibes-diy CLI unpublish
> Take a deployed vibe down (reversible). De-indexes the slug and blocks its public URL/remix/version listing; code, data, and grants are kept. Bring it back with `publish`.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

## `vibes-diy versions`

```text
vibes-diy CLI versions
> List every version of a vibe (fsId, mode, releaseSeq). Owner sees drafts; pull any with `pull --fsId`.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  [vibe] - App slug or handle/app-slug (e.g. jchris/hat-smeller) [optional]
```

## `vibes-diy put-asset`

```text
vibes-diy CLI put-asset
> Stream a file to the asset endpoint and print the resulting CID + URL.

OPTIONS:
  --api-url, -u <str>  - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --app-slug, -a <str> - App slug (defaults to the file's basename without extension) [default: ]
  --handle <str>       - Act as this bound handle for this call only (leaves your default handle unchanged) [default: ]
  --user-slug <str>    - a string [default: ]
  --vibe <str>         - Vibe identifier as handle/app-slug [default: ]
  --mime-type <str>    - Content-Type for the upload (inferred from extension if omitted) [default: ]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --verify-fetch - After upload, GET the asset back via /assets/cid and compare size [optional]
  --help, -h     - show help [optional]

ARGUMENTS:
  <file> - Path to the file to upload
```

## `vibes-diy skills`

```text
vibes-diy CLI skills
> List available skills or show a skill's content.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --name, -n <str>    - Skill name to show content for (omit to list all) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy themes`

```text
vibes-diy CLI themes
> List available themes or show a theme's design markdown.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --slug, -s <str>    - Theme slug to show content for (omit to list all) [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy system`

```text
vibes-diy CLI system
> Emit the base system prompt to stdout.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```

## `vibes-diy user-settings`

```text
vibes-diy CLI user-settings
> Ensure/refresh user settings for the logged-in device.

OPTIONS:
  --api-url, -u <str>        - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --set-default-handle <str> - Set the account's default (active) handle to one of its bound handles [optional]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]
```
