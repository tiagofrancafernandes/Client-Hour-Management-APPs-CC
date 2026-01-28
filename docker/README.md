# Tiago Apps Docker

Configurações Docker para desenvolvimento e produção.

**Documentação completa:** [DOCKER-SETUP.md](../DOCKER-SETUP.md)

---

## Quick Start

```bash
# 1. Configurar hosts locais
sudo ./docker/infra/setup-hosts.sh

# 2. Copiar arquivos de configuração
cp docker-compose.example.yaml docker-compose.yaml
cp .env.docker.example .env.docker

# 3. Ajustar USER_ID/GROUP_ID no .env.docker
id -u  # Seu USER_ID
id -g  # Seu GROUP_ID

# 4. Iniciar
docker compose --env-file .env.docker up -d
```

---

## URLs Locais

| Aplicação | URL |
|-----------|-----|
| Landing Page | http://local.tiagoapps.com.br |
| Frontend | http://app.local.tiagoapps.com.br |
| Backoffice | http://admin.local.tiagoapps.com.br |
| API | http://api.local.tiagoapps.com.br |

---

## Estrutura

```
docker/
├── laravel/           # Dockerfiles PHP (dev/prod)
├── node/              # Dockerfiles Node.js (dev/prod)
├── nginx/             # Configurações Nginx
├── postgres/init/     # Scripts inicialização DB
└── infra/             # Hosts e scripts auxiliares
```

---

## Comandos Frequentes

### Docker Compose

```bash
# Iniciar serviços
docker compose --env-file .env.docker up -d

# Parar serviços
docker compose --env-file .env.docker down

# Ver logs
docker compose --env-file .env.docker logs -f

# Status dos containers
docker compose --env-file .env.docker ps
```

### Laravel (Backend)

```bash
# Artisan
docker compose --env-file .env.docker exec backend php artisan migrate
docker compose --env-file .env.docker exec backend php artisan tinker

# Composer
docker compose --env-file .env.docker exec backend composer install
docker compose --env-file .env.docker exec backend composer require pacote
```

### Node.js (Frontend)

```bash
# NPM
docker compose --env-file .env.docker exec frontend npm install
docker compose --env-file .env.docker exec frontend npm run build

# NPX
docker compose --env-file .env.docker exec frontend npx prettier --write src/
```

### PostgreSQL

```bash
# Conectar ao banco
docker compose --env-file .env.docker exec postgres psql -U tiagoapps -d tiagoapps

# Backup
docker compose --env-file .env.docker exec postgres pg_dump -U tiagoapps tiagoapps > backup.sql
```

### Redis

```bash
# Conectar ao Redis CLI
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis

# Limpar cache
docker compose --env-file .env.docker exec redis redis-cli -a f2apps_redis FLUSHALL
```

---

## Documentação dos Projetos

Cada aplicação possui seu próprio README com instruções detalhadas:

- **Backend:** `backend/README.md`
- **Frontend:** `frontend/README.md`
- **Landing Page:** `landingpage/README.md`
- **Backoffice:** `frontend-backoffice/README.md`

---

## Mais Informações

Para instruções completas, troubleshooting e referência de variáveis, consulte:

**[DOCKER-SETUP.md](../DOCKER-SETUP.md)**
