# 🤝 Contribuindo para Twenty CRM

Obrigado por considerar contribuir para o Twenty CRM! Este documento fornece diretrizes e instruções para contribuir.

## 📋 Código de Conduta

Todos os contribuidores devem seguir nosso Código de Conduta. Esperamos comportamento respeitoso e profissional de todos.

## 🐛 Reportando Bugs

Se você encontrou um bug, por favor:

1. **Verifique se o bug já foi reportado** - Procure em Issues
2. **Forneça detalhes específicos**:
   - Versão do Twenty CRM
   - Versão do Node.js
   - Sistema operacional
   - Passos para reproduzir
   - Comportamento esperado vs. real
3. **Inclua logs** - Cole logs de erro se disponível

### Template de Bug Report

```markdown
**Descrição do Bug**
Uma descrição clara e concisa do que é o bug.

**Passos para Reproduzir**
1. Vá para '...'
2. Clique em '...'
3. Veja o erro

**Comportamento Esperado**
O que você esperava que acontecesse.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente**
- Node.js: [versão]
- OS: [ex: Ubuntu 22.04]
- Navegador: [ex: Chrome 120]
```

## ✨ Sugerindo Melhorias

Se você tem uma ideia para melhorar o Twenty CRM:

1. **Descreva a melhoria** - Seja específico e claro
2. **Explique o caso de uso** - Por que isso seria útil?
3. **Liste exemplos** - Mostre como funcionaria
4. **Mencione alternativas** - Existem outras soluções?

## 🔧 Processo de Desenvolvimento

### 1. Fork o Repositório

```bash
git clone https://github.com/seu-usuario/twenty-crm-easypanel.git
cd twenty-crm-easypanel
```

### 2. Criar Branch

```bash
# Atualize main
git checkout main
git pull origin main

# Crie uma branch para sua feature
git checkout -b feature/sua-feature
# ou para um bug
git checkout -b fix/seu-bug
```

### 3. Fazer Mudanças

- Faça mudanças pequenas e focadas
- Escreva código limpo e bem documentado
- Siga o estilo de código existente
- Adicione testes se aplicável

### 4. Commit

```bash
# Commit com mensagem clara
git commit -m "feat: adicionar nova funcionalidade"
# ou
git commit -m "fix: corrigir bug em pastas"
```

### 5. Push e Pull Request

```bash
git push origin feature/sua-feature
```

Abra um Pull Request no GitHub com:

- Título claro e descritivo
- Descrição detalhada das mudanças
- Referência a Issues relacionadas
- Screenshots se aplicável

## 📝 Convenções de Commit

Use o formato Conventional Commits:

```
type(scope): subject

body

footer
```

### Tipos

- **feat**: Nova funcionalidade
- **fix**: Correção de bug
- **docs**: Mudanças na documentação
- **style**: Formatação, sem mudanças lógicas
- **refactor**: Refatoração sem mudanças funcionais
- **perf**: Melhorias de performance
- **test**: Adicionar ou atualizar testes
- **chore**: Mudanças em build, deps, etc

### Exemplos

```
feat(folders): adicionar suporte a pastas aninhadas
fix(auth): corrigir erro de autenticação JWT
docs(readme): atualizar instruções de instalação
```

## 🧪 Testes

Antes de fazer commit:

```bash
# Executar testes
yarn test

# Verificar linting
yarn lint

# Build
yarn build
```

## 📚 Documentação

Se sua mudança afeta a funcionalidade:

1. Atualize o README.md
2. Atualize o DEPLOYMENT.md se necessário
3. Adicione comentários no código
4. Atualize exemplos se aplicável

## 🔐 Segurança

Se você encontrou uma vulnerabilidade de segurança:

1. **NÃO** abra uma Issue pública
2. Envie um email para: security@twenty.com
3. Descreva a vulnerabilidade em detalhes
4. Aguarde uma resposta antes de divulgar

## 📊 Processo de Revisão

Seu Pull Request será revisado por:

1. **Verificação automática** - Testes, linting, build
2. **Revisão de código** - Um ou mais maintainers
3. **Testes manuais** - Se necessário
4. **Merge** - Após aprovação

## 🎯 Diretrizes de Qualidade

- Código limpo e legível
- Sem duplicação
- Bem testado
- Bem documentado
- Sem breaking changes (se possível)

## 📦 Dependências

Antes de adicionar uma nova dependência:

1. Verifique se já existe algo similar
2. Considere o tamanho do pacote
3. Verifique a manutenção do pacote
4. Discuta em uma Issue primeiro

## 🚀 Release Process

Releases seguem Semantic Versioning:

- **MAJOR**: Breaking changes
- **MINOR**: Novas funcionalidades
- **PATCH**: Correções de bugs

## 💬 Comunicação

- **Issues**: Para bugs e features
- **Discussions**: Para perguntas e ideias
- **Pull Requests**: Para mudanças de código
- **Email**: Para segurança

## 🙏 Agradecimentos

Obrigado por contribuir! Sua ajuda é valiosa para melhorar o Twenty CRM.

---

**Versão**: 1.0  
**Data**: 27 de Fevereiro de 2026
