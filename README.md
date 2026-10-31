# ⚡ Plugin Oficial — Modo Imparável

> **Conecte seu agente de inteligência artificial favorito ao Modo Imparável através do Model Context Protocol (MCP).**

Este repositório é o hub oficial universal para transformar agentes como **Cursor**, **Claude**, **Hermes**, **OpenCode**, **OpenClaw**, **ChatGPT**, **Antigravity**, **Grok** e **DeepSeek** em copilotos do seu dia a dia, executando e consultando hábitos, rotinas, metas, saúde, finanças e anotações.

---

## 🔒 Quem pode utilizar este Plugin?

Este repositório de conexão é **público**, porém o acesso real aos dados e ferramentas é **exclusivo para assinantes premium do Modo Imparável**.

Para conectar qualquer IA, você precisa de um **Personal Access Token (PAT)** emitido pelo sistema. Você pode obtê-lo de duas formas:
1. **Pela Web:** Acesse [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections)
2. **Pelo Aplicativo Nativo (Android e iOS):** No aplicativo oficial do Modo Imparável (disponível na Google Play Store e Apple App Store), acesse a tela **Conexões MCP**.
3. Clique no botão **"Gerar Novo Token (PAT)"** e copie a chave gerada (inicia com `pat_...`). Guarde-a com segurança.

> 📱 **Disponível no App:** O Modo Imparável conta com aplicativo nativo para Android e iOS. Você pode gerenciar suas conexões de IA e emitir seus tokens diretamente pelo celular na aba **Conexões MCP**.

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

## 🤖 Como Conectar sua IA Favorita (MCP + Skill)

Para que qualquer inteligência artificial opere com o Modo Imparável com máxima eficiência e segurança, a integração é composta por dois pilares fundamentais:
- 🔌 **Passo 1: Conectar o Servidor MCP** — Fornece as ferramentas técnicas para a IA poder consultar e executar ações no banco de dados.
- 🧠 **Passo 2: Instalar a Skill** — Fornece o discernimento e regras comportamentais (como o fluxo obrigatório de confirmação em 2 etapas para finanças e exclusões, formato de datas e regras de contexto).

Abaixo estão as instruções para cada plataforma:

---

### 1. Cursor IDE

- **🔌 Passo 1 (MCP):** No diretório do seu projeto ou global (`~/.cursor/mcp.json`), configure o arquivo `.cursor/mcp.json`:
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

- **🧠 Passo 2 (Skill / Regras):** Copie o arquivo de regras em `connectors/cursor/modo-imparavel.mdc` para a pasta `.cursor/rules/` do seu projeto. O Cursor injetará automaticamente as regras operacionais em todas as conversas do assistente.

---

### 2. Claude (Anthropic)

#### Claude Code (CLI)
- **🔌 Passo 1 (MCP):** Adicione o servidor via terminal:
  ```bash
  claude mcp add --transport http modo-imparavel https://mcp.modoimparavel.site/mcp --header "Authorization: Bearer <SEU_PAT_AQUI>"
  ```
- **🧠 Passo 2 (Skill):** Copie o arquivo `skill/SKILL.md` para o diretório de skills do Claude:
  ```bash
  mkdir -p ~/.claude/skills/modo-imparavel
  cp skill/SKILL.md ~/.claude/skills/modo-imparavel/
  ```
  *(Ou adicione uma referência ao `skill/SKILL.md` no arquivo `CLAUDE.md` do seu projeto).*

#### Claude Desktop
- **🔌 Passo 1 (MCP):** Adicione no seu arquivo `claude_desktop_config.json`:
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
- **🧠 Passo 2 (Skill):** Nas **Instruções Personalizadas** (ou no System Prompt do seu Projeto no Claude), cole o conteúdo de `skill/SKILL.md`.

---

### 3. Hermes Agent (Nous Research)

- **🔌 Passo 1 (MCP):** No terminal da sua VPS ou máquina local, adicione o servidor:
  ```bash
  hermes mcp add modo-imparavel --url https://mcp.modoimparavel.site/mcp --auth header
  ```
  *(O Hermes perguntará se precisa de autenticação [Enter] e solicitará seu Token PAT).*
  
  *Ou cole diretamente em `~/.hermes/config.yaml`:*
  ```yaml
  mcp_servers:
    modo-imparavel:
      url: "https://mcp.modoimparavel.site/mcp"
      headers:
        Authorization: "Bearer <SEU_PAT_AQUI>"
  ```

- **🧠 Passo 2 (Skill):** Instale a skill em 1 comando com o gerenciador nativo do Hermes:
  ```bash
  hermes skills install https://raw.githubusercontent.com/twofxz/plugin-modo-imparavel/main/skill/SKILL.md -y
  ```

---

### 4. Antigravity (Google DeepMind)

- **🔌 Passo 1 (MCP):** No arquivo de configuração MCP do Antigravity (`mcp_config.json` ou painel de configurações):
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

- **🧠 Passo 2 (Skill):** Copie o arquivo `skill/SKILL.md` para o diretório de skills do Antigravity:
  ```bash
  mkdir -p ~/.gemini/antigravity/skills/modo-imparavel
  cp skill/SKILL.md ~/.gemini/antigravity/skills/modo-imparavel/
  ```

---

### 5. Codex (OpenAI)

- **🔌 Passo 1 (MCP):** Configure o servidor no seu arquivo `.codex/mcp.json` ou `mcp.json`:
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

- **🧠 Passo 2 (Skill):** Copie `skill/SKILL.md` para o diretório de skills do seu workspace:
  ```bash
  mkdir -p .codex/skills/modo-imparavel
  cp skill/SKILL.md .codex/skills/modo-imparavel/
  ```
  *(Ou referencie as regras no seu `AGENTS.md`).*

---

### 6. ChatGPT (Custom GPTs / Actions)

- **🔌 Passo 1 (Ação / Ferramentas):**
  1. No [ChatGPT](https://chatgpt.com), crie ou edite um **Custom GPT**.
  2. Em **Actions** > **Create new action**:
     - Em **Schema**, cole o conteúdo de `connectors/chatgpt/openapi.json`.
     - Em **Authentication**, escolha **API Key** -> **Bearer** e insira o seu PAT.
- **🧠 Passo 2 (Skill / Instruções):**
  - No campo **Instructions** do seu GPT, cole o conteúdo completo do arquivo `skill/SKILL.md`.

---

### 7. OpenCode & OpenClaw

#### OpenCode
- **🔌 Passo 1 (MCP):** Em `opencode.jsonc`:
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
- **🧠 Passo 2 (Skill):**
  ```bash
  mkdir -p .opencode/skills/modo-imparavel
  cp skill/SKILL.md .opencode/skills/modo-imparavel/
  ```

#### OpenClaw
- **🔌 Passo 1 (MCP):**
  ```bash
  openclaw mcp add modo-imparavel https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer <SEU_PAT_AQUI>"
  ```
- **🧠 Passo 2 (Skill):**
  ```bash
  mkdir -p ~/.openclaw/skills/modo-imparavel
  cp skill/SKILL.md ~/.openclaw/skills/modo-imparavel/
  ```

---

### 8. Grok (xAI) e DeepSeek (V3/R1)

Utilize os modelos Grok ou DeepSeek através de um dos harnesses suportados acima (**Cursor**, **Hermes Agent** ou **OpenCode**). 
Basta selecionar o modelo desejado no seu cliente; a conexão MCP e a Skill instaladas no harness garantirão que tanto o Grok quanto o DeepSeek executem as ferramentas com precisão e responsabilidade.

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
