# TASK 03 — Feature de Timer

## Objetivo

Implementar timer para registro de horas em tempo real com ciclos de início/pausa/parada.

---

## Conceitos

### Timer
- Registro temporário de tempo trabalhado
- Pode ter múltiplos **ciclos** (play/pause cria novo ciclo)
- Só é convertido em débito de horas após **confirmação**

### Ciclo
- Par de timestamps: `started_at` e `ended_at`
- Criado ao iniciar/retomar timer
- Finalizado ao pausar/parar timer

### Estados do Timer
- `running` - Timer em execução (contando)
- `paused` - Timer pausado (não contando)
- `stopped` - Timer parado, aguardando confirmação
- `confirmed` - Timer confirmado, convertido em ledger entry
- `cancelled` - Timer cancelado, descartado

---

## Backend

### 1. Migrations

**timers**
```php
Schema::create('timers', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained()->cascadeOnDelete();
    $table->foreignId('wallet_id')->constrained()->cascadeOnDelete();
    $table->string('title')->nullable();
    $table->text('description')->nullable();
    $table->enum('status', ['running', 'paused', 'stopped', 'confirmed', 'cancelled']);
    $table->timestamp('confirmed_at')->nullable();
    $table->foreignId('ledger_entry_id')->nullable()->constrained()->nullOnDelete();
    $table->timestamps();
});
```

**timer_cycles**
```php
Schema::create('timer_cycles', function (Blueprint $table) {
    $table->id();
    $table->foreignId('timer_id')->constrained()->cascadeOnDelete();
    $table->timestamp('started_at');
    $table->timestamp('ended_at')->nullable();
    $table->timestamps();
});
```

### 2. Models

**Timer**
```php
class Timer extends Model
{
    use HasTags;

    protected $fillable = [
        'user_id', 'wallet_id', 'title', 'description', 'status',
        'confirmed_at', 'ledger_entry_id',
    ];

    public function user(): BelongsTo;
    public function wallet(): BelongsTo;
    public function cycles(): HasMany;
    public function ledgerEntry(): BelongsTo;

    // Calcula tempo total em segundos
    public function getTotalSecondsAttribute(): int;

    // Calcula tempo total formatado (HH:MM:SS)
    public function getFormattedDurationAttribute(): string;

    // Calcula horas decimais (para ledger entry)
    public function getTotalHoursAttribute(): float;
}
```

**TimerCycle**
```php
class TimerCycle extends Model
{
    protected $fillable = ['timer_id', 'started_at', 'ended_at'];

    protected $casts = [
        'started_at' => 'datetime',
        'ended_at' => 'datetime',
    ];

    public function timer(): BelongsTo;

    public function getDurationSecondsAttribute(): int;
}
```

### 3. Endpoints API

| Method | Endpoint | Description | Permission |
|--------|----------|-------------|------------|
| GET | `/api/timers` | Listar timers do usuário | `timer.view_any` |
| GET | `/api/timers/active` | Obter timer ativo (se houver) | `timer.view` |
| GET | `/api/timers/{id}` | Detalhes do timer | `timer.view` |
| POST | `/api/timers` | Iniciar novo timer | `timer.create` |
| POST | `/api/timers/{id}/pause` | Pausar timer | `timer.update` |
| POST | `/api/timers/{id}/resume` | Retomar timer | `timer.update` |
| POST | `/api/timers/{id}/stop` | Parar timer | `timer.update` |
| POST | `/api/timers/{id}/cancel` | Cancelar timer | `timer.update` |
| POST | `/api/timers/{id}/confirm` | Confirmar e criar ledger entry | `timer.confirm` |
| PUT | `/api/timers/{id}` | Atualizar timer (só stopped) | `timer.update` |
| PUT | `/api/timers/{id}/cycles` | Atualizar ciclos (só stopped) | `timer.update` |
| DELETE | `/api/timers/{id}` | Excluir timer (só confirmed/cancelled) | `timer.delete` |

### 4. TimerService

```php
class TimerService
{
    public function start(User $user, Wallet $wallet, array $data): Timer;
    public function pause(Timer $timer): Timer;
    public function resume(Timer $timer): Timer;
    public function stop(Timer $timer): Timer;
    public function cancel(Timer $timer): Timer;
    public function confirm(Timer $timer, array $adjustedCycles = null): Timer;
    public function getActiveTimer(User $user): ?Timer;
    public function updateCycles(Timer $timer, array $cycles): Timer;
}
```

### 5. Validações

- **Iniciar timer**: usuário não pode ter outro timer `running` ou `paused`
- **Excluir wallet**: não permitir se houver timer ativo vinculado
- **Excluir cliente**: não permitir se houver timer ativo em suas wallets
- **Confirmar timer**: ciclos devem ter `ended_at` preenchido

### 6. Permissões (adicionar ao seeder)

```php
'timer.view',
'timer.view_any',
'timer.create',
'timer.update',
'timer.confirm',
'timer.delete',
```

---

## Frontend

### 1. Store: useTimerStore (Pinia)

```typescript
interface TimerCycle {
    id: number;
    started_at: string;
    ended_at: string | null;
}

interface Timer {
    id: number;
    wallet_id: number;
    wallet: Wallet;
    title: string | null;
    description: string | null;
    status: 'running' | 'paused' | 'stopped' | 'confirmed' | 'cancelled';
    cycles: TimerCycle[];
    tags: Tag[];
    total_seconds: number;
    formatted_duration: string;
}

const useTimerStore = defineStore('timer', () => {
    const activeTimer = ref<Timer | null>(null);
    const elapsedSeconds = ref(0);

    // Actions
    async function fetchActiveTimer(): Promise<void>;
    async function startTimer(walletId: number, data: object): Promise<Timer>;
    async function pauseTimer(): Promise<void>;
    async function resumeTimer(): Promise<void>;
    async function stopTimer(): Promise<void>;
    async function cancelTimer(): Promise<void>;
    async function confirmTimer(adjustedCycles?: TimerCycle[]): Promise<void>;

    // Computed
    const isRunning = computed(() => activeTimer.value?.status === 'running');
    const isPaused = computed(() => activeTimer.value?.status === 'paused');
    const isStopped = computed(() => activeTimer.value?.status === 'stopped');
    const hasActiveTimer = computed(() => isRunning.value || isPaused.value);
});
```

### 2. Componente: TimerFloatingBalloon

Balão flutuante exibido quando há timer ativo:

```vue
<template>
    <Teleport to="body">
        <div
            v-if="timerStore.hasActiveTimer"
            class="fixed bottom-4 right-4 z-50"
            @mouseenter="expanded = true"
            @mouseleave="expanded = false"
        >
            <!-- Balão compacto -->
            <div
                v-if="!expanded"
                class="bg-blue-600 text-white px-4 py-2 rounded-full shadow-lg cursor-pointer"
            >
                {{ formattedTime }}
                <span v-if="timerStore.isPaused" class="ml-2">⏸️</span>
                <span v-else class="ml-2 animate-pulse">●</span>
            </div>

            <!-- Balão expandido com ações -->
            <div
                v-else
                class="bg-white dark:bg-gray-800 rounded-lg shadow-xl p-4 min-w-64"
            >
                <div class="text-2xl font-mono text-center mb-4">
                    {{ formattedTime }}
                </div>

                <div class="text-sm text-gray-500 mb-4">
                    {{ timerStore.activeTimer?.wallet?.client?.name }}
                    → {{ timerStore.activeTimer?.wallet?.name }}
                </div>

                <div class="flex justify-center gap-2">
                    <button v-if="timerStore.isPaused" @click="resume">▶️ Play</button>
                    <button v-if="timerStore.isRunning" @click="pause">⏸️ Pausar</button>
                    <button @click="stop">⏹️ Parar</button>
                    <button @click="showCancelConfirm">❌ Cancelar</button>
                </div>
            </div>
        </div>
    </Teleport>
</template>
```

### 3. Componente: TimerStartModal

Modal para iniciar timer:

- Seleção de cliente (dropdown)
- Seleção de carteira (dropdown, filtrado por cliente)
- Título (opcional)
- Descrição (opcional)
- Tags (componente TagInput)
- Botão "Iniciar Timer"

### 4. Componente: TimerConfirmModal

Modal exibido ao parar timer:

- Resumo do tempo total
- Lista de ciclos (editáveis)
  - Ajustar horário de início/fim
  - Excluir ciclo
  - Adicionar novo ciclo
- Total recalculado em tempo real
- Botões: "Confirmar" / "Voltar" / "Cancelar Timer"

### 5. Tela: TimersListView

Listagem de timers do usuário:

- Filtros por status
- Tabela com: Data, Carteira, Duração, Status, Ações
- Ações por status:
  - `stopped`: Confirmar, Editar, Cancelar
  - `confirmed`: Visualizar
  - `cancelled`: Excluir

### 6. Atualização do Header/Layout

- Exibir indicador de timer ativo no header
- Botão para iniciar timer (se não houver ativo)

### 7. Intervalo de Atualização

```typescript
// No TimerFloatingBalloon
let interval: number;

onMounted(() => {
    interval = setInterval(() => {
        if (timerStore.isRunning) {
            timerStore.elapsedSeconds++;
        }
    }, 1000);
});

onUnmounted(() => {
    clearInterval(interval);
});
```

---

## Regras de Negócio

1. **Um timer por usuário**: Não pode iniciar novo se houver `running` ou `paused`
2. **Timer não debita automaticamente**: Só após confirmação vira ledger entry
3. **Ciclos são imutáveis em execução**: Só podem ser editados no status `stopped`
4. **Cancelar descarta**: Timer cancelado não gera débito
5. **Confirmar cria ledger entry**: Calcula total de horas e insere como débito
6. **Wallet protegida**: Não excluir wallet/cliente com timer ativo

---

## Critérios de Aceite

- [x] Timer pode ser iniciado com wallet selecionada
- [x] Timer pode ser pausado e retomado (cria novos ciclos)
- [x] Balão flutuante aparece quando timer está ativo
- [x] Ao parar, modal de confirmação permite ajustar ciclos
- [x] Confirmar cria ledger entry com horas calculadas
- [x] Cancelar descarta timer sem criar débito
- [x] Apenas 1 timer ativo por usuário (backend valida)
- [x] Tela de listagem de timers funciona
- [ ] Não é possível excluir wallet com timer ativo
- [ ] Testes automatizados cobrem fluxos principais

---

## Output Esperado

### Backend
- Migrations: `timers`, `timer_cycles`
- Models: `Timer`, `TimerCycle`
- `TimerController`
- `TimerService`
- `TimerPolicy`
- Permissões no seeder
- Testes Feature

### Frontend
- Store: `useTimerStore`
- Componentes:
  - `TimerFloatingBalloon.vue`
  - `TimerStartModal.vue`
  - `TimerConfirmModal.vue`
  - `TimerCycleEditor.vue`
- View: `TimersListView.vue`
- Rota: `/timers`

---

## Hotfixes Aplicados

### 31/01/2026 - Correção de Reatividade

**Problema**: Balão flutuante não aparecia e modal de confirmação não funcionava

**Arquivo**: [TASK-03-HOTFIX-timer-reactivity.md](TASK-03-HOTFIX-timer-reactivity.md)

**Resumo**:
- Corrigido código não-reativo em `TimerFloatingBalloon.vue` (linhas 98-106)
- Corrigido código não-reativo em `TimerConfirmModal.vue` (linhas 107-109)
- Adicionados `watch` para observar mudanças em `hasTimer`, `timer` e `props`
- Sistema de timer agora funciona completamente

**Commit**: `e771d24`
