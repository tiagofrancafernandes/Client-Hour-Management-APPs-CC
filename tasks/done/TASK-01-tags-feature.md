# TASK 01 — Feature de Tags

## Objetivo

Implementar sistema de tags para categorização de registros de horas no backend e frontend.

---

## Packages

- **Backend**: `spatie/laravel-tags` (https://github.com/spatie/laravel-tags)

---

## Backend

### 1. Instalação e Configuração

```bash
composer require spatie/laravel-tags
php artisan vendor:publish --provider="Spatie\Tags\TagsServiceProvider" --tag="tags-migrations"
php artisan migrate
```

### 2. Model LedgerEntry

- Adicionar trait `HasTags` ao model `LedgerEntry`
- Configurar relação many-to-many com tags

```php
use Spatie\Tags\HasTags;

class LedgerEntry extends Model
{
    use HasTags;
}
```

### 3. Endpoints API

| Method | Endpoint | Description | Permission |
|--------|----------|-------------|------------|
| GET | `/api/tags` | Listar todas as tags | `tag.view_any` |
| POST | `/api/tags` | Criar nova tag | `tag.create` |
| PUT | `/api/tags/{id}` | Atualizar tag | `tag.update` |
| DELETE | `/api/tags/{id}` | Excluir tag | `tag.delete` |

### 4. Atualizar Endpoints Existentes

- `POST /api/ledger-entries` - Aceitar array de tags
- `GET /api/ledger-entries` - Incluir tags na resposta
- `GET /api/reports` - Filtrar por tags

### 5. Validação

- Tag name: required, string, max:50, unique
- Tags em ledger entry: array de IDs ou strings (criar se não existir)

---

## Frontend

### 1. Componente TagInput

Criar componente reutilizável para seleção/criação de tags:

**Funcionalidades:**
- Dropdown com tags existentes (autocomplete)
- Criar nova tag ao digitar e pressionar `Enter` ou `,`
- Exibir tags selecionadas como chips removíveis
- Busca em tempo real enquanto digita

**Props:**
- `modelValue`: array de tags selecionadas
- `placeholder`: texto placeholder
- `allowCreate`: boolean para permitir criação inline

### 2. Integração nas Telas

#### Formulário de Ledger Entry
- Adicionar campo de tags ao criar débito/crédito
- Tags opcionais

#### Filtros de Relatório
- Adicionar seletor de tags no formulário de filtros
- Filtrar relatório por tags selecionadas (espaço já existe)

#### Tela de Gerenciamento de Tags (opcional)
- CRUD de tags para administradores
- Listar, criar, editar, excluir tags

### 3. Store/Composable

- `useTags()` composable para gerenciar tags
- Cache local das tags disponíveis
- Métodos: `fetchTags`, `createTag`, `updateTag`, `deleteTag`

---

## Permissões

Já existentes no seeder:
- `tag.view`
- `tag.view_any`
- `tag.create`
- `tag.update`
- `tag.delete`

---

## Critérios de Aceite

- [x] Tags podem ser criadas e gerenciadas via API
- [x] Ledger entries podem ter múltiplas tags associadas
- [x] Frontend permite selecionar tags existentes
- [x] Frontend permite criar tags inline (vírgula/enter)
- [x] Relatórios podem ser filtrados por tags
- [x] Testes automatizados cobrem funcionalidades principais

---

## Output Esperado

### Backend
- Migration para relação ledger_entry <-> tags
- TagController atualizado (se necessário)
- LedgerEntryController aceita tags
- ReportController filtra por tags
- Testes Feature para tags

### Frontend
- Componente `TagInput.vue`
- Composable `useTags.ts`
- Integração em formulários de ledger entry
- Integração em filtros de relatório
