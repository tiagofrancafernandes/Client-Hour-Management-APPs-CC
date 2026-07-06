# Dynamic Payment Method Setup Fields Implementation Plan

> **Para workers agênticos:** Use superpowers:subagent-driven-development (recomendado) ou superpowers:executing-plans para implementar este plano task-by-task. As etapas usam sintaxe checkbox (`- [ ]`) para rastreamento.

**Objetivo:** Implementar sistema dinâmico de campos de setup para métodos de pagamento, permitindo que administradores configurem credenciais/chaves de API sem que clientes vejam esses dados sensíveis.

**Arquitetura:** O sistema funciona em dois níveis:
1. **Campos de Setup** (setup_fields) - Dados sensíveis configurados apenas por admin, armazenados no banco, não visíveis ao cliente
2. **Campos de Instruções** - Instruções de pagamento visíveis ao cliente

Cada método de pagamento declara `setupFieldRules()` e opcionalmente `setupFieldDefaultValues()`. O backend valida, persiste e o frontend renderiza campos readonly aguardando preenchimento.

**Tech Stack:**
- Backend: Laravel 12, PHP 8.2+, PostgreSQL
- Frontend: Vue 3, Composition API, TypeScript
- Testes Backend: Pest/PHPUnit
- Testes Frontend: Chrome DevTools MCP

## Global Constraints

- Todos os campos de setup são **readonly** até preenchidos pelo admin
- Método de pagamento fica **inativo** até todos os campos obrigatórios serem preenchidos
- Valores padrão via `setupFieldDefaultValues()` aparecem como placeholder
- Validação segue regras do `setupFieldRules()`: type, min, max, required
- Campos select recebem array de opções no `setupFieldRules()`

---

## Task 1: Database Migration - Adicionar Coluna setup_fields

**Arquivos:**
- Criar: `backend/database/migrations/2026_07_06_000000_add_setup_fields_to_payment_method_configs_table.php`
- Modificar: `backend/app/Models/PaymentMethodConfig.php:23-29` (fillable)

**Interfaces:**
- Consome: Nada (migrations não dependem de outras)
- Produz: Coluna `setup_fields` (JSON nullable) na tabela `payment_method_configs`

- [ ] **Step 1: Criar arquivo de migration**
- [ ] **Step 2: Escrever conteúdo da migration**
- [ ] **Step 3: Atualizar PaymentMethodConfig fillable**
- [ ] **Step 4: Adicionar cast para setup_fields**
- [ ] **Step 5: Rodar migration**
- [ ] **Step 6: Commit**

---

## Task 2: Backend - Adicionar setupFieldDefaultValues() ao AbstractPaymentMethod

**Arquivos:**
- Modificar: `backend/app/PaymentMethods/AbstractPaymentMethod.php:122-125`
- Modificar: `backend/app/PaymentMethods/PixOfflinePaymentMethod.php` (exemplo)

**Interfaces:**
- Consome: Nada (classe abstrata base)
- Produz: Método `setupFieldDefaultValues(): array` que retorna array associativo com valores padrão

- [ ] **Step 1: Adicionar método ao AbstractPaymentMethod**
- [ ] **Step 2: Adicionar método ao PixOfflinePaymentMethod (exemplo)**
- [ ] **Step 3: Rodar testes para validar (opcional)**
- [ ] **Step 4: Commit**

---

## Task 3: Backend - Adicionar Métodos Helper ao PaymentMethodConfig

**Arquivos:**
- Modificar: `backend/app/Models/PaymentMethodConfig.php`

**Interfaces:**
- Consome: `setupFieldRules()` e `setupFieldDefaultValues()` do payment method
- Produz: Métodos `getPaymentMethodInstance()`, `getSetupFieldRules()`, `getSetupFieldDefaults()`, `isSetupComplete()`

- [ ] **Step 1: Adicionar método para obter instância do payment method**
- [ ] **Step 2: Adicionar importação necessária no topo do arquivo**
- [ ] **Step 3: Adicionar método para retornar regras de setup**
- [ ] **Step 4: Adicionar método para retornar valores padrão**
- [ ] **Step 5: Adicionar método para validar completude de setup**
- [ ] **Step 6: Commit**

---

## Task 4: Backend - Criar Service para Validar Setup Fields

**Arquivos:**
- Criar: `backend/app/Services/PaymentMethodSetupValidator.php`

**Interfaces:**
- Consome: `setupFieldRules()` do payment method, dados de entrada
- Produz: Validação com retorno `['valid' => bool, 'errors' => array]`

- [ ] **Step 1: Criar arquivo do service**
- [ ] **Step 2: Implementar service com validação de tipos**
- [ ] **Step 3: Commit**

---

## Task 5: Backend - Atualizar UpdatePaymentMethodConfigRequest

**Arquivos:**
- Modificar: `backend/app/Http/Requests/UpdatePaymentMethodConfigRequest.php`

**Interfaces:**
- Consome: Validação de setup_fields do request
- Produz: Regras de validação para setup_fields

- [ ] **Step 1: Adicionar validação de setup_fields no rules()**
- [ ] **Step 2: Adicionar validação customizada no after hook**
- [ ] **Step 3: Adicionar método para injetar o validator**
- [ ] **Step 4: Atualizar messages()**
- [ ] **Step 5: Commit**

---

## Task 6: Backend - Atualizar PaymentMethodConfigController

**Arquivos:**
- Modificar: `backend/app/Http/Controllers/Api/Admin/PaymentMethodConfigController.php:48-56` (show)
- Modificar: `backend/app/Http/Controllers/Api/Admin/PaymentMethodConfigController.php:59-73` (update)

**Interfaces:**
- Consome: Método `show()` e `update()` existentes
- Produz: Response com setup fields merged com defaults

- [ ] **Step 1: Atualizar método show() para incluir setup field info**
- [ ] **Step 2: Atualizar método update() para processar setup_fields**
- [ ] **Step 3: Atualizar método index() para incluir is_setup_complete**
- [ ] **Step 4: Commit**

---

## Task 7: Backend - Testes para Setup Fields (Migration + Model)

**Arquivos:**
- Criar: `backend/tests/Feature/Api/SetupFieldsTest.php`

**Interfaces:**
- Consome: Migration, Model, Controller
- Produz: Testes que validam persistência e retrieval de setup_fields

- [ ] **Step 1: Criar arquivo de teste**
- [ ] **Step 2: Implementar testes de persistência**
- [ ] **Step 3: Rodar testes**
- [ ] **Step 4: Commit**

---

## Task 8: Backend - Testes para PaymentMethodSetupValidator

**Arquivos:**
- Criar: `backend/tests/Unit/Services/PaymentMethodSetupValidatorTest.php`

**Interfaces:**
- Consome: `PaymentMethodSetupValidator` service
- Produz: Testes de validação por tipo, min/max, required, select

- [ ] **Step 1: Criar arquivo de teste**
- [ ] **Step 2: Implementar testes de validação**
- [ ] **Step 3: Rodar testes**
- [ ] **Step 4: Commit**

---

## Task 9: Backend - Testes para PaymentMethodConfig Helper Methods

**Arquivos:**
- Modificar: `backend/tests/Feature/Api/SetupFieldsTest.php` (adicionar testes)

**Interfaces:**
- Consome: Métodos helper do PaymentMethodConfig
- Produz: Testes para `getSetupFieldRules()`, `getSetupFieldDefaults()`, `isSetupComplete()`

- [ ] **Step 1: Adicionar testes ao arquivo existente**
- [ ] **Step 2: Rodar testes**
- [ ] **Step 3: Commit**

---

## Task 10: Frontend - Composable usePaymentMethodSetup

**Arquivos:**
- Criar: `frontend/src/composables/usePaymentMethodSetup.ts`

**Interfaces:**
- Consome: API response com `setup_field_rules`, `setup_fields`, `setup_field_defaults`
- Produz: `{ setupFieldRules, setupFields, setupDefaults, mergedSetupFields, updateSetupField }`

- [ ] **Step 1: Criar arquivo do composable**
- [ ] **Step 2: Implementar composable**
- [ ] **Step 3: Adicionar types ao `frontend/src/types/index.ts`**
- [ ] **Step 4: Commit**

---

## Task 11: Frontend - Componente CPaymentMethodSetupFields

**Arquivos:**
- Criar: `frontend/src/components/CPaymentMethodSetupFields.vue`

**Interfaces:**
- Consome: `setupFieldRules`, `setupFields`, `setupDefaults` do composable
- Produz: Componente Vue que renderiza campos readonly com validação

- [ ] **Step 1: Criar arquivo do componente**
- [ ] **Step 2: Implementar componente**
- [ ] **Step 3: Commit**

---

## Task 12: Frontend - Integrar Setup Fields na View de Edit Payment Instructions

**Arquivos:**
- Modificar: `frontend/src/views/Admin/PaymentMethodsView.vue` ou similar (encontre o arquivo de edição)

**Interfaces:**
- Consome: Componente `CPaymentMethodSetupFields`
- Produz: Formulário que permite editar setup_fields e instructions

- [ ] **Step 1: Encontrar arquivo de edição de payment methods**
- [ ] **Step 2: Adicionar import do componente**
- [ ] **Step 3: Adicionar estado para setup_fields**
- [ ] **Step 4: Carregar config ao abrir modal/view**
- [ ] **Step 5: Adicionar template HTML para setup fields**
- [ ] **Step 6: Atualizar função de save para incluir setup_fields**
- [ ] **Step 7: Commit**

---

## Task 13: Frontend - Testes com Chrome DevTools MCP

**Arquivos:**
- Criar: `frontend/tests/e2e/payment-setup-fields.spec.ts`

**Interfaces:**
- Consome: UI do formulário de payment methods
- Produz: Testes E2E que validam interação com campos de setup

- [ ] **Step 1: Criar arquivo de teste E2E**
- [ ] **Step 2: Implementar teste E2E com Chrome DevTools**
- [ ] **Step 3: Atualizar arquivo de teste para usar MCP Chrome DevTools**
- [ ] **Step 4: Adicionar data-testid aos componentes**
- [ ] **Step 5: Commit**

---

## Task 14: Testes de Integração Backend - End-to-End

**Arquivos:**
- Modificar: `backend/tests/Feature/Api/PaymentMethodConfigControllerTest.php` (adicionar testes de setup)

**Interfaces:**
- Consome: Todos os métodos anteriores (controller, validator, model)
- Produz: Testes E2E que validam fluxo completo de setup

- [ ] **Step 1: Adicionar testes de integração ao arquivo existente**
- [ ] **Step 2: Rodar todos os testes de payment methods**
- [ ] **Step 3: Rodar testes de setup validator**
- [ ] **Step 4: Commit**

---

## Task 15: Documentação e Cleanup Final

**Arquivos:**
- Criar: `docs/PAYMENT_METHOD_SETUP_FIELDS.md` (documentação)
- Modificar: `.gitignore` (se necessário)

**Interfaces:**
- Consome: Todos os arquivos anteriores
- Produz: Documentação completa e cleanup

- [ ] **Step 1: Criar documentação**
- [ ] **Step 2: Verificar formatação de código**
- [ ] **Step 3: Rodar testes completos**
- [ ] **Step 4: Commit final**

---

## Resumo de Alterações

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `backend/database/migrations/2026_07_06_*` | Criar | Migration para adicionar coluna setup_fields |
| `backend/app/PaymentMethods/AbstractPaymentMethod.php` | Modificar | Adicionar setupFieldDefaultValues() |
| `backend/app/Models/PaymentMethodConfig.php` | Modificar | Adicionar helper methods |
| `backend/app/Services/PaymentMethodSetupValidator.php` | Criar | Validador de setup fields |
| `backend/app/Http/Requests/UpdatePaymentMethodConfigRequest.php` | Modificar | Adicionar validação de setup_fields |
| `backend/app/Http/Controllers/Api/Admin/PaymentMethodConfigController.php` | Modificar | Adicionar tratamento de setup_fields |
| `backend/tests/Feature/Api/SetupFieldsTest.php` | Criar | Testes de persistência |
| `backend/tests/Unit/Services/PaymentMethodSetupValidatorTest.php` | Criar | Testes de validação |
| `frontend/src/composables/usePaymentMethodSetup.ts` | Criar | Composable para gerenciar setup fields |
| `frontend/src/components/CPaymentMethodSetupFields.vue` | Criar | Componente de formulário |
| `frontend/src/views/Admin/PaymentMethodsView.vue` | Modificar | Integrar setup fields |
| `frontend/tests/e2e/payment-setup-fields.spec.ts` | Criar | Testes E2E |
| `docs/PAYMENT_METHOD_SETUP_FIELDS.md` | Criar | Documentação |
