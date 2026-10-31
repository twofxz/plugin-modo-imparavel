# ⚡ Plugin Oficial — Modo Imparável

> **Conecte seu agente de inteligência artificial favorito ao Modo Imparável através do Model Context Protocol (MCP).**

Este repositório é o hub oficial universal para transformar agentes como **Cursor**, **Claude**, **Hermes**, **OpenCode**, **OpenClaw**, **ChatGPT**, **Antigravity**, **Grok** e **DeepSeek** em copilotos do seu dia a dia, executando e consultando hábitos, rotinas, metas, saúde, finanças e anotações.

---

## 🔒 Quem pode utilizar este Plugin?

Este repositório de conexão é **público**, porém o acesso real aos dados e ferramentas é **exclusivo para assinantes premium do Modo Imparável**.

Para conectar qualquer IA, você precisa de um **Personal Access Token (PAT)** emitido pelo sistema:
1. Acesse o painel web: [https://app.modoimparavel.site/conexoes-mcp](https://app.modoimparavel.site/conexoes-mcp)
2. Clique no botão **"Gerar Novo Token (PAT)"**.
3. Copie o token gerado (começa com `pat_...`). Guarde-o com segurança.

> ⚠️ **Atenção:** Usuários sem assinatura ativa ou sem conta no Modo Imparável não conseguem gerar o token, e qualquer requisição não autorizada será rejeitada com código `401 Unauthorized`.

---

## 🚀 Instalação Rápida em 1 Comando (Terminal / VPS)

Se você utiliza Linux, macOS ou está em uma VPS (por exemplo, rodando o **Hermes Agent** ou **Claude Code**):

```bash
curl -fsSL https://raw.githubusercontent.com/twofxz/plugin-modo-imparavel/main/install.sh | bash
```

Se preferir clonar e executar localmente:
```bash
git clone https://github.com/twofxz/plugin-modo-imparavel.git
cd plugin-modo-imparavel
bash install.sh
```

### No Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/twofxz/plugin-modo-imparavel/main/install.ps1 | iex
```

O instalador detectará automaticamente os agentes presentes na sua máquina (Hermes, Claude, Cursor, OpenCode), solicitará seu Token PAT com segurança e configurará tudo em segundos.

---

## 🤖 Como Conectar sua IA Favorita Manualmente

Se você prefere configurar seu editor ou IA manualmente, siga as instruções abaixo:

### 1. Cursor IDE
No diretório do seu projeto ou no diretório global (`~/.cursor/mcp.json`):
Crie o arquivo `.cursor/mcp.json`:
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
*Copie também a regra de comportamento em `connectors/cursor/modo-imparavel.mdc` para `.cursor/rules/` para que o agente do Cursor conheça as melhores práticas do Modo Imparável.*

---

### 2. Claude (Anthropic)

#### Claude Code (CLI)
No terminal:
```bash
claude mcp add --transport http modo-imparavel https://mcp.modoimparavel.site/mcp --header "Authorization: Bearer <SEU_PAT_AQUI>"
```

#### Claude Desktop
Edite o arquivo de configuração do Claude Desktop (`claude_desktop_config.json`):
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

### 3. Hermes Agent (Nous Research)
O Hermes Agent é ideal para rodar em VPS ou servidores locais:

**Via CLI:**
```bash
hermes mcp add --name modo-imparavel --url https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer <SEU_PAT_AQUI>"
```

**Ou adicionando em `~/.hermes/config.yaml`:**
```yaml
mcp_servers:
  modo-imparavel:
    url: "https://mcp.modoimparavel.site/mcp"
    headers:
      Authorization: "Bearer <SEU_PAT_AQUI>"
```

Para instalar a skill no Hermes:
```bash
mkdir -p ~/.hermes/skills/modo-imparavel
cp skill/SKILL.md ~/.hermes/skills/modo-imparavel/
```

---

### 4. OpenCode & OpenClaw

**OpenCode (`opencode.jsonc`):**
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

**OpenClaw CLI:**
```bash
openclaw mcp add modo-imparavel https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer <SEU_PAT_AQUI>"
```

---

### 5. ChatGPT (Custom GPTs / Actions)
Como a interface web do ChatGPT opera via OpenAPI em vez de MCP direto:
1. No [ChatGPT](https://chatgpt.com), crie ou edite um **Custom GPT**.
2. Em **Instructions**, cole o conteúdo de `skill/SKILL.md`.
3. Em **Actions** > **Create new action**:
   - Em **Schema**, cole o conteúdo de `connectors/chatgpt/openapi.json`.
   - Em **Authentication**, escolha **API Key** -> **Bearer** e insira o seu PAT.
4. Salve e comece a conversar com o Modo Imparável dentro do ChatGPT!

---

### 6. Antigravity (Google DeepMind)
Adicione a configuração em `mcp_servers` com a URL `https://mcp.modoimparavel.site/mcp` e o cabeçalho `Authorization: Bearer <SEU_PAT_AQUI>`.

---

### 7. Grok (xAI) e DeepSeek (V3/R1)
Utilize o conector através do **Cursor**, **Hermes Agent** ou **OpenCode**, selecionando o modelo Grok ou DeepSeek de sua preferência. O harness gerencia a execução das ferramentas do Modo Imparável em tempo real.

---

## 🛠️ O que sua IA pode fazer? (Catálogo das 21 Ferramentas)

| Domínio | Ferramenta | Descrição |
|---|---|---|
| **Planejamento** | `consultar_dia` | Consulta hábitos, rotinas e metas da data |
| **Planejamento** | `consultar_semana` | Panorama consolidado da semana |
| **Planejamento** | `criar_planejamento` | Cria metas, hábitos ou rotinas |
| **Planejamento** | `concluir_planejamento`| Dá baixa em um item concluído |
| **Saúde** | `consultar_saude` | Consulta água, treinos e bem-estar |
| **Saúde** | `registrar_agua` | Registra ingestão de água (ml) |
| **Nutrição** | `consultar_alimentacao`| Histórico de refeições e calorias |
| **Nutrição** | `propor_refeicao` | Elabora proposta nutricional estruturada |
| **Nutrição** | `salvar_refeicao` | Persiste refeição aprovada |
| **Lembretes** | `criar_lembrete` | Cria lembrete com data e hora |
| **Finanças** | `consultar_financas` | Resumo financeiro, receitas e despesas |
| **Finanças** | `preparar_receita` | Prepara lançamento de receita (2 etapas) |
| **Finanças** | `preparar_despesa` | Prepara lançamento de despesa (2 etapas) |
| **Finanças** | `preparar_assinatura` | Prepara cadastro de recorrência (2 etapas) |
| **Finanças** | `preparar_pagamento_assinatura` | Prepara baixa de assinatura (2 etapas) |
| **Finanças** | `confirmar_financas` | Consolida operação financeira após consentimento |
| **Caderno** | `listar_pastas_notas` | Lista pastas de notas |
| **Caderno** | `consultar_notas` | Busca notas por pasta ou termo |
| **Caderno** | `criar_nota` | Cria nova nota no caderno |
| **Exclusão** | `preparar_exclusao` | Prepara exclusão segura (2 etapas) |
| **Exclusão** | `confirmar_exclusao` | Executa deleção permanente autorizada |

---

## 🛡️ Segurança: Confirmação em Duas Etapas

Para sua total tranquilidade, nenhuma inteligência artificial tem permissão para lançar despesas, receitas ou apagar dados de forma unilateral:
1. O agente invoca `preparar_*`.
2. O agente informa os detalhes e solicita a sua autorização direta.
3. Somente com a sua confirmação explícita, o agente chama `confirmar_*`.

---

## 📄 Licença

Este conector é distribuído sob a licença [MIT](LICENSE). O uso dos serviços de backend do Modo Imparável está sujeito aos [Termos de Uso](https://modoimparavel.site) da plataforma.
