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

### Opção 2: Via Comando CLI
No terminal do seu ambiente ou VPS onde o Hermes está instalado:

```bash
hermes mcp add --name modo-imparavel --url https://mcp.modoimparavel.site/mcp --headers "Authorization=Bearer <SEU_PAT_AQUI>"
```

### Instalação da Skill no Hermes
Copie a pasta `skill/` deste repositório para o diretório de skills do Hermes:
```bash
mkdir -p ~/.hermes/skills/modo-imparavel
cp skill/SKILL.md ~/.hermes/skills/modo-imparavel/
```
