# TASK-03-05 — Implement PIX Receipt Upload Storage

## STATUS

✅ DONE

## RELATED PLAN

[PLAN-TASK-03-credit-purchase.md](../plans/PLAN-TASK-03-credit-purchase.md) - Step 07

## DESCRIPTION

Implement file upload handling for PIX Offline payment receipts.

## REQUIREMENTS

### Storage Configuration

File: `.env`

```
FILESYSTEM_DISK=local
FILESYSTEM_VISIBILITY=private
```

### Create Storage Directories

```bash
mkdir -p storage/app/private/pix-receipts
chmod 700 storage/app/private/pix-receipts
```

### Implementation

1. Create PaymentReceiptController:
    - Endpoint: POST /api/credit-purchases/{id}/upload-receipt
    - Accept: multipart/form-data with 'receipt' file
    - Validate: PDF, PNG, JPG (max 5MB)
    - Store: storage/app/private/pix-receipts/{purchase_id}/
    - Return: file path for CreditPurchasePayment.pix_receipt_path

2. Update CreditPurchasePayment Model:
    ```php
    public function getReceiptUrl(): ?string
    {
        return $this->pix_receipt_path
            ? Storage::disk('private')->url($this->pix_receipt_path)
            : null;
    }
    ```

### Implementation Steps

1. Create PaymentReceiptController
2. Implement file upload endpoint
3. Add validation rules
4. Store files in private directory
5. Test upload with various file types

### Files to Create/Modify

- `app/Http/Controllers/Api/PaymentReceiptController.php` (new)
- `app/Models/CreditPurchasePayment.php` (add accessor)
- `routes/api.php` (add route)

### Testing

- Upload valid PDF/PNG/JPG
- Reject invalid file types
- Reject files > 5MB
- Verify file stored correctly
- Verify URL generation works

---

## NOTES

- Files stored in private directory
- Only authenticated users can download
- Admin can view in approval UI
