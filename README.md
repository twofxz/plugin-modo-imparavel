# Modo Imparável — Conexão MCP e Skill

Conecte clientes compatíveis ao servidor MCP remoto oficial do Modo Imparável em `https://mcp.modoimparavel.site/mcp`. O servidor fornece ferramentas de planejamento, hábitos, rotinas, saúde, finanças, anotações, nutrição e lembretes conforme as permissões da conta. A skill em `skill/SKILL.md` oferece instruções complementares para clientes compatíveis; ela não cria a conexão nem substitui os schemas publicados autoritativamente pelo servidor.

**Status geral:** Conexão em validação técnica. Este documento não atesta suporte universal a todas as versões de clientes de terceiros. A automação de instalador local atende **exclusivamente ao Cursor IDE**, com homologação automatizada em ambiente Windows. Todas as demais plataformas requerem configuração manual e homologação prática pelo usuário antes de uso em larga escala.

---

## 1. Requisitos e Credenciais

- **Assinatura:** O acesso exige uma conta com assinatura ativa ou período de teste vigente no Modo Imparável.
- **Autenticação:** Suporta **OAuth 2.0** (Dynamic Client Registration / RFC 7591) em clientes como ChatGPT web, e **Personal Access Token (PAT)** via cabeçalho `Authorization: Bearer <TOKEN>` em clientes que suportam transporte HTTP Streamable.
- **Gerenciamento de Chaves:** Emita ou revogue conexões e tokens no painel web ou aplicativo móvel oficial:
  👉 [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections)
- **Segurança Crítica:** O PAT é uma credencial privada. **Nunca** cole seu token em chats ou prompts com agentes, não o compartilhe e **nunca** o salve em arquivos de configuração versionados no GitHub. Utilize referências a variáveis de ambiente (`MODO_IMPARAVEL_PAT`).

---

## 2. ChatGPT web — Servidor MCP Personalizado (OAuth)

1. No ChatGPT web, abra **Plugins** / **Settings** e selecione **Adicionar servidor MCP personalizado**.
2. Nomeie o servidor (ex: `modo-imparavel`) e informe a URL oficial:
   `https://mcp.modoimparavel.site/mcp`
3. Selecione autenticação **OAuth 2.0**. O servidor apresentará os metadados de descoberta (RFC 9728 / RFC 8414). Complete o login na sua conta do Modo Imparável e autorize os escopos de acesso solicitados.
4. Instale o plugin e teste uma leitura em um novo chat: *"Consulte meus hábitos e rotinas de hoje"*.
5. Gerencie ou revogue o acesso a qualquer momento em [Conexões MCP](https://modoimparavel.site/mcp/connections).

> ℹ️ **Nota:** Actions de GPTs customizados e o arquivo OpenAPI (`connectors/chatgpt/openapi.json`) representam um caminho alternativo legado e não estão homologados como protocolo MCP nativo.

---

## 3. Claude (Claude Code e Claude Desktop) — Configuração Manual

**Status: Configuração manual / Não homologado nesta entrega.**

- **Claude Code (CLI):** Execute o comando adicionando o servidor com interpolação segura da variável de ambiente:
  ```bash
  claude mcp add --transport http modo-imparavel https://mcp.modoimparavel.site/mcp --header "Authorization: Bearer $MODO_IMPARAVEL_PAT"
  ```
- **Claude Desktop:** Adicione manualmente ao arquivo `claude_desktop_config.json`:
  ```json
  {
    "mcpServers": {
      "modo-imparavel": {
        "url": "https://mcp.modoimparavel.site/mcp",
        "headers": {
          "Authorization": "Bearer ${env:MODO_IMPARAVEL_PAT}"
        }
      }
    }
  }
  ```
  *(Se sua versão do Claude Desktop não suportar expansão de `${env:...}`, configure permissões restritas no arquivo e garanta que ele esteja listado no `.gitignore`)*.
- Para orientar o modelo, copie `skill/SKILL.md` para as regras de projeto ou pasta de skills do Claude.

---

## 4. Cursor IDE — Instalador Automatizado e Manual

Os instaladores automatizados contidos neste repositório atendem **apenas ao Cursor IDE** (`~/.cursor/mcp.json`).

### O que o instalador faz:
- Preserva integralmente outros servidores MCP já configurados no arquivo.
- Cria backup recuperável com timestamp (`mcp.backup-YYYYMMDD-HHmmss.json`) e cópia `.bak`.
- É totalmente idempotente: execuções repetidas não duplicam nem corrompem o arquivo.
- Escreve a referência `${env:MODO_IMPARAVEL_PAT}`, nunca gravando o token em texto puro.
- Informa o que foi instalado e alerta que a skill deve ser consultada à parte.

### Como executar:
- **Windows (PowerShell):**
  ```powershell
  powershell -ExecutionPolicy Bypass -File ./install.ps1 -Target cursor
  ```
- **Linux / macOS (Bash — requer Node.js):**
  ```bash
  bash ./install.sh --target cursor
  ```
Após executar, defina `MODO_IMPARAVEL_PAT` nas variáveis do sistema/usuário e reinicie o Cursor.

---

## 5. Demais Clientes — Configuração Manual / Não Homologados

Os conectores a seguir estão documentados em `connectors/` como referência técnica preliminar e **não foram homologados em ambiente nativo nesta entrega**:
- **Codex CLI / Extensão:** Suporta `codex mcp add` ou `~/.codex/config.toml`. Consulte a documentação oficial da OpenAI.
- **Hermes Agent (Nous Research):** Configuração em `~/.hermes/config.yaml`.
- **OpenCode:** Configuração em `opencode.jsonc`.
- **Antigravity (Google DeepMind):** Configuração em `skills/` e `mcp_config.json`.
- **OpenClaw:** Configuração em `openclaw.json`.
- **Grok (xAI) e DeepSeek:** Recomendado o uso desses modelos como motores de inferência dentro de clientes hospedeiros homologados (como Cursor ou OpenCode). As interfaces web diretas dos provedores não oferecem suporte oficial a conexões MCP remotas personalizadas nesta data.

---

## 6. Regras de Confirmação em Duas Etapas e Solução de Problemas

- **Ações Financeiras e Exclusões:** Toda mutação financeira (`preparar_receita`, `preparar_despesa`, `preparar_assinatura`) e exclusão (`preparar_exclusao`) exige confirmação em 2 etapas. A IA deve executar a preparação, apresentar a prévia e aguardar confirmação explícita do usuário antes de chamar `confirmar_*`.
- **Erros de Autenticação (401):** Verifique se o PAT é válido e se a assinatura está ativa em [Conexões MCP](https://modoimparavel.site/mcp/connections).
- **Acesso Negado (403):** Confirme os escopos e permissões autorizados para a conexão.
- **Limitação de Ferramentas:** O catálogo ativo possui 21 ferramentas. A ferramenta `consultar_conhecimento` permanece indisponível até validação formal da integração com a base interna.
