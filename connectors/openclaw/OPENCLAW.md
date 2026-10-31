# Conexão com OpenClaw

### Passo 1: Conectar o MCP
Via CLI do OpenClaw:
```bash
openclaw mcp add modo-imparavel https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer <SEU_PAT_AQUI>"
```

Ou no arquivo `~/.openclaw/openclaw.json`:
```json
{
  "mcp": {
    "servers": {
      "modo-imparavel": {
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
Copie o arquivo `skill/SKILL.md` para o diretório de skills do OpenClaw:
```bash
mkdir -p ~/.openclaw/skills/modo-imparavel
cp skill/SKILL.md ~/.openclaw/skills/modo-imparavel/
```
