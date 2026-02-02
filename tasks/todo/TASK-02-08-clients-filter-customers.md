# TASK-02-08 — Auto-Filter Clients List for Customer View

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 09

## DESCRIPTION

Update ClientsView to show only own client for customer users, hiding other clients.

## REQUIREMENTS

### ClientsView Updates (`src/views/ClientsView.vue`)

1. Filter clients list for customers:
   ```typescript
   const displayedClients = computed(() => {
       if (isCustomer) {
           return clients.value.filter(c => c.id === getCustomerId());
       }
       return clients.value;
   });
   ```

2. Hide add client button for customers:
   ```vue
   <CButton v-if="!isCustomer" @click="...">Add Client</CButton>
   ```

### Implementation Steps
1. Import isCustomer and getCustomerId from useAuth
2. Create computed displayedClients property
3. Render displayedClients instead of clients
4. Hide create button for customers
5. Test with customer user

### Files to Modify
- `src/views/ClientsView.vue` (likely ClientDetailView or clients list)

### Testing
- Admin sees all clients
- Customer sees only their client
- Customer cannot create new clients
- UI shows customer's client with full info

---

## NOTES
- Filtering happens on frontend computed property
- Customer can still edit their own client details
- Create button hidden for customer role
