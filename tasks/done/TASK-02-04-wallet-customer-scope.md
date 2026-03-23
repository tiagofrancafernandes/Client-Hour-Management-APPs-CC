# TASK-02-04 — Implement Wallet Query Scope for Customer Filtering

## STATUS

✅ DONE

## RELATED PLAN

[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 06

## DESCRIPTION

Add query scope to Wallet model to automatically filter wallets to a customer's associated client.

## REQUIREMENTS

### Wallet Model Updates (`app/Models/Wallet.php`)

1. Add scope to filter by customer:

    ```php
    public function scopeForCustomer(Builder $query, User $user): Builder
    {
        if (!$user || !$user->customer_id) {
            return $query->whereNull('client_id'); // No results if not a customer
        }

        return $query->where('client_id', $user->customer_id);
    }
    ```

2. Add helper to check if customer can access wallet:
    ```php
    public function canAccessAsCustomer(User $user): bool
    {
        return $this->client_id === $user->customer_id;
    }
    ```

### Implementation Steps

1. Add scopeForCustomer() query scope to Wallet model
2. Add canAccessAsCustomer() helper method
3. Update WalletController to use scope for customers
4. Test filtering with customer user

### Files to Modify

- `app/Models/Wallet.php`
- `app/Http/Controllers/Api/WalletController.php` (use the scope)

### Testing

- Customer sees only their own wallets
- Customer cannot access other client wallets
- scopeForCustomer() returns correct count
- Non-customer users unaffected

---

## NOTES

- Query scope makes filtering automatic and consistent
- Scope returns empty query if user not a customer
- WalletController should use this scope for customer requests
