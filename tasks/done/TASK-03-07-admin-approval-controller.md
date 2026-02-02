# TASK-03-07 — Create Admin Payment Approval Controller

## STATUS
✅ DONE

## DESCRIPTION
Create PaymentApprovalController for admin approval of PIX Offline payments.

## REQUIREMENTS

POST /api/payments/{id}/approve
- Admin only
- Update payment_status to 'approved'
- Set receipt_approved_by and receipt_approved_at
- Trigger credit application

POST /api/payments/{id}/reject
- Admin only
- Update payment_status to 'rejected'
- Add optional rejection reason

GET /api/payments/pending-approvals
- Admin only
- List pending PIX payments
- Include purchase details

Files to Create:
- app/Http/Controllers/Api/PaymentApprovalController.php

---
