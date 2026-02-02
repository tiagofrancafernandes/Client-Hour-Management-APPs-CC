# TASK-03-14 — Create Admin Payment Approval View

## STATUS
✅ DONE

## DESCRIPTION
Create admin interface for viewing and approving pending PIX payments.

## REQUIREMENTS

View: `AdminPaymentApprovalsView.vue`

Display:
- Table of pending PIX payments
- Columns: Customer, Amount, Date, Receipt, Actions
- Filter: pending/approved/rejected
- Search by customer name

Actions:
- "View Receipt" button → download/view file
- "Approve" button → update status
- "Reject" button → modal with reason

Approval Flow:
- Confirm dialog before approval
- Apply credit automatically
- Show success message
- Refresh list

Implementation Steps:
1. Create AdminPaymentApprovalsView.vue
2. Fetch pending payments
3. Display table with filters
4. Add approval/reject buttons
5. Implement file download
6. Call approval endpoints
7. Test workflow

Files to Create:
- src/views/AdminPaymentApprovalsView.vue

---
