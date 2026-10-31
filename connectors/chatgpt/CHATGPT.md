# Conexão com ChatGPT (Custom GPTs / Actions)

O ChatGPT Web conecta-se a serviços externos através de **Custom Actions**.

### Passo a Passo para Conectar:
1. Acesse o [ChatGPT](https://chatgpt.com) e crie ou edite um **Custom GPT**.
2. Na aba **Configure**:
   - Dê o nome de "Modo Imparável".
   - No campo **Instructions**, copie e cole todo o conteúdo do arquivo `skill/SKILL.md` deste repositório.
3. Role até a seção **Actions** e clique em **Create new action**.
4. Em **Schema**, copie e cole o conteúdo do arquivo `connectors/chatgpt/openapi.json`.
5. Em **Authentication**:
   - Selecione **API Key**.
   - Em **Auth Type**, escolha **Bearer**.
   - No campo **API Key**, cole o seu Personal Access Token (PAT) gerado no Modo Imparável: [https://app.modoimparavel.site/conexoes-mcp](https://app.modoimparavel.site/conexoes-mcp).
6. Salve o seu GPT. Agora o seu ChatGPT consegue consultar seu dia, registrar hábitos, finanças e anotações diretamente no Modo Imparável!
