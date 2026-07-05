# AGENTS.md

This file provides guidance to coding agents when working in this repository.

## Scope

This `AGENTS.md` applies to the backend repository at `./backend`, while also documenting the related frontend application and the project-level context that must be considered during development.

## Required Reading

To understand the project before making changes, read these files:

- `CLAUDE.md`
- `backend/CLAUDE.md`
- `frontend/CLAUDE.md`

## Project Overview

**Hour Ledger System** is a client hour tracking application that follows a strict **ledger-based model**.

### Applications

#### Frontend Application

- Path: `./frontend`
- URL: `http://local-frontend.com`

#### Backend Application

- Path: `./backend`
- URL: `http://local-8000.com`
- API URL: `http://local-8000.com/api`

## Admin Access

- Email: `admin@mail.com`
- Password: `power@123`

## Tech Stack

### Backend

- Laravel 12
- PHP 8.2+
- PostgreSQL 16
- Redis 7
- Laravel Sanctum
- Spatie Laravel Permission
- PSR-12 via Laravel Pint

### Frontend

- Vue 3.5+
- Vite 7
- TypeScript 5.9+
- TailwindCSS v4
- Vue Router 4
- Prettier

### Infrastructure

- Docker Compose

## Critical Domain Rules

This system follows strict **append-only ledger** principles:

- **NO balance columns**. Balance is always calculated from ledger entries.
- **NO deletes**. All changes are insertions, including adjustments.
- **NO soft deletes**. Data is immutable.
- `LedgerEntry.hours` is signed.
- Positive values represent credit.
- Negative values represent debit.

### Domain Entities

- **Client** has many **Wallets**
- **Wallet** belongs to **Client** and has many **LedgerEntries**
- **LedgerEntry** is an immutable record of hour changes
- **Tag** is an optional classification for entries

## Architecture Guidelines

### Backend

- Keep controllers thin.
- Put business logic in Services.
- Prefer dedicated services such as `BalanceCalculatorService`, `LedgerService`, and `ReportService`.
- Use `$request->input('field')` instead of `$request->field`.
- API endpoints require `auth:sanctum`.

### Frontend

- Use Vue Composition API with TypeScript.
- Prefer API-driven components with minimal business logic in views/components.
- Use centralized API communication in `services/api.ts`.
- Respect configured path aliases from `vite.config.ts`.
- For conditional classes in Vue, use object syntax instead of ternary operators.
- TailwindCSS v4 uses `@import "tailwindcss"` and not `@tailwind` directives.

## UI and Frontend Rules

When creating or modifying frontend code or UI, use the skill `/tailwind-ui`.

Also respect the established frontend design system and reusable components described in the project documentation, including:

- `frontend/design/design.json`
- `src/components/CButton.vue`
- `src/components/CInput.vue`
- `src/components/CSelect.vue`
- `src/components/CTextarea.vue`
- `src/components/CDropZone.vue`

### Frontend Conventions

- Prefer the global `CButton` component instead of raw button styling when applicable.
- Use the toast helper from `@/composables/useToast` for feedback messages.
- Maintain the existing responsive and design-system patterns.

## Development Commands

### Backend

```bash
php artisan migrate
php artisan test
php artisan test --filter=TestName
./vendor/bin/pint
php artisan route:list --path=api
php artisan tinker
php artisan db:seed --class=RolesAndPermissionsSeeder
```

### Frontend

```bash
npm install
npm run dev
npm run build
npm run preview
vue-tsc -b
```

### Docker

```bash
docker compose --env-file .env.docker up -d --build
docker compose --env-file .env.docker up -d
docker compose --env-file .env.docker down
docker compose --env-file .env.docker exec backend php artisan migrate
docker compose --env-file .env.docker exec backend php artisan test
docker compose --env-file .env.docker exec backend ./vendor/bin/pint
docker compose --env-file .env.docker exec frontend npm install
docker compose --env-file .env.docker exec frontend npm run build
```

## Backend API Surface

All endpoints require `auth:sanctum` middleware.

- Clients: `GET/POST /api/clients`, `GET/PUT/DELETE /api/clients/{id}`
- Wallets: `GET/POST /api/wallets`, `GET/PUT/DELETE /api/wallets/{id}`
- Wallet Balance: `GET /api/wallets/{id}/balance`
- Wallet Entries: `GET /api/wallets/{id}/entries`
- Ledger Entries: `GET/POST /api/ledger-entries`, `GET /api/ledger-entries/{id}`
- Tags: `GET/POST /api/tags`, `GET/PUT/DELETE /api/tags/{id}`
- Reports: `GET /api/reports`, `GET /api/reports/summary`, `GET /api/reports/by-wallet`, `GET /api/reports/by-client`

## Permissions

Managed via Spatie Laravel Permission:

- `admin`: full access to clients, wallets, credits, and adjustments
- `user`: view access, debit insertion, and reports

## Code Style Rules

Respect the rules defined in `UNIVERSAL-CODE-STYLE-RULES.md`.

These rules are mandatory and take precedence over framework conventions, language idioms, and assistant defaults.

### Enforcement

- Prefer readability over brevity.
- Use explicit control flow.
- Use braces in all control structures.
- Avoid one-line conditionals and loops.
- Prefer guard clauses and early returns.
- Avoid unnecessary `else` blocks.
- Use block-scoped variables.
- Separate logical sections with blank lines.
- If two implementations are valid, choose the most explicit and readable.

If any instruction conflicts with `UNIVERSAL-CODE-STYLE-RULES.md`, that file wins.

## Execution Notes

- Treat backend and frontend as related applications.
- Before making changes, gather context from the required reading files.
- Preserve the append-only ledger model in every implementation.
- Do not introduce logic that depends on mutable balance columns or destructive record updates.
