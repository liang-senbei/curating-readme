#!/usr/bin/env bash
# audit-repo.sh — read-only repository inventory for the curating-readme skill.
# Surfaces the facts a README/doc update must be grounded in. Makes NO changes.
#
# Usage:  bash audit-repo.sh [path-to-repo]   # defaults to current directory
#
# Output is grouped into labeled sections. Treat it as ground truth: every claim
# in the docs you write should be traceable to something here (or to a file it points at).

set -uo pipefail
ROOT="${1:-.}"
cd "$ROOT" 2>/dev/null || { echo "audit-repo: cannot enter '$ROOT'"; exit 1; }
ROOT="$(pwd)"

# Directories we never want to descend into.
PRUNE='-name node_modules -o -name .git -o -name dist -o -name build -o -name vendor -o -name target -o -name .venv -o -name __pycache__ -o -name .next'
have() { command -v "$1" >/dev/null 2>&1; }
sec()  { printf '\n=== %s ===\n' "$1"; }

echo "REPOSITORY AUDIT"
echo "root: $ROOT"
date +"generated: %Y-%m-%dT%H:%M:%S%z" 2>/dev/null

# ---------------------------------------------------------------------------
sec "PROJECT TYPE & MANIFEST"
manifest=""
for f in package.json pyproject.toml setup.py setup.cfg requirements.txt go.mod Cargo.toml \
         composer.json pom.xml build.gradle build.gradle.kts Gemfile pubspec.yaml deno.json; do
  [ -f "$f" ] && { echo "found manifest: $f"; manifest="$f"; }
done
[ -z "$manifest" ] && echo "(no recognized manifest — may be a docs/content/script repo)"

if [ -f package.json ] && have python3; then
  python3 - <<'PY' 2>/dev/null
import json
d=json.load(open("package.json"))
for k in ("name","version","description","license","type","main","module","bin"):
    if k in d: print(f"  {k}: {d[k]}")
if d.get("scripts"): print("  scripts:", ", ".join(d["scripts"].keys()))
deps=list((d.get("dependencies") or {}).keys())
if deps: print(f"  dependencies ({len(deps)}):", ", ".join(deps[:15]) + (" …" if len(deps)>15 else ""))
PY
fi
[ -f pyproject.toml ] && { echo "  -- pyproject.toml (name/version/description) --"; grep -E '^\s*(name|version|description)\s*=' pyproject.toml 2>/dev/null | head -5; }
[ -f go.mod ]        && { echo "  -- go.mod (module/go) --"; grep -E '^(module|go) ' go.mod 2>/dev/null | head -3; }
[ -f Cargo.toml ]    && { echo "  -- Cargo.toml (name/version) --"; grep -E '^\s*(name|version|description)\s*=' Cargo.toml 2>/dev/null | head -5; }

# ---------------------------------------------------------------------------
sec "ENTRYPOINTS & RUNNABLE SCRIPTS"
[ -d bin ]     && { echo "bin/:";     ls -1 bin 2>/dev/null | sed 's/^/  /' | head -20; }
[ -d scripts ] && { echo "scripts/:"; ls -1 scripts 2>/dev/null | sed 's/^/  /' | head -30; }
[ -d cmd ]     && { echo "cmd/:";     ls -1 cmd 2>/dev/null | sed 's/^/  /' | head -20; }
if [ -f Makefile ]; then
  echo "Makefile targets:"
  grep -E '^[a-zA-Z0-9_.-]+:' Makefile 2>/dev/null | sed 's/:.*//' | sort -u | sed 's/^/  /' | head -30
fi
# Likely top-level entry files
ls -1 main.* index.* app.* server.* cli.* 2>/dev/null | sed 's/^/  entry: /'

# ---------------------------------------------------------------------------
sec "EXISTING DOCUMENTATION"
for f in README* readme* CONTRIBUTING* CHANGELOG* HISTORY* LICENSE* COPYING* \
         SECURITY* CODE_OF_CONDUCT* AUTHORS* MAINTAINERS* AGENTS.md CLAUDE.md \
         CODEOWNERS .github/CODEOWNERS; do
  [ -e "$f" ] && printf '  %-22s %s lines\n' "$f" "$(wc -l < "$f" 2>/dev/null | tr -d ' ')"
done
[ -d docs ] && { echo "  docs/ tree:"; find docs -maxdepth 2 -type f 2>/dev/null | sort | sed 's/^/    /' | head -40; }
mdcount=$(find . \( $PRUNE \) -prune -o -name '*.md' -type f -print 2>/dev/null | wc -l | tr -d ' ')
echo "  total markdown files (excluding vendored): $mdcount"

# ---------------------------------------------------------------------------
sec "PROJECT STRUCTURE (top level)"
ls -1Ap 2>/dev/null | grep -vE '^(\.git/|node_modules/)$' | sed 's/^/  /' | head -50
echo "  -- shallow tree (depth 2, pruned) --"
find . -maxdepth 2 \( $PRUNE \) -prune -o -type d -print 2>/dev/null \
  | grep -vE '^\.$' | sort | sed 's|^\./||; s/^/    /' | head -40

# ---------------------------------------------------------------------------
sec "CONFIGURATION & ENVIRONMENT"
for f in .env.example .env.sample .env.template config.example.* sample.env; do
  if [ -f "$f" ]; then
    echo "  $f — declared keys:"
    grep -E '^[A-Za-z_][A-Za-z0-9_]*=' "$f" 2>/dev/null | sed 's/=.*//' | sort -u | sed 's/^/    /'
  fi
done
echo "  env vars referenced in first-party code (sampled, names only):"
grep -rohE '(process\.env\.[A-Z0-9_]+|os\.environ\[["'\''][A-Z0-9_]+|os\.getenv\(["'\''][A-Z0-9_]+|getenv\(["'\''][A-Z0-9_]+)' . \
  --include='*.js' --include='*.ts' --include='*.py' --include='*.go' --include='*.rb' --include='*.sh' \
  --exclude-dir={node_modules,.git,dist,build,vendor,target,.venv,__pycache__,.next} 2>/dev/null \
  | grep -oE '[A-Z][A-Z0-9_]{2,}' | sort | uniq -c | sort -rn | head -25 | sed 's/^/    /'

# ---------------------------------------------------------------------------
sec "GIT METADATA"
if have git && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "  remote:        $(git remote get-url origin 2>/dev/null || echo '(none)')"
  echo "  branch:        $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  echo "  commits:       $(git rev-list --count HEAD 2>/dev/null)"
  echo "  contributors:  $(git shortlog -sne HEAD 2>/dev/null | wc -l | tr -d ' ')"
  echo "  first commit:  $(git log --reverse --format=%as 2>/dev/null | head -1)"
  echo "  last commit:   $(git log -1 --format='%as  %s' 2>/dev/null)"
  tags=$(git tag --sort=-creatordate 2>/dev/null | head -5 | tr '\n' ' ')
  echo "  recent tags:   ${tags:-(none)}"
  echo "  top authors:"
  git shortlog -sn HEAD 2>/dev/null | head -5 | sed 's/^/    /'
else
  echo "  (not a git repository)"
fi

# ---------------------------------------------------------------------------
sec "LANGUAGE BREAKDOWN (by tracked file extension)"
if have git && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git ls-files 2>/dev/null | grep -oE '\.[A-Za-z0-9]+$' | sort | uniq -c | sort -rn | head -12 | sed 's/^/  /'
else
  find . \( $PRUNE \) -prune -o -type f -name '*.*' -print 2>/dev/null \
    | grep -oE '\.[A-Za-z0-9]+$' | sort | uniq -c | sort -rn | head -12 | sed 's/^/  /'
fi

# ---------------------------------------------------------------------------
sec "CI / TOOLING HINTS"
for f in .github/workflows .gitlab-ci.yml .circleci azure-pipelines.yml Jenkinsfile \
         Dockerfile docker-compose.yml docker-compose.yaml .pre-commit-config.yaml \
         .eslintrc* .prettierrc* tsconfig.json pytest.ini tox.ini .editorconfig; do
  if [ -e "$f" ]; then
    if [ -d "$f" ]; then echo "  $f/: $(ls -1 "$f" 2>/dev/null | tr '\n' ' ')"; else echo "  $f"; fi
  fi
done

# ---------------------------------------------------------------------------
sec "DONE"
echo "Use this inventory as ground truth. If a fact you want to document is not here,"
echo "open the file it points to and verify — do not guess. Report gaps to the user."
