# TASK-01-07 — Test Internal Note Feature End-to-End

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 07

## DESCRIPTION

Comprehensive testing of the internal note feature across backend and frontend to ensure proper permission enforcement and user experience.

## REQUIREMENTS

### Backend Testing

#### 1. Database & Migration Testing
- [ ] Run migration: `php artisan migrate`
- [ ] Verify `internal_note` column exists in wallets table
- [ ] Verify column is nullable
- [ ] Verify rollback works: `php artisan migrate:rollback`
- [ ] Verify column removed after rollback
- [ ] Test remigration: `php artisan migrate`

#### 2. Permission Testing
- [ ] Verify `wallet.view_internal_note` permission exists
- [ ] Verify permission assigned to admin role
- [ ] Verify permission NOT assigned to user role
- [ ] Test with `php artisan tinker`:
  ```php
  $admin = User::where('email', 'admin@test.com')->first();
  $admin->hasPermissionTo('wallet.view_internal_note'); // true

  $user = User::where('email', 'user@test.com')->first();
  $user->hasPermissionTo('wallet.view_internal_note'); // false
  ```

#### 3. Model Testing
- [ ] Test Wallet model methods:
  ```php
  $wallet = Wallet::first();
  $wallet->internal_note = 'Test note';
  $wallet->save(); // Should succeed

  // Test hideInternalNoteIfNotPermitted
  $user = User::find(1);
  $wallet->hideInternalNoteIfNotPermitted($user);

  // Test canViewInternalNote
  $wallet->canViewInternalNote($user);
  ```

#### 4. API Endpoint Testing
Test with curl or Postman:

**Test GET /api/wallets (list)**
- [ ] Login as admin → internal_note present in response
- [ ] Login as user → internal_note NOT in response
- [ ] Check status code 200
- [ ] Check response structure

**Test GET /api/wallets/:id (show)**
- [ ] Login as admin → internal_note present
- [ ] Login as user → internal_note NOT present
- [ ] Check status code 200
- [ ] Check other fields still present

**Test PUT /api/wallets/:id (update)**
- [ ] Login as admin, update internal_note → Success 200
- [ ] Login as user, attempt to update → Forbidden 403
- [ ] Verify internal_note actually updated in database
- [ ] Verify other fields can be updated by non-admin

**Test unauthorized access:**
- [ ] Request without auth token → 401
- [ ] Request with invalid token → 401
- [ ] Verify error messages are appropriate

### Frontend Testing

#### 1. Component & Permission Testing
- [ ] View wallet detail as admin → internal_note section visible
- [ ] View wallet detail as user → internal_note section hidden
- [ ] No console errors or warnings
- [ ] All other sections display correctly

#### 2. Toggle Button Testing
- [ ] Icon is eye-off by default (closed eye)
- [ ] Click toggle → icon changes to eye (open eye)
- [ ] Click toggle → icon changes back to eye-off
- [ ] Content hidden when eye-off
- [ ] Content visible when eye
- [ ] Toggle works multiple times

#### 3. Edit Mode Testing
- [ ] Admin can see edit button
- [ ] Admin can edit internal_note
- [ ] User cannot see edit button for internal_note
- [ ] Changes save correctly
- [ ] UI updates after save

#### 4. Responsive Design Testing
**Mobile (320px):**
- [ ] Internal note section visible
- [ ] Eye icon visible and clickable
- [ ] Text readable and not truncated
- [ ] Touch interactions work

**Tablet (768px):**
- [ ] Layout correct
- [ ] All elements visible
- [ ] Toggle functionality works

**Desktop (1920px):**
- [ ] Proper spacing
- [ ] Eye icon aligned correctly
- [ ] All elements properly sized

#### 5. State Management Testing
- [ ] Navigate away from wallet → state cleared
- [ ] Return to wallet → eye defaults to closed
- [ ] Multiple wallets have independent toggle states
- [ ] Refresh page → eye resets to closed

#### 6. Integration Testing
- [ ] Create wallet → internal_note field available to fill
- [ ] Fill internal_note → Saves to database
- [ ] Edit wallet → internal_note preserved
- [ ] Delete wallet → internal_note deleted with it

### Test Data Setup

Create test scenarios:

```php
// In tinker or seeder
$admin = User::find(1); // Admin user
$user = User::find(2);  // Regular user

$wallet = Wallet::first();
$wallet->internal_note = 'Confidential: Customer negotiating better rates';
$wallet->save();
```

### Testing Tools

- **Backend:** Postman, curl, tinker
- **Frontend:** Browser DevTools, console
- **API Testing:** Postman collection recommended

### Success Criteria

- ✅ Migration runs successfully
- ✅ Permission properly enforced at API level
- ✅ Admin users see internal_note, others don't
- ✅ Frontend toggle works independently
- ✅ Permission check works in controller
- ✅ No console errors
- ✅ Responsive on all screen sizes
- ✅ All tests pass (unit, feature, integration)
- ✅ Code passes linting (pint, prettier)

### Running Tests

```bash
# Backend tests
php artisan test

# Run specific test file
php artisan test tests/Feature/WalletTest.php

# Format code
./vendor/bin/pint

# Frontend tests (if available)
npm run test
```

### Documentation

- [ ] Document API response differences based on permission
- [ ] Update API documentation with permission requirements
- [ ] Create user guide for internal note feature
- [ ] Document permission requirements for roles

### Regression Testing

- [ ] Test all other wallet operations still work
- [ ] Test other models/features not affected
- [ ] Test existing API endpoints
- [ ] Test existing UI components

### Sign-Off Checklist

- [ ] All tests pass
- [ ] Code reviewed
- [ ] No regressions found
- [ ] Documentation updated
- [ ] Feature deployed to staging
- [ ] Smoke testing completed
- [ ] Feature marked as complete

---

## NOTES
- Test each permission level thoroughly
- Document any bugs found with reproduction steps
- Ensure no sensitive data leaks
- Verify security: non-permitted users truly cannot access internal_note
