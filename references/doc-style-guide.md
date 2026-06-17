# Documentation style guide

How the prose, formatting, and visuals should look. Apply these on top of the section
structure in `readme-structure.md`. When the target repo already has a consistent style,
**match it** — these are defaults, not overrides.

## Voice & prose

- **Second person, active, present tense.** "Run `make build`", not "The user should run…".
- **Lead with the answer.** Put the most useful sentence first; details after.
- **Show, don't tell.** A runnable code block beats a paragraph describing it.
- **No marketing.** Drop "blazing-fast", "simply", "just", "easy". State what it does and let
  it stand.
- **One term per concept.** Pick "command" or "subcommand", "option" or "flag" — and use it
  everywhere. Inconsistent vocabulary is the most common doc smell.
- **Match the repo's language.** Chinese repo → write Chinese. Keep code, flags, and proper
  nouns in their original form.

## Headings

- One `#` H1 (the title). Sections are `##`; subsections `###`. Don't skip levels.
- Sentence case, short, noun phrases ("Quick start", not "How To Get Started Quickly").
- Keep heading text stable — anchors (and the TOC) depend on it.

## Code blocks

- Always fence with a language: ```` ```bash ````, ```` ```python ````, ```` ```json ````.
- Commands must be copy-pasteable and runnable **as written**. Show a prompt only when
  distinguishing input from output, and don't include the `$` if it would be copied.
- Show expected output when it helps, in its own block or after a `# →` comment.
- Use placeholders in angle brackets for values the reader supplies: `<your-api-key>`.

## Links

- Prefer **relative links** for in-repo targets (`./CONTRIBUTING.md`, `docs/deploy.md`) so
  they work on forks and mirrors. Absolute URLs for external resources.
- Every link must resolve. Verify relative links from the location of the file they live in.
- Use descriptive link text, never "click here".

## Tables

- Use tables for structured key/value data: config vars, CLI flags, env, compatibility.
- Keep a header row and align with pipes. Example for configuration:

  | Variable | Default | Required | Description |
  |----------|---------|----------|-------------|
  | `PORT`   | `3000`  | no       | HTTP listen port |

## Badges (shields.io)

Markdown form: `[![alt](https://img.shields.io/...)](link-target)`. Common badges:

```markdown
[![CI](https://img.shields.io/github/actions/workflow/status/OWNER/REPO/ci.yml)](https://github.com/OWNER/REPO/actions)
[![npm](https://img.shields.io/npm/v/PACKAGE)](https://www.npmjs.com/package/PACKAGE)
[![PyPI](https://img.shields.io/pypi/v/PACKAGE)](https://pypi.org/project/PACKAGE/)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![Coverage](https://img.shields.io/codecov/c/github/OWNER/REPO)](https://codecov.io/gh/OWNER/REPO)
```

Rules: only show a badge that reflects reality (don't show CI status with no CI, or a
published-version badge for an unpublished package). Keep them to one tidy line. Replace
`OWNER/REPO/PACKAGE` with real values from the audit.

## Length & density

- Favor scannability: short paragraphs, bullet lists, tables, clear headings.
- The README is a front door, not a manual. Push deep material into `docs/` and link to it.
- If a section grows past a screen, that content probably belongs in a linked file.

## Collapsible details

For legacy notes, long output, or rarely needed detail, use `<details>` so it doesn't clutter:

```markdown
<details>
<summary>Legacy v1 setup (deprecated)</summary>

…older instructions here…
</details>
```

## Accessibility & rendering

- Always give images alt text. Don't encode meaning in color alone.
- Verify the README renders on the host (GitHub/GitLab): tables, task lists, and Mermaid (if
  used) behave differently across renderers.
