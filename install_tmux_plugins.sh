#!/bin/bash

# Must run AFTER setup.sh: TPM reads the stowed tmux.conf to learn which
# plugins to install.

set -e

TMUX_DIR="${HOME}/.config/tmux"
TPM_DIR="${TMUX_DIR}/plugins/tpm"

if ! command -v tmux >/dev/null 2>&1; then
	echo "==> tmux not installed, skipping plugins."
	exit 0
fi

if [ ! -f "${TMUX_DIR}/tmux.conf" ]; then
	echo "==> ${TMUX_DIR}/tmux.conf not found, run setup.sh first. Skipping plugins."
	exit 0
fi

if [ -f "${TPM_DIR}/tpm" ]; then
	echo "==> TPM already installed, skipping."
else
	echo "==> Installing TPM..."
	git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
fi

# TPM treats any existing directory as an installed plugin, so an empty dir
# left by a half-finished install silently blocks the clone forever. rmdir
# only succeeds on empties, so real plugins are untouched.
for dir in "${TMUX_DIR}"/plugins/*/; do
	[ -d "$dir" ] && rmdir "$dir" 2>/dev/null || true
done

echo "==> Installing tmux plugins..."
tmux start-server
tmux source-file "${TMUX_DIR}/tmux.conf"
"${TPM_DIR}/bin/install_plugins"

echo "==> tmux plugins installed."
