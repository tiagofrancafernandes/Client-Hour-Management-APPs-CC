# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Hours Ledger System** — A client hour tracking application following a **ledger-based model**.

### Tech Stack
- **Backend**: Laravel 12 (PHP 8.2+) with Sanctum authentication
- **Frontend**: Vue 3 + Vite + TypeScript + TailwindCSS v4
- **Database**: PostgreSQL 16
- **Cache**: Redis 7
- **Containerization**: Docker Compose

### Key Directories
```
├── backend/           # Laravel API (separate git repo)
├── frontend/          # Vue 3 customer app (separate git repo)
├── docker/            # Docker configurations
└── STEP-*.md          # Execution plan steps
```

## Critical Domain Rules

This system follows strict **append-only ledger** principles:

- **NO balance columns** — Balance is always calculated from SUM of ledger entries
- **NO deletes** — All changes are insertions (including adjustments)
- **NO soft deletes** — Data is immutable
- `LedgerEntry.hours` is signed (positive = credit, negative = debit)

### Domain Entities
- **Client** → has many Wallets
- **Wallet** → belongs to Client, has many LedgerEntries (balance is derived)
- **LedgerEntry** → immutable record of hour changes
- **Tag** → optional classification for entries

## Development Commands

All commands use Docker with `--env-file .env.docker`. Common prefix:
```bash
dc="docker compose --env-file .env.docker"
```

### Starting the Environment
```bash
# First time (with build)
docker compose --env-file .env.docker up -d --build

# Subsequent runs
docker compose --env-file .env.docker up -d

# Stop all services
docker compose --env-file .env.docker down
```

### Backend (Laravel)
```bash
# Artisan commands
docker compose --env-file .env.docker exec backend php artisan migrate
docker compose --env-file .env.docker exec backend php artisan test
docker compose --env-file .env.docker exec backend php artisan tinker

# Composer
docker compose --env-file .env.docker exec backend composer install
docker compose --env-file .env.docker exec backend composer require <package>

# Code formatting (PSR-12)
docker compose --env-file .env.docker exec backend ./vendor/bin/pint
```

### Frontend (Vue 3)
```bash
# NPM commands
docker compose --env-file .env.docker exec frontend npm install
docker compose --env-file .env.docker exec frontend npm run build
docker compose --env-file .env.docker exec frontend npm run dev
```

### Database
```bash
# PostgreSQL CLI
docker compose --env-file .env.docker exec postgres psql -U mkpay -d mkpay

# Backup
docker compose --env-file .env.docker exec postgres pg_dump -U mkpay mkpay > backup.sql
```

### View Logs
```bash
docker compose --env-file .env.docker logs -f backend
docker compose --env-file .env.docker logs -f frontend
```

## Local URLs

After configuring `/etc/hosts` (see DOCKER-SETUP.md):

| Application | URL |
|-------------|-----|
| API | http://api.local.tiagoapps.com.br |
| Frontend | http://app.local.tiagoapps.com.br |
| Landing Page | http://local.tiagoapps.com.br |
| Backoffice | http://admin.local.tiagoapps.com.br |

Direct ports: Frontend `:5173`, Landing `:3000`, Backoffice `:3001`

## Architecture Guidelines

### Backend (Laravel)
- **Thin controllers** — Business logic goes in Service classes
- Services for logic (e.g., `BalanceCalculatorService`, `ReportService`)
- Use `$request->input('field')` instead of `$request->field`
- PSR-12 code style (configured in `pint.json`)
- Sanctum for API authentication

### Frontend (Vue 3)
- Composition API with TypeScript
- TailwindCSS v4 (uses `@import "tailwindcss"`, not `@tailwind` directives)
- Object syntax for conditional classes (no ternary in `:class`)
- API-driven, no business logic in components

## Code Style Guideline (Mandatory)

All code generated, modified, or refactored **must strictly follow** the rules defined in:

**UNIVERSAL-CODE-STYLE-RULES.md**

### Enforcement Rules

- The rules in `UNIVERSAL-CODE-STYLE-RULES.md` are **authoritative and non-negotiable**
- No framework convention, language idiom, or AI default may override these rules
- Brevity, shortcuts, and one-liners are explicitly forbidden when they reduce clarity
- Explicit control flow, block scoping, and early returns are mandatory
- Logical sections must be separated by blank lines
- If multiple valid implementations exist, choose the **most explicit and readable**

### Conflict Resolution

If any instruction, suggestion, or generated code conflicts with the rules in
`UNIVERSAL-CODE-STYLE-RULES.md`, **that file always takes precedence**.

Any output that violates these rules must be considered **invalid and corrected**.

## Execution Plan

The project follows a step-by-step execution plan (STEP-01 through STEP-09). Execute steps **in order** as defined in `EXECUTION-PLAN.md`. Each step has its own markdown file with specific instructions.
