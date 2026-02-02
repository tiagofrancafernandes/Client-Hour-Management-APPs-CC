```markdown
# TASK-03 — Credit Purchase (Migrations + Models)

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md)

## DESCRIPTION

Implement the credit purchase subsystem: migrations (wallet flag + two tables), Eloquent models, relationships and casts.

## SCOPE / REQUIREMENTS

1) Migrations
- Add `credit_purchase_allowed` boolean column to `wallets` (default false)
- Create `credit_purchases` table (wallet_id, customer_id, total_hours, total_price, currency_code, status enum, timestamps)
- Create `credit_purchase_payments` table (credit_purchase_id, payment_method enum, payment_status enum, pix_receipt_path, receipt_approved_by, receipt_approved_at, notes, timestamps)

2) Models
- `app/Models/CreditPurchase.php` with relationships `wallet()`, `customer()`, `payments()` and casts for decimals and status
- `app/Models/CreditPurchasePayment.php` with relationships `creditPurchase()`, `approvedBy()` and casts for enums and datetime
- Update `User` and `Wallet` models to include relationships to credit purchases/payments

3) Testing
- Run migrations and rollbacks, verify foreign keys and cascade behavior
- Test model relationships and casts in tinker

## IMPLEMENTATION STEPS
1. Create three migrations (add wallet column, create credit_purchases, create credit_purchase_payments)
2. Create models with relationships and casts
3. Update `User` and `Wallet` models
4. Run migrations and test via tinker

## FILES TO CREATE/MODIFY
- `database/migrations/*_add_credit_purchase_allowed_to_wallets_table.php` (new)
- `database/migrations/*_create_credit_purchases_table.php` (new)
- `database/migrations/*_create_credit_purchase_payments_table.php` (new)
- `app/Models/CreditPurchase.php` (new)
- `app/Models/CreditPurchasePayment.php` (new)
- `app/Models/User.php` (modify)
- `app/Models/Wallet.php` (modify)

---

## NOTES
- This file unifies migration and model tasks for the credit purchase feature into one task to simplify tracking and execution.

```
