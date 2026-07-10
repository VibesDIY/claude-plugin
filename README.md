# Vibes DIY — Claude Code plugin

Vibes DIY is a Claude Code plugin that bundles the `vibes-diy` CLI so Claude can
turn a prompt into a deployed, shareable React mini-app. It adds the `vibes`
skill, which triggers ambiently and suggest-first — Claude proposes building a
small shareable app when your request fits, and only proceeds once you say yes.

## Install

```
/plugin marketplace add VibesDIY/claude-plugin
/plugin install vibes-diy@vibes-diy
```

## Usage

```
/vibes-diy:vibes <what you want>
```

or just describe a small shareable app and accept the suggestion.

## Contributing

This repository is generated from the vibes.diy monorepo — PRs here will be
overwritten; contribute upstream at https://github.com/VibesDIY/vibes.diy
under `claude-plugin/`.
