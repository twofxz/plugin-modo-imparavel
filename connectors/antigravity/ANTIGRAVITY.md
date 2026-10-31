# Conexão com Antigravity (Google DeepMind)

Para que o **Antigravity** interaja com o Modo Imparável, são necessárias duas partes: o **MCP** (ferramentas) e a **Skill** (regras e inteligência operacional).

---

### Passo 1: Conectar o Servidor MCP (Ferramentas)
No seu arquivo de configuração de servidores MCP do Antigravity (ou no seu workspace):

```json
{
  "mcp_servers": {
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

### Passo 2: Instalar a Skill (Inteligência & Regras)
O Antigravity possui suporte nativo à especificação canônica de `SKILL.md`.

Para instalar a skill no Antigravity:
1. Crie o diretório da skill:
   - **No projeto/workspace atual:** `skills/modo-imparavel/`
   - **Ou no diretório global do usuário:** `~/.gemini/antigravity/skills/modo-imparavel/`
2. Copie o arquivo `skill/SKILL.md` deste repositório para essa pasta:
   ```bash
   mkdir -p ~/.gemini/antigravity/skills/modo-imparavel
   cp skill/SKILL.md ~/.gemini/antigravity/skills/modo-imparavel/
   ```

Pronto! O Antigravity carregará as 21 ferramentas e respeitará rigorosamente o fluxo de confirmação em duas etapas para finanças e exclusões.
