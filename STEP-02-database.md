# STEP 02 — Database Schema & Migrations

## GOAL

Create database migrations ONLY.

---

## DATABASE
- PostgreSQL
- Use numeric for hours
- Use foreign keys
- Add indexes where needed

---

## TABLES TO CREATE

### clients
- id
- name
- notes (nullable)
- timestamps

### wallets
- id
- client_id
- name
- description (nullable)
- hourly_rate_reference (nullable)
- timestamps

### ledger_entries
- id
- wallet_id
- hours (numeric, signed)
- title (nullable)
- description (nullable)
- reference_date (nullable)
- timestamps

### tags (optional)
- id
- name

### ledger_entry_tag (pivot, optional)
- ledger_entry_id
- tag_id

---

## RULES

- NO balance column
- NO soft deletes
- NO seeders yet

---

## OUTPUT EXPECTED

- Laravel migrations only
- No models
- No controllers
