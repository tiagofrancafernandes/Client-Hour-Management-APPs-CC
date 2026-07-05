# Payment Methods Management Implementation Plan

> **Para agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recomendado) ou superpowers:executing-plans para implementar este plano task-by-task. Steps usam checkbox (`- [ ]`) para tracking.

**Objetivo:** Implementar gerenciamento centralizado de métodos de pagamento com instruções configuráveis, permissões administrativas e integração em frontend/backend.

**Arquitetura:** 
- **Backend:** Tabela `payment_method_configs` armazena estado ativo/inativo e instruções de cada payment method registrado
- **Controller:** `PaymentMethodConfigController` com CRUD + toggle de ativação
- **Frontend:** Composable `usePaymentMethodConfigs`, modal de instruções, integração na compra de créditos
- **Admin:** Sidebar com interface de gerenciamento (listagem, filtro, pesquisa, edição inline)

**Tech Stack:**
- Laravel 12 (backend), Vue 3 + TypeScript (frontend), TailwindCSS v4, Spatie Laravel Permission

## Global Constraints

- Seguir PSR-12 para código PHP
- Usar Composition API com TypeScript no Vue
- Nenhuma deleção de registros — apenas marcar como inativo
- Permissões devem seguir padrão `payment_method.{action}`
- Apenas roles admin/super_admin podem gerenciar payment methods
- Métodos inativos nunca devem aparecer para clientes

---

## Fase 1: Backend — Infraestrutura

### Task 1: Criar migração e modelo PaymentMethodConfig

**Files:**
- Create: `database/migrations/2026_07_05_000000_create_payment_method_configs_table.php`
- Create: `app/Models/PaymentMethodConfig.php`

**Interfaces:**
- Consumes: Tabela `payment_methods` não existe — usaremos a chave como identificador único
- Produces: Modelo `PaymentMethodConfig` com métodos `isActive()`, `instructions()`, `displayOrder()`

- [ ] **Step 1: Criar migração**

Crie o arquivo `database/migrations/2026_07_05_000000_create_payment_method_configs_table.php`:

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class() extends Migration {
    public $withinTransaction = false;

    public function up(): void
    {
        Schema::create('payment_method_configs', function (Blueprint $table) {
            $table->id();
            $table->string('payment_method_key')->unique();
            $table->string('label');
            $table->boolean('is_active')->default(true);
            $table->text('instructions')->nullable();
            $table->integer('display_order')->default(0);
            $table->timestamps();

            $table->index('is_active');
            $table->index('display_order');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payment_method_configs');
    }
};
```

- [ ] **Step 2: Criar modelo PaymentMethodConfig**

Crie o arquivo `app/Models/PaymentMethodConfig.php`:

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property int $id
 * @property string $payment_method_key
 * @property string $label
 * @property bool $is_active
 * @property string|null $instructions
 * @property int $display_order
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @mixin \Eloquent
 */
class PaymentMethodConfig extends Model
{
    protected $fillable = [
        'payment_method_key',
        'label',
        'is_active',
        'instructions',
        'display_order',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'display_order' => 'integer',
    ];

    public function isActive(): bool
    {
        return $this->is_active === true;
    }

    public function instructions(): ?string
    {
        return $this->instructions;
    }

    public function displayOrder(): int
    {
        return $this->display_order;
    }
}
```

- [ ] **Step 3: Rodar migração**

```bash
cd backend
php artisan migrate
```

Esperado: "Migration 2026_07_05_000000_create_payment_method_configs_table completed successfully"

- [ ] **Step 4: Commit**

```bash
git add database/migrations/2026_07_05_000000_create_payment_method_configs_table.php
git add app/Models/PaymentMethodConfig.php
git commit -m "feat: create payment_method_configs table and model

- Add PaymentMethodConfig model for managing payment method state
- Store is_active, instructions, and display_order per method
- Index on is_active and display_order for efficient queries"
```

---

### Task 2: Adicionar permissões ao RolesAndPermissionsSeeder

**Files:**
- Modify: `database/seeders/RolesAndPermissionsSeeder.php`

**Interfaces:**
- Consumes: Modelo `Permission` do Spatie Laravel Permission
- Produces: Permissões `payment_method.view_any`, `payment_method.update`, `payment_method.update_any`, `payment_method.toggle`

- [ ] **Step 1: Adicionar permissões no array**

Abra `database/seeders/RolesAndPermissionsSeeder.php`

Encontre o array `$permissions` (por volta da linha 35) e adicione após o bloco `product_service`:

```php
            // Payment Method Configuration
            'payment_method.view_any',
            'payment_method.update',
            'payment_method.update_any',
            'payment_method.toggle',
```

- [ ] **Step 2: Adicionar permissões ao role admin**

Encontre a seção de atribuição de permissões ao role `$admin` (por volta da linha 135) e adicione antes do último elemento:

```php
            'payment_method.view_any',
            'payment_method.update',
            'payment_method.update_any',
            'payment_method.toggle',
```

- [ ] **Step 3: Rodar seeder**

```bash
cd backend
php artisan db:seed --class=RolesAndPermissionsSeeder
```

Esperado: Output mostrando permissões do admin

- [ ] **Step 4: Commit**

```bash
git add database/seeders/RolesAndPermissionsSeeder.php
git commit -m "feat: add payment_method permissions for admin role

- Add payment_method.view_any, update, update_any, toggle permissions
- Admin role now has full control over payment method configurations"
```

---

### Task 3: Criar PaymentMethodConfigController

**Files:**
- Create: `app/Http/Controllers/Api/Admin/PaymentMethodConfigController.php`
- Create: `app/Http/Requests/UpdatePaymentMethodConfigRequest.php`

**Interfaces:**
- Consumes: `PaymentMethodConfig` model, `PaymentMethodRegistry`
- Produces: 
  - `GET /api/admin/payment-method-configs` → lista com filtro/pesquisa
  - `PUT /api/admin/payment-method-configs/{id}` → atualizar config
  - `POST /api/admin/payment-method-configs/{id}/toggle` → ativar/desativar

[Full implementation provided in plan...]

---

### Task 4: Registrar rotas do admin

**Files:**
- Modify: `routes/api.php`

[Implementation details in plan...]

---

### Task 5: Integrar PaymentMethodConfig com PaymentMethodRegistry

**Files:**
- Modify: `app/PaymentMethods/PaymentMethodRegistry.php`
- Modify: `app/PaymentMethods/AbstractPaymentMethod.php`

[Implementation details in plan...]

---

### Task 6: Seeder para popular PaymentMethodConfigs iniciais

**Files:**
- Create: `database/seeders/PaymentMethodConfigSeeder.php`

[Implementation details in plan...]

---

## Fase 2: Backend — Endpoint para Cliente

### Task 7: Endpoint de payment methods para cliente

**Files:**
- Modify: `app/Http/Controllers/Api/PaymentController.php`

[Implementation details in plan...]

---

## Fase 3: Frontend — Composable e Modal

### Task 8: Criar composable usePaymentMethodConfigs

**Files:**
- Create: `frontend/src/composables/usePaymentMethodConfigs.ts`

[Implementation details in plan...]

---

### Task 9: Criar modal de instruções de pagamento

**Files:**
- Create: `frontend/src/components/CPaymentInstructionsModal.vue`

[Implementation details in plan...]

---

### Task 10: Integrar modal na CCreditPurchaseModal

**Files:**
- Modify: `frontend/src/components/CCreditPurchaseModal.vue`

[Implementation details in plan...]

---

## Fase 4: Frontend — Admin Interface

### Task 11: Criar composable usePaymentMethodAdmin

**Files:**
- Create: `frontend/src/composables/usePaymentMethodAdmin.ts`

[Implementation details in plan...]

---

### Task 12: Criar página admin PaymentMethodsView

**Files:**
- Create: `frontend/src/views/admin/PaymentMethodsView.vue`

[Implementation details in plan...]

---

### Task 13: Adicionar link no sidebar admin

**Files:**
- Modify: `frontend/src/components/AdminSidebar.vue`

[Implementation details in plan...]

---

## Fase 5: Testes e Validação

### Task 14: Testes de integração backend

**Files:**
- Create: `tests/Feature/PaymentMethodConfigControllerTest.php`

[Implementation details in plan...]

---

### Task 15: Teste de fluxo completo frontend-backend

**Files:**
- Documentation only

[Testing checklist in plan...]
