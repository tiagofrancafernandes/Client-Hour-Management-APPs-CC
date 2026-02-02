# TASK-02-05 — Implement Ledger Entry Query Scope for Customer Filtering

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 07

## DESCRIPTION

Add query scope to LedgerEntry model to automatically filter ledger entries to a customer's associated client's wallets.

## REQUIREMENTS

### LedgerEntry Model Updates (`app/Models/LedgerEntry.php`)

1. Add scope to filter by customer (through wallet):
   ```php
   public function scopeForCustomer(Builder $query, User $user): Builder
   {
       if (!$user || !$user->customer_id) {
           return $query->whereRaw('false'); // No results if not a customer
       }

       // Filter to ledger entries where wallet belongs to customer's client
       return $query->whereHas('wallet', function (Builder $q) use ($user) {
           $q->where('client_id', $user->customer_id);
       });
   }
   ```

### Implementation Steps
1. Add scopeForCustomer() query scope to LedgerEntry model
2. Update LedgerService to use scope for customers
3. Test filtering with customer user

### Files to Modify
- `app/Models/LedgerEntry.php`
- `app/Services/LedgerService.php` (apply scope in getWalletEntries)

### Testing
- Customer sees only ledger entries for their wallets
- Customer cannot access other client ledger entries
- Filtering works in wallet entries view

---

## NOTES
- Scope uses whereHas() to join through wallet relationship
- Returns empty query if user not a customer
- LedgerService should apply scope automatically
