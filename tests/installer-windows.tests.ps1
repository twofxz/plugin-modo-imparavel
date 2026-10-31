$ErrorActionPreference = 'Stop'
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('mcp-install-test-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $testRoot | Out-Null
$config = Join-Path $testRoot 'mcp.json'
$installer = Join-Path $PSScriptRoot '../install.ps1'
$env:MODO_IMPARAVEL_PAT = 'pat_synthetic_test_1234567890'
try {
  '{"mcpServers":{"outro":{"url":"https://example.test/mcp"}},"custom":true}' | Set-Content -LiteralPath $config
  $output = & $installer -Target cursor -ConfigPath $config 6>&1 | Out-String
  if ($output.Contains($env:MODO_IMPARAVEL_PAT)) { throw 'token written to output' }
  $data = Get-Content -Raw -LiteralPath $config | ConvertFrom-Json
  if ($data.mcpServers.outro.url -ne 'https://example.test/mcp' -or !$data.custom) { throw 'existing configuration lost' }
  if ($data.mcpServers.'modo-imparavel'.headers.Authorization -ne 'Bearer ${env:MODO_IMPARAVEL_PAT}') { throw 'missing environment reference' }
  if (!(Test-Path -LiteralPath "$config.bak")) { throw 'backup missing' }
  $tsBackups = Get-ChildItem -Path $testRoot -Filter 'mcp.backup-*.json'
  if ($tsBackups.Count -eq 0) { throw 'timestamped backup missing' }
  & $installer -Target cursor -ConfigPath $config
  $data = Get-Content -Raw -LiteralPath $config | ConvertFrom-Json
  if (@($data.mcpServers.PSObject.Properties | Where-Object Name -eq 'modo-imparavel').Count -ne 1) { throw 'duplicate server' }
  if ((Get-Content -Raw -LiteralPath $config).Contains($env:MODO_IMPARAVEL_PAT)) { throw 'token written to configuration' }
  $invalid = Join-Path $testRoot 'invalid.json'
  '{invalid' | Set-Content -LiteralPath $invalid
  $failed = $false
  try { & $installer -Target cursor -ConfigPath $invalid } catch { $failed = $true }
  if (!$failed -or (Get-Content -Raw -LiteralPath $invalid).Trim() -ne '{invalid') { throw 'invalid configuration modified or accepted' }
  $invalidShape = Join-Path $testRoot 'invalid-shape.json'
  '{"mcpServers":false}' | Set-Content -LiteralPath $invalidShape
  $failed = $false
  try { & $installer -Target cursor -ConfigPath $invalidShape } catch { $failed = $true }
  if (!$failed -or (Get-Content -Raw -LiteralPath $invalidShape).Trim() -ne '{"mcpServers":false}') { throw 'invalid mcpServers modified or accepted' }
  Write-Host 'PASS: preserves existing configuration, creates backup with timestamp and is idempotent'
} finally {
  Remove-Item -LiteralPath $testRoot -Recurse -Force
}
