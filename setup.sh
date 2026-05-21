#!/usr/bin/env bash
# setup.sh — Create symlinks so every AI tool reads from ~/.config/ai/
# Run once after cloning. No special privileges needed on Linux/macOS.
set -euo pipefail

CONFIG_DIR="$HOME/.config/ai"

link() {
  local target="$1" source="$2" tool="$3"
  local parent
  parent="$(dirname "$target")"

  if [ ! -d "$parent" ]; then
    echo "  SKIP  $tool not found ($parent does not exist)"
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "  SKIP  $target (already exists — back up and remove to symlink)"
  else
    ln -s "$source" "$target"
    echo "  LINK  $target -> $source"
  fi
}

# --- MCP server config ---
link "$HOME/.config/Code/User/mcp.json"                  "$CONFIG_DIR/mcp.json"          "VS Code"
link "$HOME/.config/Claude/claude_desktop_config.json"    "$CONFIG_DIR/mcp.json"          "Claude Desktop"

# --- Instruction files (global) ---
link "$HOME/.claude/CLAUDE.md"                            "$CONFIG_DIR/instructions.md"   "Claude Code"
link "$HOME/.cursor/rules/config-ai.md"                   "$CONFIG_DIR/instructions.md"   "Cursor"

echo ""
echo "Done. Symlinks created."
echo ""
echo "For tools that don't support instruction files, paste this:"
echo ""
echo '  You have access to my knowledge base at ~/.config/ai/. Start by reading AGENTS.md, then the files it references. Use this context for all responses.'
echo ""
echo "See prompts/bootstrap.md for more."
