# Hours Ledger System — Execution Plan

## Project Structure

| Component | Technology | Folder |
|-----------|------------|--------|
| Backend | Laravel 12 + PostgreSQL | `/backend` |
| Frontend | Vue 3 + TailwindCSS v4 | `/frontend` |

## Domain Rules (Strict)

- **Append-only ledger** — No deletes, everything is an insertion
- **No balance column** — Balance calculated via `SUM(ledger_entries.hours)`
- **Thin controllers** — Business logic in Services
- **English naming only**

## Execution Steps

| Status | Step | File | Description |
|--------|------|------|-------------|
| ✅ | 01 | [STEP-01-domain-model.md](STEP-01-domain-model.md) | Domain modeling and concepts |
| ✅ | 02 | [STEP-02-database.md](STEP-02-database.md) | Database schema and migrations |
| ✅ | 03 | [STEP-03-models.md](STEP-03-models.md) | Eloquent models and relationships |
| ✅ | 04 | [STEP-04-permissions.md](STEP-04-permissions.md) | Permissions and roles (Spatie) |
| ✅ | 05 | [STEP-05-services.md](STEP-05-services.md) | Business services |
| ✅ | 06 | [STEP-06-api.md](STEP-06-api.md) | API endpoints |
| ✅ | 07 | [STEP-07-frontend.md](STEP-07-frontend.md) | Frontend screens |
| ✅ | 08 | [STEP-08-reports.md](STEP-08-reports.md) | Reports with filters |
| ✅ | 09 | [STEP-09-validation.md](STEP-09-validation.md) | Validation and consistency |

## Implementation Summary

### Backend (`/backend`)

**Models**: `Client`, `Wallet`, `LedgerEntry`, `Tag`

**Services**:
- `BalanceCalculatorService` — Calculates balances via SUM
- `LedgerService` — Creates entries (credit/debit/adjustment)
- `ReportService` — Filtering and aggregation

**API Endpoints**: Clients, Wallets, Ledger Entries, Tags, Reports

### Frontend (`/frontend`)

**Views**: ClientsView, ClientDetailView, WalletDetailView, ReportsView, TagsView

**Composables**: useClients, useWallets, useLedger, useTags, useReports

## Setup Commands

```bash
# Backend
docker compose --env-file .env.docker exec backend composer require spatie/laravel-permission
docker compose --env-file .env.docker exec backend php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
docker compose --env-file .env.docker exec backend php artisan migrate
docker compose --env-file .env.docker exec backend php artisan db:seed --class=RolesAndPermissionsSeeder

# Frontend
docker compose --env-file .env.docker exec frontend npm install
```

## Local URLs

| Application | URL |
|-------------|-----|
| API | http://api.local.tiagoapps.com.br |
| Frontend | http://app.local.tiagoapps.com.br |
