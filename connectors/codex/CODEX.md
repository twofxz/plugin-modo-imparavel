# Codex CLI / extensão — MCP remoto

**Status: requer teste completo da versão e autenticação utilizada.**

Adicione o servidor usando a CLI ou a configuração suportada pela versão instalada:

```bash
codex mcp add modo-imparavel --url https://mcp.modoimparavel.site/mcp
codex mcp list
```

Para configuração manual, a documentação da OpenAI usa `~/.codex/config.toml` com uma seção `[mcp_servers.modo-imparavel]` e o campo `url`. Configure OAuth ou uma variável de ambiente para o bearer apenas de acordo com o suporte da sua versão. Não coloque credenciais em arquivos de projeto ou mensagens.

Uma skill opcional pode ser instalada no diretório apropriado ao ambiente. O MCP e a skill são componentes separados: instalar somente a skill não autentica nem conecta ferramentas. Teste leitura, ação, revogação e reconexão.

Fonte: https://developers.openai.com/learn/docs-mcp
