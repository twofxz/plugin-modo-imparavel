#!/usr/bin/env bash
set -euo pipefail

target=cursor
while [ "$#" -gt 0 ]; do
  case "$1" in
    --target) [ "$#" -ge 2 ] || { echo 'Informe o destino.' >&2; exit 1; }; target="$2"; shift 2 ;;
    *) echo "Argumento não suportado: $1" >&2; exit 1 ;;
  esac
done
[ "$target" = cursor ] || { echo 'Este instalador configura somente Cursor. Consulte os guias para outros clientes.' >&2; exit 1; }
command -v node >/dev/null || { echo 'Node.js é necessário para preservar a configuração JSON existente.' >&2; exit 1; }

node <<'NODE'
const fs = require('node:fs');
const path = require('node:path');
const os = require('node:os');
const configPath = process.env.MCP_CURSOR_CONFIG || path.join(os.homedir(), '.cursor', 'mcp.json');
let config = {};
if (fs.existsSync(configPath)) {
  try {
    config = JSON.parse(fs.readFileSync(configPath, 'utf8').replace(/^\uFEFF/, ''));
  } catch (err) {
    throw Error('Configuração JSON inválida ou corrompida; nenhum arquivo foi alterado.');
  }
  if (!config || typeof config !== 'object' || Array.isArray(config)) throw Error('Configuração inválida; nenhum arquivo foi alterado.');
}
if (config.mcpServers === undefined) config.mcpServers = {};
if (!config.mcpServers || typeof config.mcpServers !== 'object' || Array.isArray(config.mcpServers)) throw Error('mcpServers inválido; nenhum arquivo foi alterado.');
config.mcpServers['modo-imparavel'] = {
  url: 'https://mcp.modoimparavel.site/mcp',
  headers: { Authorization: 'Bearer ${env:MODO_IMPARAVEL_PAT}' },
};
const parent = path.dirname(configPath);
fs.mkdirSync(parent, { recursive: true });
if (fs.existsSync(configPath)) {
  const now = new Date();
  const pad = (n) => String(n).padStart(2, '0');
  const ts = `${now.getFullYear()}${pad(now.getMonth()+1)}${pad(now.getDate())}-${pad(now.getHours())}${pad(now.getMinutes())}${pad(now.getSeconds())}`;
  const tsBackup = path.join(parent, `mcp.backup-${ts}.json`);
  fs.copyFileSync(configPath, tsBackup);
  fs.copyFileSync(configPath, `${configPath}.bak`);
}
const temp = `${configPath}.${process.pid}-${Date.now()}.tmp`;
try {
  fs.writeFileSync(temp, JSON.stringify(config, null, 2) + '\n', { flag: 'wx', mode: 0o600 });
  fs.renameSync(temp, configPath);
} finally {
  if (fs.existsSync(temp)) fs.unlinkSync(temp);
}
console.log('Configuração do Cursor atualizada com sucesso em: ' + configPath);
console.log('Servidor registrado: modo-imparavel (https://mcp.modoimparavel.site/mcp)');
console.log('Outros servidores existentes foram preservados intactos.');
console.log('Backup recuperável criado com timestamp (mcp.backup-YYYYMMDD-HHmmss.json).');
console.log('Defina MODO_IMPARAVEL_PAT no ambiente do Cursor e reinicie-o.');
console.log('A skill não foi instalada automaticamente. Consulte o guia antes de usá-la.');
console.log('Nenhuma conexão foi testada; confirme a autenticação no cliente.');
NODE
