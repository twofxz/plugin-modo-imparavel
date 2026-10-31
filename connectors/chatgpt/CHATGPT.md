# ChatGPT web — servidor MCP personalizado

**Status: requer teste completo com uma nova conta.** O acesso depende das permissões da conta e do workspace.

1. Em Plugins, selecione **Adicionar servidor MCP personalizado**.
2. Informe o nome e a URL `https://mcp.modoimparavel.site/mcp`.
3. Selecione OAuth e use o registro de cliente apresentado pelo servidor; se necessário, registre o callback exato mostrado pelo ChatGPT.
4. Entre na conta Modo Imparável, escolha as permissões, autorize e instale o plugin.
5. Em uma conversa, selecione-o e solicite uma leitura. Para finalizar a homologação, teste uma ação autorizada, revogação e reconexão.

Não cole um PAT em conversa. Custom GPT Actions e o arquivo OpenAPI são um caminho diferente e não estão homologados. Referência: https://developers.openai.com/api/docs/guides/custom-mcp-server
