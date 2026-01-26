# STEP 03 — Eloquent Models

## GOAL

Create models and relationships.

---

## MODELS

- Client
- Wallet
- LedgerEntry
- Tag (if implemented)

---

## RELATIONSHIPS

- Client hasMany Wallets
- Wallet belongsTo Client
- Wallet hasMany LedgerEntries
- LedgerEntry belongsTo Wallet
- LedgerEntry belongsToMany Tags (optional)

---

## RULES

- No business logic
- No accessors for balance
- Only relationships and casts

---

## OUTPUT EXPECTED

- Models only
- Clean relationships
