# ~/.config/ai

Centralized AI configuration for all agentic tooling.
One directory, portable across tools.

## The problem

Every AI tool wants its own config in its own location.
You end up teaching each one who you are from scratch,
configuring the same MCP servers in every tool, and maintaining
parallel instruction files that inevitably drift.

## The fix

Put everything in `~/.config/ai/` and symlink it to where
each tool expects its config. Edit once, every tool picks it up.

## Quick start

```powershell
git clone https://github.com/glennmusa/config-ai ~/.config/ai
cd ~/.config/ai

# Create the symlinks (requires Administrator)
.\setup.ps1
```

Then paste this into any AI tool with file access:

```
Set up my ~/.config/ai/ knowledge base. Follow the skill in skills/onboarding.md.
```

The tool will walk you through filling out each knowledge file
step by step — who you are, how you write, how you work, your team,
and your MCP servers. Takes about five minutes.

## How it works

```
                              ┌─────────────────────┐
                              │   ~/.config/ai/     │
                              │                     │
                              │  mcp.json           │
                              │  instructions.md    │
                              │  AGENTS.md          │
                              │  knowledge/         │
                              │    me.md            │
                              │    voice.md         │
                              │    preferences.md   │
                              │    people/team.md   │
                              │  skills/            │
                              │  prompts/           │
                              │  agents/            │
                              └────────┬────────────┘
                                       │
                          symlinks fan out to each tool
                                       │
              ┌────────────────────────┼────────────────────────┐
              │                        │                        │
     ┌────────▼──────────┐    ┌────────▼──────────┐    ┌────────▼─────────┐
     │    VS Code        │    │  Claude Desktop   │    │     Cursor       │
     │                   │    │                   │    │                  │
     │  mcp.json ←───────│────│── mcp.json ←──────│────│── (manual)       │
     │  copilot-         │    │  claude_desktop_  │    │  .cursorrules ←──│
     │  instructions.md ←│    │  config.json ←────│    │                  │
     └───────────────────┘    └───────────────────┘    └──────────────────┘
```

`mcp.json` has two root keys with identical server definitions:
- `"servers"` — read by VS Code Copilot
- `"mcpServers"` — read by Claude Desktop, Cursor, and other MCP clients

Each tool reads the key it understands and ignores the other.

Symlinks redirect each tool's hardcoded config path to the canonical files:

| Tool | Expected path | Symlinked to |
|------|---------------|--------------|
| VS Code | `%APPDATA%\Code\User\mcp.json` | `~/.config/ai/mcp.json` |
| Claude Desktop | `%APPDATA%\Claude\claude_desktop_config.json` | `~/.config/ai/mcp.json` |
| VS Code Copilot | `.github/copilot-instructions.md` | `~/.config/ai/instructions.md` |
| Claude | `CLAUDE.md` | `~/.config/ai/instructions.md` |
| Cursor | `.cursorrules` | `~/.config/ai/instructions.md` |

## Enforcement

Tools that support instruction files get enforcement automatically
via symlinks. For everything else, paste the bootstrap prompt:

```
You have access to my knowledge base at ~/.config/ai/. Start by reading AGENTS.md, then the files it references. Use this context for all responses.
```

See `prompts/bootstrap.md` for the full version.

## Concepts

This is what works for us — not a hard and fast rule. Use what's useful, ignore what isn't.

### The maturity model (suggested)

Most AI workflows follow a natural progression:

```
knowledge → prompt → skill → agent
```

1. **Knowledge** — facts about you that don't change often
2. **Prompt** — a one-liner you paste when you need something done
3. **Skill** — a reusable procedure with steps, inputs, and expected outputs
4. **Agent** — a skill with enough context to run autonomously

Not everything needs to be an agent. Most useful things are skills.

A prompt is a sentence. A skill is a prompt that grew up. An agent is a skill that can think for itself.

| Type | What it is | Example |
|------|-----------|---------|
| **Knowledge** | Facts about you that don't change often | `me.md`, `voice.md` |
| **Prompt** | A one-liner that kicks off a workflow | `prompts/bootstrap.md` |
| **Skill** | A multi-step procedure an agent can follow | `skills/onboarding.md` |
| **Agent** | A skill with enough context to run autonomously | `agents/onboarding.md` |
