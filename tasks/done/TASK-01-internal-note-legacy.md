````markdown
# TASK-01 — Internal Note (Backend + Frontend)

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md)

## DESCRIPTION

Implement permission-protected internal notes on Wallets across backend and frontend. This task unifies model, controller, composable, UI and testing steps.

## SCOPE / REQUIREMENTS

1) Backend
- Add `internal_note` column to wallets (migration) — nullable
- Add `internal_note` to `$fillable` in `app/Models/Wallet.php`
- Add model helpers: `hideInternalNoteIfNotPermitted(User $user): self` and `canViewInternalNote(User $user): bool`
- Update controllers (`app/Http/Controllers/Api/WalletController.php`) to filter responses in `index()` and `show()` using model helper, and protect `update()` for internal_note edits
- Add permission `wallet.view_internal_note` (seeder/roles)

2) Frontend
- Update `useWallets` composable (`src/composables/useWallets.ts`) to include `internal_note` in types and manage visibility state with methods `toggleInternalNoteVisibility`, `isInternalNoteVisible`, `hasInternalNotePermission`
- Add toggle eye button in wallet detail view (e.g., `src/views/WalletDetailView.vue` / `ClientDetailView.vue`) to show/hide internal_note; support edit mode textarea when permitted

3) Tests & Verification
- Migrations: run and rollback checks
- Model methods tested in `php artisan tinker`
- API: test GET index/show responses for admin vs regular user; test PUT behavior (403 when unauthorized)
- Frontend: test toggle behavior, edit mode, responsive layout, and state management

## IMPLEMENTATION STEPS
1. Create migration to add `internal_note` to `wallets` table
2. Update `app/Models/Wallet.php` (fillable, methods, relationship adjustments if needed)
3. Add/ensure permission `wallet.view_internal_note` and assign to admin role
4. Update `WalletController` methods (`index`, `show`, `update`) to use model filtering and permission checks
5. Update frontend composable `useWallets` with visibility methods and types
6. Add toggle button and edit UI in wallet detail view
7. Run backend and frontend tests and manual verification

## FILES TO CREATE/MODIFY
- `database/migrations/*_add_internal_note_to_wallets.php` (new)
- `app/Models/Wallet.php` (modify)
- `app/Http/Controllers/Api/WalletController.php` (modify)
- `database/seeders/RolesAndPermissionsSeeder.php` (modify to add permission)
- `src/composables/useWallets.ts` (modify)
- `src/views/WalletDetailView.vue` or `src/views/ClientDetailView.vue` (modify)

## ACCEPTANCE CRITERIA
- Admin users see `internal_note` values in API and frontend
- Non-admin users do not see `internal_note` in API responses or frontend UI
- Only users with permission can update `internal_note`
- Frontend toggle shows/hides internal_note per-wallet and behaves responsively

---

## NOTES
- This file consolidates the detailed step files for internal-note feature into a single task with ordered steps and acceptance criteria.

````
