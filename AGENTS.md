# HaLOS Metapackages - Agentic Coding Guide

**LAST MODIFIED**: 2026-01-02

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

**CRITICAL: Never edit debian/changelog files directly.**

Changelogs must be updated using `./run bumpversion` which uses the `dch` tool
to ensure proper RFC 2822 date formatting. Direct edits cause weekday/date
mismatches that break Debian tools.

### Bumping Versions

```bash
# Bump patch version (0.2.4 -> 0.2.5)
./run bumpversion patch

# Bump minor version (0.2.4 -> 0.3.0)
./run bumpversion minor "Add new feature"

# Bump major version (0.2.4 -> 1.0.0)
./run bumpversion major "Breaking changes"

# Push the automatically created commit
git push
```

The command:
1. Updates the VERSION file
2. Updates both halos/debian/changelog and halos-marine/debian/changelog using dch
3. Commits all changes

### Pre-commit Hooks

Install hooks after cloning:
```bash
./run install-hooks
```

The hooks prevent direct changelog edits. If you need to bypass (e.g., fixing an existing error):
```bash
SKIP_CHANGELOG_CHECK=1 git commit ...
```
