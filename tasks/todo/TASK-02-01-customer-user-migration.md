# TASK-02-01 — Add Customer Association to Users

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 01

## DESCRIPTION

Create a database migration to add the `customer_id` foreign key column to the users table, establishing the relationship between users and clients.

## REQUIREMENTS

### Migration Details
- Add `customer_id` column to users table
- Type: `BIGINT UNSIGNED`, nullable
- Foreign key references `clients.id` with cascade delete
- Run Laravel migration: `php artisan make:migration add_customer_id_to_users_table`
- Migration file location: `database/migrations/`

### Implementation Steps
1. Generate migration file with artisan command
2. Add column: `$table->unsignedBigInteger('customer_id')->nullable();`
3. Add foreign key: `$table->foreign('customer_id')->references('id')->on('clients')->onDelete('cascade');`
4. Implement down() method to drop foreign key and column
5. Run migration: `php artisan migrate`
6. Verify foreign key relationship in database

### Files to Create/Modify
- `database/migrations/YYYY_MM_DD_HHMMSS_add_customer_id_to_users_table.php` (new)

### Testing
- Run migration successfully
- Verify column and foreign key exist
- Verify rollback works
- Verify cascade delete behavior

---

## NOTES
- This column will be nullable to support admin/operator users who don't represent a specific customer
- Next step will be creating the customer role
