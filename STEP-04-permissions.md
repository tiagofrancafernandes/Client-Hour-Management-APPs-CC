# STEP 04 — Permissions & Roles

## GOAL

Implement access control.

---

## PACKAGE

- spatie/laravel-permission

---

## ROLES

- admin
- user

---

## RULES

Only admin can:
- create clients
- create wallets
- insert credits
- create adjustments

Users can:
- insert debits
- view reports

---

## OUTPUT EXPECTED

- Role setup
- Policies
- Middleware or Gates
