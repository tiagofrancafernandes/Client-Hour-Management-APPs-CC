# PLAN — Features Janeiro 2026

## Objetivo

Implementar 4 novas funcionalidades no sistema de gestão de horas:
1. Tags para categorização de registros
2. Exportação de relatórios (PDF/Excel)
3. Timer para registro de horas em tempo real
4. Importação de registros via planilha

---

## Execution Steps

| Status | Priority | File | Description |
|--------|----------|------|-------------|
| ✅ | 01 | [TASK-01-tags-feature.md](../done/TASK-01-tags-feature.md) | Feature de tags (backend + frontend) |
| ✅ | 02 | [TASK-02-report-export.md](../done/TASK-02-report-export.md) | Exportação de relatórios PDF/Excel |
| 🔄 | 03 | [TASK-03-timer-feature.md](../doing/TASK-03-timer-feature.md) | Timer para registro de horas |
| ⬜ | 04 | [TASK-04-import-records.md](../todo/TASK-04-import-records.md) | Importação de registros CSV/XLSX |

---

## Dependencies

```
TASK-01 (Tags) ──┬──> TASK-02 (Export) ─┐
                 │                       │
                 └──> TASK-03 (Timer) ───┼──> TASK-04 (Import)
                                         │
                      (pode ser paralelo)┘
```

**Notas:**
- Task 01 (Tags) deve ser implementada primeiro pois as outras tasks podem usar tags
- Task 02 e Task 03 podem ser desenvolvidas em paralelo após Task 01
- Task 04 pode ser desenvolvida em paralelo ou após as outras

---

## Tech Stack

### Backend
- Laravel 12 + PHP 8.2+
- `spatie/laravel-tags` - Gerenciamento de tags
- `spatie/simple-excel` - Exportação Excel
- `barryvdh/laravel-dompdf` ou `spatie/laravel-pdf` - Exportação PDF

### Frontend
- Vue 3 + Composition API
- TailwindCSS v4
- Pinia (state management)

---

## Labels

- ⬜ → Pendente
- 🔄 → Em andamento
- ✅ → Concluído
- ⏸️ → Pausado
