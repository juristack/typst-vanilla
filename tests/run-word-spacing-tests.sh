#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

OUT="$(mktemp -d "$ROOT/.word-spacing-tests.XXXXXX")"
trap 'rm -rf "$OUT"' EXIT

for spacing in single double; do
  pdf="$OUT/word-${spacing}.pdf"

  echo "Testing ${spacing} spacing..."
  typst compile --root . "tests/word-${spacing}-spacing.typ" "$pdf"
  test -s "$pdf"
  python3 tests/check-word-spacing.py "$pdf" "$spacing"
done

echo "All Word spacing regression tests passed."
