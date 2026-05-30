#!/bin/bash

set -e

echo "==> Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "==> Installing Codex..."
curl -fsSL https://chatgpt.com/codex/install.sh | sh

echo "==> Installing OpenCode..."
curl -fsSL https://opencode.ai/install | bash

echo "==> All external tools installed."
