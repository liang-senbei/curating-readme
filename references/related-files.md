# Related documentation files — playbook

The README is the hub; these are the spokes. For each: what it's for, the standard it follows,
and a compact skeleton. Create or update only the files in scope, and keep README links to
them valid. Match the repo's existing language.

## Contents

- [CONTRIBUTING.md](#contributingmd)
- [CHANGELOG.md](#changelogmd)
- [LICENSE](#license)
- [SECURITY.md](#securitymd)
- [CODE_OF_CONDUCT.md](#code_of_conductmd)
- [docs/ directory](#docs-directory)
- [AGENTS.md / CLAUDE.md](#agentsmd--claudemd)
- [.github/ helpers](#github-helpers)

## CONTRIBUTING.md

How to contribute. Lives at repo root or `.github/`. GitHub links to it from the PR/issue UI.

Cover: how to set up a dev environment, how to run tests/lint, branch/commit conventions,
the PR process, and any DCO/CLA. Ground the build/test commands in the manifest scripts.

```markdown
# Contributing to <project>

Thanks for your interest in contributing!

## Development setup
```bash
<clone + install + how to run locally>
```

## Running tests & lint
```bash
<test command>
<lint command>
```

## Submitting changes
1. Fork and create a branch (`feat/…`, `fix/…`).
2. Make your change; add tests; keep the changelog updated.
3. Ensure tests and lint pass.
4. Open a PR describing the change and linking any issue.

## Commit messages
Follow <Conventional Commits / the project's convention>.
```

## CHANGELOG.md

A human-readable history of notable changes. Follow [Keep a Changelog](https://keepachangelog.com)
and [Semantic Versioning](https://semver.org). Newest version on top. Don't dump raw git log —
curate by impact. Group under: Added, Changed, Deprecated, Removed, Fixed, Security.

```markdown
# Changelog

All notable changes to this project are documented here.
Format follows Keep a Changelog; this project adheres to Semantic Versioning.

## [Unreleased]

## [1.2.0] - 2026-01-15
### Added
- <new capability>
### Fixed
- <bug fix>

## [1.1.0] - 2025-12-01
### Changed
- <behavior change>
```

## LICENSE

The legal terms. Use the exact text of a standard license (MIT, Apache-2.0, GPL-3.0, …) with
the copyright line filled in. Determine the intended license from the manifest, an existing
header, or by asking — **never invent or assume one**. For internal/private repos with no
open-source license, a short proprietary notice is appropriate; confirm with the user.

## SECURITY.md

Responsible-disclosure policy: how to report a vulnerability (private contact, not a public
issue), which versions are supported, and expected response time.

```markdown
# Security Policy

## Supported versions
| Version | Supported |
|---------|-----------|
| 1.x     | ✅        |

## Reporting a vulnerability
Email <security@example.com> (or open a private advisory). Do not file public issues for
security problems. We aim to respond within <N> business days.
```

## CODE_OF_CONDUCT.md

Community behavior standards. Most projects adopt the
[Contributor Covenant](https://www.contributor-covenant.org) verbatim with a contact email
filled in. Don't write a bespoke one unless asked.

## docs/ directory

Where deep content lives so the README stays a front door. Common layout:

```
docs/
├── getting-started.md
├── configuration.md
├── architecture.md
├── deployment.md
└── api/ or reference/
```

When you move detail out of the README, link to it from the matching README section. Keep one
topic per file; give each long file (>100 lines) its own table of contents.

## AGENTS.md / CLAUDE.md

Guidance for AI agents / coding assistants working in the repo: conventions, entrypoints,
gotchas, and "fuzzy phrase → command" mappings. These are *internal operating instructions*,
distinct from the user-facing README — don't merge them. When updating the README reveals new
conventions or commands, reflect them here too so humans and agents stay in sync.

## .github/ helpers

Optional but professional: `ISSUE_TEMPLATE/`, `PULL_REQUEST_TEMPLATE.md`, `CODEOWNERS`,
`FUNDING.yml`. Add only when the project wants them; keep them minimal and accurate.
