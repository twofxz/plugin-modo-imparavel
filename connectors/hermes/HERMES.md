# Conexão com Hermes Agent (Nous Research)

**Status: Configuração manual / Não homologado nesta entrega.** Requer teste completo de conexão, leitura, ação autorizada, revogação e reconexão na versão utilizada pelo cliente.

O **Hermes Agent** conecta-se via MCP através de duas configurações:

### Opção 1: Via Arquivo de Configuração (Recomendado)
Adicione o seguinte bloco no seu arquivo `~/.hermes/config.yaml`:

```yaml
mcp_servers:
  modo-imparavel:
    url: "https://mcp.modoimparavel.site/mcp"
    headers:
      Authorization: "Bearer ${MODO_IMPARAVEL_PAT}"
```

> ⚠️ **Atenção:** Mantenha suas credenciais protegidas em variáveis de ambiente. Não suba arquivos `config.yaml` com tokens em texto puro para repositórios públicos.

### Opção 2: Via Comando CLI Oficial do Hermes
No terminal da máquina onde o Hermes está instalado:

```bash
hermes mcp add modo-imparavel --url https://mcp.modoimparavel.site/mcp --auth header
```
Ao ser solicitado:
1. `Does this server require authentication?` -> **Yes**
2. `API key / Bearer token:` -> Forneça a variável ou token PAT emitido no painel de [Conexões MCP](https://modoimparavel.site/mcp/connections).

### Instalação da Skill no Hermes
Para instalar a skill no gerenciador nativo do Hermes:

```bash
hermes skills install https://raw.githubusercontent.com/twofxz/plugin-modo-imparavel/main/skill/SKILL.md
```

Para verificar se a skill está instalada:
```bash
hermes skills list
```
Lembre-se: a instalação da skill é complementar e não substitui a conexão MCP nem a validação do servidor.
