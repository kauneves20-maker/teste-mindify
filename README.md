# Twenty CRM - Easypanel Edition

[![License: AGPL-3.0](https://img.shields.io/badge/License-AGPL%203.0-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Node.js](https://img.shields.io/badge/Node.js-18%2B-green.svg)](https://nodejs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)

Twenty CRM otimizado para deployment automático no Easypanel com funcionalidades customizadas de pastas, arquivos e notas com links públicos.

## 🎯 Funcionalidades

### ✨ Sistema de Pastas
- Criar pastas hierárquicas
- Organizar em estrutura de árvore
- Renomear e atualizar descrição
- Deletar com cascata de arquivos

### 🔗 Links Públicos
- Gerar token único para cada pasta
- Compartilhar sem necessidade de login
- Acesso público controlado
- Log de auditoria de acessos

### 📁 Gerenciamento de Arquivos
- Upload com validação
- Armazenamento local ou S3
- Preview de imagens
- Download de arquivos
- Compressão automática

### 📝 Notas Vinculadas
- Criar notas com pasta automática
- Vincular a pastas existentes
- Editar conteúdo
- Visualizar pasta associada

### 🔐 Segurança
- Autenticação JWT
- Verificação de workspace
- Níveis de permissão (view, edit, admin)
- Row Level Security (RLS)
- Rate limiting

## 🚀 Deploy Rápido no Easypanel

### Pré-requisitos
- Conta no Easypanel
- Domínio configurado
- Banco de dados PostgreSQL (gerenciado ou externo)

### Passo 1: Importar Repositório

1. Acesse o painel do Easypanel
2. Clique em **Create Project**
3. Selecione **GitHub**
4. Escolha este repositório (`twenty-crm-easypanel`)
5. Clique em **Connect**

### Passo 2: Configurar Variáveis de Ambiente

No painel do Easypanel, vá para **Settings** → **Environment Variables** e adicione:

```bash
# Obrigatórias
DATABASE_URL=postgresql://usuario:senha@seu-postgres-host:5432/twenty_crm
PG_DATABASE_URL=postgresql://usuario:senha@seu-postgres-host:5432/twenty_crm
NODE_ENV=production
APP_SECRET=gerar_com_openssl_rand_base64_32
FRONTEND_URL=https://seu-dominio.com
SERVER_URL=https://seu-dominio.com/api

# Opcionais
STORAGE_TYPE=local
STORAGE_LOCAL_PATH=.local-storage
IS_WORKSPACE_CREATION_LIMITED_TO_SERVER_ADMINS=false
AUTH_PASSWORD_ENABLED=true
IS_MULTIWORKSPACE_ENABLED=true
```

### Passo 3: Fazer Deploy

1. Clique em **Deploy**
2. Aguarde o build (15-20 minutos)
3. Acesse sua aplicação quando estiver pronto

## 📋 Estrutura do Repositório

```
.
├── Dockerfile                  # Build otimizado para Easypanel
├── nixpacks.toml              # Configuração Nixpacks (detecção automática)
├── package.json               # Scripts de build
├── .env.example               # Variáveis de ambiente
├── README.md                  # Este arquivo
├── DEPLOYMENT.md              # Guia de deployment detalhado
├── scripts/
│   └── init-easypanel.sh      # Script de inicialização
├── sql/
│   ├── init.sql               # Inicialização do PostgreSQL
│   ├── create-tables.sql      # Tabelas customizadas
│   └── create-indexes.sql     # Índices para performance
├── .dockerignore               # Arquivos ignorados no build
├── .gitignore                  # Arquivos ignorados no git
└── packages/                   # Código-fonte do Twenty (não incluído)
    ├── twenty-server/          # Backend NestJS
    ├── twenty-front/           # Frontend React
    └── ...
```

## 🔧 Configuração

### Variáveis Obrigatórias

| Variável | Descrição | Exemplo |
|----------|-----------|---------|
| `DATABASE_URL` | URL de conexão PostgreSQL | `postgresql://user:pass@host:5432/db` |
| `NODE_ENV` | Ambiente | `production` |
| `APP_SECRET` | Secret da aplicação | `gerar_com_openssl_rand_base64_32` |
| `FRONTEND_URL` | URL do frontend | `https://seu-dominio.com` |
| `SERVER_URL` | URL da API | `https://seu-dominio.com/api` |

### Variáveis Opcionais

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `STORAGE_TYPE` | `local` | Tipo de armazenamento |
| `STORAGE_LOCAL_PATH` | `.local-storage` | Caminho de armazenamento |
| `EMAIL_DRIVER` | `logger` | Driver de email |
| `IS_MULTIWORKSPACE_ENABLED` | `true` | Habilitar múltiplos workspaces |

## 🗄️ Banco de Dados

### Criar Banco de Dados

#### Opção 1: Usar Banco Gerenciado do Easypanel

1. No Easypanel, vá para **Databases**
2. Clique em **Create Database**
3. Selecione **PostgreSQL**
4. Configure e copie a URL

#### Opção 2: Usar PostgreSQL Externo

1. Crie um banco de dados: `twenty_crm`
2. Execute os scripts SQL:
   ```bash
   psql $DATABASE_URL < sql/init.sql
   psql $DATABASE_URL < sql/create-tables.sql
   psql $DATABASE_URL < sql/create-indexes.sql
   ```

## 🔑 Gerar APP_SECRET

```bash
# No seu computador
openssl rand -base64 32

# Copie o resultado e adicione em Environment Variables
```

## 📈 Build e Deploy

### Build Command (Automático)
```bash
yarn install && yarn build
```

### Start Command (Automático)
```bash
node dist/packages/twenty-server/src/main.js
```

### Port
```
3000
```

## ✅ Verificar Deploy

### Após o Deploy

1. Acesse o painel do Easypanel
2. Vá para seu projeto
3. Verifique o status em **Deployments**

### Testar Aplicação

```bash
# Health check
curl https://seu-dominio.com/healthz

# Acessar aplicação
https://seu-dominio.com
```

## 📚 Documentação

- **DEPLOYMENT.md** - Guia completo de deployment
- **CONTRIBUTING.md** - Guia de contribuição
- [Twenty Documentation](https://docs.twenty.com)
- [Easypanel Documentation](https://easypanel.io/docs)

## 🆘 Troubleshooting

### Erro: "Build failed"

```
Solução:
1. Verifique se package.json está na raiz
2. Verifique se nixpacks.toml está correto
3. Consulte os logs de build
4. Certifique-se de que yarn.lock existe
```

### Erro: "Connection refused"

```
Solução:
1. Verifique DATABASE_URL
2. Teste a conexão: psql $DATABASE_URL
3. Certifique-se de que o banco está acessível
```

### Erro: "Out of memory"

```
Solução:
1. Aumente a memória do container
2. Otimize as queries
3. Implemente cache
```

## 🔐 Segurança

### Checklist

- [ ] Mude a senha do PostgreSQL
- [ ] Use APP_SECRET forte (32+ caracteres)
- [ ] HTTPS é automático no Easypanel
- [ ] Configure firewall do banco
- [ ] Monitore logs regularmente
- [ ] Faça backups regulares

## 📊 Monitoramento

No painel do Easypanel:

1. **Logs** - Ver logs de aplicação
2. **Monitoring** - Ver recursos (CPU, Memória, Disco)
3. **Deployments** - Ver histórico de deploys

## 💾 Backup

### Backup do Banco de Dados

```bash
# Via Easypanel
# Vá para Databases → Backups

# Ou manualmente
pg_dump $DATABASE_URL > backup.sql
```

### Restaurar Backup

```bash
psql $DATABASE_URL < backup.sql
```

## 🔄 Atualizar Aplicação

Quando quiser fazer deploy de uma nova versão:

```bash
git add .
git commit -m "Update Twenty CRM"
git push origin main
```

O Easypanel fará deploy automaticamente (se auto-deploy estiver habilitado).

## 📝 Notas Importantes

1. **Domínio**: Certifique-se de que seu domínio aponta para o Easypanel
2. **Banco de Dados**: Use um banco gerenciado ou externo
3. **Variáveis**: Todas as variáveis obrigatórias devem estar configuradas
4. **Build**: O primeiro build pode levar 15+ minutos
5. **SSL**: HTTPS é automático no Easypanel

## 🎯 Próximos Passos

1. ✅ Importar repositório no Easypanel
2. ✅ Criar banco de dados
3. ✅ Configurar variáveis de ambiente
4. ✅ Fazer deploy
5. ✅ Criar primeira conta
6. ✅ Criar workspace
7. ✅ Testar funcionalidades
8. ✅ Configurar backups

## 📄 Licença

Twenty CRM é open-source sob licença **AGPL-3.0**.

Veja [LICENSE](LICENSE) para detalhes completos.

## 🤝 Contribuindo

Contribuições são bem-vindas! Veja [CONTRIBUTING.md](CONTRIBUTING.md) para detalhes.

## 📞 Suporte

Para problemas ou dúvidas:

1. Consulte [DEPLOYMENT.md](DEPLOYMENT.md)
2. Verifique os logs no Easypanel
3. Consulte [Twenty Docs](https://docs.twenty.com)
4. Consulte [Easypanel Docs](https://easypanel.io/docs)

## 🙏 Agradecimentos

- [Twenty](https://twenty.com) - CRM open-source
- [Easypanel](https://easypanel.io) - Plataforma de deployment
- [PostgreSQL](https://www.postgresql.org/) - Banco de dados

---

**Versão**: 1.0  
**Data**: 27 de Fevereiro de 2026  
**Status**: ✅ Pronto para Easypanel  
**Última Atualização**: 2026-02-27
