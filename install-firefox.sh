#!/usr/bin/env bash
set -euo pipefail

EXT_ID="{278b0ae0-da9d-4cc6-be81-5aa7f3202672}"
SRC_DIR="$(cd "$(dirname "$0")/v3" && pwd)"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <profile-path>"
  echo ""
  echo "Example:"
  echo "  $0 '/Users/josh/Library/Application Support/Waterfox/Profiles/lo455frq.68-edition-default'"
  exit 1
fi

PROFILE="$1"

if [ ! -d "$PROFILE" ]; then
  echo "Error: profile directory not found: $PROFILE"
  exit 1
fi

EXT_DIR="$PROFILE/extensions"
mkdir -p "$EXT_DIR"

XPI="$EXT_DIR/$EXT_ID.xpi"

# Build XPI (zip archive of v3/ contents)
(cd "$SRC_DIR" && zip -r -q -FS "$XPI" .)

echo "Installed: $XPI"
echo "Restart the browser to load the extension."
