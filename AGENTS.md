# HaLOS Metapackages - Agentic Coding Guide

**LAST MODIFIED**: 2025-11-21

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
