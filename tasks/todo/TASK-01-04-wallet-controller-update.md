# TASK-01-04 — Update WalletController for Permission Filtering

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 04

## DESCRIPTION

Modify the WalletController to filter API responses based on user permissions, hiding `internal_note` field from users without `wallet.view_internal_note` permission.

## REQUIREMENTS

### WalletController Updates (`app/Http/Controllers/Api/WalletController.php`)

1. Update `show()` method to filter response:
   ```php
   public function show(Wallet $wallet)
   {
       $this->authorize('view', $wallet);

       $wallet->hideInternalNoteIfNotPermitted(auth()->user());

       return response()->json($wallet);
   }
   ```

2. Update `index()` method to filter all wallets:
   ```php
   public function index()
   {
       $wallets = Wallet::all();

       $wallets->each(function ($wallet) {
           $wallet->hideInternalNoteIfNotPermitted(auth()->user());
       });

       return response()->json($wallets);
   }
   ```

3. Update `update()` method to allow internal_note modification:
   - Verify user has `wallet.view_internal_note` permission before allowing edit
   - Log who modified the internal_note and when
   - Existing validation should handle this through policy

4. Add helper method to check permission:
   ```php
   private function ensureCanViewInternalNote(User $user): void
   {
       if (!$user->hasPermissionTo('wallet.view_internal_note')) {
           abort(403, 'Unauthorized to view internal notes');
       }
   }
   ```

### Implementation Steps
1. Locate `app/Http/Controllers/Api/WalletController.php`
2. Update `index()` method to filter each wallet
3. Update `show()` method to filter single wallet
4. Update `update()` method to check permission on internal_note changes
5. Add helper method for permission checking
6. Test endpoints with different user roles
7. Verify responses with postman or curl

### Files to Modify
- `app/Http/Controllers/Api/WalletController.php`

### Testing
- Test GET /api/wallets with user without permission → internal_note missing
- Test GET /api/wallets with admin user → internal_note present
- Test GET /api/wallets/:id with user without permission → internal_note missing
- Test GET /api/wallets/:id with admin user → internal_note present
- Test PUT /api/wallets/:id to update internal_note without permission → 403
- Test PUT /api/wallets/:id to update internal_note with permission → Success
- Test response structure with and without permission

---

## NOTES
- Use the Wallet model methods created in TASK-01-03
- Ensure policy authorization is checked first
- Consider using a resource class or trait for consistent filtering
- Next step will update the frontend composable
