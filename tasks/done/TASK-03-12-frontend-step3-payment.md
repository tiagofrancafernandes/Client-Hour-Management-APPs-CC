# TASK-03-12 — Implement Step 3: Payment Method Selection

## STATUS

✅ DONE

## DESCRIPTION

Implement third step: payment method selection and file upload.

## REQUIREMENTS

Payment Methods:

- PIX Offline: Shows file upload for receipt
- Bank Transfer: Shows account details (to be configured)

File Upload:

- Accept: PDF, PNG, JPG
- Max size: 5MB
- Display preview or filename
- Validation before submit

Implementation Steps:

1. Create payment method selector
2. Implement conditional rendering for upload
3. Add file input with validation
4. Show file preview/name
5. Implement submit logic (call API)
6. Handle success/error
7. Test with various files

Files to Modify:

- src/components/CreditPurchaseModal.vue

---
