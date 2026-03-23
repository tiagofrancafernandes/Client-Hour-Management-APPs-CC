# TASK-03-09 — Create Credit Purchase Modal Component

## STATUS

✅ DONE

## DESCRIPTION

Create multi-step modal component for credit purchase workflow.

## REQUIREMENTS

Component: `CreditPurchaseModal.vue`

Features:

- Multi-step flow (package → review → payment)
- Step 1: Package selection
    - Cards: 5h (10%), 10h (15%), 15h (20%)
    - Custom input with 25% discount if >15h
    - Real-time price calculation

- Step 2: Review summary
    - Display selected hours, total price, discount
    - Show currency and hourly rate

- Step 3: Payment method
    - PIX Offline or Bank Transfer options
    - File upload for PIX
    - Submit button

Implementation Steps:

1. Create CreditPurchaseModal.vue
2. Implement step 1: package cards + calculations
3. Implement step 2: review display
4. Implement step 3: payment selection + upload
5. Add form validation
6. Test component

Files to Create:

- src/components/CreditPurchaseModal.vue

---
