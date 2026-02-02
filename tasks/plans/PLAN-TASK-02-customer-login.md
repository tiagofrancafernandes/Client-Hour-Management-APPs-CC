# PLAN-TASK-02 — Customer Login System

## GOAL

Implement customer user accounts with client association and role-based access control to customer-specific data.

---

## DESCRIPTION

Enable clients to have associated user accounts that can login and access customer-specific views:
- Customers can only see their own client's data
- Clients list filtered to show only their own client
- Wallets list shows only their own client's wallets
- Reports filtered automatically to customer's data
- Customer role with limited permissions compared to admin/operator roles

---

## EXECUTION STEPS

| Status | Step | Description |
|--------|------|-------------|
| ⬜ | 01 | Add `customer_id` column to users table (foreign key to clients) |
| ⬜ | 02 | Create 'customer' role in permissions/roles system |
| ⬜ | 03 | Define customer permissions (report.view, wallet.view, etc.) |
| ⬜ | 04 | Update UserController to allow customer user creation during client registration |
| ⬜ | 05 | Add customer association check in Client model |
| ⬜ | 06 | Implement wallet query scope to filter by customer's client |
| ⬜ | 07 | Implement report query scope to filter by customer's client |
| ⬜ | 08 | Update frontend auth system to detect customer role |
| ⬜ | 09 | Hide client selector in reports view for customers |
| ⬜ | 10 | Auto-filter wallets to customer's client in reports view |
| ⬜ | 11 | Create customer login view with simplified UI |
| ⬜ | 12 | Test customer access restrictions and data filtering |

---

## REQUIREMENTS

### Backend
- Migration to add customer_id to users table
- Customer role with appropriate permissions
- Query scopes for automatic data filtering
- User creation endpoint that supports customer_id
- Permission checks for customer access

### Frontend
- Detect customer role on login
- Conditional UI rendering (hide client selector, etc.)
- Automatic wallet filtering
- Customer-specific reports view
- Simplified navigation for customer role

### Testing
- Customer can only see own client's data
- Customer can't edit wallets or view internal notes
- Customer reports automatically filtered
- Customer can access reports and wallet views
