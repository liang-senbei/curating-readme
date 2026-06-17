# curating-readme — a README / docs curation skill

**English** | [简体中文](README.zh-CN.md)

A [Claude Agent Skill](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
that turns a repository's **existing** information (manifest, code, scripts, config, git history,
current docs) into a **standardized, well-structured** README and related documentation
(CONTRIBUTING / CHANGELOG / docs/ / SECURITY).

Modeled on conventions from large, reputable projects: the
[standard-readme spec](https://github.com/RichardLitt/standard-readme) +
[Anthropic's skill-authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).

## Principles

- **Ground everything in the repo.** Every feature, command, config key, badge, and link must
  trace to something real in the repository. Never fabricate — if a claim can't be verified, leave
  it out and ask.
- **Update, don't clobber.** Treat an existing README as a draft to improve: preserve hand-written
  content, fill gaps, fix what's stale, and restructure only as much as the standard requires.
- **Match the repo's language and voice.** Chinese repo → write Chinese. Mirror the tone,
  terminology, and locale; don't switch languages unless asked.

## Layout

```
curating-readme/
├── SKILL.md                      # Skill body: 5-step workflow + checklists (the AI reads this on trigger)
├── README.md / README.zh-CN.md   # This file (human-facing), EN + 中文
├── references/                   # Loaded on demand (progressive disclosure)
│   ├── readme-structure.md       # Canonical README section order / required-vs-optional / what each holds
│   ├── doc-style-guide.md        # Voice / badges / headings / code blocks / links / tables
│   └── related-files.md          # CONTRIBUTING / CHANGELOG / LICENSE / SECURITY / docs playbook + skeletons
├── assets/
│   └── README.template.md        # Fill-in README skeleton
└── scripts/
    └── audit-repo.sh             # Read-only repo inventory (run it first, in step 1)
```

## Usage

### Install as a Claude Code skill

Skills load from `~/.claude/skills/` (user-level) or a project's `.claude/skills/`. Clone, then
symlink (or copy):

```bash
git clone https://github.com/liang-senbei/curating-readme.git
mkdir -p ~/.claude/skills
ln -s "$(pwd)/curating-readme" ~/.claude/skills/curating-readme   # or: cp -r curating-readme ~/.claude/skills/
```

Then, in any repository, say "update / standardize the README" or "document this project" and the
skill triggers; or call `/curating-readme` explicitly. Skills load at session startup — restart or
`/clear` a running session to pick it up.

### Just run the audit (no install needed)

```bash
bash scripts/audit-repo.sh /path/to/your/repo
```

Prints a "what does this repo actually contain" inventory — project type, entrypoints, runnable
scripts, existing docs, directory structure, env vars, git metadata, language breakdown, CI hints —
for the AI to ground its docs in, and for you to eyeball.

## Workflow (the checklist in SKILL.md)

1. **Gather** — run `audit-repo.sh`; read the existing README / manifest / entrypoints.
2. **Classify** — library / CLI / service / monorepo / docs → decide which sections apply.
3. **Draft** — write or refresh the README per `references/readme-structure.md`.
4. **Sync related files** — CONTRIBUTING / CHANGELOG / docs per `references/related-files.md`.
5. **Verify** — links resolve, commands exist, TOC matches headings, terminology and language are
   consistent, and every claim traces back to the repo.

See [SKILL.md](./SKILL.md) for the full instructions.
