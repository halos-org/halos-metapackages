# HaLOS Metapackages - Agentic Coding Guide

**LAST MODIFIED**: 2026-01-29

## 🎯 For Agentic Coding: Use the HaLOS Workspace

**IMPORTANT**: Work from the halos-distro workspace for full context.

## About This Project

Debian metapackages for the HaLOS system. Contains two packages:
- `halos` - Base system (Cockpit + tools)
- `halos-marine` - Marine variant (depends on halos + marine packages)

## Quick Start

```bash
# Build packages
./run build-all

# Lint
./run lint
```

## Structure

```
halos-metapackages/
├── VERSION                 # Upstream version
├── halos/debian/          # halos metapackage
├── halos-marine/debian/   # halos-marine metapackage
├── docker/                # Build environment
├── .github/               # CI/CD workflows
└── docs/                  # Documentation
```

## Git Workflow

**MANDATORY**: PRs must have all checks passing before merging.

**Branch Workflow**: Never push to main - use feature branches and PRs.

See `halos-distro/docs/DEVELOPMENT_WORKFLOW.md` for detailed workflows.

## Version Management

Version bumping uses `bump2version` (consistent with other HaLOS repos).
`debian/changelog` files are tracked in git. CI overwrites them during release builds with the correct revision.

### Bumping Versions

```bash
# Bump patch version (0.2.4 -> 0.2.5)
./run bumpversion patch

# Bump minor version (0.2.4 -> 0.3.0)
./run bumpversion minor

# Bump major version (0.2.4 -> 1.0.0)
./run bumpversion major

# Push the automatically created commit
git push
```

Requires `bump2version` installed (`pip install bump2version`).

**CI Enforcement**: PRs that change package-affecting files must include a VERSION bump or CI will fail. Changes to docs, tests, CI config, and dev tooling are automatically excluded.
