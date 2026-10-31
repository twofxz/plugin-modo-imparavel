# OpenCode — MCP remoto

**Status: requer teste completo na versão instalada.** O exemplo abaixo corresponde ao formato documentado para OpenCode v2; outras versões podem usar outro formato.

Em `opencode.jsonc`, preserve suas configurações existentes e adicione:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "servers": {
      "modo-imparavel": {
        "type": "remote",
        "url": "https://mcp.modoimparavel.site/mcp",
        "oauth": false,
        "headers": { "Authorization": "Bearer {env:MODO_IMPARAVEL_PAT}" }
      }
    }
  }
}
```

Defina a variável de ambiente no processo do OpenCode sem incluir seu valor no arquivo ou em conversa. OAuth é outra alternativa quando suportado e testado. Teste uma leitura, uma ação autorizada, revogação e reconexão. Instalar a skill é opcional e não autentica a conexão.

Fonte: https://dev.opencode.ai/v2/docs/mcp-servers/
