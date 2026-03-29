#!/bin/bash
# Generate release notes for a release
# Usage: generate-release-notes.sh <VERSION> <TAG_VERSION> <RELEASE_TYPE>
# RELEASE_TYPE: "prerelease", "draft", or "stable"

set -e

VERSION="${1:?Version required}"
TAG_VERSION="${2:?Tag version required}"
RELEASE_TYPE="${3:?Release type required}"

if [ -z "$VERSION" ] || [ -z "$TAG_VERSION" ] || [ -z "$RELEASE_TYPE" ]; then
  echo "Usage: generate-release-notes.sh <VERSION> <TAG_VERSION> <RELEASE_TYPE>"
  exit 1
fi

SHORT_SHA="${GITHUB_SHA:0:7}"

# Get the latest published (non-prerelease) release
LAST_TAG=$(gh release list --limit 100 --json tagName,isPrerelease,isDraft \
  --jq '.[] | select(.isDraft == false and .isPrerelease == false) | .tagName' | head -n1)

if [ -n "$LAST_TAG" ]; then
  echo "Generating changelog since $LAST_TAG"
  CHANGELOG=$(git log "${LAST_TAG}"..HEAD --pretty=format:"- %s (%h)" --no-merges --)
else
  echo "No previous published releases found, using recent commits"
  CHANGELOG=$(git log -10 --pretty=format:"- %s (%h)" --no-merges)
fi

case "$RELEASE_TYPE" in
  prerelease)
    cat > release_notes.md <<EOF
## HaLOS Metapackages ${TAG_VERSION} (Pre-release)

> **This is a pre-release build from the main branch. Use for testing only.**

**Packages:** \`halos\`, \`halos-marine\`, \`halos-halpi2\`, \`halos-halpi2-marine\`, \`halos-desktop\`, \`halos-headless\`, \`halos-desktop-marine\`, \`halos-headless-marine\`

**Build Information:**
- Commit: ${SHORT_SHA} (\`${GITHUB_SHA}\`)
- Built: $(date -u '+%Y-%m-%d %H:%M:%S UTC')

### Recent Changes

${CHANGELOG}
EOF
    ;;

  draft|stable)
    cat > release_notes.md <<EOF
## HaLOS Metapackages v${VERSION}

Debian metapackages for the HaLOS (Hat Labs Operating System) distribution.

**Packages:** \`halos\`, \`halos-marine\`, \`halos-halpi2\`, \`halos-halpi2-marine\`, \`halos-desktop\`, \`halos-headless\`, \`halos-desktop-marine\`, \`halos-headless-marine\`

### Changes

${CHANGELOG}
EOF
    ;;

  *)
    echo "Error: Unknown RELEASE_TYPE '$RELEASE_TYPE'. Use 'prerelease', 'draft', or 'stable'"
    exit 1
    ;;
esac

echo "Release notes created"
