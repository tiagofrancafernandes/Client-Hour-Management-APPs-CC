# Tiago Apps - Guia de Configuração do Ambiente Docker

Este guia explica como configurar e utilizar o ambiente Docker para desenvolvimento e produção do Tiago Apps.

> **Novo no projeto?** Siga este guia do início ao fim para configurar seu ambiente de desenvolvimento.

---

## Índice

1. [Pré-requisitos](#pré-requisitos)
2. [Repositórios do Projeto](#repositórios-do-projeto)
3. [Clonando os Repositórios](#clonando-os-repositórios)
4. [Estrutura de Arquivos](#estrutura-de-arquivos)
5. [Configuração Inicial](#configuração-inicial)
6. [Iniciando o Ambiente](#iniciando-o-ambiente)
7. [Acessando as Aplicações](#acessando-as-aplicações)
8. [Executando Comandos nos Containers](#executando-comandos-nos-containers)
9. [Ambiente de Produção](#ambiente-de-produção)
10. [Troubleshooting](#troubleshooting)
11. [Referência de Variáveis](#referência-de-variáveis)

---

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

| Software | Versão Mínima | Como verificar |
|----------|---------------|----------------|
| Docker Engine | 24.0+ | `docker --version` |
| Docker Compose | v2.20+ | `docker compose version` |
| Git | 2.0+ | `git --version` |

### Instalação do Docker (Ubuntu/Debian)

```bash
# Instalar Docker
curl -fsSL https://get.docker.com | sh

# Adicionar seu usuário ao grupo docker (evita usar sudo)
sudo usermod -aG docker $USER

# Reinicie o terminal ou execute:
newgrp docker

# Verificar instalação
docker --version
docker compose version
```

---

## Repositórios do Projeto

O Tiago Apps é composto por múltiplos repositórios. Cada aplicação tem seu próprio repositório:

| Aplicação | Tecnologia | Repositório | Pasta Local |
|-----------|------------|-------------|-------------|
| **Infraestrutura** | Docker/Nginx | `TODO: URL do repositório principal` | `Client-Hour-Management-APPs/` |
| **Backend (API)** | Laravel + PostgreSQL | `TODO: URL do repositório backend` | `Client-Hour-Management-APPs/backend/` |
| **Frontend** | Vue 3 + Tailwind | `TODO: URL do repositório frontend` | `Client-Hour-Management-APPs/frontend/` |
| **Landing Page** | Nuxt 4 + Tailwind | `TODO: URL do repositório landingpage` | `Client-Hour-Management-APPs/landingpage/` |
| **Backoffice** | Nuxt 4 + Tailwind | `TODO: URL do repositório backoffice` | `Client-Hour-Management-APPs/frontend-backoffice/` |

> **Documentação específica:** Cada projeto possui seu próprio `README.md` com instruções detalhadas sobre a aplicação. Consulte-os para informações específicas de cada tecnologia.

---

## Clonando os Repositórios

### Passo 1: Clonar o repositório principal (infraestrutura)

```bash
# Navegue até a pasta onde deseja criar o projeto
cd ~/projetos  # ou sua pasta de preferência

# Clone o repositório principal
git clone TODO:URL_REPOSITORIO_PRINCIPAL Client-Hour-Management-APPs

# Entre na pasta do projeto
cd Client-Hour-Management-APPs
```

### Passo 2: Clonar os repositórios das aplicações

Cada aplicação deve ser clonada em sua pasta específica dentro de `Client-Hour-Management-APPs/`:

```bash
# Certifique-se de estar na raiz do projeto
cd ~/projetos/Client-Hour-Management-APPs

# Backend (Laravel)
git clone TODO:URL_REPOSITORIO_BACKEND backend

# Frontend (Vue 3)
git clone TODO:URL_REPOSITORIO_FRONTEND frontend

# Landing Page (Nuxt 4)
git clone TODO:URL_REPOSITORIO_LANDINGPAGE landingpage

# Backoffice (Nuxt 4)
git clone TODO:URL_REPOSITORIO_BACKOFFICE frontend-backoffice
```

### Estrutura final após clonar

```
Client-Hour-Management-APPs/
├── backend/                 # ← Repositório do Backend (Laravel)
│   └── README.md            # Documentação específica do Backend
├── frontend/                # ← Repositório do Frontend (Vue 3)
│   └── README.md            # Documentação específica do Frontend
├── landingpage/             # ← Repositório da Landing Page (Nuxt 4)
│   └── README.md            # Documentação específica da Landing Page
├── frontend-backoffice/     # ← Repositório do Backoffice (Nuxt 4)
│   └── README.md            # Documentação específica do Backoffice
├── docker/                  # Configurações Docker
├── docker-compose.example.yaml
├── .env.docker.example
└── DOCKER-SETUP.md          # Este arquivo
```

> **Importante:** As pastas `backend/`, `frontend/`, `landingpage/` e `frontend-backoffice/` estão no `.gitignore` do repositório principal. Isso permite que cada aplicação tenha seu próprio controle de versão independente.

---

## Estrutura de Arquivos Docker

```
docker/
├── laravel/                    # Dockerfiles para Laravel/PHP
│   ├── Dockerfile.dev          # Desenvolvimento (com Xdebug)
│   ├── Dockerfile.prod         # Produção (otimizado)
│   ├── php-dev.ini             # Config PHP desenvolvimento
│   └── php-prod.ini            # Config PHP produção
├── node/                       # Dockerfiles para Node.js
│   ├── Dockerfile.vue.dev      # Vue 3 desenvolvimento
│   ├── Dockerfile.vue.prod     # Vue 3 produção
│   ├── Dockerfile.nuxt.dev     # Nuxt 4 desenvolvimento
│   └── Dockerfile.nuxt.prod    # Nuxt 4 produção
├── nginx/                      # Configurações Nginx
│   ├── nginx.conf              # Configuração principal
│   ├── api.conf                # API Laravel (PHP-FPM)
│   ├── landingpage.conf        # Landing Page (proxy Nuxt)
│   ├── frontend.conf           # Frontend (proxy Vite)
│   ├── backoffice.conf         # Backoffice (proxy Nuxt)
│   └── vue-prod.conf           # Vue produção (estático)
├── postgres/
│   └── init/                   # Scripts de inicialização do banco
│       └── 01-init.sql
└── infra/
    ├── etc-hosts.example       # Arquivo hosts de exemplo
    └── setup-hosts.sh          # Script para configurar hosts
```

---

## Configuração Inicial

### Passo 1: Configurar domínios locais

Para acessar as aplicações pelos domínios locais, você precisa adicionar entradas no arquivo `/etc/hosts` do seu sistema operacional.

**Opção A: Usar script automático (recomendado)**

```bash
sudo ./docker/infra/setup-hosts.sh
```

**Opção B: Configurar manualmente**

```bash
# Abra o arquivo hosts
sudo nano /etc/hosts

# Adicione as seguintes linhas ao final do arquivo:
127.0.0.1 local.tiagoapps.com.br
127.0.0.1 app.local.tiagoapps.com.br
127.0.0.1 admin.local.tiagoapps.com.br
127.0.0.1 api.local.tiagoapps.com.br

# Salve e feche (Ctrl+O, Enter, Ctrl+X)
```

### Passo 2: Copiar arquivos de configuração

```bash
# Copiar docker-compose de exemplo
cp docker-compose.example.yaml docker-compose.yaml

# Copiar variáveis de ambiente de exemplo
cp .env.docker.example .env.docker
```

### Passo 3: Configurar variáveis de ambiente

Edite o arquivo `.env.docker` com suas configurações:

```bash
nano .env.docker
```

**Configurações importantes a verificar:**

```env
# Obtenha seu USER_ID e GROUP_ID para evitar problemas de permissão
# Execute no terminal: id -u && id -g
USER_ID=1000      # Substitua pelo resultado de: id -u
GROUP_ID=1000     # Substitua pelo resultado de: id -g

# Senhas do banco de dados (altere em produção!)
POSTGRES_USER=tiagoapps
POSTGRES_PASSWORD=sua_senha_segura_aqui
POSTGRES_DB=tiagoapps

# Senha do Redis
REDIS_PASSWORD=sua_senha_redis_aqui

# Portas (altere se houver conflito com outros serviços)
NGINX_HTTP_PORT=80
POSTGRES_PORT=5432
REDIS_PORT=6379
```

### Passo 4: Configurar cada aplicação

Cada aplicação tem seu próprio arquivo `.env`. Consulte o `README.md` de cada projeto para instruções específicas:

```bash
# Backend (Laravel)
cp backend/.env.example backend/.env
# Edite backend/.env conforme README do backend

# Frontend (Vue 3)
cp frontend/.env.example frontend/.env
# Edite frontend/.env conforme README do frontend

# E assim por diante para as outras aplicações...
```

---

## Iniciando o Ambiente

### Primeira execução (build das imagens)

Na primeira vez, o Docker precisa construir as imagens. Isso pode levar alguns minutos:

```bash
# Iniciar todos os serviços (com build)
docker compose --env-file .env.docker up -d --build
```

### Execuções subsequentes

```bash
# Iniciar todos os serviços
docker compose --env-file .env.docker up -d

# Iniciar e acompanhar logs em tempo real
docker compose --env-file .env.docker up

# Iniciar apenas serviços específicos
docker compose --env-file .env.docker up -d postgres redis backend
```

### Verificar status dos containers

```bash
docker compose --env-file .env.docker ps
```

Saída esperada (todos os serviços rodando):

```
NAME              STATUS              PORTS
tiagoapps-nginx       Up 2 minutes        0.0.0.0:80->80/tcp
tiagoapps-postgres    Up 2 minutes        0.0.0.0:5432->5432/tcp
tiagoapps-redis       Up 2 minutes        0.0.0.0:6379->6379/tcp
tiagoapps-backend     Up 2 minutes        9000/tcp
tiagoapps-frontend    Up 2 minutes        0.0.0.0:5173->5173/tcp
tiagoapps-landingpage Up 2 minutes        0.0.0.0:3000->3000/tcp
tiagoapps-backoffice  Up 2 minutes        0.0.0.0:3001->3000/tcp
```

### Parar os serviços

```bash
# Parar todos os serviços
docker compose --env-file .env.docker down

# Parar e remover volumes (CUIDADO: apaga dados do banco!)
docker compose --env-file .env.docker down -v
```

---

## Acessando as Aplicações

### URLs via Nginx (recomendado)

| Aplicação | URL | Descrição |
|-----------|-----|-----------|
| Landing Page | http://local.tiagoapps.com.br | Site institucional |
| Frontend | http://app.local.tiagoapps.com.br | Painel do cliente |
| Backoffice | http://admin.local.tiagoapps.com.br | Painel administrativo |
| API | http://api.local.tiagoapps.com.br | API REST Laravel |

### URLs de acesso direto (debug/desenvolvimento)

Útil quando você quer acessar diretamente o servidor de desenvolvimento, sem passar pelo Nginx:

| Aplicação | URL |
|-----------|-----|
| Frontend (Vite) | http://localhost:5173 |
| Landing Page (Nuxt) | http://localhost:3000 |
| Backoffice (Nuxt) | http://localhost:3001 |

---

## Executando Comandos nos Containers

Esta seção explica como executar comandos dentro dos containers Docker. Isso é essencial para tarefas do dia a dia como rodar migrations, instalar pacotes, etc.

### Sintaxe básica

```bash
docker compose --env-file .env.docker exec <SERVIÇO> <COMANDO>
```

Onde:
- `<SERVIÇO>` é o nome do serviço definido no docker-compose (backend, frontend, etc.)
- `<COMANDO>` é o comando que você quer executar

---

### Laravel / Backend (PHP)

> **Documentação detalhada:** Consulte `backend/README.md` para mais informações sobre o backend.

#### Artisan (CLI do Laravel)

```bash
# Sintaxe geral
docker compose --env-file .env.docker exec backend php artisan <comando>

# Exemplos comuns:

# Rodar migrations
docker compose --env-file .env.docker exec backend php artisan migrate

# Rodar migrations com seed
docker compose --env-file .env.docker exec backend php artisan migrate --seed

# Reverter última migration
docker compose --env-file .env.docker exec backend php artisan migrate:rollback

# Criar nova migration
docker compose --env-file .env.docker exec backend php artisan make:migration create_users_table

# Criar novo controller
docker compose --env-file .env.docker exec backend php artisan make:controller UserController

# Criar novo model
docker compose --env-file .env.docker exec backend php artisan make:model User -mcr

# Limpar caches
docker compose --env-file .env.docker exec backend php artisan cache:clear
docker compose --env-file .env.docker exec backend php artisan config:clear
docker compose --env-file .env.docker exec backend php artisan route:clear
docker compose --env-file .env.docker exec backend php artisan view:clear

# Listar rotas
docker compose --env-file .env.docker exec backend php artisan route:list

# Tinker (REPL interativo)
docker compose --env-file .env.docker exec backend php artisan tinker

# Rodar testes
docker compose --env-file .env.docker exec backend php artisan test

# Gerar APP_KEY
docker compose --env-file .env.docker exec backend php artisan key:generate
```

#### Composer (Gerenciador de dependências PHP)

```bash
# Sintaxe geral
docker compose --env-file .env.docker exec backend composer <comando>

# Exemplos:

# Instalar dependências
docker compose --env-file .env.docker exec backend composer install

# Atualizar dependências
docker compose --env-file .env.docker exec backend composer update

# Adicionar novo pacote
docker compose --env-file .env.docker exec backend composer require vendor/pacote

# Adicionar pacote de desenvolvimento
docker compose --env-file .env.docker exec backend composer require --dev vendor/pacote

# Remover pacote
docker compose --env-file .env.docker exec backend composer remove vendor/pacote

# Atualizar autoload
docker compose --env-file .env.docker exec backend composer dump-autoload
```

#### PHPUnit (Testes)

```bash
# Rodar todos os testes
docker compose --env-file .env.docker exec backend ./vendor/bin/phpunit

# Rodar teste específico
docker compose --env-file .env.docker exec backend ./vendor/bin/phpunit tests/Feature/UserTest.php

# Rodar com coverage
docker compose --env-file .env.docker exec backend ./vendor/bin/phpunit --coverage-html coverage
```

---

### Frontend / Node.js (Vue 3, Nuxt 4)

> **Documentação detalhada:** Consulte `frontend/README.md`, `landingpage/README.md` ou `frontend-backoffice/README.md` conforme a aplicação.

#### NPM (Gerenciador de pacotes Node.js)

```bash
# Sintaxe geral
docker compose --env-file .env.docker exec <serviço> npm <comando>

# Onde <serviço> pode ser: frontend, landingpage, backoffice
```

**Exemplos para o Frontend (Vue 3):**

```bash
# Instalar dependências
docker compose --env-file .env.docker exec frontend npm install

# Adicionar pacote
docker compose --env-file .env.docker exec frontend npm install nome-do-pacote

# Adicionar pacote de desenvolvimento
docker compose --env-file .env.docker exec frontend npm install -D nome-do-pacote

# Remover pacote
docker compose --env-file .env.docker exec frontend npm uninstall nome-do-pacote

# Atualizar pacotes
docker compose --env-file .env.docker exec frontend npm update

# Rodar scripts definidos no package.json
docker compose --env-file .env.docker exec frontend npm run build
docker compose --env-file .env.docker exec frontend npm run lint
docker compose --env-file .env.docker exec frontend npm run test
```

**Exemplos para Landing Page (Nuxt 4):**

```bash
# Instalar dependências
docker compose --env-file .env.docker exec landingpage npm install

# Build de produção
docker compose --env-file .env.docker exec landingpage npm run build

# Gerar site estático
docker compose --env-file .env.docker exec landingpage npm run generate
```

**Exemplos para Backoffice (Nuxt 4):**

```bash
# Instalar dependências
docker compose --env-file .env.docker exec backoffice npm install

# Build de produção
docker compose --env-file .env.docker exec backoffice npm run build
```

#### NPX (Executar pacotes sem instalar)

```bash
# Sintaxe geral
docker compose --env-file .env.docker exec <serviço> npx <comando>

# Exemplos:

# Criar novo componente Vue (se tiver CLI configurado)
docker compose --env-file .env.docker exec frontend npx vue-cli-service inspect

# Executar prettier
docker compose --env-file .env.docker exec frontend npx prettier --write src/

# Executar eslint
docker compose --env-file .env.docker exec frontend npx eslint --fix src/

# Verificar vulnerabilidades
docker compose --env-file .env.docker exec frontend npx audit-ci
```

---

### PostgreSQL (Banco de Dados)

#### PSQL (CLI do PostgreSQL)

```bash
# Conectar ao banco de dados
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps

# Executar comando SQL diretamente
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps -c "SELECT * FROM users LIMIT 5;"

# Listar todos os bancos
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -c "\l"

# Listar todas as tabelas
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps -c "\dt"

# Descrever estrutura de uma tabela
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps -c "\d users"

# Listar conexões ativas
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -c "SELECT * FROM pg_stat_activity;"
```

#### Backup e Restore

```bash
# Fazer backup do banco
docker compose --env-file .env.docker exec postgres pg_dump -U tiagoapps tiagoapps > backup_$(date +%Y%m%d_%H%M%S).sql

# Restaurar backup (use -T para não alocar TTY)
docker compose --env-file .env.docker exec -T postgres psql -U tiagoapps tiagoapps < backup.sql

# Backup compactado
docker compose --env-file .env.docker exec postgres pg_dump -U tiagoapps tiagoapps | gzip > backup_$(date +%Y%m%d).sql.gz

# Restaurar backup compactado
gunzip -c backup.sql.gz | docker compose --env-file .env.docker exec -T postgres psql -U tiagoapps tiagoapps
```

---

### Redis (Cache)

```bash
# Conectar ao Redis CLI
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis

# Executar comando diretamente
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis PING

# Listar todas as chaves
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis KEYS "*"

# Obter valor de uma chave
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis GET "chave"

# Limpar todo o cache
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis FLUSHALL

# Limpar apenas o banco atual
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis FLUSHDB

# Ver estatísticas
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis INFO

# Monitorar comandos em tempo real
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis MONITOR
```

---

### Acessar Shell dos Containers

Às vezes você precisa acessar o terminal do container para explorar ou debugar:

```bash
# Backend (PHP/Laravel)
docker compose --env-file .env.docker exec backend sh

# Frontend (Node.js)
docker compose --env-file .env.docker exec frontend sh

# Landing Page (Node.js)
docker compose --env-file .env.docker exec landingpage sh

# Backoffice (Node.js)
docker compose --env-file .env.docker exec backoffice sh

# Nginx
docker compose --env-file .env.docker exec nginx sh

# PostgreSQL
docker compose --env-file .env.docker exec postgres sh

# Redis
docker compose --env-file .env.docker exec redis sh
```

---

### Logs dos Containers

```bash
# Ver logs de todos os serviços
docker compose --env-file .env.docker logs

# Acompanhar logs em tempo real
docker compose --env-file .env.docker logs -f

# Logs de um serviço específico
docker compose --env-file .env.docker logs -f backend

# Últimas 100 linhas
docker compose --env-file .env.docker logs --tail=100 backend

# Logs de múltiplos serviços
docker compose --env-file .env.docker logs -f backend nginx postgres
```

---

### Dica: Criar Aliases (Atalhos)

Para facilitar o dia a dia, você pode criar aliases no seu terminal. Adicione ao seu `~/.bashrc` ou `~/.zshrc`:

```bash
# Aliases para Tiago Apps Docker
alias dc='docker compose --env-file .env.docker'
alias dcup='docker compose --env-file .env.docker up -d'
alias dcdown='docker compose --env-file .env.docker down'
alias dclogs='docker compose --env-file .env.docker logs -f'
alias dcps='docker compose --env-file .env.docker ps'

# Aliases para comandos frequentes
alias artisan='docker compose --env-file .env.docker exec backend php artisan'
alias composer='docker compose --env-file .env.docker exec backend composer'
alias npm-front='docker compose --env-file .env.docker exec frontend npm'
alias psql-tiagoapps='docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps'
```

Depois de adicionar, recarregue o terminal:

```bash
source ~/.bashrc  # ou source ~/.zshrc
```

Agora você pode usar:

```bash
artisan migrate
composer install
npm-front install axios
psql-tiagoapps
```

---

## Ambiente de Produção

### Configuração

```bash
# Usar docker-compose de produção
cp docker-compose.prod.example.yaml docker-compose.yaml

# Configurar variáveis de produção
nano .env.docker
```

**Variáveis de produção importantes:**

```env
APP_ENV=production
APP_DEBUG=false

# Domínios de produção
SAAS_DOMAIN=tiagoapps.com.br
CUSTOMER_APP_DOMAIN=app.tiagoapps.com.br
BACKOFFICE_DOMAIN=admin.tiagoapps.com.br
API_DOMAIN=api.tiagoapps.com.br

# URLs completas (HTTPS em produção)
SAAS_URL=https://tiagoapps.com.br
CUSTOMER_APP_URL=https://app.tiagoapps.com.br
BACKOFFICE_URL=https://admin.tiagoapps.com.br
API_URL=https://api.tiagoapps.com.br

# SENHAS FORTES E ÚNICAS!
POSTGRES_PASSWORD=senha_muito_forte_e_unica_aqui
REDIS_PASSWORD=outra_senha_forte_aqui
```

### Build e Deploy

```bash
# Build das imagens
docker compose --env-file .env.docker build

# Build sem cache (após alterações significativas)
docker compose --env-file .env.docker build --no-cache

# Iniciar em produção
docker compose --env-file .env.docker up -d
```

---

## Troubleshooting

### Problema: Portas em uso

**Sintoma:**
```
Error: Bind for 0.0.0.0:80 failed: port is already allocated
```

**Solução:**
Altere as portas no `.env.docker`:

```env
NGINX_HTTP_PORT=8080
POSTGRES_PORT=5433
REDIS_PORT=6380
```

### Problema: Permissão negada em arquivos

**Sintoma:**
```
Permission denied: /var/www/html/storage/logs
```

**Solução:**

1. Verifique seu USER_ID e GROUP_ID:
```bash
id -u  # Seu USER_ID
id -g  # Seu GROUP_ID
```

2. Atualize `.env.docker` com os valores corretos:
```env
USER_ID=1000
GROUP_ID=1000
```

3. Rebuild o container:
```bash
docker compose --env-file .env.docker build --no-cache backend
docker compose --env-file .env.docker up -d backend
```

### Problema: Container reiniciando em loop

**Sintoma:**
```
Container tiagoapps-backend is restarting
```

**Solução:**

1. Verifique os logs:
```bash
docker compose --env-file .env.docker logs backend
```

2. Verifique se as dependências estão saudáveis:
```bash
docker compose --env-file .env.docker ps
```

### Problema: Módulos Node.js não encontrados

**Sintoma:**
```
Error: Cannot find module 'xxx'
```

**Solução:**

```bash
# Remover node_modules e reinstalar
docker compose --env-file .env.docker exec frontend rm -rf node_modules
docker compose --env-file .env.docker exec frontend npm install

# Ou remover o volume e recriar
docker compose --env-file .env.docker down
docker volume rm f2apps_frontend-node-modules
docker compose --env-file .env.docker up -d frontend
```

### Problema: Hot Reload não funciona

**Sintoma:** Alterações nos arquivos não são refletidas automaticamente.

**Solução para Vue/Vite (`vite.config.js`):**

```javascript
export default defineConfig({
  server: {
    host: '0.0.0.0',
    watch: {
      usePolling: true
    }
  }
})
```

**Solução para Nuxt (`nuxt.config.ts`):**

```typescript
export default defineNuxtConfig({
  vite: {
    server: {
      watch: {
        usePolling: true
      }
    }
  }
})
```

### Problema: Conexão recusada entre containers

**Sintoma:**
```
Connection refused to postgres:5432
```

**Solução:**

1. Verifique se o container está rodando:
```bash
docker compose --env-file .env.docker ps postgres
```

2. Use o nome do serviço (não localhost):
```env
# Correto (dentro do Docker)
DB_HOST=postgres

# Incorreto (dentro do Docker)
DB_HOST=localhost
```

### Limpar tudo e recomeçar

```bash
# Parar tudo
docker compose --env-file .env.docker down

# Remover volumes (CUIDADO: apaga dados!)
docker compose --env-file .env.docker down -v

# Remover imagens do projeto
docker compose --env-file .env.docker down --rmi local

# Limpar cache do Docker (libera espaço)
docker system prune -a

# Rebuild completo
docker compose --env-file .env.docker build --no-cache
docker compose --env-file .env.docker up -d
```

---

## Referência de Variáveis de Ambiente

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `USER_ID` | ID do usuário host (evita problemas de permissão) | 1000 |
| `GROUP_ID` | ID do grupo host | 1000 |
| `APP_ENV` | Ambiente da aplicação | local |
| `APP_DEBUG` | Modo debug | true |
| `NGINX_HTTP_PORT` | Porta HTTP do Nginx | 80 |
| `NGINX_HTTPS_PORT` | Porta HTTPS do Nginx | 443 |
| `POSTGRES_USER` | Usuário PostgreSQL | tiagoapps |
| `POSTGRES_PASSWORD` | Senha PostgreSQL | f2apps_secret |
| `POSTGRES_DB` | Nome do banco | tiagoapps |
| `POSTGRES_PORT` | Porta PostgreSQL | 5432 |
| `REDIS_PASSWORD` | Senha Redis | f2apps_redis |
| `REDIS_PORT` | Porta Redis | 6379 |
| `FRONTEND_PORT` | Porta do frontend Vue (acesso direto) | 5173 |
| `LANDINGPAGE_PORT` | Porta da landing page (acesso direto) | 3000 |
| `BACKOFFICE_PORT` | Porta do backoffice (acesso direto) | 3001 |
| `SAAS_DOMAIN` | Domínio da landing page | local.tiagoapps.com.br |
| `CUSTOMER_APP_DOMAIN` | Domínio do frontend | app.local.tiagoapps.com.br |
| `BACKOFFICE_DOMAIN` | Domínio do backoffice | admin.local.tiagoapps.com.br |
| `API_DOMAIN` | Domínio da API | api.local.tiagoapps.com.br |

---

## Recursos Adicionais

- **Backend (Laravel):** Consulte `backend/README.md`
- **Frontend (Vue 3):** Consulte `frontend/README.md`
- **Landing Page (Nuxt 4):** Consulte `landingpage/README.md`
- **Backoffice (Nuxt 4):** Consulte `frontend-backoffice/README.md`
- **Docker Compose Reference:** https://docs.docker.com/compose/
- **Laravel Documentation:** https://laravel.com/docs
- **Vue 3 Documentation:** https://vuejs.org/guide/
- **Nuxt 4 Documentation:** https://nuxt.com/docs
