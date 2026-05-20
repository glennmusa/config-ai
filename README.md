# ~/.config/ai

Centralized AI configuration for all agentic tooling.
One directory, portable across tools.

## The problem

Every AI tool wants its own config in its own location.
You end up teaching each one who you are from scratch,
configuring the same MCP servers three times, and maintaining
parallel instruction files that inevitably drift.

## The fix

Put everything in `~/.config/ai/` and symlink it to where
each tool expects its config. Edit once, every tool picks it up.

## Structure

```
~/.config/ai/
├── AGENTS.md             # Entry point — tells agents what to read
├── instructions.md       # Thin pointer to AGENTS.md (auto-loaded by some tools)
├── mcp.json              # MCP server definitions (dual-key for cross-tool compat)
├── knowledge/            # Portable context — who you are, how you write, how you work
│   ├── me.md             # Identity, role, expertise
│   ├── voice.md          # Writing style and tone
│   ├── preferences.md    # Workflow and tool preferences
│   ├── people/           # Team and collaborator context
│   │   └── team.md       # Immediate team and key relationships
│   ├── projects/         # Active project notes
│   └── reference/        # Technical conventions and patterns
├── agents/               # Custom agent definitions
├── skills/               # Reusable multi-step procedures
├── prompts/              # One-liner prompt templates
│   └── bootstrap.md      # Paste-in for tools without instruction file support
├── setup.ps1             # Creates symlinks (run once, as Administrator)
└── README.md             # This file
```

## Quick start

```powershell
git clone https://github.com/youruser/config-ai ~/.config/ai
cd ~/.config/ai

# Edit the knowledge files to match you
code knowledge/me.md knowledge/voice.md knowledge/preferences.md

# Create the symlinks (requires Administrator)
.\setup.ps1
```

## How mcp.json works

The file has two root keys with identical server definitions:
- `"servers"` — read by VS Code Copilot
- `"mcpServers"` — read by Claude Desktop, Cursor, and other MCP clients

Each tool reads the key it understands and ignores the other.
Edit once, every tool picks it up.

## Symlinks

Each tool expects its config at a hardcoded path.
Symlinks redirect them to this canonical directory:

| Tool | Expected path | Symlinked to |
|------|---------------|--------------|
| VS Code | `%APPDATA%\Code\User\mcp.json` | `~/.config/ai/mcp.json` |
| Claude Desktop | `%APPDATA%\Claude\claude_desktop_config.json` | `~/.config/ai/mcp.json` |
| VS Code Copilot | `.github/copilot-instructions.md` | `~/.config/ai/instructions.md` |
| Claude projects | `CLAUDE.md` | `~/.config/ai/instructions.md` |
| Cursor | `.cursorrules` | `~/.config/ai/instructions.md` |

## Enforcement

Tools that support instruction files get enforcement automatically
via symlinks. For everything else, paste the bootstrap prompt:

```
You have access to my knowledge base at ~/.config/ai/. Start by reading AGENTS.md, then the files it references. Use this context for all responses.
```

See `prompts/bootstrap.md` for the full version.

## Concepts

### Knowledge vs. skills vs. prompts

| Type | What it is | Example |
|------|-----------|---------|
| **Knowledge** | Facts about you that don't change often | `me.md`, `voice.md` |
| **Skill** | A multi-step procedure an agent can follow | `skills/onboarding.md` |
| **Prompt** | A one-liner that kicks off a workflow | `prompts/bootstrap.md` |

A prompt is a sentence. A skill is a prompt that grew up.

### The maturity model (suggested)

Most AI workflows follow a natural progression:

```
prompt → skill → agent
```

1. **Prompt** — a one-liner you paste when you need something done
2. **Skill** — a reusable procedure with steps, inputs, and expected outputs
3. **Agent** — a skill with enough context to run autonomously

Not everything needs to be an agent. Most useful things are skills.
