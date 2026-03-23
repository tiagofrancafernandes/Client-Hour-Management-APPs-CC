# TASK-02-10 — Implement Backend Customer Filtering in Endpoints

## STATUS

✅ DONE

## RELATED PLAN

[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 04-06

## DESCRIPTION

Update API controllers to automatically apply customer filtering when user is a customer.

## REQUIREMENTS

### Controller Updates

1. **ClientController** (show endpoint):

    ```php
    public function show(Client $client)
    {
        // If customer, ensure they own this client
        if (auth()->user()->hasRole('customer')) {
            if ($client->id !== auth()->user()->customer_id) {
                abort(403);
            }
        }
        return response()->json($client);
    }
    ```

2. **WalletController** (index endpoint):

    ```php
    public function index(Request $request)
    {
        $query = Wallet::query();

        // Apply customer filtering
        if (auth()->user()->hasRole('customer')) {
            $query->forCustomer(auth()->user());
        }

        return response()->json($query->paginate());
    }
    ```

3. **LedgerService**:
    ```php
    public function getWalletEntries(Wallet $wallet, int $perPage)
    {
        // Verify customer can access this wallet
        if (auth()->user()->hasRole('customer')) {
            abort_if(!$wallet->canAccessAsCustomer(auth()->user()), 403);
        }
        // ... fetch entries
    }
    ```

### Implementation Steps

1. Update ClientController show() with customer check
2. Update WalletController index() with scope
3. Update WalletController show() with permission check
4. Update LedgerService with wallet access check
5. Update ReportService with customer filtering
6. Test all endpoints with customer user

### Files to Modify

- `app/Http/Controllers/Api/ClientController.php`
- `app/Http/Controllers/Api/WalletController.php`
- `app/Services/LedgerService.php`
- `app/Services/ReportService.php`

### Testing

- Customer can only see own client
- Customer can only see own wallets
- Customer can only see own ledger entries
- Non-customer endpoints unaffected
- 403 errors for unauthorized access

---

## NOTES

- Filtering applied at API level for security
- Scope methods ensure data isolation
- Consistent filtering across all endpoints
