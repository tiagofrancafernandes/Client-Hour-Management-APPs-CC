# TASK 02 — Exportação de Relatórios

## Objetivo

Permitir exportação de relatórios em formato PDF e Excel.

---

## Packages

- **Excel**: `spatie/simple-excel` (https://github.com/spatie/simple-excel)
- **PDF**: `barryvdh/laravel-dompdf` ou `spatie/laravel-pdf`

---

## Backend

### 1. Instalação

```bash
composer require spatie/simple-excel
composer require barryvdh/laravel-dompdf
```

### 2. Endpoints API

| Method | Endpoint | Description | Permission |
|--------|----------|-------------|------------|
| GET | `/api/reports/export` | Exportar relatório | `report.view` |

**Query Parameters:**
- `format`: `pdf` ou `excel` (required)
- `client_id`: filtro por cliente (optional)
- `wallet_id`: filtro por carteira (optional)
- `date_from`: data inicial (optional)
- `date_to`: data final (optional)
- `tags`: array de IDs de tags (optional)
- `type`: `credit` ou `debit` (optional)

### 3. Service: ReportExportService

```php
class ReportExportService
{
    public function exportToExcel(array $filters): StreamedResponse;
    public function exportToPdf(array $filters): Response;
}
```

### 4. Excel Export

Usando `spatie/simple-excel`:

```php
use Spatie\SimpleExcel\SimpleExcelWriter;

public function exportToExcel(array $filters): StreamedResponse
{
    $entries = $this->getFilteredEntries($filters);

    return SimpleExcelWriter::streamDownload('relatorio.xlsx')
        ->addHeader(['Data', 'Cliente', 'Carteira', 'Tipo', 'Horas', 'Título', 'Tags'])
        ->addRows($entries->map(fn ($entry) => [
            $entry->reference_date->format('d/m/Y'),
            $entry->wallet->client->name,
            $entry->wallet->name,
            $entry->hours > 0 ? 'Crédito' : 'Débito',
            number_format(abs($entry->hours), 2, ',', '.'),
            $entry->title,
            $entry->tags->pluck('name')->implode(', '),
        ]));
}
```

### 5. PDF Export

Usando `barryvdh/laravel-dompdf`:

```php
use Barryvdh\DomPDF\Facade\Pdf;

public function exportToPdf(array $filters): Response
{
    $entries = $this->getFilteredEntries($filters);
    $summary = $this->reportService->getReportSummary($filters);

    $pdf = Pdf::loadView('reports.export', [
        'entries' => $entries,
        'summary' => $summary,
        'filters' => $filters,
    ]);

    return $pdf->download('relatorio.pdf');
}
```

### 6. View para PDF

Criar view `resources/views/reports/export.blade.php`:
- Header com logo e data de geração
- Resumo (total créditos, débitos, saldo)
- Filtros aplicados
- Tabela com registros
- Footer com paginação

---

## Frontend

### 1. Botões de Exportação

Adicionar na tela de relatórios:

```vue
<div class="flex gap-2">
    <button @click="exportReport('excel')" class="btn-secondary">
        Exportar Excel
    </button>
    <button @click="exportReport('pdf')" class="btn-secondary">
        Exportar PDF
    </button>
</div>
```

### 2. Função de Exportação

```typescript
async function exportReport(format: 'pdf' | 'excel') {
    const params = new URLSearchParams({
        format,
        ...currentFilters.value,
    });

    const url = `${API_URL}/reports/export?${params}`;

    // Download direto via link
    window.open(url, '_blank');
}
```

### 3. Loading State

- Mostrar indicador de loading durante geração
- Desabilitar botões enquanto exporta

---

## Permissões

Usar permissão existente:
- `report.view` - Permite visualizar e exportar relatórios

---

## Critérios de Aceite

- [x] Endpoint de exportação funciona com filtros
- [x] Excel gerado contém todas as colunas necessárias
- [x] PDF gerado tem layout profissional
- [x] PDF inclui resumo e filtros aplicados
- [x] Frontend permite escolher formato de exportação
- [x] Exportação respeita os filtros aplicados na tela
- [x] Arquivos são nomeados com data/hora da geração

---

## Output Esperado

### Backend
- `ReportExportService`
- Endpoint `GET /api/reports/export`
- View Blade para PDF
- Testes Feature para exportação

### Frontend
- Botões de exportação na tela de relatórios
- Função de download com filtros atuais
