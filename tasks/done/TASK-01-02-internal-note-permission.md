# TASK-01-02 — Add Internal Note Permission

## STATUS
✅ DONE

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 02

## DESCRIPTION

Add the `wallet.view_internal_note` permission to the permissions system and assign it to appropriate roles.

## REQUIREMENTS

### Permission Definition
- Permission name: `wallet.view_internal_note`
- Description: "View internal notes on wallets"
- Assign to: admin role (by default)

### Implementation Steps
1. Create permission in RolesAndPermissionsSeeder if not exists
2. Add permission to admin role
3. Verify permission is created in database via tinker

### Files to Create/Modify
- `database/seeders/RolesAndPermissionsSeeder.php` (modify)

### Testing
- Run seeder: `php artisan db:seed --class=RolesAndPermissionsSeeder`
- Verify permission exists in permissions table
- Verify admin role has this permission

### Database Query Example
```php
// Tinker check
Spatie\Permission\Models\Permission::where('name', 'wallet.view_internal_note')->first();
Role::findByName('admin')->hasPermissionTo('wallet.view_internal_note');
```

---

## NOTES
- This permission should be checked in API responses to conditionally hide/show internal_note
- Only users with this permission will see internal_note in API responses
- Next step will implement the API filtering logic
