# Testing Checklist: Payment Methods Feature

This document provides a comprehensive testing checklist for verifying the payment methods feature works correctly end-to-end across the system.

## Overview

The payment methods feature includes:
- Admin interface for managing payment methods (CRUD operations)
- Customer interface for selecting payment methods during purchase
- Payment method filtering (active/inactive states)
- Payment instructions display
- Permission-based access control

---

## Client Flow (Customer) Testing

### 1. Authentication & Navigation
- [ ] User can log in as a customer
- [ ] User can navigate to "Buy Credits" section
- [ ] Modal opens successfully

### 2. Buy Credits Modal - Payment Method Selection
- [ ] Modal displays correctly with all steps
- [ ] Navigation between steps works (Step 1 → Step 2 → Step 3)
- [ ] Clicking "Step 3 - Payment Method" shows payment options
- [ ] **Only ACTIVE payment methods are displayed to customer**
- [ ] Inactive payment methods are NOT visible
- [ ] Payment methods display in correct order (by `order` field)
- [ ] Each payment method shows: label, description (if any)

### 3. Payment Method Selection
- [ ] User can click on a payment method to select it
- [ ] Visual indicator shows selected method
- [ ] Selected method is highlighted/styled differently
- [ ] User can change selection by clicking another method

### 4. Payment Instructions Modal
- [ ] "View Instructions" button appears for payment methods with instructions
- [ ] Clicking "View Instructions" opens modal
- [ ] Modal displays all required information:
  - [ ] Payment method label
  - [ ] Payment amount/value
  - [ ] Full instruction text
  - [ ] Expiration date (if applicable)
- [ ] Information is accurately displayed (matches backend data)
- [ ] Close button (X) works correctly
- [ ] Modal can be closed by clicking outside

### 5. Copy Instructions Feature
- [ ] "Copy Instructions" button is present
- [ ] Button is clickable and functional
- [ ] Copy action works (text is copied to clipboard)
- [ ] User gets visual feedback (success message/toast)
- [ ] Copied content includes all instruction details

### 6. Purchase Completion
- [ ] After selecting payment method, user can proceed to purchase
- [ ] "Proceed" or "Complete Purchase" button works
- [ ] Selected payment method is saved with transaction
- [ ] Success message displays after purchase
- [ ] Customer receives payment confirmation/instructions

---

## Admin Flow Testing

### 1. Authentication & Navigation
- [ ] Admin user can log in successfully
- [ ] Admin dashboard loads correctly
- [ ] "Payment Methods" option appears in admin sidebar
- [ ] Non-admin users cannot access admin panel (permission denied)

### 2. Payment Methods List
- [ ] Payment Methods management page loads
- [ ] Table displays all payment methods:
  - [ ] ID
  - [ ] Label/Name
  - [ ] Status (Active/Inactive)
  - [ ] Order
  - [ ] Actions (Edit, Toggle, Delete if applicable)
- [ ] Page displays correct number of records
- [ ] Table is properly formatted and readable

### 3. Search Functionality
- [ ] Search input field is present
- [ ] Search by payment method label works
- [ ] Search results update in real-time
- [ ] Search is case-insensitive
- [ ] Clear search returns full list
- [ ] Empty search returns all methods

### 4. Filter by Status
- [ ] Filter dropdown/button for "Active" methods exists
- [ ] Filter dropdown/button for "Inactive" methods exists
- [ ] Filtering by "Active" shows only active methods
- [ ] Filtering by "Inactive" shows only inactive methods
- [ ] "All" filter shows all methods
- [ ] Filter state persists correctly

### 5. Edit Payment Method
- [ ] "Edit" button opens edit form/modal
- [ ] Edit form displays current values:
  - [ ] Label
  - [ ] Status (active/inactive toggle)
  - [ ] Order
  - [ ] Instructions (if applicable)
- [ ] Fields are editable
- [ ] Admin can change label
- [ ] Admin can toggle active/inactive status
- [ ] Admin can update order
- [ ] Admin can update instructions
- [ ] "Save" button saves changes
- [ ] Success message displays after save
- [ ] Changes are reflected in list immediately
- [ ] "Cancel" button discards changes

### 6. Toggle Active/Inactive Status
- [ ] Toggle button/checkbox appears for each method
- [ ] Clicking toggle changes status
- [ ] Status change is saved immediately (or after confirmation)
- [ ] Success message displays
- [ ] List updates to reflect new status
- [ ] Visual indicator changes (color, icon, etc.)

### 7. Deactivate Method
- [ ] Admin can deactivate a payment method
- [ ] Status changes to "Inactive"
- [ ] Method is marked as inactive in database
- [ ] Changes are reflected immediately in admin view

### 8. Sorting
- [ ] Payment methods can be sorted by Order field
- [ ] Drag-and-drop reordering works (if implemented)
- [ ] Manual order input works
- [ ] Changes to order are saved
- [ ] Customer sees methods in updated order

---

## End-to-End Integration Testing

### Active/Inactive State Propagation
- [ ] Admin activates a payment method
  - [ ] Method becomes visible to customers
  - [ ] Customer can select it immediately
- [ ] Admin deactivates a payment method
  - [ ] Method disappears from customer view
  - [ ] If already selected, customer sees update
  - [ ] Method cannot be selected

### Multiple Payment Methods
- [ ] System with 2+ active methods:
  - [ ] All active methods display for customer
  - [ ] All inactive methods are hidden
  - [ ] Customer can switch between options
  - [ ] Selected method is tracked correctly
- [ ] System with 1 active method:
  - [ ] Method displays and is automatically selected (if applicable)
  - [ ] Customer sees only this option
- [ ] System with 0 active methods:
  - [ ] Customer sees message "No payment methods available"
  - [ ] Purchase cannot proceed

### Payment Method with Instructions
- [ ] Method WITH instructions:
  - [ ] "View Instructions" button displays
  - [ ] Button is functional
  - [ ] Instructions modal shows correctly
  - [ ] All details are accurate
  - [ ] Copy feature works
- [ ] Method WITHOUT instructions:
  - [ ] "View Instructions" button does NOT display
  - [ ] No error occurs

### Order Consistency
- [ ] Admin sets specific order values (e.g., 1, 3, 5)
- [ ] Customer sees methods in correct order
- [ ] Order changes are reflected without page reload
- [ ] Order is preserved across sessions

---

## Permission & Security Testing

### Access Control
- [ ] Unauthenticated user:
  - [ ] Cannot access admin payment methods page
  - [ ] Cannot make API calls to admin endpoints
  - [ ] Redirected to login
- [ ] Regular customer:
  - [ ] Cannot access admin payment methods page
  - [ ] Cannot modify payment methods
  - [ ] Cannot make admin API calls
- [ ] Admin user:
  - [ ] Can access admin payment methods page
  - [ ] Can create/read/update payment methods
  - [ ] Can make all admin API calls

### Data Isolation
- [ ] Admin sees all methods (active and inactive)
- [ ] Customer sees only active methods
- [ ] Inactive methods do not appear in dropdown/list for customer
- [ ] Customer cannot select inactive method via URL manipulation

### API Security
- [ ] Admin endpoints require authentication
- [ ] Admin endpoints check admin role
- [ ] Customer cannot call admin update endpoints
- [ ] Customer can only read active methods
- [ ] Payment methods list endpoint filters correctly by role

---

## Performance Testing

### Load & Responsiveness
- [ ] Payment methods list loads within acceptable time (<2s)
- [ ] Search updates responsively
- [ ] Filter works without lag
- [ ] Modal opens/closes smoothly
- [ ] Edit form loads quickly
- [ ] Save changes completes within reasonable time

### Large Dataset Handling
- [ ] System with 100+ payment methods:
  - [ ] List loads correctly
  - [ ] Search works efficiently
  - [ ] No UI freezing
  - [ ] Pagination (if implemented) works

---

## Mobile Responsiveness Testing

### Customer Mobile Experience
- [ ] Modal displays correctly on mobile
- [ ] All buttons are touch-friendly
- [ ] Text is readable
- [ ] Instructions modal is usable on mobile
- [ ] Copy button works on mobile

### Admin Mobile Experience
- [ ] Payment methods list is readable on mobile
- [ ] Table scrolls horizontally if needed
- [ ] Search bar works on mobile
- [ ] Edit modal is usable on mobile
- [ ] Buttons are touch-friendly

---

## Error Handling Testing

### Validation
- [ ] Attempting to save with empty label shows error
- [ ] Invalid data formats show appropriate errors
- [ ] Duplicate labels are handled (if applicable)
- [ ] Error messages are clear and helpful

### Network Issues
- [ ] Network timeout during save shows error message
- [ ] Network timeout during load shows retry option
- [ ] User can retry failed operations
- [ ] No data corruption on failed saves

### State Recovery
- [ ] After error, user can retry operation
- [ ] Modal state is preserved after error
- [ ] List state is preserved after error
- [ ] No orphaned data created on failed operations

---

## Browser Compatibility Testing

- [ ] Chrome/Chromium (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] Mobile browsers (Chrome Mobile, Safari Mobile)

### Compatibility Checklist
- [ ] All features work across browsers
- [ ] No console errors
- [ ] Styling is consistent
- [ ] No layout issues
- [ ] Forms work correctly
- [ ] Modals display properly

---

## Database & Backend Validation

### Payment Methods Table
- [ ] Records are created with correct fields
- [ ] Active status is stored correctly
- [ ] Order field maintains correct values
- [ ] Instructions are stored securely
- [ ] Timestamps (created_at, updated_at) are set correctly

### API Responses
- [ ] GET endpoints return correct data
- [ ] PUT/POST endpoints validate input
- [ ] Error responses have appropriate status codes
- [ ] Response data matches expected structure
- [ ] Inactive methods are filtered in customer endpoints

---

## Regression Testing

After any changes, verify:

- [ ] Existing active methods still display to customers
- [ ] Existing inactive methods remain hidden
- [ ] Admin can still manage methods
- [ ] All previous test cases still pass
- [ ] No new errors introduced
- [ ] Performance is not degraded

---

## Sign-Off Checklist

Before considering the feature complete:

- [ ] All customer-facing tests pass
- [ ] All admin-facing tests pass
- [ ] Integration tests pass
- [ ] No permission/security issues found
- [ ] Performance is acceptable
- [ ] Mobile experience is good
- [ ] Cross-browser testing complete
- [ ] Database schema correct
- [ ] API responses correct
- [ ] Error handling works
- [ ] Code reviewed and merged
- [ ] Documentation updated
- [ ] Ready for production deployment

---

## Test Execution Notes

### How to Run Tests

1. **Setup Environment:**
   ```bash
   docker compose --env-file .env.docker up -d
   ```

2. **Customer Flow Testing:**
   - Log in as customer user
   - Navigate through Buy Credits modal
   - Test all payment method selections
   - Test instructions display
   - Complete test purchase

3. **Admin Flow Testing:**
   - Log in as admin user
   - Navigate to Payment Methods admin page
   - Test search and filtering
   - Test edit functionality
   - Test status toggling

4. **Integration Testing:**
   - Make admin changes
   - Verify changes appear in customer view
   - Test multiple scenarios
   - Verify no cross-contamination

5. **Automated Testing (if applicable):**
   ```bash
   # Run API tests
   docker compose --env-file .env.docker exec backend php artisan test

   # Run frontend tests
   docker compose --env-file .env.docker exec frontend npm run test
   ```

### Test Data

Use the following test scenarios:

**Scenario 1: Single Active Method**
- 1 active method: "Bank Transfer"
- Customer sees only this option

**Scenario 2: Multiple Active Methods**
- 2+ active methods with different orders
- Verify all display in correct order
- Verify all can be selected

**Scenario 3: Mixed Active/Inactive**
- 3+ methods total, 1-2 inactive
- Verify inactive are hidden from customer
- Verify admin sees all

**Scenario 4: Methods with Instructions**
- Create method with detailed instructions
- Test instructions display and copy

**Scenario 5: No Active Methods**
- Deactivate all methods
- Verify customer cannot complete purchase
- Verify admin still sees all methods

---

## Issues Found & Resolution

Document any issues found during testing:

| Issue | Severity | Status | Notes |
|-------|----------|--------|-------|
| Example: Button not responsive on mobile | Medium | Pending | Needs CSS fix |

---

## Final Notes

- Test in staging environment first
- Use same test data as production (sanitized)
- Document any deviations from expected behavior
- Get approval from product owner before production release
- Keep this checklist updated with any new scenarios discovered
