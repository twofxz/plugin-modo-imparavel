# Política de Segurança e Privacidade — Plugin Modo Imparável

A segurança dos seus dados, rotinas e finanças é o pilar central da arquitetura do **Modo Imparável**.

Este repositório é público para permitir que a comunidade e os assinantes conectem facilmente seus agentes de Inteligência Artificial favoritos via **Model Context Protocol (MCP)**. No entanto, o acesso aos dados da sua conta é estritamente privado, autenticado e criptografado.

---

## 1. Exclusividade e Autenticação Premium
- **Acesso Restrito:** O acesso às ferramentas do Modo Imparável exige uma conta com **assinatura ativa** no Modo Imparável.
- **Personal Access Token (PAT):** Para conectar seu agente (Cursor, Claude, Hermes, ChatGPT, etc.), você deve gerar um token PAT pessoal e intransferível no painel web ou aplicativo móvel:
  👉 [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections)
  *(Também disponível no aplicativo nativo Android e iOS na seção **Conexões MCP**)*
- **Armazenamento e Criptografia:** Tokens novos são protegidos autoritativamente por hash criptográfico SHA-256 no banco de dados. O servidor nunca armazena o token em texto puro. Nunca compartilhe seu token e revogue imediatamente qualquer chave suspeita de vazamento.

---

## 2. Regras Críticas para Repositórios e Configurações Públicas
- **NUNCA comite seu Token:** Nunca suba arquivos de configuração (`mcp.json`, `config.yaml`, `.env`) preenchidos com o seu token para o GitHub ou qualquer repositório público.
- **Use Variáveis de Ambiente:** Sempre utilize variáveis de ambiente locais (como `MODO_IMPARAVEL_PAT`) ou mantenha seus arquivos de configuração na pasta global da sua máquina (`~/.cursor/mcp.json`, `~/.hermes/config.yaml`), garantindo que estejam ignorados pelo `.gitignore`.
- **Revogação Imediata:** Se você suspeitar que seu token foi exposto ou compartilhado por engano, acesse imediatamente [https://modoimparavel.site/mcp/connections](https://modoimparavel.site/mcp/connections) (ou abra o app nativo na tela Conexões MCP) e clique em **Revogar Chave**. A revogação entra em vigor instantaneamente em todos os servidores e gateways.

---

## 3. Confirmação em Duas Etapas (Proteção Ativa contra Ações Acidentais)
O protocolo MCP do Modo Imparável foi desenhado para impedir que agentes de inteligência artificial executem alterações financeiras ou exclusões de forma precipitada ou autônoma:
1. **Etapa 1 (Preparação):** Quando o agente deseja registrar uma despesa, receita, assinatura ou excluir um item, o servidor executa uma ferramenta `preparar_*`. Isso gera um resumo detalhado e um identificador temporário de confirmação (`confirmation_id` ou `confirmation_token`).
2. **Etapa 2 (Confirmação Explícita):** O agente é expressamente instruído a solicitar a sua autorização (apresentando os valores, categorias ou itens afetados). Somente após o seu consentimento explícito, o agente chama a ferramenta `confirmar_*` com o identificador correspondente.
3. **Validação do Servidor:** A presença das instruções na skill orienta o modelo, mas não substitui a validação técnica no backend. O servidor valida a autoridade da sessão, expiração de tokens e permissões antes de qualquer escrita.

---

## 4. Reporte de Vulnerabilidades
Se você identificar qualquer vulnerabilidade de segurança neste conector ou no protocolo MCP do Modo Imparável:
- Não abra uma issue pública no GitHub com detalhes exploráveis.
- Entre em contato diretamente com a equipe de engenharia e segurança através do canal oficial de suporte em [suporte@modoimparavel.site](mailto:suporte@modoimparavel.site).
- Vulnerabilidades reportadas com responsabilidade serão analisadas e tratadas com máxima prioridade.
