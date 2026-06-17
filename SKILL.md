---
name: curating-readme
description: >-
  Audits a repository's existing information (manifests, code, scripts, config,
  git history, existing docs) and updates the README plus related documentation
  (CONTRIBUTING, CHANGELOG, docs/, SECURITY) into a standardized, well-structured
  form modeled on conventions used by large, reputable open-source projects. Use
  whenever the user wants to write, update, refresh, standardize, audit, or fix a
  README or project documentation; mentions "README", "readme", "docs", "文档",
  "说明文档", "整理文档", "更新 readme"; asks to "document the project", "clean up
  the docs", or bring documentation in line with conventions. Grounds every
  statement in the actual repository and never fabricates.
---

# Curating README & Project Docs

Turn what a repository **already contains** into accurate, standardized, well-structured
documentation. The README is the hub; related files (CONTRIBUTING, CHANGELOG, docs/, …)
branch off it. This skill is for *organizing and updating existing information* — not for
inventing a project's story.

## Core principles (non-negotiable)

1. **Ground everything in the repo.** Read before you write. Every feature, command, config
   key, badge, and link must be traceable to something real in the repository (a manifest,
   a script, source code, a config file, git history). If you cannot verify a claim, leave
   it out and ask the user — do **not** guess.
2. **Update, don't clobber.** Treat an existing README as a draft to improve. Preserve
   hand-written and custom sections; fill gaps, fix what's stale, and restructure only as
   much as the standard requires. Never replace a thoughtful README with a generic template.
3. **Match the repo's language and voice.** If the existing docs are in Chinese, write in
   Chinese. Mirror the project's tone, heading style, terminology, and locale. Do not switch
   languages or rewrite the voice unless explicitly asked.
4. **Concise and accurate beats long and vague.** Assume the reader is competent. Cut
   filler. A short README that is 100% correct is worth more than a long one with one wrong
   install command.
5. **Only touch what's in scope.** Edit the README and the related files the task calls for.
   Keep every cross-link between them valid.

## Workflow

Copy this checklist into your working notes and check items off as you go:

```
- [ ] 1. Gather ground truth   (run the audit, read existing docs + key code)
- [ ] 2. Classify the project  (type → which sections apply)
- [ ] 3. Draft / refresh README (follow the standard section order)
- [ ] 4. Update related files   (CONTRIBUTING / CHANGELOG / docs / …)
- [ ] 5. Verify                 (links, commands, TOC, consistency, grounding)
```

### Step 1 — Gather ground truth

Run the inventory script first; it is read-only and deterministic:

```bash
bash scripts/audit-repo.sh [path-to-repo]   # defaults to current directory
```

It surfaces: project type & manifest fields, entrypoints & runnable scripts, existing docs,
directory structure, env vars/config, git metadata, language breakdown, and CI hints. Treat
its output as your source of truth.

Then read the files it points to that matter most: the existing `README*`, the manifest
(`package.json` / `pyproject.toml` / `go.mod` / …), the main entrypoint, any existing
`CONTRIBUTING`/`CHANGELOG`, and agent-guidance files (`AGENTS.md`, `CLAUDE.md`). If the
script cannot run, gather the same facts by hand.

### Step 2 — Classify the project

Identify the type, because it decides which sections are required:

| Type | Required emphasis | Often omit |
|------|-------------------|------------|
| Library / SDK / package | Install, Usage, API | Deployment |
| CLI tool | Install, Usage (commands/flags) | API |
| Web app / service | Quick Start, Configuration, Deployment, Architecture | Published API (unless it exposes one) |
| Monorepo | Overview + per-package links, Structure | Single Install |
| Docs / content repo | Background, Structure, Contributing | Install, Usage |

See `references/readme-structure.md` for the full ordered section list and exactly what each
section must contain and which are required vs optional.

### Step 3 — Draft / refresh the README

Follow the canonical section **order and rules** in `references/readme-structure.md`. When
starting from nothing, copy `assets/README.template.md` as a skeleton and fill it from the
audit — never ship the placeholders. When a README already exists, merge: keep good content,
re-order to the standard, fix stale facts, add missing required sections, drop sections that
don't apply to the type.

Quick rules to keep in mind (details in the references):
- Short description on its own line, **under ~120 characters**, matching the manifest/repo description.
- Add a **Table of Contents** once the README passes ~100 lines.
- **Install** and **Usage** are required for any code project; show real, copy-pasteable commands.
- **License** goes last and names the actual license (check `LICENSE`/manifest, don't assume MIT).
- Badges must reflect reality (CI that exists, the real package name/version). See `references/doc-style-guide.md`.

### Step 4 — Update related files

Bring the supporting docs in line with what the README now promises. Use
`references/related-files.md` for what each file is for, its standard format, and a compact
skeleton: `CONTRIBUTING`, `CHANGELOG` (Keep a Changelog + SemVer), `LICENSE`, `SECURITY`,
`CODE_OF_CONDUCT`, `docs/`, and agent-guidance files (`AGENTS.md`/`CLAUDE.md`). Only create
or edit the ones in scope, and make sure README links to them resolve.

### Step 5 — Verify (feedback loop)

Do not finish until all of these pass; fix and re-check:

```
- [ ] Every statement traces to the repo (no invented features/commands/numbers)
- [ ] Every command, script, and file path referenced actually exists (cross-check audit output)
- [ ] No broken links; relative links resolve from the file's location
- [ ] Table of Contents matches the actual headings (if present)
- [ ] Terminology and naming are consistent throughout
- [ ] Language and voice match the rest of the repo
- [ ] Required sections for this project type are present; inapplicable ones are absent
- [ ] Code blocks are fenced with a language and are runnable as written
```

Finish by telling the user **what changed** and listing any gaps you could not fill from the
repo (so they can supply the missing facts rather than you inventing them).

## Anti-patterns to avoid

- **Fabrication.** No features, benchmarks, badges, install steps, or roadmap items the repo
  doesn't support. This is the cardinal sin for this skill.
- **Time-sensitive phrasing.** Avoid "as of June 2026" / "currently in beta" unless dated by
  the repo. State the present and move legacy notes into a collapsed `<details>` section.
- **Wholesale overwrite.** Don't discard a carefully written README to paste a template.
- **Language/voice switching.** Don't translate or re-tone unless asked.
- **Empty ritual sections.** Don't add an "API" section to an app that exposes none, or a
  "Tests" section when there are no tests.

## Reference files

- `references/readme-structure.md` — canonical ordered section list (standard-readme + large-project conventions): required/optional, what each contains.
- `references/doc-style-guide.md` — prose tone, badges (shields.io), headings, code blocks, links, tables, consistency rules.
- `references/related-files.md` — CONTRIBUTING / CHANGELOG / LICENSE / SECURITY / docs / AGENTS-CLAUDE playbook, with compact skeletons.
- `assets/README.template.md` — fill-in README skeleton with all standard sections and inline guidance.
- `scripts/audit-repo.sh` — read-only repository inventory; run it in Step 1.
