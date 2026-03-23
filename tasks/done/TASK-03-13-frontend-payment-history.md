# TASK-03-13 — Create Payment History View for Customers

## STATUS

✅ DONE

## DESCRIPTION

Create view for customers to see their credit purchase history and payment status.

## REQUIREMENTS

View: `CreditPurchaseHistoryView.vue`

Display:

- Table of all purchases
- Columns: Date, Hours, Total, Status, Actions
- Status badges: pending, approved, rejected, completed
- "View Details" button for each purchase

Details View:

- Purchase summary
- Payment method
- Payment status with approval date (if applicable)
- PIX receipt (download if approved)

Implementation Steps:

1. Create CreditPurchaseHistoryView.vue
2. Fetch purchases via API
3. Display table with pagination
4. Add status badges
5. Create details modal
6. Test with various statuses

Files to Create:

- src/views/CreditPurchaseHistoryView.vue

---
