# Conexão com OpenCode

### Passo 1: Conectar o MCP
No arquivo `opencode.jsonc` (ou `.opencode/config.json`):

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "servers": {
      "modo-imparavel": {
        "type": "remote",
        "url": "https://mcp.modoimparavel.site/mcp",
        "headers": {
          "Authorization": "Bearer <SEU_PAT_AQUI>"
        }
      }
    }
  }
}
```

### Passo 2: Instalar a Skill
Copie o arquivo `skill/SKILL.md` para o diretório de skills do OpenCode:
```bash
mkdir -p .opencode/skills/modo-imparavel
cp skill/SKILL.md .opencode/skills/modo-imparavel/
```
