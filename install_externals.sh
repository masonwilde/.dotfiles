#!/bin/bash

set -e

install_if_missing() {
	local name="$1"
	local cmd="$2"
	shift 2
	if command -v "$cmd" >/dev/null 2>&1; then
		echo "==> $name already installed, skipping."
	else
		echo "==> Installing $name..."
		"$@"
	fi
}

install_if_missing "Bun" bun bash -c "curl -fsSL https://bun.com/install | bash"
install_if_missing "Claude Code" claude bash -c "curl -fsSL https://claude.ai/install.sh | bash"
install_if_missing "Codex" codex sh -c "curl -fsSL https://chatgpt.com/codex/install.sh | sh"
install_if_missing "OpenCode" opencode bash -c "curl -fsSL https://opencode.ai/install | bash"

echo "==> All external tools installed."
