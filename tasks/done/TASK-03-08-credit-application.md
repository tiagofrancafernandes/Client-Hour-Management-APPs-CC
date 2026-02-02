# TASK-03-08 — Implement Credit Application Logic

## STATUS
✅ DONE

## DESCRIPTION
Create service to apply approved credits as ledger entries.

## REQUIREMENTS

Service: `CreditApplicationService`

Methods:
- applyCredit(CreditPurchase $purchase, CreditPurchasePayment $payment): bool
  - Create LedgerEntry with positive hours
  - Set reference_date to today
  - Set title: "Credit Purchase - {hours}h"
  - Update CreditPurchase status to 'confirmed'
  - Update CreditPurchasePayment status to 'completed'

Implementation Steps:
1. Create CreditApplicationService
2. Implement applyCredit() method
3. Add transaction handling
4. Call from PaymentApprovalController
5. Test credit creation

Files to Create:
- app/Services/CreditApplicationService.php

---
