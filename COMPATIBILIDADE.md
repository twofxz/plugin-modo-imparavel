# Matriz de Compatibilidade e Homologação — Modo Imparável MCP

**Status do Repositório:** Apenas a automação do instalador local para **Cursor IDE no Windows** foi testada e aprovada com suíte automatizada nesta entrega (`tests/installer-windows.tests.ps1`). Todas as demais plataformas, clientes e sistemas operacionais permanecem em **Configuração manual / Não homologado em ambiente nativo**, exigindo validação direta pelo proprietário da conta antes de divulgação em produção.

---

## Matriz de Clientes e Protocolos

| Cliente | Método de Conexão | Autenticação | Status de Homologação | Notas e Limitações |
|---|---|---|---|---|
| **Cursor IDE (Windows)** | Instalador (`install.ps1`) ou manual (`mcp.json`) | PAT via variável de ambiente (`MODO_IMPARAVEL_PAT`) | **Homologado (Instalador)** | Testado com preservação de outros servidores, backup com timestamp e idempotência. |
| **Cursor IDE (Linux / macOS)** | Script (`install.sh`) ou manual (`mcp.json`) | PAT via variável de ambiente (`MODO_IMPARAVEL_PAT`) | **Não homologado em ambiente nativo** | Script testado sob emulação Git Bash; requer teste em host Linux/macOS nativo. |
| **ChatGPT web** | Servidor MCP personalizado (`/mcp`) | OAuth 2.0 (DCR / RFC 7591) | **Não homologado nesta entrega** | Requer teste completo de jornada: cadastro assistido, leitura, escrita, revogação e reconexão. |
| **Claude Code (CLI)** | CLI (`claude mcp add`) | PAT (Header Bearer) ou OAuth | **Não homologado nesta entrega** | Requer teste manual na versão instalada pelo usuário. |
| **Claude Desktop** | Manual (`claude_desktop_config.json`) | PAT (Header Bearer) | **Não homologado nesta entrega** | Requer teste manual nas versões Windows, macOS e Linux. |
| **Codex CLI / Extensão** | CLI (`codex mcp add`) ou `config.toml` | OAuth ou PAT conforme versão | **Não homologado nesta entrega** | Configuração documentada conforme diretrizes OpenAI; requer validação prática. |
| **Hermes Agent (Nous)** | CLI (`hermes mcp add`) ou `config.yaml` | PAT (Header Bearer) | **Não homologado nesta entrega** | Requer teste em ambiente VPS/Linux dedicado. |
| **OpenCode** | Manual (`opencode.jsonc`) | PAT via variável de ambiente | **Não homologado nesta entrega** | Configuração documentada para v2; requer teste prático. |
| **Antigravity (Google)** | Manual (`mcp_config.json`) | PAT via variável de ambiente | **Não homologado nesta entrega** | Requer validação de ferramentas e skill no ambiente Antigravity. |
| **OpenClaw** | CLI (`openclaw mcp add`) ou `openclaw.json` | PAT (Header Bearer) | **Não homologado nesta entrega** | Requer validação em ambiente com OpenClaw ativo. |
| **Grok (xAI) no Cursor/Harness** | Via cliente MCP hospedeiro | Autenticação do hospedeiro | **Configuração manual / Conforme cliente** | O modelo consome ferramentas via Cursor/OpenCode; não é conexão nativa do xAI. |
| **DeepSeek no Cursor/Harness** | Via cliente MCP hospedeiro | Autenticação do hospedeiro | **Configuração manual / Conforme cliente** | O modelo consome ferramentas via Cursor/OpenCode; não é conexão nativa do DeepSeek. |
| **Grok / DeepSeek web própria** | Não suportado diretamente | N/A | **Não homologado / Sem suporte MCP remoto** | Não inserir tokens ou credenciais em interfaces de chat web de terceiros. |

---

## Roteiro de Homologação Manual para Novos Clientes

Ao testar qualquer cliente acima em sua máquina:
1. **Ambiente:** Anote produto, versão exata, sistema operacional e data do teste (nunca grave nem registre credenciais nos relatórios).
2. **Conexão:** Obtenha o token PAT ou inicie o fluxo OAuth em [Conexões MCP](https://modoimparavel.site/mcp/connections).
3. **Descoberta:** Verifique se as 21 ferramentas ativas aparecem listadas no cliente com seus parâmetros esperados.
4. **Leitura:** Execute uma leitura segura (ex: `consultar_dia`).
5. **Mutação em Duas Etapas:** Execute uma preparação (ex: `preparar_despesa`), inspecione a prévia retornada, aprove explicitamente e invoque a confirmação (`confirmar_financas`). Verifique o reflexo imediato no aplicativo do Modo Imparável.
6. **Revogação:** No painel [Conexões MCP](https://modoimparavel.site/mcp/connections), revogue o token ou conexão. Teste uma nova chamada e confirme a recepção do erro `401 Unauthorized`.
7. **Reconexão:** Gere nova credencial e confirme a recuperação do acesso.
