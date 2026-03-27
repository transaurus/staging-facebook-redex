#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for facebook/redex
# Runs on existing source tree (no clone). Installs deps and builds.
# Expected to run from the docusaurus root (website/) of the checked-out repo.

echo "[INFO] Node version: $(node -v)"
echo "[INFO] Yarn version: $(yarn --version)"

# --- Install dependencies ---
echo "[INFO] Installing dependencies..."
yarn install --frozen-lockfile

# --- Build ---
echo "[INFO] Running build..."
yarn build

echo "[INFO] Verifying build output..."
if [ -d "build" ] && [ "$(ls -A build)" ]; then
    FILE_COUNT=$(find build -type f | wc -l)
    echo "[SUCCESS] Build completed! $FILE_COUNT files in build/"
else
    echo "[ERROR] Build directory missing or empty"
    exit 1
fi

echo "[DONE] Build complete."
