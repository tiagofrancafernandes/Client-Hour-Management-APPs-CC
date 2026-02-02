# TASK-03-02 — Create Credit Purchase Models

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md) - Step 03-04

## DESCRIPTION

Create Eloquent models for CreditPurchase and CreditPurchasePayment with relationships and attribute casts.

## REQUIREMENTS

### CreditPurchase Model (`app/Models/CreditPurchase.php`)
Properties:
- id (unsignedBigInteger)
- wallet_id (unsignedBigInteger) - FK
- customer_id (unsignedBigInteger) - FK (the user who made purchase)
- total_hours (decimal)
- total_price (decimal)
- currency_code (string)
- status (enum: pending, approved, rejected, cancelled)
- timestamps

Relationships:
- `wallet()` - belongsTo Wallet
- `customer()` - belongsTo User
- `payments()` - hasMany CreditPurchasePayment

Casts:
- total_hours → decimal:2
- total_price → decimal:2
- status → string (native enum support)

### CreditPurchasePayment Model (`app/Models/CreditPurchasePayment.php`)
Properties:
- id (unsignedBigInteger)
- credit_purchase_id (unsignedBigInteger) - FK
- payment_method (enum: pix_offline, bank_transfer)
- payment_status (enum: pending, approved, rejected, completed)
- pix_receipt_path (string, nullable)
- receipt_approved_by (unsignedBigInteger, nullable) - FK
- receipt_approved_at (timestamp, nullable)
- notes (text, nullable)
- timestamps

Relationships:
- `creditPurchase()` - belongsTo CreditPurchase
- `approvedBy()` - belongsTo User (approved_by)

Casts:
- payment_method → string (native enum support)
- payment_status → string (native enum support)
- receipt_approved_at → datetime

### Implementation Steps
1. Create CreditPurchase model with relationships and casts
2. Create CreditPurchasePayment model with relationships and casts
3. Update User model to include `creditPurchases` and `creditPurchasePayments` relationships
4. Update Wallet model to include `creditPurchases` relationship
5. Test models via tinker

### Files to Create/Modify
- `app/Models/CreditPurchase.php` (new)
- `app/Models/CreditPurchasePayment.php` (new)
- `app/Models/User.php` (modify - add relationships)
- `app/Models/Wallet.php` (modify - add relationship)

### Testing
- Create test CreditPurchase record
- Access relationships (wallet, customer, payments)
- Verify attribute casts work correctly
- Test eager loading with includes

---

## NOTES
- Use PHP 8.1+ native enum support for payment_method and payment_status
- Implement proper cascading delete behavior
- Next step will create API controllers and routes
