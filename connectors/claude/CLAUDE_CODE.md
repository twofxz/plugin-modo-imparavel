# Conexão com Claude Code (CLI)

Para conectar o Claude Code diretamente ao Modo Imparável através do terminal:

```bash
claude mcp add --transport http modo-imparavel https://mcp.modoimparavel.site/mcp --header "Authorization: Bearer <SEU_PAT_AQUI>"
```

### Para Claude Desktop:
Copie o conteúdo de `claude_desktop_config.json` para o seu arquivo de configuração do Claude Desktop:
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux:** `~/.config/Claude/claude_desktop_config.json`
