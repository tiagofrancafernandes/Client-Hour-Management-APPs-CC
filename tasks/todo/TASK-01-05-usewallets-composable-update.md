# TASK-01-05 — Update useWallets Composable for Internal Note

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 05

## DESCRIPTION

Update the `useWallets` composable to handle `internal_note` visibility state and provide methods to toggle visibility in the frontend.

## REQUIREMENTS

### useWallets Composable Updates (`src/composables/useWallets.ts`)

1. Update TypeScript types to include internal_note:
   ```typescript
   interface Wallet {
       id: number;
       client_id: number;
       name: string;
       description: string;
       hourly_rate_reference: Decimal;
       currency_code: string;
       internal_note?: string;  // ADD THIS
       credit_purchase_allowed: boolean;
       created_at: string;
       updated_at: string;
   }
   ```

2. Add visibility tracking state:
   ```typescript
   const internalNoteVisibility = ref<Record<number, boolean>>({});
   // Track which wallets have internal_note visible
   ```

3. Add method to toggle visibility:
   ```typescript
   const toggleInternalNoteVisibility = (walletId: number): void => {
       internalNoteVisibility.value[walletId] =
           !internalNoteVisibility.value[walletId];
   };
   ```

4. Add method to check if internal_note is visible:
   ```typescript
   const isInternalNoteVisible = (walletId: number): boolean => {
       return internalNoteVisibility.value[walletId] ?? false;
   };
   ```

5. Add method to check if user has permission:
   ```typescript
   const hasInternalNotePermission = (): boolean => {
       // Check from user store or auth state
       return auth.user?.permissions?.includes('wallet.view_internal_note') ?? false;
   };
   ```

6. Update fetchWallets() to ensure internal_note is properly typed
7. Update updateWallet() to handle internal_note modifications

### Implementation Steps
1. Open `src/composables/useWallets.ts`
2. Update Wallet interface to include internal_note field
3. Add internalNoteVisibility ref for tracking visibility state
4. Add toggleInternalNoteVisibility() method
5. Add isInternalNoteVisible() method
6. Add hasInternalNotePermission() method
7. Export all new methods and state
8. Update any existing methods that fetch/update wallets
9. Test in components

### Files to Modify
- `src/composables/useWallets.ts`

### Testing
- Verify Wallet type includes internal_note
- Test toggle visibility state persists in composable
- Test hasInternalNotePermission() returns correct value
- Verify fetchWallets() properly handles internal_note field
- Test with different user permissions
- Verify composable state is reactive

---

## NOTES
- Visibility state is frontend-only and independent of API response
- Permission check can reference user from auth composable
- Consider persistence (localStorage) for visibility preferences if needed
- Next step will add the UI toggle button
