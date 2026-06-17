# README structure — canonical section reference

The standard order and rules for README sections, synthesized from the
[standard-readme spec](https://github.com/RichardLitt/standard-readme/blob/main/spec.md) and
the conventions used by large, reputable open-source projects (Kubernetes, React, Vue, Rust,
TensorFlow, etc.). Follow this order. Include a section only when it applies to the project
type (see the SKILL.md classification table). Omit sections that would be empty.

## Contents

- [Ordering at a glance](#ordering-at-a-glance)
- [1. Title](#1-title)
- [2. Banner / logo (optional)](#2-banner--logo-optional)
- [3. Badges (optional)](#3-badges-optional)
- [4. Short description (required)](#4-short-description-required)
- [5. Long description / Background (optional)](#5-long-description--background-optional)
- [6. Table of contents (required if >100 lines)](#6-table-of-contents-required-if-100-lines)
- [7. Features / Highlights (optional)](#7-features--highlights-optional)
- [8. Security (optional)](#8-security-optional)
- [9. Install (required for code)](#9-install-required-for-code)
- [10. Usage / Quick start (required for code)](#10-usage--quick-start-required-for-code)
- [11. Configuration (optional)](#11-configuration-optional)
- [12. Architecture / Project structure (optional)](#12-architecture--project-structure-optional)
- [13. API / Reference (optional)](#13-api--reference-optional)
- [14. Examples (optional)](#14-examples-optional)
- [15. Deployment (optional)](#15-deployment-optional)
- [16. Troubleshooting / FAQ (optional)](#16-troubleshooting--faq-optional)
- [17. Roadmap (optional)](#17-roadmap-optional)
- [18. Maintainers (optional)](#18-maintainers-optional)
- [19. Contributing (required)](#19-contributing-required)
- [20. Acknowledgements / Thanks (optional)](#20-acknowledgements--thanks-optional)
- [21. License (required, last)](#21-license-required-last)

## Ordering at a glance

```
Title → Banner → Badges → Short description → Background →
TOC → Features → Security → Install → Usage → Configuration →
Architecture → API → Examples → Deployment → Troubleshooting →
Roadmap → Maintainers → Contributing → Acknowledgements → License
```

The five **required** sections for a typical code project: Title, Short description, Install,
Usage, Contributing, License. Everything else is added when it earns its place.

---

## 1. Title

- An `# H1` at the top. Match the repository / package-manager name (e.g. the npm or PyPI
  name). If you use a friendlier display title, put the canonical name next to it in italics
  and parentheses: `# Rocket *(rocket-cli)*`.
- Exactly one H1 in the whole README.

## 2. Banner / logo (optional)

- A project logo or hero image, immediately after the title, no heading of its own.
- Link a **local** image committed to the repo (`docs/assets/…`), not a hotlinked URL.
- Provide alt text. Keep it from dominating the fold.

## 3. Badges (optional)

- Status signals directly under the title/banner, no heading, newline-delimited.
- Only badges that reflect **reality**: CI/build status (if CI exists), package version,
  test coverage, license, language/runtime version, chat/community link.
- Generate via [shields.io](https://shields.io). Never show a green "build passing" badge for
  a project with no CI. See `doc-style-guide.md` for badge syntax.

## 4. Short description (required)

- One line, immediately after badges, **no heading**, **under ~120 characters**.
- Must not start with `> `. Should match the GitHub repo description and the manifest
  `description` field so all three agree.
- Answer "what is this and who is it for" in a single sentence.

## 5. Long description / Background (optional)

- A short paragraph or two expanding on the short description: the problem it solves,
  motivation, and key context. May carry a `## Background` heading.
- Note here if the repo / folder / package names differ. Cover intellectual provenance or
  prior art if relevant. Keep it tight — link out to a blog/design doc for the long version.

## 6. Table of contents (required if >100 lines)

- A `## Table of Contents` listing every `##` (and ideally `###`) section, each linking to
  its anchor. Start the TOC with the section *after* it.
- Mandatory once the README exceeds ~100 lines; optional but nice below that.
- Keep it in sync with the actual headings (verify in Step 5).

## 7. Features / Highlights (optional)

- A scannable bullet list of what the project does well — the first thing many readers look
  for. Common in large-project READMEs.
- Each bullet = a concrete capability, not marketing. Ground each in real functionality.

## 8. Security (optional)

- Place near the top only if security is a primary concern of the project (crypto, auth,
  handling secrets/PII). Otherwise link to `SECURITY.md` from lower down.
- Cover responsible-disclosure contact and any critical usage caveats.

## 9. Install (required for code)

- A fenced code block with the exact install/setup steps, copy-pasteable.
- Cover prerequisites (runtime/version, system deps) in a **Prerequisites** or
  **Dependencies** subsection. Show the package-manager command for libraries
  (`npm i x`, `pip install x`, `go get x`), or the clone+bootstrap flow for apps.
- Verify the commands against the manifest and scripts in the audit output.

## 10. Usage / Quick start (required for code)

- The shortest path to a working result: a minimal, runnable example with expected output.
- For CLIs: the primary commands and their key flags. For libraries: the canonical code
  snippet. For services: how to start it and hit it.
- Prefer one clear default over enumerating every option (link to deeper docs for the rest).

## 11. Configuration (optional)

- Environment variables, config files, and flags — ideally as a table:
  `name | default | required? | description`.
- Source this from `.env.example` and the config references the audit found. Don't leak real
  secrets; show placeholders.

## 12. Architecture / Project structure (optional)

- A high-level diagram or a tree of the top-level directories with one-line descriptions.
- Valuable for apps, services, and monorepos. Generate the tree from the audit's structure
  output. Explain the *why* of the layout, not just the *what*.

## 13. API / Reference (optional)

- For libraries/SDKs: exported functions, types, and objects with signatures and short
  descriptions. For services: endpoints, methods, and payloads.
- If large, keep a summary here and link to a generated `API.md` or hosted docs.

## 14. Examples (optional)

- Realistic, end-to-end usage beyond the quick start — recipes for common tasks. Link to an
  `examples/` directory if one exists.

## 15. Deployment (optional)

- For apps/services: how to build for production and deploy (Docker, systemd, cloud, CI/CD).
- Ground every step in real scripts/Dockerfiles/workflows the audit surfaced.

## 16. Troubleshooting / FAQ (optional)

- Common errors and fixes; frequently asked questions. Only include issues that genuinely
  recur — don't pad.

## 17. Roadmap (optional)

- Planned direction as a short list or link to issues/milestones/a project board. Mark it as
  aspirational; never present plans as shipped features.

## 18. Maintainers (optional)

- Who maintains the project and how to reach them (handles/links). Pull from git history /
  CODEOWNERS if not already documented.

## 19. Contributing (required)

- State where to ask questions, whether PRs are accepted, and the contribution requirements
  (style, tests, DCO/CLA). Link to `CONTRIBUTING.md` for the full process and keep the README
  section to a short pointer.
- Optionally credit contributors or link to a contributors graph.

## 20. Acknowledgements / Thanks (optional)

- Credit inspirations, funders, and key dependencies. May be titled "Thanks", "Credits", or
  "Acknowledgements".

## 21. License (required, last)

- The **last** section. Name the license using its [SPDX identifier](https://spdx.org/licenses/)
  (e.g. `MIT`, `Apache-2.0`), name the copyright holder, and link to the `LICENSE` file.
- Confirm the actual license from the `LICENSE` file or manifest — **never assume MIT**. If
  there is no license file and the repo is private/internal, say so (e.g. "Proprietary —
  internal use only") rather than inventing one.
