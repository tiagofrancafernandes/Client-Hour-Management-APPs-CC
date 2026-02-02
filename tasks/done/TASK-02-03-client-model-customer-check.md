# TASK-02-03 — Add Customer Association Check to Client Model

## STATUS
✅ DONE

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 05

## DESCRIPTION

Add methods to Client model to check and manage customer association, and verify customer access to client data.

## REQUIREMENTS

### Client Model Updates (`app/Models/Client.php`)

1. Add relation to users (customers):
   ```php
   public function users(): HasMany
   {
       return $this->hasMany(User::class, 'customer_id');
   }
   ```

2. Add helper to check if user is customer of this client:
   ```php
   public function isUserCustomer(User $user): bool
   {
       return $user->customer_id === $this->id;
   }
   ```

3. Add scope to find client by customer user:
   ```php
   public function scopeByCustomer(Builder $query, User $user): Builder
   {
       return $query->where('id', $user->customer_id);
   }
   ```

### Implementation Steps
1. Add HasMany relationship to User model (customers)
2. Add isUserCustomer(User $user) helper method
3. Add scopeByCustomer() query scope
4. Test relationships in tinker

### Files to Modify
- `app/Models/Client.php`

### Testing
- Create test customer user
- Verify customer can access their client
- Verify customer cannot see other clients
- Test scopeByCustomer() returns correct data

---

## NOTES
- Customer can only access the client they are associated with
- This ensures data isolation between customers
- Query scopes will be used in controllers
