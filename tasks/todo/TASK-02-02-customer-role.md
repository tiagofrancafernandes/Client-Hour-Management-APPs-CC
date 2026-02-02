# TASK-02-02 — Create Customer Role

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 02-03

## DESCRIPTION

Create the customer role and assign appropriate permissions for customer access.

## REQUIREMENTS

### Customer Role Definition
- Role name: `customer`
- Description: "Customer/Client access to own data"

### Permissions to Assign to Customer Role
- `report.view` - View reports (filtered to own data)
- `wallet.view` - View wallets (filtered to own data)
- `ledger_entry.view` - View ledger entries (filtered to own data)

### Implementation Steps
1. Create customer role in RolesAndPermissionsSeeder
2. Assign required permissions to customer role
3. Verify role and permissions exist via tinker

### Files to Create/Modify
- `database/seeders/RolesAndPermissionsSeeder.php` (modify)

### Testing
- Run seeder: `php artisan db:seed --class=RolesAndPermissionsSeeder`
- Verify role exists in roles table
- Verify customer role has all required permissions
- Create test customer user and assign role

### Database Query Example
```php
// Tinker check
$customerRole = Role::findByName('customer');
$customerRole->hasPermissionTo('report.view');
$customerRole->hasPermissionTo('wallet.view');
$customerRole->hasPermissionTo('ledger_entry.view');
```

---

## NOTES
- Customer role is read-only (no create/update/delete permissions)
- Customer can only access data for their associated client
- Next step will implement query scopes for automatic filtering
