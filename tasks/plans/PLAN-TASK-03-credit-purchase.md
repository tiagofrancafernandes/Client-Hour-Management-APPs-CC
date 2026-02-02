# PLAN-TASK-03 — Credit Purchase System

## GOAL

Implement a multi-step credit purchase flow allowing customers to buy hour packages and track payment status.

---

## DESCRIPTION

Create a complete credit purchase workflow:
- Modal with preset hour packages (5h, 10h, 15h) with discounts (10%, 15%, 20%)
- Custom hour input with automatic 25% discount if >15 hours
- Multi-step flow: select package → review → confirm payment method
- Support for Pix Offline (with receipt upload) and Bank Transfer payment methods
- Admin approval required for Pix Offline payments
- Automatic credit application after approval

---

## EXECUTION STEPS

| Status | Step | Description |
|--------|------|-------------|
| ⬜ | 01 | Add `credit_purchase_allowed` column to wallets table |
| ⬜ | 02 | Create credit purchase permission |
| ⬜ | 03 | Create CreditPurchase model and relationships |
| ⬜ | 04 | Create CreditPurchasePayment model for payment tracking |
| ⬜ | 05 | Create CreditPurchaseController with store/show endpoints |
| ⬜ | 06 | Create payment type validation and enum |
| ⬜ | 07 | Implement Pix Offline receipt upload storage |
| ⬜ | 08 | Create PaymentApprovalController for admin approval |
| ⬜ | 09 | Implement credit application logic (LedgerEntry creation on approval) |
| ⬜ | 10 | Create frontend multi-step modal component |
| ⬜ | 11 | Implement step 1: package selection with calculations |
| ⬜ | 12 | Implement step 2: review summary with total |
| ⬜ | 13 | Implement step 3: payment method selection |
| ⬜ | 14 | Implement file upload for Pix Offline |
| ⬜ | 15 | Create payment history/status view for customer |
| ⬜ | 16 | Create admin payment approval view |
| ⬜ | 17 | Test complete purchase flow and payment tracking |

---

## REQUIREMENTS

### Backend
- Migrations for credit_purchase and credit_purchase_payment tables
- CreditPurchase model with relationships
- CreditPurchasePayment model with payment_type enum
- Validation for hourly_rate_reference and currency_code requirements
- File upload handling for Pix Offline receipts
- Admin approval endpoint with credit application logic
- API endpoints for purchase creation and payment tracking

### Frontend
- Multi-step modal component
- Step 1: Package cards (5h/10h/15h) + custom input
- Step 2: Review summary with total price
- Step 3: Payment method selection
- File upload for Pix Offline
- Toast notifications for success/error
- Redirect to payment details after creation
- Payment history/status view
- Permission checks for credit_purchase

### Admin Panel
- View pending payment approvals
- Approve/reject Pix Offline payments
- View payment receipts
- Track payment history

### Testing
- Verify discount calculations (10%, 15%, 20%, 25%)
- Verify hourly_rate_reference and currency_code requirements
- Test file upload for Pix Offline
- Verify admin approval creates ledger entry
- Verify customer sees correct payment status
