# TASK-03-03 — Create Credit Purchase API Endpoints

## STATUS

✅ DONE

## RELATED PLAN

[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md) - Step 05

## DESCRIPTION

Create CreditPurchaseController with endpoints for creating and viewing credit purchases.

## REQUIREMENTS

### Controller: `CreditPurchaseController`

**POST /api/credit-purchases** (Create)

```php
public function store(Request $request): JsonResponse
{
    // Validate user is customer or admin
    // Validate wallet_id exists and belongs to user
    // Validate hourly_rate_reference exists
    // Create CreditPurchase with status='pending'
    // Return purchase with payment options
}
```

**GET /api/credit-purchases/{id}** (Show)

```php
public function show(CreditPurchase $purchase): JsonResponse
{
    // Authorize view (owner or admin)
    // Return purchase with relationships
}
```

**GET /api/credit-purchases** (List customer's purchases)

```php
public function index(): JsonResponse
{
    // For customers: show only their purchases
    // For admin: show all purchases
    // Include payment status
}
```

### Implementation Steps

1. Create `CreditPurchaseController` in `Http/Controllers/Api`
2. Implement store() with validation
3. Implement show() with authorization
4. Implement index() with filtering
5. Add routes in api.php
6. Test endpoints with curl

### Files to Create/Modify

- `app/Http/Controllers/Api/CreditPurchaseController.php` (new)
- `routes/api.php` (add routes)

### Testing

- POST creates valid purchase
- GET /show returns purchase
- GET /index filters customer purchases
- Unauthorized access returns 403

---

## NOTES

- Purchases created with status='pending'
- Next step creates payment tracking
