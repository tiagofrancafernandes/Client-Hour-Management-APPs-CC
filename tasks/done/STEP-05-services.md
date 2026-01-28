# STEP 05 — Business Services

## GOAL

Centralize business logic.

---

## SERVICES

### BalanceCalculatorService
- Calculates wallet balance
- Uses SUM of ledger entries

### ReportService
- Aggregates entries
- Applies filters

---

## RULES

- No DB logic in controllers
- Services only
- Pure PHP logic

---

## OUTPUT EXPECTED

- Service classes
- Unit-test–ready code
