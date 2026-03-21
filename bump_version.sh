#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./bump_version.sh <version>"
  echo "Example: ./bump_version.sh 0.1.0"
  exit 1
fi

VERSION="$1"

# manifest.json
sed -i '' "s/\"version\": \".*\"/\"version\": \"$VERSION\"/" manifest.json

# pyproject.toml
sed -i '' "s/^version = \".*\"/version = \"$VERSION\"/" pyproject.toml

# .claude-plugin/plugin.json
sed -i '' "s/\"version\": \".*\"/\"version\": \"$VERSION\"/" .claude-plugin/plugin.json

echo "Updated to $VERSION"
git diff --stat

git add manifest.json pyproject.toml .claude-plugin/plugin.json
git commit -m "バージョンを $VERSION に更新"
git tag "v$VERSION"
git push && git push origin "v$VERSION"

echo "Done: v$VERSION released"
