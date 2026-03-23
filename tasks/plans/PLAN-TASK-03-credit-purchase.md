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

| Status | Step | Description                                                           |
| ------ | ---- | --------------------------------------------------------------------- |
| ✅     | 01   | Add `credit_purchase_allowed` column to wallets table                 |
| ✅     | 02   | Create credit purchase permission                                     |
| ✅     | 03   | Create CreditPurchase model and relationships                         |
| ✅     | 04   | Create CreditPurchasePayment model for payment tracking               |
| ✅     | 05   | Create CreditPurchaseController with store/show endpoints             |
| ✅     | 06   | Create payment type validation and enum                               |
| ✅     | 07   | Implement Pix Offline receipt upload storage                          |
| ✅     | 08   | Create PaymentApprovalController for admin approval                   |
| ✅     | 09   | Implement credit application logic (LedgerEntry creation on approval) |
| ✅     | 10   | Create frontend multi-step modal component                            |
| ✅     | 11   | Implement step 1: package selection with calculations                 |
| ✅     | 12   | Implement step 2: review summary with total                           |
| ✅     | 13   | Implement step 3: payment method selection                            |
| ✅     | 14   | Implement file upload for Pix Offline                                 |
| ✅     | 15   | Create payment history/status view for customer                       |
| ✅     | 16   | Create admin payment approval view                                    |
| ✅     | 17   | Test complete purchase flow and payment tracking                      |

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

### Tasks to implements (verify if implemented and check it)

- [ ] [TASK-03-01-credit-purchase-migrations.md](../todo/TASK-03-01-credit-purchase-migrations.md)
- [ ] [TASK-03-02-credit-purchase-models.md](../todo/TASK-03-02-credit-purchase-models.md)
- [ ] [TASK-03-03-credit-purchase-controller.md](../todo/TASK-03-03-credit-purchase-controller.md)
- [ ] [TASK-03-04-payment-methods.md](../todo/TASK-03-04-payment-methods.md)
- [ ] [TASK-03-05-pix-receipt-upload.md](../todo/TASK-03-05-pix-receipt-upload.md)
- [ ] [TASK-03-06-payment-controller.md](../todo/TASK-03-06-payment-controller.md)
- [ ] [TASK-03-07-admin-approval-controller.md](../todo/TASK-03-07-admin-approval-controller.md)
- [ ] [TASK-03-08-credit-application.md](../todo/TASK-03-08-credit-application.md)
- [ ] [TASK-03-09-frontend-modal.md](../todo/TASK-03-09-frontend-modal.md)
- [ ] [TASK-03-10-frontend-step1-packages.md](../todo/TASK-03-10-frontend-step1-packages.md)
- [ ] [TASK-03-11-frontend-step2-review.md](../todo/TASK-03-11-frontend-step2-review.md)
- [ ] [TASK-03-12-frontend-step3-payment.md](../todo/TASK-03-12-frontend-step3-payment.md)
- [ ] [TASK-03-13-frontend-payment-history.md](../todo/TASK-03-13-frontend-payment-history.md)
- [ ] [TASK-03-14-admin-approval-view.md](../todo/TASK-03-14-admin-approval-view.md)
- [ ] [TASK-03-15-add-to-wallet-view.md](../todo/TASK-03-15-add-to-wallet-view.md)
- [ ] [TASK-03-16-discount-calculations.md](../todo/TASK-03-16-discount-calculations.md)
- [ ] [TASK-03-17-complete-flow-testing.md](../todo/TASK-03-17-complete-flow-testing.md)
