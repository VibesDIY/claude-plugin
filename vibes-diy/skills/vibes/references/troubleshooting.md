# Troubleshooting

## Not logged in

Interactive terminal: run `vibes-diy login`. This opens the browser so the
user can authorize there (120s timeout); pass `--force` to re-enroll a
device that's already registered.

Headless / remote environment: on a machine that IS already logged in, run
`base64 < ~/.fireproof/keybag/<id>.json` and set the resulting string as the
`VIBES_DEVICE_ID` environment variable in the headless environment — the
CLI seeds its keybag from it on first run.

Never print, log, or commit the keybag file's contents or the
`VIBES_DEVICE_ID` value in any command output, commit, or issue.

## Certs are per-API-URL

Switching `VIBES_API_URL` (e.g. moving between prod and a preview
environment) requires a separate enrollment — a cert minted against one API
URL will not authenticate against another.

## Poisoned slugs

If a `generate`/`edit` against a given slug returns the identical error on
repeated attempts, the slug is poisoned. Abandon it and redeploy under a
fresh slug (a new descriptive name) rather than retrying the same one.

## Deploy verification

`vibes-diy push` exits nonzero when the release is missing pushed files —
treat the exit code as ground truth and never report success without
checking it. Also verify the live URL actually responds before telling the
user the app is deployed.

## Stream cuts during generate/edit

The CLI auto-resumes from the server's persisted replay when a stream is
interrupted. Retry once on a transient error, then report the failure if it
persists.

## Deprecated flags

Use `--handle` (not the deprecated `--user-slug`). Prefer explicit
`--handle` in automation/scripts to prevent credential drift between
sessions.

## Still stuck

Fetch the live docs at https://good.vibes.diy before declaring any
capability unsupported — the installed CLI and these references can lag
what's actually shipped.
