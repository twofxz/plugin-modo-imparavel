param(
    [ValidateSet('cursor')][string]$Target = 'cursor',
    [string]$ConfigPath = (Join-Path $HOME '.cursor/mcp.json')
)

$ErrorActionPreference = 'Stop'

if (Test-Path -LiteralPath $ConfigPath) {
    try {
        $config = Get-Content -Raw -LiteralPath $ConfigPath | ConvertFrom-Json
    } catch {
        throw 'Configuração JSON inválida ou corrompida; nenhum arquivo foi alterado.'
    }
    if ($config -isnot [pscustomobject]) { throw 'Configuração inválida; nenhum arquivo foi alterado.' }
} else {
    $config = [pscustomobject]@{}
}

if ($null -eq $config.mcpServers) { $config | Add-Member -NotePropertyName mcpServers -NotePropertyValue ([pscustomobject]@{}) }
if ($config.mcpServers -isnot [pscustomobject]) { throw 'mcpServers inválido; nenhum arquivo foi alterado.' }

$server = [pscustomobject]@{
    url = 'https://mcp.modoimparavel.site/mcp'
    headers = [pscustomobject]@{ Authorization = 'Bearer ${env:MODO_IMPARAVEL_PAT}' }
}

if ($null -ne $config.mcpServers.PSObject.Properties['modo-imparavel']) {
    $config.mcpServers.'modo-imparavel' = $server
} else {
    $config.mcpServers | Add-Member -NotePropertyName 'modo-imparavel' -NotePropertyValue $server
}

$parent = Split-Path -Parent $ConfigPath
if ($parent -and !(Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }

if (Test-Path -LiteralPath $ConfigPath) {
    $timestamp = (Get-Date).ToString('yyyyMMdd-HHmmss')
    $tsBackup = Join-Path $parent "mcp.backup-$timestamp.json"
    Copy-Item -LiteralPath $ConfigPath -Destination $tsBackup -ErrorAction Stop
    $legacyBackup = "$ConfigPath.bak"
    Copy-Item -LiteralPath $ConfigPath -Destination $legacyBackup -Force -ErrorAction Stop
}

$tempPath = "$ConfigPath.$([guid]::NewGuid().ToString('N')).tmp"
try {
    $config | ConvertTo-Json -Depth 50 | Set-Content -LiteralPath $tempPath -Encoding UTF8
    Move-Item -LiteralPath $tempPath -Destination $ConfigPath -Force
} finally {
    if (Test-Path -LiteralPath $tempPath) { Remove-Item -LiteralPath $tempPath -Force }
}

Write-Host 'Configuração do Cursor atualizada com sucesso em: ' $ConfigPath
Write-Host 'Servidor registrado: modo-imparavel (https://mcp.modoimparavel.site/mcp)'
Write-Host 'Outros servidores existentes foram preservados intactos.'
Write-Host 'Backup recuperável criado com timestamp (mcp.backup-YYYYMMDD-HHmmss.json).'
Write-Host 'Defina MODO_IMPARAVEL_PAT no ambiente do Cursor e reinicie-o.'
Write-Host 'A skill não foi instalada automaticamente. Consulte o guia antes de usá-la.'
Write-Host 'Nenhuma conexão foi testada; confirme a autenticação no cliente.'
