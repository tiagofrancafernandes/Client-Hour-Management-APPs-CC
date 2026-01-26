# STEP 01 — Domain Model Definition

## GOAL

Define the **domain concepts** and naming conventions.
NO CODE YET.

---

## CONCEPTS (FINAL)

### Client
Represents a customer.
A client can have multiple wallets.

### Wallet
Represents a project or cost center.
Belongs to a client.
Holds ledger entries.
Balance is derived.

### LedgerEntry
Immutable record.
Represents a change in hours.
Can be positive or negative.

### Tag
Optional classification for ledger entries.

---

## RULES

- Balance is NEVER stored
- LedgerEntry.hours is signed (positive or negative)
- Adjustments are ledger entries
- Deleting entries is forbidden

---

## OUTPUT EXPECTED

- Confirm naming
- Confirm relationships
- Confirm invariants

Do NOT generate migrations or models yet.
