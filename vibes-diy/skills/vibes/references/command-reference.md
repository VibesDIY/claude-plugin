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

- app-chats - List or read the runtime in-app chats stored by a deployed vibe (the app's own chat/image messages, NOT the codegen build transcript).
- chats - (removed) Use 'codegen-log' or 'app-chats' instead.
- codegen-log - Inspect a vibe's codegen build transcript (the builder↔LLM conversation that generated its source). List chats, or show one chat's prompts / reconstructed model output.
- db - Read and write Fireproof documents
- secrets - Manage per-vibe secrets readable by backend.js via ctx.secrets (owner-only; values are write-only)
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

- `npx vibes-diy push --instant-join` — deploy and auto-accept sharing so anyone with the link can use it
- `npx vibes-diy push --app-slug other-name` — deploy to a different app slug instead of the directory name
- `npx vibes-diy unpublish <vibe>` — take a deployed vibe down (reversible; code and data are kept)
- `npx vibes-diy publish <vibe>` — make it live again, or promote a `--mode dev` draft to production
- `npx vibes-diy login` — authenticate this device (run once before first push)
- `npx vibes-diy mcp --help` — start an MCP server for AI agent data access (Claude Desktop / Cowork)
- `npx vibes-diy help` — show all available commands
```

## `vibes-diy app-chats`

```text
vibes-diy CLI app-chats
> List or read the runtime in-app chats stored by a deployed vibe (the app's own chat/image messages, NOT the codegen build transcript).

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Handle (uses default if omitted) [default: ]

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

## `vibes-diy codegen-log`

```text
vibes-diy CLI codegen-log
> Inspect a vibe's codegen build transcript (the builder↔LLM conversation that generated its source). List chats, or show one chat's prompts / reconstructed model output.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Handle (uses default if omitted) [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID — same as positional, kept for symmetry with `db put --id` [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID (_id); falls back to the body _id, else generated [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Write with admin override (bypasses the vibe's access function). Works for the vibe owner or a platform admin [optional]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]
  --db <str>          - Database name [default: default]
  --id <str>          - Document ID — same as positional, kept for symmetry with `db put --id` [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --admin    - Delete with admin override (bypasses the db ACL). Works for the vibe owner or a platform admin [optional]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --user-slug <str>   - [deprecated] use --handle or --vibe instead [default: ]

FLAGS:
  --json, -j - selects json output format [optional]
  --text, -t - select text output format [default: true]
  --help, -h - show help [optional]

ARGUMENTS:
  <KEY> - a string
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
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
  --handle <str>      - Handle to publish under (uses default if omitted) [default: ]
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
  --handle <str>       - Handle to publish under (uses default if omitted) [default: ]
  --user-slug <str>    - a string [default: ]
  --vibe <str>         - Vibe identifier as handle/app-slug [default: ]
  --focus <str>        - Path to focus first in slot rendering (e.g. Card.jsx for multi-file edits) [optional]
  --model <str>        - Ephemeral model override for this run (e.g. qwen/qwen3-coder-480b-a35b-instruct); not persisted [optional]
  --api-key <str>      - Per-call BYOK provider key for this run (overrides any stored key, bills your own key); defaults to env VIBES_LLM_API_KEY. Not persisted. [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --instant-join - [Deprecated: no-op. Auto-accept editor is now always enabled by default.] [optional]
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
  --handle <str>      - Handle; defaults to defaultHandle from user settings [default: ]
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]

FLAGS:
  --help, -h - show help [optional]
## MCP Server Setup

Tools: vibes_list_apps, vibes_list_databases, vibes_get, vibes_put, vibes_delete, vibes_query

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

Add to .claude/settings.json:

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
  --handle <str>      - Handle (uses default if omitted) [default: ]
  --user-slug <str>   - a string [default: ]
  --dir <str>         - Directory to write files into (defaults to ./<appSlug>/) [default: ]
  --fsId <str>        - Pull a specific version by fsId (overrides --published / the draft default) [default: ]

FLAGS:
  --json, -j  - selects json output format [optional]
  --text, -t  - select text output format [default: true]
  --published - Pull the published (production) version instead of your latest draft [optional]
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
  --handle <str>          - Handle to publish under (uses default if omitted) [default: ]
  --user-slug <str>       - a string [default: ]
  --vibe <str>            - Vibe identifier as handle/app-slug [default: ]
  --message, -m <str>     - Context for the seeded chat: describe what the app is / the request behind it. Becomes the opening message of the vibe's chat instead of a generic 'Initial push' note. [default: ]
  --idle-timeout <number> - Idle timeout in ms (resets on any incoming message). Defaults to api-impl's 30s; bump higher for very large pushes that exceed post-storage DB-write windows. [optional]

FLAGS:
  --json, -j     - selects json output format [optional]
  --text, -t     - select text output format [default: true]
  --instant-join - [Deprecated: no-op. Auto-accept editor is now always enabled by default. Use --private to opt out.] [optional]
  --public       - [Deprecated: no-op. Public access is now always enabled by default. Use --private to opt out.] [optional]
  --private      - Opt out of fast-path defaults: disables public access and auto-accept-editor. Use for private or gated apps. [optional]
  --help, -h     - show help [optional]
```

## `vibes-diy publish`

```text
vibes-diy CLI publish
> Make a vibe live: promote its latest draft (or --fsId) to a new production release, and clear any unpublish tombstone. Use after editing in dev mode, or to bring an unpublished vibe back.

OPTIONS:
  --api-url, -u <str> - set the api url [default: https://vibes.diy/api?.stable-entry.=cli]
  --vibe <str>        - Vibe identifier as handle/app-slug [default: ]
  --handle <str>      - Handle (uses default if omitted) [default: ]
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
  --handle <str>      - Handle (uses default if omitted) [default: ]

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
  --handle <str>      - Handle (uses default if omitted) [default: ]

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
  --handle <str>       - Handle (uses default if omitted) [default: ]
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
