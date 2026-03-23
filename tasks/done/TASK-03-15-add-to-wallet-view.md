# TASK-03-15 — Add Credit Purchase Button to Wallet View

## STATUS

✅ DONE

## DESCRIPTION

Add "Buy Credits" button and modal integration to wallet detail view.

## REQUIREMENTS

Wallet Detail View Updates:

- Add "Buy Credits" button near balance
- Only show if credit_purchase_allowed is true
- Only show if user is customer
- Open CreditPurchaseModal when clicked

Modal Integration:

- Pass wallet_id to modal
- Auto-select wallet
- Handle success (refresh balance)
- Show confirmation message

Implementation Steps:

1. Add button to wallet detail view
2. Implement permission check
3. Pass wallet data to modal
4. Handle modal events
5. Refresh wallet on success
6. Test integration

Files to Modify:

- src/views/WalletDetailView.vue

---
