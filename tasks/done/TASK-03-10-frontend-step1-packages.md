# TASK-03-10 — Implement Step 1: Package Selection

## STATUS
✅ DONE

## DESCRIPTION
Implement first step of credit purchase modal: package selection with discount calculations.

## REQUIREMENTS

Display:
- 5 hours @ 10% discount
- 10 hours @ 15% discount  
- 15 hours @ 20% discount
- Custom input for other amounts (25% discount if >15h)

Calculations:
- base_price = hours * hourly_rate_reference
- discount_percent = (depends on hours)
- total_price = base_price * (1 - discount_percent/100)

Implementation Steps:
1. Create card component for packages
2. Implement hour calculation logic
3. Display price with discount percentage
4. Highlight selected package
5. Custom input for other amounts
6. Test calculations

Files to Modify:
- src/components/CreditPurchaseModal.vue

---
