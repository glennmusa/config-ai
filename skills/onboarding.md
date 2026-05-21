# Onboarding

A guided setup for your `~/.config/ai/` knowledge base.
Any AI tool can follow this skill.

## Prerequisites

- This repo cloned to `~/.config/ai/`
- An AI tool with file read/write access (VS Code Copilot, Cursor, Claude, etc.)

## Instructions

Walk me through setting up my knowledge base. Follow these steps in order,
showing me a draft of each file and waiting for approval before moving on.

### Step 1: me.md

Ask me:
- What's your name and role?
- What team or company do you work at?
- What do you work on day-to-day?
- What are your key technical skills?

Write the answers to `knowledge/me.md` using the existing template as a guide.
Show me the draft. Wait for approval before continuing.

### Step 2: voice.md

Ask me:
- How would you describe your writing style in a few words?
- Any phrases or patterns you always avoid?
- Do you write differently for docs vs. chat vs. email?

If I have trouble describing it, ask me to paste a sample of writing I'm proud of
and infer the style from that. Update `knowledge/voice.md` with the results.
Show me the draft. Wait for approval.

### Step 3: preferences.md

Ask me:
- What do you expect from AI tools? (e.g. confirm before changes, be concise, have opinions)
- Any hard rules? (e.g. never commit without asking, always check for repo guidelines first)

Update `knowledge/preferences.md`. Show draft. Wait for approval.

### Step 4: team.md

Ask me:
- Who's on your immediate team? (names, roles)
- Who do you collaborate with outside your team?
- Any regular meetings worth noting?

Update `knowledge/people/team.md`. Show draft. Wait for approval.

### Step 5: MCP servers

Scan the host for existing MCP configurations. Check these paths (skip any that don't exist):

| Tool            | Windows                                          | Linux / macOS                          |
|-----------------|--------------------------------------------------|----------------------------------------|
| VS Code         | `%APPDATA%\Code\User\mcp.json`                  | `~/.config/Code/User/mcp.json`         |
| Claude Desktop  | `%APPDATA%\Claude\claude_desktop_config.json`    | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Claude Code     | `~/.claude/settings.json`                        | `~/.claude/settings.json`              |
| Cursor          | `~/.cursor/mcp.json`                             | `~/.cursor/mcp.json`                   |

For each file found, extract the MCP server entries. Deduplicate by server name
(same name + same command = one entry). Present a combined list:

> I found these MCP servers already configured on your machine:
> - **server-name** — `command args` (from VS Code)
> - ...

Ask me:
- Should I import all of these into `mcp.json`?
- Any servers to skip or add?

Update `mcp.json` with the final set in both the `"servers"` and `"mcpServers"` keys.
Show draft. Wait for approval.

### Step 6: Symlinks

Tell me to run `setup.ps1` as Administrator to create the symlinks.
Explain what it does before I run it.

### Step 7: Bootstrap

Show me the bootstrap prompt from `prompts/bootstrap.md` and explain
when to use it (for tools that don't support instruction files).

### Done

Summarize what was set up and suggest next steps:
- Add project notes to `knowledge/projects/`
- Add technical conventions to `knowledge/reference/`
- Create skills in `skills/` for repeatable workflows
- Create custom agents in `agents/` for autonomous tasks
