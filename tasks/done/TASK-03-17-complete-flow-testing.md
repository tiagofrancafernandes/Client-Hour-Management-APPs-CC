# TASK-03-17 — Test Complete Credit Purchase Flow

## STATUS

✅ DONE

## DESCRIPTION

Comprehensive end-to-end testing of the complete credit purchase workflow.

## REQUIREMENTS

Test Scenarios:

1. Customer Flow:
    - [ ] Customer sees "Buy Credits" button
    - [ ] Opens modal and selects package
    - [ ] Reviews total and discount
    - [ ] Selects PIX payment method
    - [ ] Uploads receipt
    - [ ] Payment created with pending status
    - [ ] Sees payment in history
    - [ ] Waits for admin approval

2. Admin Approval Flow:
    - [ ] Admin sees pending payments
    - [ ] Views customer details
    - [ ] Downloads/views receipt
    - [ ] Approves payment
    - [ ] Credit automatically applied
    - [ ] Wallet balance increases
    - [ ] Ledger entry created
    - [ ] Customer sees status updated

3. Error Handling:
    - [ ] Invalid file type rejected
    - [ ] File too large rejected
    - [ ] Network errors handled
    - [ ] Validation messages clear

4. Data Validation:
    - [ ] Discount calculations correct
    - [ ] Total prices accurate
    - [ ] Currency codes consistent
    - [ ] Ledger entries correct

Testing Steps:

1. Create test customer user
2. Enable credit_purchase on wallet
3. Test customer purchase flow
4. Test admin approval flow
5. Verify balance updated
6. Verify ledger entry created
7. Test error scenarios
8. Load testing if possible

---
