# Política de Segurança e Privacidade — Plugin Modo Imparável

A segurança dos seus dados, rotinas e finanças é o pilar central da arquitetura do **Modo Imparável**.

Este repositório é público para permitir que a comunidade e os assinantes conectem facilmente seus agentes de Inteligência Artificial favoritos via **Model Context Protocol (MCP)**. No entanto, o acesso aos dados da sua conta é estritamente privado, autenticado e criptografado.

---

## 1. Exclusividade e Autenticação Premium
- **Acesso Restrito:** O acesso às ferramentas do Modo Imparável exige uma conta com **assinatura ativa** no Modo Imparável.
- **Personal Access Token (PAT):** Para conectar seu agente (Cursor, Claude, Hermes, ChatGPT, etc.), você deve gerar um token PAT pessoal e intransferível no painel web ou aplicativo móvel:
  👉 [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections)
  *(Também disponível no aplicativo nativo Android e iOS na seção **Conexões MCP**)*
- **Token Hash SHA-256:** O servidor do Modo Imparável nunca armazena o seu token em texto puro. Apenas o hash SHA-256 criptográfico é persistido no banco de dados.

---

## 2. Regras Críticas para Repositórios e Configurações Públicas
- **NUNCA comite seu Token:** Nunca suba arquivos de configuração (`mcp.json`, `config.yaml`, `.env`) preenchidos com o seu token para o GitHub ou qualquer repositório público.
- **Use Variáveis de Ambiente:** Sempre que possível, utilize variáveis de ambiente locais (como `MODO_IMPARAVEL_PAT`) ou mantenha seus arquivos de configuração na pasta global da sua máquina (`~/.cursor/mcp.json`, `~/.hermes/config.yaml`).
- **Revogação Imediata:** Se você suspeitar que seu token foi exposto ou compartilhado por engano, acesse imediatamente [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections) (ou abra o app nativo na tela Conexões MCP) e clique em **Revogar Chave**. A revogação entra em vigor instantaneamente em todos os servidores.

---

## 3. Confirmação em Duas Etapas (Proteção Ativa contra Ações Acidentais)
O protocolo MCP do Modo Imparável foi desenhado para impedir que inteligências artificiais executem alterações financeiras ou exclusões de forma precipitada:
1. **Etapa 1 (Preparação):** Quando o agente deseja registrar uma despesa, receita, assinatura ou excluir um item, o servidor executa uma ferramenta `preparar_*`. Isso gera um resumo detalhado e um `token_confirmacao` temporário.
2. **Etapa 2 (Confirmação Explícita):** O agente é expressamente instruído a solicitar a sua autorização (apresentando os valores, categorias ou itens afetados). Somente após o seu "Sim", o agente chama a ferramenta `confirmar_*`.
3. Sem o consentimento explícito e o token de confirmação válido, nenhuma mutação sensível é gravada no banco de dados.

---

## 4. Reporte de Vulnerabilidades
Se você identificar qualquer vulnerabilidade de segurança neste conector ou no protocolo MCP do Modo Imparável:
- Não abra uma issue pública no GitHub com detalhes exploráveis.
- Entre em contato diretamente com a equipe de engenharia e segurança através do canal oficial de suporte em [suporte@modoimparavel.site](mailto:suporte@modoimparavel.site).
- Vulnerabilidades reportadas com responsabilidade serão analisadas e tratadas com máxima prioridade.
