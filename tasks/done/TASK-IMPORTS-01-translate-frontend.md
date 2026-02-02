```markdown
# TASK-IMPORTS-01 — Translate Imports Feature Frontend to English

## STATUS
✅ DONE

## DESCRIPTION

Translate all Portuguese text in the imports feature frontend to English. This includes all UI text, labels, buttons, messages, form fields, and validation messages in the imports feature accessible via `/imports` route.

**Total strings to translate:** 114

## COMPLETION NOTES

All Portuguese UI strings listed in the task were translated to English across the frontend files. Changes applied to:

- `src/router/index.ts` - route meta titles
- `src/views/ImportPlansListView.vue` - list view strings, buttons, dialogs, toasts
- `src/views/ImportUploadView.vue` - upload view strings, form labels, instructions, errors, toasts
- `src/views/ImportReviewView.vue` - review view strings, table headers, dialogs, toasts
- `src/components/ImportRowEditModal.vue` - modal strings
- `src/components/CDropZone.vue` - dropzone placeholder label

Minor TypeScript/linters warnings may remain (unrelated to translations). Date formatting locale was preserved.

---

Original task file content is archived in `tasks/archive` if needed.

```
