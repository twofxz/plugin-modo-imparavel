---
name: modo-imparavel
description: Skill oficial para agentes de IA operarem e interagirem com o Modo Imparável via Model Context Protocol (MCP).
version: 1.0.0
---

# Skill Oficial — Modo Imparável MCP

Esta skill instrui o agente de inteligência artificial a interagir com o ecossistema do **Modo Imparável** através das ferramentas fornecidas pelo servidor MCP oficial em `https://mcp.modoimparavel.site/mcp`.

---

## 1. Princípios de Operação

1. **Gating de Assinatura Premium:** O acesso às ferramentas exige um Personal Access Token (PAT) válido emitido em `https://modoimparavel.site/conexoes-mcp`. Sem esse token, as chamadas falham com 401.
2. **Confirmação em Duas Etapas:** O agente NUNCA deve executar ações financeiras de mutação ou exclusões de itens diretamente. Deve sempre chamar a ferramenta de preparação (`preparar_*`), apresentar o resumo ao usuário, solicitar sua confirmação explícita e somente então invocar `confirmar_*`.
3. **Formato de Datas:** Sempre utilize datas no formato canônico `YYYY-MM-DD` (ex: `2026-10-31`).
4. **Idempotência:** Em requisições de criação ou preparação, forneça `idempotency_key` quando solicitado para evitar duplicações em reenvios de rede.

---

## 2. Catálogo Oficial das 21 Ferramentas

### 📅 Planejamento, Hábitos e Rotinas
- `consultar_dia`: Consulta metas, hábitos, rotinas e avaliações de uma data (`date: YYYY-MM-DD`).
- `consultar_semana`: Retorna o panorama semanal consolidado do usuário (`date: YYYY-MM-DD`).
- `criar_planejamento`: Cria uma nova meta, hábito ou rotina.
  - Parâmetros: `entity` ('goal'|'habit'|'routine'), `title`, `description`, `priority` ('baixa'|'media'|'alta'), `frequency` ('daily'|'weekly'|'once'|'monthly'), `days_of_week` (array de inteiros, 0=domingo), `date` ou `time`.
- `concluir_planejamento`: Marca um item como concluído na data informada (`item_id`, `item_type`, `date`).

### 💧 Saúde e Hidratação
- `consultar_saude`: Consulta registros de consumo de água, treinos e resumo de bem-estar da data (`date: YYYY-MM-DD`).
- `registrar_agua`: Registra consumo de água em mililitros (`amount_ml: integer` entre 50 e 5000, `date: YYYY-MM-DD`).

### 🥗 Alimentação e Nutrição
- `consultar_alimentacao`: Consulta histórico de refeições e calorias da data (`date: YYYY-MM-DD`).
- `propor_refeicao`: Prepara e sugere uma refeição estruturada (itens, gramas, calorias e macronutrientes) para aprovação.
- `salvar_refeicao`: Persiste uma proposta ativa de refeição após confirmação explícita (`message_id`, `confirmation_token`).

### ⏰ Lembretes
- `criar_lembrete`: Agenda um lembrete com notificação no sistema (`mensagem: string`, `data_hora: ISO 8601`).

### 💰 Finanças Pessoais (Protocolo de 2 Etapas)
- `consultar_financas`: Retorna o resumo financeiro (saldo, receitas, despesas, faturas e fluxo do mês).
- `preparar_receita`: Prepara o registro de uma receita (`valor`, `descricao`, `categoria`, `data`, `conta_id`). Retorna `token_confirmacao`.
- `preparar_despesa`: Prepara o registro de uma despesa (`valor`, `descricao`, `categoria`, `data`, `conta_id`). Retorna `token_confirmacao`.
- `preparar_assinatura`: Prepara o cadastro de um serviço recorrente (`nome`, `valor`, `dia_vencimento`, `categoria`). Retorna `token_confirmacao`.
- `preparar_pagamento_assinatura`: Prepara a baixa de uma assinatura mensal. Retorna `token_confirmacao`.
- `confirmar_financas`: Executa e consolida a transação preparada usando o `token_confirmacao` após autorização expressa do usuário.

### 📝 Caderno e Anotações
- `listar_pastas_notas`: Lista as pastas de anotações disponíveis no caderno do usuário.
- `consultar_notas`: Consulta notas de uma pasta específica ou busca notas por termo (`folder_id`, `termo_busca`).
- `criar_nota`: Cria uma nova nota ou anotação rápida (`titulo`, `conteudo`, `folder_id` opcional).

### 🗑️ Exclusão Segura (Protocolo de 2 Etapas)
- `preparar_exclusao`: Prepara a remoção de um item protegido (`entity_type`: meta, hábito, nota, transação; `entity_id`). Retorna `token_confirmacao` e detalhes do item que será apagado.
- `confirmar_exclusao`: Efetua a deleção definitiva após o consentimento claro do usuário.

---

## 3. Fluxo de Diálogo Obrigatório para Ações Críticas

### Exemplo: Registro de Despesa
```text
Usuário: "Gastei R$ 85,00 no almoço no cartão de crédito."
Agente:
1. Chama a tool `preparar_despesa(valor: 85.00, descricao: "Almoço", categoria: "Alimentação")`.
2. Servidor retorna: `{ token_confirmacao: "tok_123", resumo: "Despesa de R$ 85,00 em Alimentação" }`.
3. Agente responde ao usuário:
   "Preparei o registro de uma despesa de **R$ 85,00** em **Alimentação**. Posso confirmar o lançamento?"
4. Usuário: "Sim, pode confirmar."
5. Agente chama a tool `confirmar_financas(token_confirmacao: "tok_123")`.
6. Agente responde: "Pronto! Despesa registrada com sucesso no Modo Imparável."
```

### Exemplo: Exclusão de Hábito ou Meta
```text
Usuário: "Exclua o hábito de ler 10 páginas."
Agente:
1. Chama a tool `preparar_exclusao(entity_type: "habit", entity_id: "...")`.
2. Servidor retorna: `{ token_confirmacao: "del_456", item: "Ler 10 páginas", aviso: "Ação irreversível" }`.
3. Agente responde ao usuário:
   "Atenção: Você tem certeza que deseja excluir permanentemente o hábito **'Ler 10 páginas'**? Esta ação não pode ser desfeita."
4. Usuário: "Tenho certeza, pode apagar."
5. Agente chama a tool `confirmar_exclusao(token_confirmacao: "del_456")`.
6. Agente responde: "O hábito foi removido com sucesso."
```

---

## 4. Tratamento de Erros e Casos Especiais

- **Erro 401 (Unauthorized):** Informe amigavelmente o usuário de que seu Personal Access Token (PAT) expirou ou foi revogado, direcionando-o para [modoimparavel.site/conexoes-mcp](https://modoimparavel.site/conexoes-mcp).
- **Tool execution failed:** Verifique os parâmetros obrigatórios da ferramenta e formato de data (`YYYY-MM-DD`).
- **Token de Confirmação Expirado:** Se o usuário demorar muito para confirmar uma operação financeira, informe que o token de segurança expirou e prepare a operação novamente.
