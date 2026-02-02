# TASK-03-01 — Create Credit Purchase Tables

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md) - Steps 01-02

## DESCRIPTION

Create database migrations for credit purchase system including two new tables and a new wallet column.

## REQUIREMENTS

### Migrations to Create

#### 1. Add credit_purchase_allowed column to wallets
- Column: `credit_purchase_allowed` (BOOLEAN, default: false)

#### 2. Create credit_purchases table
Columns:
- `id` - BIGINT UNSIGNED PRIMARY KEY
- `wallet_id` - BIGINT UNSIGNED (foreign key to wallets)
- `customer_id` - BIGINT UNSIGNED (foreign key to users) - the user who made the purchase
- `total_hours` - DECIMAL(8,2)
- `total_price` - DECIMAL(10,2)
- `currency_code` - VARCHAR(3) - copied from wallet's hourly_rate_reference
- `status` - ENUM('pending', 'approved', 'rejected', 'cancelled') - default: 'pending'
- `timestamps`

#### 3. Create credit_purchase_payments table
Columns:
- `id` - BIGINT UNSIGNED PRIMARY KEY
- `credit_purchase_id` - BIGINT UNSIGNED (foreign key to credit_purchases)
- `payment_method` - ENUM('pix_offline', 'bank_transfer') - default: 'bank_transfer'
- `payment_status` - ENUM('pending', 'approved', 'rejected', 'completed') - default: 'pending'
- `pix_receipt_path` - VARCHAR(255), nullable - path to uploaded receipt
- `receipt_approved_by` - BIGINT UNSIGNED, nullable - admin who approved
- `receipt_approved_at` - TIMESTAMP, nullable
- `notes` - TEXT, nullable - admin notes on approval/rejection
- `timestamps`

### Implementation Steps
1. Create 3 migration files using artisan
2. Add column to wallets migration
3. Create credit_purchases migration
4. Create credit_purchase_payments migration
5. Add foreign keys with cascade delete
6. Run migrations: `php artisan migrate`
7. Verify all tables and columns exist

### Files to Create/Modify
- `database/migrations/YYYY_MM_DD_HHMMSS_add_credit_purchase_allowed_to_wallets_table.php` (new)
- `database/migrations/YYYY_MM_DD_HHMMSS_create_credit_purchases_table.php` (new)
- `database/migrations/YYYY_MM_DD_HHMMSS_create_credit_purchase_payments_table.php` (new)

### Testing
- Run all migrations successfully
- Verify all tables and columns exist
- Verify foreign key relationships
- Verify cascade delete behavior
- Verify rollback works for all migrations

---

## NOTES
- status field tracks overall purchase approval
- payment_status field tracks individual payment approval (may have multiple payment attempts)
- pix_receipt_path stores relative path from storage/app/public
- Next steps will create Eloquent models
