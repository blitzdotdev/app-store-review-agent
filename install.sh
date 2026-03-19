#!/bin/bash
# Install the App Store Review Agent for Claude Code
# Usage: curl -fsSL https://raw.githubusercontent.com/blitzdotdev/app-store-review-agent/main/install.sh | bash

set -e

REPO="https://github.com/blitzdotdev/app-store-review-agent.git"
INSTALL_DIR=".claude/app-store-review-agent"
AGENTS_DIR=".claude/agents"

# Clone or update
if [ -d "$INSTALL_DIR" ]; then
  echo "Updating app-store-review-agent..."
  git -C "$INSTALL_DIR" pull --quiet
else
  echo "Installing app-store-review-agent..."
  git clone --quiet "$REPO" "$INSTALL_DIR"
fi

# Symlink agent into .claude/agents/ where Claude Code can find it
mkdir -p "$AGENTS_DIR"
ln -sf "../app-store-review-agent/agents/reviewer.md" "$AGENTS_DIR/reviewer.md"

echo ""
echo "Reviewer agent installed. Restart Claude Code, then say:"
echo ""
echo "  review my app"
echo ""
