# TASK 04 — Importação de Registros

## Objetivo

Permitir importação de registros de horas via planilhas CSV e XLSX com validação e plano de importação.

---

## Conceitos

### Plano de Importação
- Registro temporário do upload de planilha
- Contém dados validados/parseados aguardando confirmação
- Pode ser ajustado antes de confirmar
- Só persiste no ledger após confirmação

### Estados do Import Plan
- `pending` - Aguardando validação
- `validated` - Validado, aguardando confirmação
- `confirmed` - Confirmado, registros criados
- `cancelled` - Cancelado, descartado

---

## Packages

- `spatie/simple-excel` (leitura de CSV/XLSX)

---

## Backend

### 1. Migrations

**import_plans**
```php
Schema::create('import_plans', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained()->cascadeOnDelete();
    $table->foreignId('wallet_id')->constrained()->cascadeOnDelete();
    $table->string('original_filename');
    $table->string('file_path');
    $table->enum('status', ['pending', 'validated', 'confirmed', 'cancelled']);
    $table->json('summary')->nullable(); // Totais, contagens
    $table->json('validation_errors')->nullable();
    $table->timestamp('confirmed_at')->nullable();
    $table->timestamps();
});
```

**import_plan_rows**
```php
Schema::create('import_plan_rows', function (Blueprint $table) {
    $table->id();
    $table->foreignId('import_plan_id')->constrained()->cascadeOnDelete();
    $table->integer('row_number');
    $table->date('reference_date');
    $table->decimal('hours', 8, 2);
    $table->string('title');
    $table->text('description')->nullable();
    $table->json('tags')->nullable(); // Array de nomes de tags
    $table->json('validation_errors')->nullable();
    $table->boolean('is_valid')->default(true);
    $table->foreignId('ledger_entry_id')->nullable()->constrained()->nullOnDelete();
    $table->timestamps();
});
```

### 2. Models

**ImportPlan**
```php
class ImportPlan extends Model
{
    protected $fillable = [
        'user_id', 'wallet_id', 'original_filename', 'file_path',
        'status', 'summary', 'validation_errors', 'confirmed_at',
    ];

    protected $casts = [
        'summary' => 'array',
        'validation_errors' => 'array',
        'confirmed_at' => 'datetime',
    ];

    public function user(): BelongsTo;
    public function wallet(): BelongsTo;
    public function rows(): HasMany;
    public function ledgerEntries(): HasManyThrough;
}
```

**ImportPlanRow**
```php
class ImportPlanRow extends Model
{
    protected $fillable = [
        'import_plan_id', 'row_number', 'reference_date', 'hours',
        'title', 'description', 'tags', 'validation_errors',
        'is_valid', 'ledger_entry_id',
    ];

    protected $casts = [
        'reference_date' => 'date',
        'hours' => 'decimal:2',
        'tags' => 'array',
        'validation_errors' => 'array',
        'is_valid' => 'boolean',
    ];

    public function importPlan(): BelongsTo;
    public function ledgerEntry(): BelongsTo;
}
```

### 3. Endpoints API

| Method | Endpoint | Description | Permission |
|--------|----------|-------------|------------|
| GET | `/api/import-plans` | Listar planos de importação | `import.view_any` |
| GET | `/api/import-plans/{id}` | Detalhes do plano | `import.view` |
| POST | `/api/import-plans` | Upload e criar plano | `import.create` |
| PUT | `/api/import-plans/{id}` | Atualizar plano | `import.update` |
| POST | `/api/import-plans/{id}/validate` | Revalidar plano | `import.update` |
| POST | `/api/import-plans/{id}/confirm` | Confirmar importação | `import.confirm` |
| POST | `/api/import-plans/{id}/cancel` | Cancelar plano | `import.update` |
| DELETE | `/api/import-plans/{id}` | Excluir plano | `import.delete` |
| GET | `/api/import-plans/{id}/rows` | Listar linhas | `import.view` |
| PUT | `/api/import-plans/{id}/rows/{rowId}` | Editar linha | `import.update` |
| DELETE | `/api/import-plans/{id}/rows/{rowId}` | Excluir linha | `import.update` |
| POST | `/api/import-plans/{id}/rows` | Adicionar linha | `import.update` |
| GET | `/api/import-templates/{format}` | Download template | - (público) |

### 4. ImportService

```php
class ImportService
{
    public function createPlan(User $user, Wallet $wallet, UploadedFile $file): ImportPlan;
    public function parseFile(ImportPlan $plan): Collection;
    public function validateRows(ImportPlan $plan): ImportPlan;
    public function confirm(ImportPlan $plan): ImportPlan;
    public function cancel(ImportPlan $plan): ImportPlan;
    public function updateRow(ImportPlanRow $row, array $data): ImportPlanRow;
    public function addRow(ImportPlan $plan, array $data): ImportPlanRow;
    public function deleteRow(ImportPlanRow $row): void;
    public function generateTemplate(string $format): StreamedResponse;
}
```

### 5. Validação de Linhas

Para cada linha da planilha:
- `reference_date`: required, date, não futura
- `hours`: required, numeric, != 0
- `title`: required, string, max:255
- `description`: nullable, string
- `tags`: nullable, array de strings

### 6. Template de Importação

**Colunas:**
| Data | Horas | Título | Descrição | Tags |
|------|-------|--------|-----------|------|
| 2026-01-15 | -2.5 | Desenvolvimento feature X | Detalhes... | dev, frontend |
| 2026-01-16 | -1.0 | Reunião com cliente | | reuniao |

**Notas no template:**
- Horas negativas = débito, positivas = crédito
- Tags separadas por vírgula
- Data no formato YYYY-MM-DD ou DD/MM/YYYY

### 7. Permissões (adicionar ao seeder)

```php
'import.view',
'import.view_any',
'import.create',
'import.update',
'import.confirm',
'import.delete',
```

---

## Frontend

### 1. Composable: useImport

```typescript
interface ImportPlanRow {
    id: number;
    row_number: number;
    reference_date: string;
    hours: number;
    title: string;
    description: string | null;
    tags: string[];
    validation_errors: string[] | null;
    is_valid: boolean;
}

interface ImportPlan {
    id: number;
    wallet_id: number;
    wallet: Wallet;
    original_filename: string;
    status: 'pending' | 'validated' | 'confirmed' | 'cancelled';
    summary: {
        total_rows: number;
        valid_rows: number;
        invalid_rows: number;
        total_hours: number;
        total_credits: number;
        total_debits: number;
    };
    rows: ImportPlanRow[];
}

function useImport() {
    async function uploadFile(walletId: number, file: File): Promise<ImportPlan>;
    async function fetchPlan(id: number): Promise<ImportPlan>;
    async function fetchPlans(): Promise<ImportPlan[]>;
    async function updateRow(planId: number, rowId: number, data: object): Promise<void>;
    async function deleteRow(planId: number, rowId: number): Promise<void>;
    async function addRow(planId: number, data: object): Promise<void>;
    async function confirmPlan(id: number): Promise<void>;
    async function cancelPlan(id: number): Promise<void>;
    async function downloadTemplate(format: 'csv' | 'xlsx'): Promise<void>;
}
```

### 2. Tela: ImportUploadView

Etapa 1 - Upload:
- Seleção de cliente e carteira
- Upload de arquivo (drag & drop ou click)
- Aceitar .csv e .xlsx
- Botão "Processar Arquivo"
- Link para download de templates

### 3. Tela: ImportReviewView

Etapa 2 - Revisão do plano:

**Header:**
- Nome do arquivo original
- Carteira selecionada
- Status do plano

**Resumo:**
- Total de linhas
- Linhas válidas / inválidas
- Total de horas (créditos/débitos)

**Tabela de Linhas:**
| # | Data | Horas | Título | Tags | Status | Ações |
|---|------|-------|--------|------|--------|-------|
| 1 | 15/01/2026 | -2.5h | Feature X | dev | ✅ | Editar / Excluir |
| 2 | 16/01/2026 | -1.0h | Reunião | | ❌ Erro | Editar / Excluir |

**Ações:**
- Editar linha (modal)
- Excluir linha
- Adicionar nova linha
- Confirmar importação (se todas válidas)
- Cancelar importação

### 4. Componente: ImportRowEditModal

Modal para editar linha:
- Data (date picker)
- Horas (number input)
- Título (text input)
- Descrição (textarea)
- Tags (TagInput)
- Exibir erros de validação
- Botões: Salvar / Cancelar

### 5. Tela: ImportPlansListView

Listagem de planos de importação:
- Filtro por status
- Tabela: Data, Arquivo, Carteira, Status, Linhas, Ações
- Ações por status:
  - `validated`: Revisar, Confirmar, Cancelar
  - `confirmed`: Visualizar
  - `cancelled`: Excluir

---

## Fluxo de Importação

```
1. Usuário seleciona carteira
2. Usuário faz upload do arquivo
3. Backend parseia e valida arquivo
4. Frontend exibe plano com resumo e linhas
5. Usuário pode:
   - Corrigir linhas com erro
   - Excluir linhas indesejadas
   - Adicionar novas linhas
6. Usuário confirma importação
7. Backend cria ledger entries
8. Plano marcado como confirmed
```

---

## Critérios de Aceite

- [ ] Upload de CSV funciona
- [ ] Upload de XLSX funciona
- [ ] Validação identifica erros nas linhas
- [ ] Linhas podem ser editadas antes de confirmar
- [ ] Linhas podem ser excluídas
- [ ] Novas linhas podem ser adicionadas
- [ ] Confirmação cria ledger entries
- [ ] Templates de exemplo estão disponíveis
- [ ] Listagem de planos funciona
- [ ] Testes automatizados cobrem fluxos principais

---

## Output Esperado

### Backend
- Migrations: `import_plans`, `import_plan_rows`
- Models: `ImportPlan`, `ImportPlanRow`
- `ImportPlanController`
- `ImportService`
- `ImportPlanPolicy`
- Permissões no seeder
- Templates CSV/XLSX em `storage/templates/`
- Testes Feature

### Frontend
- Composable: `useImport.ts`
- Views:
  - `ImportUploadView.vue`
  - `ImportReviewView.vue`
  - `ImportPlansListView.vue`
- Componentes:
  - `ImportRowEditModal.vue`
  - `ImportSummaryCard.vue`
- Rotas: `/import`, `/import/:id`, `/import/plans`
