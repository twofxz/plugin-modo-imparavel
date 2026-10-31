# Conexão com Grok (xAI) e DeepSeek

Os modelos **Grok (xAI)** e **DeepSeek (V3/R1)** podem operar o Modo Imparável através de três métodos principais:

### 1. Via Harness / Ambiente de Desenvolvimento (Cursor, OpenCode, Hermes) — Recomendado
A forma mais produtiva e avançada de usar Grok ou DeepSeek com o Modo Imparável é selecionando esses modelos dentro de um cliente MCP nativo:
- **Cursor IDE:** Selecione o modelo (ex: `deepseek-v3`, `claude-3.5-sonnet` ou `grok`) e utilize a configuração MCP de `connectors/cursor/mcp.json`.
- **Hermes Agent (Nous Research):** Configure o Hermes para usar DeepSeek ou Grok como provedor LLM em `~/.hermes/config.yaml` enquanto mantém o MCP do Modo Imparável ativo. O Hermes chamará as ferramentas autonomamente.
- **OpenCode:** Configure seu arquivo `opencode.jsonc` apontando para o modelo desejado.

### 2. Na Interface Web (Instruções Customizadas de Sistema)
Se você estiver utilizando a interface web direta do Grok ou DeepSeek:
1. Abra as Configurações de Instrução Customizada / Prompt de Sistema do seu chat.
2. Cole o conteúdo de `skill/SKILL.md` como diretriz operacional do modelo.
3. Nota: Para execução em tempo real de chamadas no banco, utilize os harnesses da Opção 1 que conectam no protocolo MCP em tempo real.
