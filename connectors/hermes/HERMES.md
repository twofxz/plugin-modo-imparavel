# Conexão com Hermes Agent (Nous Research)

O **Hermes Agent** conecta-se via MCP nativo de duas formas simples:

### Opção 1: Via Arquivo de Configuração (Recomendado)
Adicione o seguinte bloco no seu arquivo `~/.hermes/config.yaml`:

```yaml
mcp_servers:
  modo-imparavel:
    url: "https://mcp.modoimparavel.site/mcp"
    headers:
      Authorization: "Bearer <SEU_PAT_AQUI>"
```

### Opção 2: Via Comando CLI Oficial do Hermes
No terminal do seu ambiente ou VPS onde o Hermes está instalado, execute:

```bash
hermes mcp add modo-imparavel --url https://mcp.modoimparavel.site/mcp --auth header
```
O Hermes perguntará:
1. `Does this server require authentication?` -> Pressione **Enter** (Yes)
2. `API key / Bearer token:` -> Cole o seu Personal Access Token (`pat_...`) e pressione **Enter**.

### Instalação da Skill no Hermes

O Hermes possui um gerenciador nativo de skills. Basta rodar este comando único no terminal da VPS:

```bash
hermes skills install https://raw.githubusercontent.com/twofxz/plugin-modo-imparavel/main/skill/SKILL.md -y
```

O Hermes fará o download, executará o scanner de segurança automático e ativará a skill `modo-imparavel` imediatamente.

Para verificar se a skill está instalada e ativa:
```bash
hermes skills list
```
