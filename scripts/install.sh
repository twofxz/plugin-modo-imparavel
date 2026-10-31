#!/usr/bin/env bash
# ==============================================================================
# Modo Imparável — Instalador Universal de MCP para Agentes de IA
# Endpoint Oficial: https://mcp.modoimparavel.site/mcp
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

MCP_URL="https://mcp.modoimparavel.site/mcp"
TARGET=""
PAT_TOKEN=""

echo -e "${BOLD}${BLUE}======================================================${NC}"
echo -e "${BOLD}${BLUE}       MODO IMPARÁVEL — INSTALADOR MCP UNIVERSAL      ${NC}"
echo -e "${BOLD}${BLUE}======================================================${NC}"
echo -e "Conecte sua IA favorita ao Modo Imparável em segundos.\n"

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --token) PAT_TOKEN="$2"; shift ;;
        --target) TARGET="$2"; shift ;;
        *) echo -e "${YELLOW}Aviso: Argumento desconhecido ignorado: $1${NC}" ;;
    esac
    shift
done

# Check token
if [ -z "$PAT_TOKEN" ]; then
    if [ -n "$MODO_IMPARAVEL_PAT" ]; then
        PAT_TOKEN="$MODO_IMPARAVEL_PAT"
    else
        echo -e "${YELLOW}Para conectar, você precisa do seu Personal Access Token (PAT).${NC}"
        echo -e "Gere sua chave em: ${BOLD}https://modoimparavel.site/conexoes-mcp${NC}\n"
        read -s -p "Cole seu Token PAT aqui e pressione ENTER: " PAT_TOKEN
        echo ""
    fi
fi

if [ -z "$PAT_TOKEN" ]; then
    echo -e "${RED}Erro: Token PAT não informado. Operação cancelada.${NC}"
    exit 1
fi

# Detect environments
install_hermes() {
    echo -e "\n${BLUE}Configurando Hermes Agent...${NC}"
    HERMES_DIR="$HOME/.hermes"
    CONFIG_FILE="$HERMES_DIR/config.yaml"
    mkdir -p "$HERMES_DIR"

    # Se comando hermes estiver disponível no PATH, usar hermes mcp add
    if command -v hermes &> /dev/null; then
        hermes mcp add --name modo-imparavel --url "$MCP_URL" --headers "Authorization=Bearer $PAT_TOKEN" 2>/dev/null || true
    fi

    # Garante entrada no config.yaml
    if [ ! -f "$CONFIG_FILE" ]; then
        cat <<EOF > "$CONFIG_FILE"
mcp_servers:
  modo-imparavel:
    url: "$MCP_URL"
    headers:
      Authorization: "Bearer $PAT_TOKEN"
EOF
    else
        # Se mcp_servers não existir, adiciona
        if ! grep -q "modo-imparavel:" "$CONFIG_FILE"; then
            if ! grep -q "mcp_servers:" "$CONFIG_FILE"; then
                echo "mcp_servers:" >> "$CONFIG_FILE"
            fi
            cat <<EOF >> "$CONFIG_FILE"
  modo-imparavel:
    url: "$MCP_URL"
    headers:
      Authorization: "Bearer $PAT_TOKEN"
EOF
        else
            echo -e "${YELLOW}Entrada 'modo-imparavel' já existente em $CONFIG_FILE.${NC}"
        fi
    fi

    # Instala a skill no Hermes se existir a pasta skill
    if [ -f "skill/SKILL.md" ]; then
        mkdir -p "$HERMES_DIR/skills/modo-imparavel"
        cp "skill/SKILL.md" "$HERMES_DIR/skills/modo-imparavel/"
        echo -e "${GREEN}✓ Skill do Modo Imparável instalada em $HERMES_DIR/skills/modo-imparavel/${NC}"
    fi

    echo -e "${GREEN}✓ Hermes Agent configurado com sucesso!${NC}"
}

install_claude() {
    echo -e "\n${BLUE}Configurando Claude Code...${NC}"
    if command -v claude &> /dev/null; then
        claude mcp add --transport http modo-imparavel "$MCP_URL" --header "Authorization: Bearer $PAT_TOKEN"
        echo -e "${GREEN}✓ Claude Code configurado com sucesso via CLI!${NC}"
    else
        echo -e "${YELLOW}Claude CLI não encontrado no PATH. Gerando arquivo local claude_desktop_config.json...${NC}"
        cat <<EOF > claude_desktop_config.json
{
  "mcpServers": {
    "modo-imparavel": {
      "url": "$MCP_URL",
      "headers": {
        "Authorization": "Bearer $PAT_TOKEN"
      }
    }
  }
}
EOF
        echo -e "${GREEN}✓ Arquivo claude_desktop_config.json gerado no diretório atual.${NC}"
    fi
}

install_cursor() {
    echo -e "\n${BLUE}Configurando Cursor IDE...${NC}"
    mkdir -p .cursor
    cat <<EOF > .cursor/mcp.json
{
  "mcpServers": {
    "modo-imparavel": {
      "url": "$MCP_URL",
      "headers": {
        "Authorization": "Bearer $PAT_TOKEN"
      }
    }
  }
}
EOF
    if [ -f "connectors/cursor/modo-imparavel.mdc" ]; then
        mkdir -p .cursor/rules
        cp connectors/cursor/modo-imparavel.mdc .cursor/rules/
    fi
    echo -e "${GREEN}✓ Cursor IDE configurado em .cursor/mcp.json!${NC}"
}

install_opencode() {
    echo -e "\n${BLUE}Configurando OpenCode...${NC}"
    cat <<EOF > opencode.jsonc
{
  "\$schema": "https://opencode.ai/config.json",
  "mcp": {
    "servers": {
      "modo-imparavel": {
        "type": "remote",
        "url": "$MCP_URL",
        "headers": {
          "Authorization": "Bearer $PAT_TOKEN"
        }
      }
    }
  }
}
EOF
    echo -e "${GREEN}✓ OpenCode configurado em opencode.jsonc!${NC}"
}

# Execution routing
case "$TARGET" in
    hermes) install_hermes ;;
    claude) install_claude ;;
    cursor) install_cursor ;;
    opencode) install_opencode ;;
    *)
        # Auto-detect or offer menu
        DETECTED=0
        if [ -d "$HOME/.hermes" ] || command -v hermes &> /dev/null; then
            install_hermes
            DETECTED=1
        fi
        if command -v claude &> /dev/null; then
            install_claude
            DETECTED=1
        fi
        if [ -d ".cursor" ]; then
            install_cursor
            DETECTED=1
        fi
        if [ $DETECTED -eq 0 ]; then
            echo -e "${YELLOW}Nenhum ambiente foi detectado automaticamente. Instalando configuração local do Cursor e Hermes...${NC}"
            install_cursor
            install_hermes
        fi
        ;;
esac

echo -e "\n${BOLD}${GREEN}======================================================${NC}"
echo -e "${BOLD}${GREEN}   CONEXÃO COM O MODO IMPARÁVEL PRONTA PARA USO!     ${NC}"
echo -e "${BOLD}${GREEN}======================================================${NC}"
echo -e "Agora sua IA já consegue consultar seu dia, registrar hábitos, finanças e muito mais.\n"
