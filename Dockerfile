# Multi-stage build para Twenty CRM otimizado para Easypanel

# Stage 1: Builder
FROM node:18-alpine AS builder

WORKDIR /app

# Instalar dependências do sistema
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \
    curl \
    bash

# Copiar arquivos de dependências
COPY package.json yarn.lock ./

# Instalar dependências
RUN yarn install --frozen-lockfile --production=false

# Copiar código-fonte
COPY . .

# Build do projeto
RUN yarn build

# Stage 2: Runtime
FROM node:18-alpine

WORKDIR /app

# Instalar dependências de runtime
RUN apk add --no-cache \
    curl \
    postgresql-client \
    dumb-init \
    bash

# Criar usuário não-root
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

# Copiar node_modules do builder
COPY --from=builder /app/node_modules ./node_modules

# Copiar código compilado
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/packages/twenty-server/src/database ./src/database

# Copiar arquivos necessários
COPY package.json yarn.lock ./
COPY packages/twenty-server/.env* ./packages/twenty-server/

# Criar diretório para armazenamento local
RUN mkdir -p /app/packages/twenty-server/.local-storage && \
    chown -R nodejs:nodejs /app

# Mudar para usuário não-root
USER nodejs

# Health check
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
    CMD curl -f http://localhost:3000/healthz || exit 1

# Usar dumb-init para gerenciar sinais
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Comando padrão
CMD ["node", "dist/packages/twenty-server/src/main.js"]

# Expor porta
EXPOSE 3000
