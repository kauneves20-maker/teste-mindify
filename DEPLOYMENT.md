# 🚀 Guia de Deployment - Twenty CRM no Easypanel

Guia completo e passo a passo para fazer deploy do Twenty CRM no Easypanel.

## 📋 Pré-requisitos

- ✅ Conta no Easypanel
- ✅ Domínio configurado
- ✅ Acesso ao GitHub
- ✅ Banco de dados PostgreSQL (gerenciado ou externo)

## 🎯 Passo 1: Preparar Banco de Dados

### Opção A: Usar Banco Gerenciado do Easypanel (Recomendado)

1. Acesse o painel do Easypanel
2. Vá para **Databases**
3. Clique em **Create Database**
4. Selecione **PostgreSQL**
5. Configure:
   - Nome: `twenty_crm`
   - Usuário: `postgres`
   - Senha: (gere uma senha forte)
6. Clique em **Create**
7. Copie a URL de conexão (aparecerá como `DATABASE_URL`)

### Opção B: Usar PostgreSQL Externo

Se você já tem um PostgreSQL rodando:

1. Certifique-se de que está acessível
2. Crie um banco de dados: `twenty_crm`
3. Crie um usuário com permissões
4. Anote a URL de conexão

## 🔑 Passo 2: Gerar APP_SECRET

Execute no seu computador:

```bash
openssl rand -base64 32
```

Copie o resultado. Você usará isso em breve.

## 🌐 Passo 3: Importar Repositório no Easypanel

### Via Interface Web

1. Acesse o painel do Easypanel
2. Clique em **Create Project**
3. Selecione **GitHub**
4. Procure por `twenty-crm-easypanel` (ou o nome do seu fork)
5. Selecione o repositório
6. Clique em **Connect**

### Autorizar GitHub (Primeira Vez)

Se for a primeira vez:

1. Clique em **Authorize Easypanel**
2. Faça login no GitHub
3. Autorize o acesso
4. Volte para o Easypanel

## 🔧 Passo 4: Configurar Variáveis de Ambiente

No painel do Easypanel, vá para **Settings** → **Environment Variables** e adicione:

### Variáveis Obrigatórias

```bash
DATABASE_URL=postgresql://usuario:senha@seu-postgres-host:5432/twenty_crm
PG_DATABASE_URL=postgresql://usuario:senha@seu-postgres-host:5432/twenty_crm
NODE_ENV=production
APP_SECRET=cole_o_resultado_do_openssl_rand_base64_32
FRONTEND_URL=https://seu-dominio.com
SERVER_URL=https://seu-dominio.com/api
```

### Variáveis Opcionais

```bash
STORAGE_TYPE=local
STORAGE_LOCAL_PATH=.local-storage
IS_WORKSPACE_CREATION_LIMITED_TO_SERVER_ADMINS=false
AUTH_PASSWORD_ENABLED=true
IS_MULTIWORKSPACE_ENABLED=true
LOGGER_DRIVER=console
LOG_LEVELS=error,warn
ORM_QUERY_LOGGING=disabled
```

## 🚀 Passo 5: Fazer Deploy

1. No painel do Easypanel, clique em **Deploy**
2. Aguarde o build começar
3. Você verá os logs do build em tempo real

## ⏳ Passo 6: Aguardar Build

O build pode levar **15-20 minutos** porque:

1. Instala todas as dependências (`yarn install`)
2. Faz build do backend (`yarn build:server`)
3. Faz build do frontend (`yarn build:front`)
4. Cria a imagem Docker

**NÃO CANCELE O BUILD!** Deixe completar.

### Monitorar Build

1. No painel do Easypanel, vá para seu projeto
2. Clique em **Deployments**
3. Veja o status em tempo real

## ✅ Passo 7: Verificar Deploy

### Após o Build Terminar

1. Acesse o painel do Easypanel
2. Vá para seu projeto
3. Verifique o status em **Deployments**
4. Deve mostrar "Running" ou "Deployed"

### Testar Health Check

```bash
# Testar se a aplicação está respondendo
curl https://seu-dominio.com/healthz

# Deve retornar: OK
```

### Acessar Aplicação

Abra no navegador:
```
https://seu-dominio.com
```

## 👤 Passo 8: Criar Primeira Conta

1. Acesse https://seu-dominio.com
2. Clique em **Sign Up**
3. Preencha os dados:
   - Email
   - Senha
   - Nome
4. Clique em **Create Account**

## 🏢 Passo 9: Criar Workspace

1. Após login, clique em **Create Workspace**
2. Preencha os dados:
   - Nome do Workspace
   - Descrição (opcional)
3. Clique em **Create**

## 🧪 Passo 10: Testar Funcionalidades

### Testar Pastas

1. No menu, vá para **Folders**
2. Clique em **Create Folder**
3. Preencha o nome
4. Clique em **Create**

### Testar Upload de Arquivo

1. Abra uma pasta
2. Clique em **Upload File**
3. Selecione um arquivo
4. Aguarde o upload

### Testar Link Público

1. Abra uma pasta
2. Clique em **Generate Public Link**
3. Copie o link
4. Abra em uma aba anônima (sem login)
5. Você deve ver a pasta e os arquivos

### Testar Notas

1. No menu, vá para **Notes**
2. Clique em **Create Note**
3. Preencha título e conteúdo
4. Uma pasta será criada automaticamente

## 📊 Monitorar Aplicação

### Ver Logs

1. No painel do Easypanel, vá para seu projeto
2. Clique em **Logs**
3. Selecione **Application Logs**
4. Veja os logs em tempo real

### Ver Recursos

1. Vá para **Monitoring**
2. Verifique:
   - CPU
   - Memória
   - Disco
   - Rede

## 🔄 Atualizar Aplicação

Quando quiser fazer deploy de uma nova versão:

```bash
# No seu repositório local
git add .
git commit -m "Update Twenty CRM"
git push origin main
```

O Easypanel fará deploy automaticamente (se auto-deploy estiver habilitado).

Ou manualmente:

1. No painel do Easypanel
2. Vá para seu projeto
3. Clique em **Redeploy**

## 💾 Backup

### Backup do Banco de Dados

#### Via Easypanel

1. Vá para **Databases**
2. Selecione seu banco
3. Clique em **Backups**
4. Clique em **Create Backup**

#### Via Linha de Comando

```bash
pg_dump $DATABASE_URL > backup.sql
```

### Restaurar Backup

```bash
psql $DATABASE_URL < backup.sql
```

## 🆘 Troubleshooting

### Erro: "Build failed"

**Solução:**
1. Verifique se `package.json` está na raiz
2. Verifique se `nixpacks.toml` está correto
3. Consulte os logs de build
4. Certifique-se de que `yarn.lock` existe
5. Tente fazer redeploy

### Erro: "Connection refused"

**Solução:**
1. Verifique `DATABASE_URL`
2. Teste a conexão: `psql $DATABASE_URL`
3. Certifique-se de que o banco está acessível
4. Verifique firewall do banco

### Erro: "Out of memory"

**Solução:**
1. Aumente a memória do container no Easypanel
2. Otimize as queries do banco
3. Implemente cache
4. Reduza o tamanho dos uploads

### Erro: "Port already in use"

**Solução:**
1. Verifique se `NODE_PORT` está correto (3000)
2. Reinicie o container
3. Verifique se outra aplicação está usando a porta

### Aplicação lenta

**Solução:**
1. Verifique os logs
2. Otimize as queries do banco
3. Ative compressão Gzip
4. Implemente cache com Redis
5. Aumente a memória

## 🔐 Segurança

### Checklist de Segurança

- [ ] Mude a senha do PostgreSQL
- [ ] Use APP_SECRET forte (32+ caracteres)
- [ ] HTTPS é automático no Easypanel
- [ ] Configure firewall do banco
- [ ] Monitore logs regularmente
- [ ] Faça backups regulares
- [ ] Mantenha dependências atualizadas
- [ ] Configure rate limiting

## 📝 Notas Importantes

1. **Domínio**: Certifique-se de que seu domínio aponta para o Easypanel
2. **Banco de Dados**: Use um banco gerenciado ou externo
3. **Variáveis**: Todas as variáveis obrigatórias devem estar configuradas
4. **Build**: O primeiro build pode levar 15+ minutos
5. **SSL**: HTTPS é automático no Easypanel
6. **Porta**: A aplicação roda na porta 3000 (configurada automaticamente)

## 📚 Documentação Adicional

- [Twenty Documentation](https://docs.twenty.com)
- [Easypanel Documentation](https://easypanel.io/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Node.js Documentation](https://nodejs.org/docs/)

## 🎯 Próximos Passos

1. ✅ Preparar banco de dados
2. ✅ Gerar APP_SECRET
3. ✅ Importar repositório
4. ✅ Configurar variáveis
5. ✅ Fazer deploy
6. ✅ Aguardar build
7. ✅ Criar primeira conta
8. ✅ Criar workspace
9. ✅ Testar funcionalidades
10. ✅ Configurar backups

## 📞 Suporte

Para problemas ou dúvidas:

1. Consulte este guia
2. Verifique os logs no Easypanel
3. Consulte [Twenty Docs](https://docs.twenty.com)
4. Consulte [Easypanel Docs](https://easypanel.io/docs)

---

**Versão**: 1.0  
**Data**: 27 de Fevereiro de 2026  
**Status**: ✅ Pronto para Deployment
