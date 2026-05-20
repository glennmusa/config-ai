#Requires -RunAsAdministrator
# setup.ps1 — Create symlinks so every AI tool reads from ~/.config/ai/
# Run once after cloning. Requires Administrator for symlinks on Windows.

$configDir = "$HOME\.config\ai"

# --- MCP server config ---
$mcpTargets = @(
    "$env:APPDATA\Code\User\mcp.json"                           # VS Code
    # "$env:APPDATA\Claude\claude_desktop_config.json"           # Claude Desktop (uncomment if used)
)

foreach ($target in $mcpTargets) {
    $parent = Split-Path $target
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    if (Test-Path $target) {
        Write-Host "  SKIP  $target (already exists — back up and remove to symlink)" -ForegroundColor Yellow
    } else {
        New-Item -ItemType SymbolicLink -Path $target -Target "$configDir\mcp.json" | Out-Null
        Write-Host "  LINK  $target -> mcp.json" -ForegroundColor Green
    }
}

# --- Instruction files ---
$instructionTargets = @(
    "$configDir\.github\copilot-instructions.md"   # VS Code Copilot
    "$configDir\CLAUDE.md"                          # Claude
    "$configDir\.cursorrules"                       # Cursor
)

foreach ($target in $instructionTargets) {
    $parent = Split-Path $target
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    if (Test-Path $target) {
        Write-Host "  SKIP  $target (already exists)" -ForegroundColor Yellow
    } else {
        New-Item -ItemType SymbolicLink -Path $target -Target "$configDir\instructions.md" | Out-Null
        Write-Host "  LINK  $target -> instructions.md" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done. Symlinks created." -ForegroundColor Cyan
Write-Host ""
Write-Host "For tools that don't support instruction files, paste this:" -ForegroundColor White
Write-Host ""
Write-Host '  You have access to my knowledge base at ~/.config/ai/. Start by reading AGENTS.md, then the files it references. Use this context for all responses.' -ForegroundColor DarkGray
Write-Host ""
Write-Host "See prompts/bootstrap.md for more." -ForegroundColor White
