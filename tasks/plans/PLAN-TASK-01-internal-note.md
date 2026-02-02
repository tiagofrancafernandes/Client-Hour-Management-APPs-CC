# PLAN-TASK-01 — Internal Note Column

## GOAL

Add internal note column to wallets table with permission-based visibility control and frontend toggle functionality.

---

## DESCRIPTION

Add a new `internal_note` column to the wallets table that:
- Is restricted by permission at the API level
- Returns to frontend only if user has `wallet.view_internal_note` permission
- Has frontend toggle button (eye icon) to show/hide content
- Prevents unwanted exposure of internal notes during screen sharing or client viewing

---

## EXECUTION STEPS

| Status | Step | Description |
|--------|------|-------------|
| ✅ | 01 | Create migration to add `internal_note` column to wallets table |
| ✅ | 02 | Add permission `wallet.view_internal_note` to role definitions |
| ⬜ | 03 | Update Wallet model to handle hidden attributes based on permission |
| ⬜ | 04 | Modify WalletController to filter response based on user permission |
| ⬜ | 05 | Update useWallets composable to handle internal_note visibility |
| ⬜ | 06 | Add toggle button and state management in wallet detail view |
| ⬜ | 07 | Test permission enforcement and frontend toggle |

## Tasks

- ✅ [TASK-01-01-internal-note-migration.md](../done/TASK-01-01-internal-note-migration.md) - COMPLETED
- ✅ [TASK-01-02-internal-note-permission.md](../done/TASK-01-02-internal-note-permission.md) - COMPLETED
- ⬜ [TASK-01-03-wallet-model-update.md](../todo/TASK-01-03-wallet-model-update.md)
- ⬜ [TASK-01-04-wallet-controller-update.md](../todo/TASK-01-04-wallet-controller-update.md)
- ⬜ [TASK-01-05-usewallets-composable-update.md](../todo/TASK-01-05-usewallets-composable-update.md)
- ⬜ [TASK-01-06-frontend-toggle-button.md](../todo/TASK-01-06-frontend-toggle-button.md)
- ⬜ [TASK-01-07-internal-note-testing.md](../todo/TASK-01-07-internal-note-testing.md)

---

## REQUIREMENTS

### Backend
- Migration to add `internal_note` column (nullable, text)
- Permission check in wallet endpoints
- Conditional attribute hiding in API responses

### Frontend
- Toggle state for internal_note visibility (per wallet instance)
- Eye icon button to show/hide note content
- Type updates to include internal_note field

### Testing
- Verify non-permitted users don't see internal_note
- Verify permitted users can see and edit internal_note
- Verify frontend toggle works independently of visibility
