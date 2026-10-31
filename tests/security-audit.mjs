/**
 * Auditoria Automatizada de Segurança e Sanitização — Plugin Modo Imparável
 * Executa verificação rigorosa antes de publicação do repositório público.
 */

import { readdirSync, statSync, readFileSync } from 'node:fs';
import { join, extname } from 'node:path';

const ROOT_DIR = process.cwd();
const FORBIDDEN_PATTERNS = [
  { name: 'Real PAT Token', regex: /pat_[0-9a-fA-F]{32,}/g },
  { name: 'Live Active Token (Hash/Key)', regex: /pat_624cee88|pat_441799/g },
  { name: 'JWT Service Role Key', regex: /eyJ[A-Za-z0-9_-]{30,}\.eyJ[A-Za-z0-9_-]{30,}\.[A-Za-z0-9_-]{30,}/g },
  { name: 'Postgres Connection String with Password', regex: /postgres:\/\/[^:]+:[^@]+@/g },
  { name: 'Hardcoded Bearer Secret', regex: /Bearer\s+([A-Za-z0-9_-]{30,})/g },
];

console.log('🔍 Iniciando Auditoria de Sanitização em:', ROOT_DIR);

let totalFiles = 0;
let errors = [];

function walk(dir) {
  const entries = readdirSync(dir);
  for (const entry of entries) {
    if (entry === '.git' || entry === 'node_modules') continue;
    const fullPath = join(dir, entry);
    const stat = statSync(fullPath);
    if (stat.isDirectory()) {
      walk(fullPath);
    } else if (stat.isFile()) {
      totalFiles++;
      auditFile(fullPath);
    }
  }
}

function auditFile(filePath) {
  const content = readFileSync(filePath, 'utf-8');
  const relativePath = filePath.replace(ROOT_DIR, '').replace(/^\\|\//, '');

  // Skip self from secret content inspection
  if (relativePath.includes('security-audit.mjs')) {
    return;
  }

  // 1. Check for Forbidden Secrets
  for (const { name, regex } of FORBIDDEN_PATTERNS) {
    const matches = content.match(regex);
    if (matches) {
      errors.push(`[VAZAMENTO DETECTADO] Arquivo: ${relativePath} | Padrão: ${name} | Ocorrência: ${matches[0].substring(0, 10)}...`);
    }
  }

  // 2. Syntax Validation for JSON files
  const ext = extname(filePath);
  if (ext === '.json') {
    try {
      JSON.parse(content);
    } catch (err) {
      errors.push(`[ERRO DE SINTAXE JSON] Arquivo: ${relativePath} | ${err.message}`);
    }
  } else if (ext === '.jsonc') {
    try {
      // Strip comments for basic validation
      const sanitized = content.replace(/\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm, '$1');
      JSON.parse(sanitized);
    } catch (err) {
      errors.push(`[ERRO DE SINTAXE JSONC] Arquivo: ${relativePath} | ${err.message}`);
    }
  }
}

walk(ROOT_DIR);

console.log(`\n📊 Arquivos escaneados: ${totalFiles}`);

if (errors.length > 0) {
  console.error('❌ AUDITORIA FALHOU! Foram encontrados os seguintes problemas:');
  errors.forEach((err) => console.error('  - ' + err));
  process.exit(1);
} else {
  console.log('✅ AUDITORIA CONCLUÍDA COM SUCESSO! 100% LIMPO.');
  console.log('   Nenhum token real, secret de banco ou vazamento detectado.');
  console.log('   Todos os arquivos JSON/JSONC possuem sintaxe válida.');
  process.exit(0);
}
