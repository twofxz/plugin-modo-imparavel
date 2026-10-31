# Conexão com OpenClaw

**Status: Configuração manual / Não homologado nesta entrega.** Requer teste completo de conexão, leitura, ação autorizada, revogação e reconexão na versão utilizada pelo cliente.

### Passo 1: Conectar o MCP
Via CLI do OpenClaw:
```bash
openclaw mcp add modo-imparavel https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer $MODO_IMPARAVEL_PAT"
```

Ou no arquivo de configuração `~/.openclaw/openclaw.json`:
```json
{
  "mcp": {
    "servers": {
      "modo-imparavel": {
        "url": "https://mcp.modoimparavel.site/mcp",
        "headers": {
          "Authorization": "Bearer ${env:MODO_IMPARAVEL_PAT}"
        }
      }
    }
  }
}
```

> ⚠️ **Atenção:** Nunca versione seu token PAT pessoal em arquivos públicos ou em repositórios.

### Passo 2: Instalar a Skill
Copie o arquivo `skill/SKILL.md` para o diretório de skills do OpenClaw:
```bash
mkdir -p ~/.openclaw/skills/modo-imparavel
cp skill/SKILL.md ~/.openclaw/skills/modo-imparavel/
```
A instalação da skill orienta o modelo sobre regras e formatos, mas não autentica a conexão nem substitui o servidor.
