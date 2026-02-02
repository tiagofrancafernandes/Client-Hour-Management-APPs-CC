# TASK-03-06 — Create Payment Creation Controller

## STATUS
✅ DONE

## DESCRIPTION
Create PaymentController to handle payment method selection and CreditPurchasePayment creation.

## REQUIREMENTS

POST /api/credit-purchases/{id}/payments
- Validate payment_method (pix_offline or bank_transfer)
- Create CreditPurchasePayment record
- Set initial status (pending for pix_offline, approved for bank_transfer)
- Return payment details

Implementation Steps:
1. Create PaymentController in Http/Controllers/Api
2. Implement store() method
3. Add validation for payment_method
4. Create CreditPurchasePayment
5. Test endpoint

Files to Create:
- app/Http/Controllers/Api/PaymentController.php

---
