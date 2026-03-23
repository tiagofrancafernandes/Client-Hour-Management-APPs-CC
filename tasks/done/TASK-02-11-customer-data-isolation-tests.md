# TASK-02-11 — Test Customer Data Isolation and Access Control

## STATUS

✅ DONE

## RELATED PLAN

[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 12

## DESCRIPTION

Comprehensive testing to verify customer data isolation and access control at API and frontend level.

## REQUIREMENTS

### Backend Testing

#### API Endpoint Tests

- [ ] Customer GET /api/clients shows only their client
- [ ] Customer GET /api/clients/:id (other) returns 403
- [ ] Customer GET /api/clients/:id (own) returns 200
- [ ] Customer GET /api/wallets shows only own wallets
- [ ] Customer GET /api/wallets/:id (other) returns 403
- [ ] Customer GET /api/wallets/:id (own) returns 200
- [ ] Customer POST /api/wallets returns 403 (no permission)
- [ ] Customer GET /api/ledger-entries filtered to own wallets
- [ ] Customer GET /api/reports filtered to own client
- [ ] Admin endpoints unaffected by customer filtering

#### Permission Tests

- [ ] Customer has role 'customer'
- [ ] Customer has correct permissions
- [ ] Customer missing create/update/delete permissions
- [ ] Query scopes work correctly

#### Data Isolation Tests

- [ ] Customer A cannot see Client B data
- [ ] Customer A cannot see Wallet B (from Client B)
- [ ] Customer A cannot see Ledger B entries
- [ ] Admin can see all data

### Frontend Testing

#### UI Tests

- [ ] Customer login loads dashboard
- [ ] ClientsView shows only customer's client
- [ ] ReportsView hides client selector
- [ ] ReportsView auto-filters to customer's client
- [ ] Wallets list shows only own wallets
- [ ] Ledger entries filtered to own wallets

#### Permission Tests

- [ ] Customer cannot see "Add Client" button
- [ ] Customer cannot see create wallet option
- [ ] Customer cannot see internal notes
- [ ] Customer cannot edit wallet details

### Integration Tests

- [ ] Complete login flow for customer
- [ ] Customer dashboard loads correctly
- [ ] Navigation shows customer-appropriate options
- [ ] Reports display customer data only
- [ ] No cross-client data leaks

### Test Data Setup

```php
// Create test customers
$client1 = Client::create(['name' => 'Client 1', 'description' => 'Test Client 1']);
$client2 = Client::create(['name' => 'Client 2', 'description' => 'Test Client 2']);

$customer1 = User::create([
    'name' => 'Customer 1',
    'email' => 'customer1@test.com',
    'password' => Hash::make('password'),
    'customer_id' => $client1->id,
]);
$customer1->assignRole('customer');

$customer2 = User::create([
    'name' => 'Customer 2',
    'email' => 'customer2@test.com',
    'password' => Hash::make('password'),
    'customer_id' => $client2->id,
]);
$customer2->assignRole('customer');

// Create wallets for each client
Wallet::create([
    'client_id' => $client1->id,
    'name' => 'Project 1-A',
]);
Wallet::create([
    'client_id' => $client2->id,
    'name' => 'Project 2-A',
]);
```

### Success Criteria

✅ Complete customer data isolation
✅ No cross-client data visible
✅ All API endpoints enforce customer filtering
✅ Frontend UI respects customer role
✅ No 401/403 errors for authorized access
✅ Proper 403 for unauthorized access
✅ Admin access unaffected
✅ All tests pass

### Running Tests

```bash
# Backend tests
php artisan test --filter=CustomerTest

# Frontend tests (if available)
npm run test
```

---

## NOTES

- Data isolation is critical for security
- Every endpoint must verify customer access
- Frontend filtering prevents confusion but backend is authoritative
- Test both positive and negative cases
