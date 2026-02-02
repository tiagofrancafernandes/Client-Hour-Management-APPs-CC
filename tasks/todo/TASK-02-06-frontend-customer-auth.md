# TASK-02-06 — Detect Customer Role in Frontend Auth System

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 08

## DESCRIPTION

Update frontend auth system to detect and handle customer role differently from admin/operator/viewer roles.

## REQUIREMENTS

### Auth Composable Updates (`src/composables/useAuth.ts`)

1. Add customer detection method:
   ```typescript
   const isCustomer = computed(() => {
       return user.value?.roles?.includes('customer') ?? false;
   });
   ```

2. Add customer_id accessor:
   ```typescript
   const getCustomerId = (): number | null => {
       return user.value?.customer_id ?? null;
   };
   ```

3. Export new helpers

### Types Updates (`src/types/index.ts`)

1. Update User interface to include:
   ```typescript
   interface User {
       // ... existing fields
       customer_id?: number | null;
       roles?: string[];
   }
   ```

### Implementation Steps
1. Add isCustomer computed property
2. Add getCustomerId() method
3. Update User type interface
4. Export helpers from useAuth
5. Test customer role detection

### Files to Modify
- `src/composables/useAuth.ts`
- `src/types/index.ts`

### Testing
- Admin user: isCustomer = false
- Customer user: isCustomer = true
- getCustomerId() returns correct ID
- Roles array properly populated

---

## NOTES
- Customer role detection enables conditional UI rendering
- customer_id needed for filtered queries in composables
- Next task will use these helpers to hide UI elements
