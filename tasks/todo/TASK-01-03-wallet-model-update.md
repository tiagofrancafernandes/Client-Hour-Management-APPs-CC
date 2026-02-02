# TASK-01-03 — Update Wallet Model for Internal Note

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 03

## DESCRIPTION

Update the Wallet model to include the `internal_note` field in fillable attributes and add conditional hiding logic based on user permissions.

## REQUIREMENTS

### Wallet Model Updates (`app/Models/Wallet.php`)

1. Add `internal_note` to `$fillable` array:
   ```php
   protected $fillable = [
       'client_id',
       'name',
       'description',
       'hourly_rate_reference',
       'currency_code',
       'internal_note',        // ADD THIS
       'credit_purchase_allowed',
       // ... other fields
   ];
   ```

2. Add method to hide internal_note based on permission:
   ```php
   public function hideInternalNoteIfNotPermitted(User $user): self
   {
       if (!$user->hasPermissionTo('wallet.view_internal_note')) {
           unset($this->attributes['internal_note']);
       }
       return $this;
   }
   ```

3. Add helper method for checking permission:
   ```php
   public function canViewInternalNote(User $user): bool
   {
       return $user->hasPermissionTo('wallet.view_internal_note');
   }
   ```

### Implementation Steps
1. Open `app/Models/Wallet.php`
2. Add `internal_note` to fillable array
3. Add `hideInternalNoteIfNotPermitted()` method
4. Add `canViewInternalNote()` helper method
5. Test in tinker that methods work correctly

### Files to Modify
- `app/Models/Wallet.php`

### Testing
- Load wallet in tinker
- Verify `internal_note` field can be set and retrieved
- Test permission-based hiding with different users
- Test helper methods

---

## NOTES
- This model update prepares the Wallet for permission-based API responses
- Controller will use these methods to filter responses
- Next step will implement the controller filtering logic
