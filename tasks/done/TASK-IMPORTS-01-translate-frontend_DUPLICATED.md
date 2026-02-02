# TASK-IMPORTS-01 — Translate Imports Feature Frontend to English

## STATUS
⬜ TODO

## DESCRIPTION

Translate all Portuguese text in the imports feature frontend to English. This includes all UI text, labels, buttons, messages, form fields, and validation messages in the imports feature accessible via `/imports` route.

**Total strings to translate:** 114

## REQUIREMENTS

### Route Titles (3 strings)
Translate in `src/router/index.ts`:
- "Importações" → "Imports"
- "Nova Importação" → "New Import"
- "Revisar Importação" → "Review Import"

### ImportPlansListView.vue (28 strings)
File: `src/views/ImportPlansListView.vue`

**Page Headers & Descriptions:**
- "Importações" → "Imports"
- "Gerencie suas importações de registros" → "Manage your record imports"

**Buttons:**
- "Nova Importação" → "New Import"
- "Limpar Filtros" → "Clear Filters"
- "Visualizar" → "View"

**Select Labels & Options:**
- "Status" → "Status"
- "Carteira" → "Wallet"
- "Todos" → "All"
- "Pendente" → "Pending"
- "Validado" → "Validated"
- "Confirmado" → "Confirmed"
- "Cancelado" → "Cancelled"
- "Todas" → "All"

**Loading & Empty States:**
- "Carregando importações..." → "Loading imports..."
- "Nenhuma importação encontrada" → "No imports found"
- "Comece fazendo upload de um arquivo CSV ou XLSX" → "Start by uploading a CSV or XLSX file"

**Summary Labels:**
- "Criado em" → "Created at"
- "Confirmado em" → "Confirmed at"
- "Total:" → "Total:"
- "Válidos:" → "Valid:"
- "Erros:" → "Errors:"
- "Horas:" → "Hours:"

**Pagination:**
- "Página" → "Page"

**Confirmation Dialog (Cancel Import):**
- "Cancelar Importação" → "Cancel Import"
- "Tem certeza que deseja cancelar esta importação? O arquivo será removido." → "Are you sure you want to cancel this import? The file will be deleted."
- "Sim, Cancelar" → "Yes, Cancel"
- "Não" → "No"

**Toast Messages:**
- "Importação cancelada com sucesso" → "Import cancelled successfully"
- "Erro ao cancelar importação" → "Error cancelling import"

### ImportUploadView.vue (42 strings)
File: `src/views/ImportUploadView.vue`

**Page Headers & Descriptions:**
- "Importar Registros" → "Import Records"
- "Faça upload de um arquivo CSV ou XLSX para importar múltiplos registros de horas" → "Upload a CSV or XLSX file to import multiple hour records"

**Form Section:**
- "Upload de Arquivo" → "File Upload"
- "Selecione a Carteira" → "Select Wallet"
- "Selecione uma carteira" → "Select a wallet"
- "Arquivo (CSV ou XLSX)" → "File (CSV or XLSX)"
- "Fazer Upload e Validar" → "Upload and Validate"
- "Cancelar" → "Cancel"

**Instructions Section:**
- "Como Usar" → "How to Use"
- "1. Baixe o Template" → "1. Download Template"
- "Use nosso template para garantir que o arquivo está no formato correto." → "Use our template to ensure your file is in the correct format."
- "Baixar CSV" → "Download CSV"
- "Baixar XLSX" → "Download XLSX"

**Step 2: Data Entry:**
- "2. Preencha os Dados" → "2. Fill in the Data"
- "Complete o arquivo com seus dados. Campos obrigatórios:" → "Complete the file with your data. Required fields:"
- "Data de referência (YYYY-MM-DD)" → "Reference date (YYYY-MM-DD)"
- "Horas (positivo = crédito, negativo = débito)" → "Hours (positive = credit, negative = debit)"
- "Título do registro" → "Record title"
- "Campos opcionais:" → "Optional fields:"
- "(separadas por vírgula)" → "(separated by comma)"

**Step 3 & 4: Validation & Confirmation:**
- "3. Validação" → "3. Validation"
- "Após o upload, o sistema irá validar todos os registros. Você poderá revisar e corrigir erros antes de confirmar a importação." → "After uploading, the system will validate all records. You can review and correct errors before confirming the import."
- "4. Confirmação" → "4. Confirmation"
- "Uma vez confirmada, a importação criará entradas no ledger. Esta ação não pode ser desfeita." → "Once confirmed, the import will create ledger entries. This action cannot be undone."

**Error Messages:**
- "Apenas arquivos CSV e XLSX são permitidos." → "Only CSV and XLSX files are allowed."
- "O arquivo não pode exceder 10MB." → "The file cannot exceed 10MB."
- "Houve algum erro ao enviar o arquivo..." → "There was an error uploading the file..."
- "Erro ao fazer upload do arquivo." → "Error uploading the file."

**Success Messages:**
- "Arquivo enviado com sucesso! Redirecionando para revisão..." → "File uploaded successfully! Redirecting for review..."
- "Erro ao fazer upload do arquivo" → "Error uploading the file"
- "Template {format} baixado com sucesso" → "Template {format} downloaded successfully"

### ImportReviewView.vue (36 strings)
File: `src/views/ImportReviewView.vue`

**Page Headers:**
- "Revisar Importação" → "Review Import"
- "Arquivo:" → "File:"
- "Carregando plano de importação..." → "Loading import plan..."

**Stat Cards:**
- "Total de Linhas" → "Total Rows"
- "Linhas Válidas" → "Valid Rows"
- "Linhas com Erros" → "Rows with Errors"
- "Total de Horas" → "Total Hours"

**Alert Messages:**
- "Atenção: Linhas com Erros" → "Warning: Rows with Errors"
- "Existem {count} linha(s) com erros de validação. Corrija os erros ou remova as linhas inválidas antes de confirmar a importação." → "There are {count} row(s) with validation errors. Fix the errors or remove invalid rows before confirming the import."

**Table & Buttons:**
- "Registros a Importar" → "Records to Import"
- "Adicionar Linha" → "Add Row"
- "Cancelar Importação" → "Cancel Import"
- "Confirmar e Criar Lançamentos" → "Confirm and Create Entries"

**Table Headers:**
- "#" → "#"
- "Data" → "Date"
- "Horas" → "Hours"
- "Título" → "Title"
- "Tags" → "Tags"
- "Status" → "Status"
- "Ações" → "Actions"

**Status Badges:**
- "Válido" → "Valid"
- "erro(s)" → "error(s)"

**Success State:**
- "Importação Confirmada" → "Import Confirmed"
- "Todos os registros foram importados com sucesso em {date}." → "All records were imported successfully on {date}."
- "Voltar para Importações" → "Back to Imports"

**Not Found:**
- "Plano de importação não encontrado" → "Import plan not found"

**Confirmation Dialogs:**
- "Excluir Linha" → "Delete Row"
- "Tem certeza que deseja excluir a linha {row_number}?" → "Are you sure you want to delete row {row_number}?"
- "Excluir" → "Delete"
- "Cancelar" → "Cancel"
- "Confirmar Importação" → "Confirm Import"
- "Confirmar a importação de {count} registro(s)? Esta ação não pode ser desfeita." → "Confirm importing {count} record(s)? This action cannot be undone."
- "Confirmar" → "Confirm"

**Toast Messages:**
- "Linha excluída com sucesso" → "Row deleted successfully"
- "Erro ao excluir linha" → "Error deleting row"
- "Linha atualizada com sucesso" → "Row updated successfully"
- "Linha adicionada com sucesso" → "Row added successfully"
- "Erro ao salvar linha" → "Error saving row"
- "Importação confirmada com sucesso!" → "Import confirmed successfully!"
- "Erro ao confirmar importação" → "Error confirming import"
- "Importação cancelada" → "Import cancelled"

### ImportRowEditModal.vue (5 strings)
File: `src/components/ImportRowEditModal.vue`

**Modal Headers:**
- "Editar Linha #{row_number}" → "Edit Row #{row_number}"
- "Nova Linha" → "New Row"

**Form Elements:**
- "Erros de Validação:" → "Validation Errors:"
- "Data de Referência *" → "Reference Date *"
- "Horas *" → "Hours *"
- "Use valores positivos para crédito e negativos para débito" → "Use positive values for credit and negative values for debit"
- "Título *" → "Title *"
- "Descrição" → "Description"
- "Tags" → "Tags"
- "Digite uma tag e pressione Enter" → "Type a tag and press Enter"

**Buttons:**
- "Cancelar" → "Cancel"
- "Salvar" → "Save"
- "Adicionar" → "Add"

### CDropZone.vue (1 string)
File: `src/components/CDropZone.vue`

**Placeholder Text:**
- "Clique ou arraste arquivos aqui" → "Click or drag files here"

## FILES TO MODIFY

1. `src/router/index.ts` - Route meta titles
2. `src/views/ImportPlansListView.vue` - Page content
3. `src/views/ImportUploadView.vue` - Upload instructions and form
4. `src/views/ImportReviewView.vue` - Review page content
5. `src/components/ImportRowEditModal.vue` - Modal content
6. `src/components/CDropZone.vue` - Drop zone placeholder

## IMPLEMENTATION STEPS

1. **Review all files** - Ensure all Portuguese strings are identified
2. **Translate route titles** in `router/index.ts` (3 strings)
3. **Translate ImportPlansListView.vue** (28 strings)
4. **Translate ImportUploadView.vue** (42 strings) - includes instructions and help text
5. **Translate ImportReviewView.vue** (36 strings)
6. **Translate ImportRowEditModal.vue** (5 strings)
7. **Translate CDropZone.vue** (1 string)
8. **Run tests** to ensure no regressions
9. **Manual testing** - Navigate through all import workflows
10. **Code review** - Verify all strings are properly translated and UI renders correctly

## ACCEPTANCE CRITERIA

- ✅ All 114 Portuguese strings translated to English
- ✅ No English text is fragmented or concatenated incorrectly
- ✅ All dynamic variables {count}, {date}, {format}, {row_number} are preserved in messages
- ✅ UI renders correctly in all screen sizes (mobile, tablet, desktop)
- ✅ All routes and page navigation work properly
- ✅ All form validations and error messages display correctly
- ✅ Toast notifications show in English
- ✅ Dialog confirmations show in English
- ✅ All tests pass with no regressions
- ✅ No console errors or warnings

## TESTING CHECKLIST

### Routes & Navigation
- [ ] Navigate to `/imports` - verify page title and labels
- [ ] Navigate to `/imports/upload` - verify form labels and instructions
- [ ] Navigate to `/imports/:id/review` - verify review page labels

### File Upload Workflow
- [ ] Upload file - verify success message is in English
- [ ] Try uploading invalid file type - verify error message is in English
- [ ] Try uploading file > 10MB - verify error message is in English
- [ ] Download CSV template - verify button label and success message
- [ ] Download XLSX template - verify button label and success message

### List & Filtering
- [ ] View imports list - verify all labels and empty state text
- [ ] Filter by status - verify all status options are in English
- [ ] Filter by wallet - verify wallet options are in English
- [ ] Clear filters - verify button label and behavior

### Review & Edit Workflow
- [ ] View import review page - verify all stat cards and headers
- [ ] Add new row - verify modal title and all form labels
- [ ] Edit existing row - verify modal title, form labels, and validation errors
- [ ] Delete row - verify confirmation dialog text

### Confirmation & Results
- [ ] Confirm import - verify confirmation dialog text
- [ ] Verify success message after confirmation
- [ ] Verify all toast notifications are in English
- [ ] Cancel import - verify confirmation and cancellation message

### Responsive Design
- [ ] Test on mobile (320px) - verify all text is readable
- [ ] Test on tablet (768px) - verify layout and text
- [ ] Test on desktop (1920px) - verify layout and text

## RELATED FILES & CONTEXT

- Design System: `frontend/design/design.json` - Verify component styling matches
- API Composable: `src/composables/useImport.ts` - No changes needed
- Types: `src/types/index.ts` - Interface names remain in English (already correct)
- Custom Components: `src/components/CButton.vue`, `src/components/CSelect.vue`, etc.

## NOTES

- Focus on clarity and consistency with existing English terminology in the app
- Keep technical terms consistent (e.g., "ledger", "wallet", "credit", "debit")
- Ensure all pluralization is correct (e.g., "rows" vs "row")
- Maintain proper grammar and capitalization in messages
- Do not change component prop names or API field names (only display text)
- All translatable strings should be in Vue templates, not hardcoded in scripts where possible

---

## COMPLETION CHECKLIST

- [ ] All files reviewed and Portuguese strings identified
- [ ] Router titles translated
- [ ] ImportPlansListView.vue translated
- [ ] ImportUploadView.vue translated
- [ ] ImportReviewView.vue translated
- [ ] ImportRowEditModal.vue translated
- [ ] CDropZone.vue translated
- [ ] Code formatted and linted with prettier
- [ ] All tests passing
- [ ] Manual testing completed
- [ ] Code review passed
- [ ] Commit created with descriptive message
