# Conexão com Grok e DeepSeek

**Status: Configuração manual / Não homologado nesta entrega.**

É essencial diferenciar dois cenários completamente distintos:

---

### Cenário 1: Modelos Grok ou DeepSeek dentro de um Cliente / Harness MCP (Recomendado)
A forma funcional de usar modelos como **Grok (xAI)** ou **DeepSeek (V3/R1)** com o Modo Imparável é executando esses modelos como o *motor de inferência (LLM provider)* dentro de um cliente MCP compatível:
- **Cursor IDE:** Selecione o modelo (ex: `deepseek-v3`, `deepseek-r1` ou `grok-2`) e utilize a configuração MCP do Cursor (`install.ps1` ou `connectors/cursor/mcp.json`).
- **OpenCode:** Configure seu `opencode.jsonc` com a chave do provedor do modelo e o servidor MCP do Modo Imparável.
- **Hermes Agent (Nous Research):** Configure o Hermes com o endpoint LLM da xAI ou DeepSeek enquanto mantém o servidor MCP conectado.

Neste cenário, a conexão MCP é realizada pelo cliente host, e o modelo apenas consome as ferramentas fornecidas.

---

### Cenário 2: Aplicativo Web ou Nativo Próprio do Provedor (x.com / deepseek.com)
Interfaces web padrão de terceiros não homologaram o protocolo MCP remoto com autenticação personalizada nesta versão:
- Não cole seu Personal Access Token (PAT) nem credenciais em prompts ou chats web abertos.
- Se a interface oferecer suporte a Instruções Personalizadas / System Prompts, você pode colar as orientações conceituais de `skill/SKILL.md` como diretriz textual. No entanto, sem um cliente MCP ativo, o modelo não terá acesso a chamadas de ferramentas em tempo real nem aos seus dados no Modo Imparável.
- Qualquer suporte nativo futuro nos aplicativos oficiais dependerá da disponibilização oficial de suporte a servidores MCP remotos pelos fornecedores.
