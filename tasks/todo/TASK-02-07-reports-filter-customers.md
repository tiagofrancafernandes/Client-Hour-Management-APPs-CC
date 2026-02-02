# TASK-02-07 — Hide Client Selector and Auto-Filter Reports for Customers

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-02-customer-login.md](../plans/PLAN-TASK-02-customer-login.md) - Step 09-10

## DESCRIPTION

Update ReportsView to hide client selector for customers and automatically filter reports to customer's client.

## REQUIREMENTS

### ReportsView Updates (`src/views/ReportsView.vue`)

1. Hide client selector for customers:
   ```vue
   <div v-if="!isCustomer" class="mb-4">
       <!-- Client selector -->
   </div>
   ```

2. Auto-set filters for customer:
   ```typescript
   onMounted(async () => {
       if (isCustomer) {
           filters.value.client_id = getCustomerId();
           await fetchReport();
       } else {
           // Load saved filters or defaults
       }
   });
   ```

3. Disable client filter for customers:
   ```typescript
   const canChangeClientFilter = computed(() => !isCustomer);
   ```

### Implementation Steps
1. Import isCustomer and getCustomerId from useAuth
2. Hide client selector when isCustomer is true
3. Disable client_id filter changes for customers
4. Auto-populate client_id on mount for customers
5. Test with customer user

### Files to Modify
- `src/views/ReportsView.vue`

### Testing
- Admin sees client selector
- Customer doesn't see client selector
- Customer reports auto-filtered to their client
- Customer cannot change client filter
- Reports show correct data

---

## NOTES
- Customer always sees filtered view of own client
- Client selector hidden but not completely removed (for simplicity)
- Auto-filtering happens on component mount
