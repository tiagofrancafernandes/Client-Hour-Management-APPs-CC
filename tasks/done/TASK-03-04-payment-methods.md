# TASK-03-04 — Implement Payment Methods and Validation

## STATUS
✅ DONE

## RELATED PLAN
[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md) - Step 06

## DESCRIPTION

Create enums and validation for payment methods (PIX Offline, Bank Transfer).

## REQUIREMENTS

### Create Enum: `PaymentMethod`

File: `app/Enums/PaymentMethod.php`

```php
enum PaymentMethod: string
{
    case PIX_OFFLINE = 'pix_offline';
    case BANK_TRANSFER = 'bank_transfer';
}
```

### Create Enum: `PaymentStatus`

File: `app/Enums/PaymentStatus.php`

```php
enum PaymentStatus: string
{
    case PENDING = 'pending';
    case APPROVED = 'approved';
    case REJECTED = 'rejected';
    case COMPLETED = 'completed';
}
```

### Update CreditPurchasePayment Model

Add casts for enums:
```php
protected $casts = [
    'payment_method' => PaymentMethod::class,
    'payment_status' => PaymentStatus::class,
    'receipt_approved_at' => 'datetime',
];
```

### Implementation Steps
1. Create PaymentMethod enum
2. Create PaymentStatus enum
3. Update CreditPurchasePayment model with casts
4. Test enum values in tinker

### Files to Create/Modify
- `app/Enums/PaymentMethod.php` (new)
- `app/Enums/PaymentStatus.php` (new)
- `app/Models/CreditPurchasePayment.php` (update casts)

### Testing
- Enum values validate correctly
- Database stores enum values
- Model casts work properly

---

## NOTES
- PIX_OFFLINE requires receipt upload and admin approval
- BANK_TRANSFER auto-completes
