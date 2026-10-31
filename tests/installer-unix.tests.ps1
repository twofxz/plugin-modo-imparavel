$ErrorActionPreference = 'Stop'
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('mcp-unix-test-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $testRoot | Out-Null
$config = Join-Path $testRoot 'mcp.json'
$installer = Join-Path $PSScriptRoot '../install.sh'
$env:MODO_IMPARAVEL_PAT = 'pat_synthetic_test_1234567890'
$env:MCP_CURSOR_CONFIG = $config
try {
  '{"mcpServers":{"outro":{"url":"https://example.test/mcp"}},"custom":true}' | Set-Content -LiteralPath $config
  Push-Location $testRoot
  $output = & 'C:\Program Files\Git\bin\bash.exe' $installer --target cursor | Out-String
  if ($LASTEXITCODE -ne 0) { throw 'installer failed' }
  if ($output.Contains($env:MODO_IMPARAVEL_PAT)) { throw 'token written to output' }
  $data = Get-Content -Raw -LiteralPath $config | ConvertFrom-Json
  if ($data.mcpServers.outro.url -ne 'https://example.test/mcp' -or !$data.custom) { throw 'existing configuration lost' }
  if ($data.mcpServers.'modo-imparavel'.headers.Authorization -ne 'Bearer ${env:MODO_IMPARAVEL_PAT}') { throw 'missing environment reference' }
  if (!(Test-Path -LiteralPath "$config.bak")) { throw 'backup missing' }
  $tsBackups = Get-ChildItem -Path $testRoot -Filter 'mcp.backup-*.json'
  if ($tsBackups.Count -eq 0) { throw 'timestamped backup missing' }
  & 'C:\Program Files\Git\bin\bash.exe' $installer --target cursor
  if ($LASTEXITCODE -ne 0) { throw 'second installation failed' }
  $data = Get-Content -Raw -LiteralPath $config | ConvertFrom-Json
  if (@($data.mcpServers.PSObject.Properties | Where-Object Name -eq 'modo-imparavel').Count -ne 1) { throw 'duplicate server' }
  if ((Get-Content -Raw -LiteralPath $config).Contains($env:MODO_IMPARAVEL_PAT)) { throw 'token written to configuration' }
  $invalid = Join-Path $testRoot 'invalid.json'
  '{"mcpServers":false}' | Set-Content -LiteralPath $invalid
  $env:MCP_CURSOR_CONFIG = $invalid
  $failed = $false
  try {
    $errOutput = & 'C:\Program Files\Git\bin\bash.exe' $installer --target cursor 2>&1
    if ($LASTEXITCODE -ne 0) { $failed = $true }
  } catch {
    $failed = $true
  }
  if (!$failed -or (Get-Content -Raw -LiteralPath $invalid).Trim() -ne '{"mcpServers":false}') { throw 'invalid mcpServers modified or accepted' }
  Write-Host 'PASS (Git Bash emulation): preserves existing configuration, creates backup and is idempotent'
} finally {
  Pop-Location
  Remove-Item -LiteralPath $testRoot -Recurse -Force
}
