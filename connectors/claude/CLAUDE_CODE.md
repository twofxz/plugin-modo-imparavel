# Conexão com Claude (Claude Code e Claude Desktop)

O ecossistema Claude necessita de duas etapas para funcionar com perfeição: o **MCP** (execução das ferramentas) e a **Skill** (discernimento de uso e confirmação em 2 etapas).

---

## Para Claude Code (CLI)

### Passo 1: Adicionar o Servidor MCP
No terminal:
```bash
claude mcp add --transport http modo-imparavel https://mcp.modoimparavel.site/mcp --header "Authorization: Bearer <SEU_PAT_AQUI>"
```

### Passo 2: Instalar a Skill
O Claude Code suporta o padrão oficial Anthropic Agent Skills:
1. Copie o arquivo de skill para o seu diretório global de skills do Claude:
   ```bash
   mkdir -p ~/.claude/skills/modo-imparavel
   cp skill/SKILL.md ~/.claude/skills/modo-imparavel/
   ```
2. *(Alternativa no projeto)*: Você também pode incluir uma referência no arquivo `CLAUDE.md` do seu projeto apontando para as diretrizes de `skill/SKILL.md`.

---

## Para Claude Desktop

### Passo 1: Configurar o MCP
Adicione em seu `claude_desktop_config.json`:
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux:** `~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "modo-imparavel": {
      "url": "https://mcp.modoimparavel.site/mcp",
      "headers": {
        "Authorization": "Bearer <SEU_PAT_AQUI>"
      }
    }
  }
}
```

### Passo 2: Inserir as Regras da Skill
No Claude Desktop, ao criar um **Project** ou nas **Instruções Personalizadas**, cole o conteúdo de `skill/SKILL.md`. Isso garante que o modelo conheça a regra de confirmação em duas etapas para operações financeiras e de exclusão.
