# ==============================================================================
# Modo Imparável — Instalador Universal de MCP para Windows (PowerShell)
# Endpoint Oficial: https://mcp.modoimparavel.site/mcp
# ==============================================================================

param(
    [string]$Token,
    [string]$Target
)

$ErrorActionPreference = "Stop"
$McpUrl = "https://mcp.modoimparavel.site/mcp"

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "       MODO IMPARÁVEL — INSTALADOR MCP UNIVERSAL      " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "Conecte sua IA favorita ao Modo Imparável em segundos.`n"

# Validação do Token
if (-not $Token) {
    if ($env:MODO_IMPARAVEL_PAT) {
        $Token = $env:MODO_IMPARAVEL_PAT
    } else {
        Write-Host "Para conectar, você precisa do seu Personal Access Token (PAT)." -ForegroundColor Yellow
        Write-Host "Gere sua chave em: https://app.modoimparavel.site/conexoes-mcp`n" -ForegroundColor Yellow
        $SecurePass = Read-Host -Prompt "Cole seu Token PAT aqui" -AsSecureString
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass)
        $Token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
}

if (-not $Token) {
    Write-Host "Erro: Token PAT não informado. Operação cancelada." -ForegroundColor Red
    exit 1
}

function Configure-Cursor {
    Write-Host "`nConfigurando Cursor IDE..." -ForegroundColor Cyan
    $cursorDir = ".cursor"
    if (-not (Test-Path $cursorDir)) { New-Item -ItemType Directory -Path $cursorDir | Out-Null }
    
    $configContent = @"
{
  "mcpServers": {
    "modo-imparavel": {
      "url": "$McpUrl",
      "headers": {
        "Authorization": "Bearer $Token"
      }
    }
  }
}
"@
    Set-Content -Path "$cursorDir/mcp.json" -Value $configContent -Encoding UTF8
    
    if (Test-Path "connectors/cursor/modo-imparavel.mdc") {
        $rulesDir = "$cursorDir/rules"
        if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Path $rulesDir | Out-Null }
        Copy-Item -Path "connectors/cursor/modo-imparavel.mdc" -Destination "$rulesDir/" -Force
    }
    Write-Host "✓ Cursor configurado com sucesso em .cursor/mcp.json!" -ForegroundColor Green
}

function Configure-ClaudeDesktop {
    Write-Host "`nConfigurando Claude Desktop..." -ForegroundColor Cyan
    $claudePath = "$env:APPDATA\Claude\claude_desktop_config.json"
    $claudeDir = Split-Path -Parent $claudePath
    if (-not (Test-Path $claudeDir)) { New-Item -ItemType Directory -Path $claudeDir | Out-Null }

    $configContent = @"
{
  "mcpServers": {
    "modo-imparavel": {
      "url": "$McpUrl",
      "headers": {
        "Authorization": "Bearer $Token"
      }
    }
  }
}
"@
    Set-Content -Path $claudePath -Value $configContent -Encoding UTF8
    Write-Host "✓ Claude Desktop configurado em $claudePath!" -ForegroundColor Green
}

# Roteamento
switch ($Target) {
    "cursor" { Configure-Cursor }
    "claude" { Configure-ClaudeDesktop }
    default {
        Configure-Cursor
        Configure-ClaudeDesktop
    }
}

Write-Host "`n======================================================" -ForegroundColor Green
Write-Host "   CONEXÃO COM O MODO IMPARÁVEL PRONTA PARA USO!     " -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Green
Write-Host "Agora sua IA já consegue consultar seu dia, registrar hábitos, finanças e muito mais.`n"
