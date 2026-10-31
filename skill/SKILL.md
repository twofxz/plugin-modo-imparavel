---
name: modo-imparavel
description: Use para consultar e operar os dados autorizados do usuário no servidor MCP do Modo Imparável.
version: 1.1.0
---

# Modo Imparável: uso das ferramentas MCP

Use o servidor configurado em `https://mcp.modoimparavel.site/mcp`. A autenticação pode ser OAuth ou PAT conforme o cliente. Nunca peça, exponha ou inclua PAT, senha ou credenciais nos argumentos de ferramentas ou na conversa. O usuário administra conexões em `https://modoimparavel.site/mcp/connections`.

O schema anunciado pelo servidor no momento da chamada é a autoridade sobre nomes de argumentos e requisitos. Não invente nomes, IDs, resultados ou confirmações; consulte a ferramenta antes de agir. Use datas no formato canônico `YYYY-MM-DD`. Caso haja ambiguidade na identificação de um item, peça esclarecimento. Informe falhas sem afirmar que dados foram alterados.

## Aviso de Segurança e Validação de Autoridade
A presença, leitura ou execução desta skill não substitui a validação rigorosa de tipos, autorização, permissões e esquemas executada pelo servidor, nem comprova consentimento humano perante o backend. Qualquer mutação ou exclusão só é aceita pelo servidor após a emissão de uma transação de preparação válida e subsequente autorização de confirmação pelo proprietário da conta.

## Catálogo de Ferramentas e Parâmetros Canônicos

- **Planejamento, Hábitos e Rotinas:**
  - `consultar_dia`: `date` (opcional, formato `YYYY-MM-DD`). Retorna hábitos, rotinas e metas da data.
  - `consultar_semana`: `date` (opcional, formato `YYYY-MM-DD`). Retorna o panorama semanal consolidado.
  - `criar_planejamento`: Requer `title` (obrigatório, string). Parâmetros aceitos: `entity` ou `item_type` (`"habit"`, `"goal"`, `"routine"`), `title`, `description`, `priority`, `frequency`, `days_of_week`, `date`, `time`, `due_date`, `idempotency_key`.
  - `concluir_planejamento`: Parâmetros aceitos: `entity` ou `item_type`, `title`, `date`, `completion_scope`, `routine_ids`, `item_id`, `idempotency_key`.
  - `preparar_exclusao`: Parâmetros aceitos: `entity` ou `item_type` (`"habit"`, `"goal"`, `"routine"`), `title`, `item_id`, `idempotency_key`. Retorna resumo e identificador de confirmação. Exclusão restrita a metas, hábitos ou rotinas (não aplicável a notas ou transações financeiras).
  - `confirmar_exclusao`: Requer `confirmation_id` ou `confirmation_token` (e opcionalmente `entity` ou `item_type`).

- **Saúde e Hidratação:**
  - `consultar_saude`: `date` (opcional, formato `YYYY-MM-DD`). Retorna consumo de água e status de saúde.
  - `registrar_agua`: Requer `amount_ml` (obrigatório, inteiro entre 50 e 5000). Parâmetro opcional: `date` (`YYYY-MM-DD`).

- **Finanças (Duas Etapas Obrigatórias):**
  - `consultar_financas`: `month` (opcional, formato `YYYY-MM`). Retorna balanço mensal, receitas, despesas e assinaturas.
  - `preparar_receita`: Requer `description` (obrigatório, string) e `amount` (obrigatório, número positivo). Parâmetros aceitos: `date`, `transaction_date`, `payment_method`, `category_id`, `credit_card_id`, `notes`, `idempotency_key`. (Nota: utilize `description` e `amount`, nunca nomes em português como `descricao` ou `valor`).
  - `preparar_despesa`: Requer `description` (obrigatório, string) e `amount` (obrigatório, número positivo). Parâmetros aceitos: `date`, `transaction_date`, `payment_method`, `category_id`, `credit_card_id`, `notes`, `idempotency_key`. (Nota: utilize `description` e `amount`, nunca `descricao` ou `valor`).
  - `preparar_assinatura`: Requer `amount` (obrigatório, número) e `billing_day` (obrigatório, inteiro 1-31). Parâmetros aceitos: `name` ou `subscription_name`, `description`, `payment_method`, `start_month`, `commitment_type`, `category_id`, `credit_card_id`, `notes`, `idempotency_key`.
  - `preparar_pagamento_assinatura`: Parâmetros aceitos: `subscription_id`, `subscription_name`, `description`, `date`, `payment_date`, `competency_month`, `idempotency_key`.
  - `confirmar_financas`: Requer `confirmation_id` ou `confirmation_token` retornado na etapa de preparação.

- **Anotações:**
  - `listar_pastas_notas`: Sem parâmetros. Retorna estrutura de pastas autorizadas.
  - `consultar_notas`: Requer `query` (obrigatório, string). Parâmetros aceitos: `folder_path`, `folder_id`, `note_id`.
  - `criar_nota`: Requer `title` (obrigatório, string). Parâmetros aceitos: `content`, `content_md`, `folder_path`, `folder_id`, `idempotency_key`. Acesso restrito às pastas autorizadas pelo backend.

- **Nutrição:**
  - `consultar_alimentacao`: `date` (opcional, formato `YYYY-MM-DD`).
  - `propor_refeicao`: Requer `period` (obrigatório, string) e `items` (obrigatório, array de strings). Parâmetros aceitos: `date`, `meal_title`, `title`, `idempotency_key`. Requer consentimento nutricional prévio do usuário.
  - `salvar_refeicao`: Requer `message_id` (obrigatório) e `confirmation_id` ou `confirmation_token`.

- **Lembretes:**
  - `criar_lembrete`: Requer `mensagem` (obrigatório, string) e `data_hora` (obrigatório, formato ISO 8601 ex: `2026-10-31T14:30:00Z`).

- **Conhecimento Interno:**
  - `consultar_conhecimento`: Ferramenta marcada como indisponível no servidor até a validação do conteúdo e integração formal à base interna (não é anunciada no catálogo ativo).

## Regras de Confirmação em Duas Etapas

Para qualquer operação que envolva mutação financeira (`preparar_receita`, `preparar_despesa`, `preparar_assinatura`, `preparar_pagamento_assinatura`), exclusão de dados (`preparar_exclusao`) ou registro de refeição (`propor_refeicao`):
1. **Preparação:** Invoque sempre a ferramenta de preparação correspondente.
2. **Apresentação e Consentimento:** Apresente ao usuário o resumo detalhado retornado pelo servidor (valores, títulos, avisos de irreversibilidade) e aguarde sua autorização inequívoca.
3. **Confirmação:** Apenas após a confirmação expressa do usuário, invoque `confirmar_financas`, `confirmar_exclusao` ou `salvar_refeicao` com o `confirmation_id` ou `confirmation_token` obtido.
4. **Idempotência:** Quando aceito pelo schema, utilize `idempotency_key` consistente para evitar duplicações em retentativas.
5. Se uma confirmação expirar, reinicie o fluxo desde a etapa de preparação. Nunca invente tokens ou tente adivinhar identificadores.
