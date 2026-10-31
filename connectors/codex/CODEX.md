# Conexão com Codex (OpenAI)

Para que o **Codex** interaja com o Modo Imparável, são necessárias duas partes: o **MCP** (ferramentas) e a **Skill** (instruções operacionais).

---

### Passo 1: Conectar o Servidor MCP (Ferramentas)
No seu arquivo de configuração MCP do Codex ou ambiente de execução (`.codex/mcp.json` ou `mcp.json`):

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

---

### Passo 2: Instalar a Skill (Instruções do Agente)
O Codex lê as instruções de comportamento do repositório ou de arquivos canônicos:
1. Copie o arquivo `skill/SKILL.md` para o diretório `.codex/skills/modo-imparavel/SKILL.md` ou adicione uma referência no seu arquivo `AGENTS.md` / `CODEX.md`:
   ```bash
   mkdir -p .codex/skills/modo-imparavel
   cp skill/SKILL.md .codex/skills/modo-imparavel/
   ```
2. Ao iniciar uma sessão no Codex, ele terá consciência de todas as 21 ferramentas, regras financeiras e formatos de data (`YYYY-MM-DD`).
