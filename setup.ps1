#Requires -RunAsAdministrator
# setup.ps1 — Create symlinks so every AI tool reads from ~/.config/ai/
# Run once after cloning. Requires Administrator for symlinks on Windows.

$configDir = "$HOME\.config\ai"

function Link-Config {
    param([string]$Target, [string]$Source, [string]$Tool)
    $parent = Split-Path $Target
    if (-not (Test-Path $parent)) {
        Write-Host "  SKIP  $Tool not found ($parent does not exist)" -ForegroundColor DarkGray
        return
    }
    if (Test-Path $Target) {
        Write-Host "  SKIP  $Target (already exists — back up and remove to symlink)" -ForegroundColor Yellow
    } else {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
        Write-Host "  LINK  $Target -> $Source" -ForegroundColor Green
    }
}

# --- MCP server config ---
Link-Config "$env:APPDATA\Code\User\mcp.json"                   "$configDir\mcp.json"          "VS Code"
Link-Config "$env:APPDATA\Claude\claude_desktop_config.json"     "$configDir\mcp.json"          "Claude Desktop"

# --- Instruction files (global) ---
Link-Config "$HOME\.claude\CLAUDE.md"                            "$configDir\instructions.md"   "Claude Code"
Link-Config "$HOME\.cursor\rules\config-ai.md"                   "$configDir\instructions.md"   "Cursor"

Write-Host ""
Write-Host "Done. Symlinks created." -ForegroundColor Cyan
Write-Host ""
Write-Host "Now prompt your AI tool to onboard you with something like:" -ForegroundColor White
Write-Host ""
Write-Host '  Set up my ~/.config/ai/ knowledge base. Follow the skill in skills/onboarding.md.' -ForegroundColor DarkGray
Write-Host ""
Write-Host "See prompts/onboarding.md for more." -ForegroundColor White
