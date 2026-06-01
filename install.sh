#!/usr/bin/env bash
# sshk — one-line installer
set -euo pipefail
echo "Installing sshk..."
mkdir -p "$HOME/.local/bin"
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/sshk -o "$HOME/.local/bin/sshk"
chmod +x "$HOME/.local/bin/sshk"
echo ""
echo "✅ sshk installed."
echo "   Run 'sshk help' to get started."
