# TASK 03 - HOTFIX — Correção de Reatividade do Timer

## Data
31/01/2026

## Contexto

Após implementação da TASK-03 (Feature de Timer), foram identificados problemas de reatividade que impediam o funcionamento correto do sistema de timer.

---

## Problemas Identificados

### 1. TimerFloatingBalloon não aparecia após iniciar timer

**Arquivo**: `frontend/src/components/TimerFloatingBalloon.vue`

**Sintoma**:
- Balão flutuante não aparecia quando um timer era iniciado
- Mesmo com timer ativo (status running/paused), o balão não era exibido

**Causa Raiz** (linhas 98-106):
```typescript
// ❌ Código incorreto - fora de qualquer função reativa
// Este código só executava UMA VEZ quando o componente era criado
if (hasTimer.value && !intervalId.value) {
    startLocalTimer();
}

if (!hasTimer.value && intervalId.value) {
    stopLocalTimer();
}
```

**Problema**: O código estava fora de qualquer ciclo de vida reativo (watch, onMounted, computed, etc), então só executava uma vez quando o componente era montado, não quando `hasTimer` mudava de valor.

**Solução Aplicada**:
```typescript
// ✅ Código correto - watch para observar mudanças
watch(hasTimer, (newValue, oldValue) => {
    if (newValue && !intervalId.value) {
        // Timer became active - start local timer
        startLocalTimer();
    } else if (!newValue && intervalId.value) {
        // Timer is no longer active - stop local timer
        stopLocalTimer();
    }
});

// Watch para atualizar tempo local quando timer mudar
watch(timer, (newTimer) => {
    if (newTimer) {
        localTime.value = newTimer.total_seconds;
    } else {
        localTime.value = 0;
    }
}, { deep: true });
```

### 2. TimerConfirmModal não inicializava os ciclos

**Arquivo**: `frontend/src/components/TimerConfirmModal.vue`

**Sintoma**:
- Modal de confirmação não mostrava os ciclos do timer
- Não era possível confirmar o timer e criar o ledger entry

**Causa Raiz** (linhas 107-109):
```typescript
// ❌ Código incorreto - fora de qualquer função reativa
// Este código só executava UMA VEZ quando o componente era criado
if (props.show && props.timer) {
    initializeCycles();
}
```

**Problema**: Similar ao anterior, o código estava fora de qualquer watcher, então não reagia a mudanças nas props.

**Solução Aplicada**:
```typescript
// ✅ Código correto - watch para observar mudanças
watch(
    () => [props.show, props.timer],
    ([newShow, newTimer]) => {
        if (newShow && newTimer) {
            initializeCycles();
        }
    },
    { immediate: true }
);
```

---

## Fluxo Corrigido

### Antes (Não Funcionava):
```
1. Usuário clica "Start Timer" → Timer criado no backend ✅
2. Timer store atualiza activeTimer ✅
3. hasActiveTimer computed retorna true ✅
4. TimerFloatingBalloon v-if="hasTimer" → ❌ Permanece false (código não reativo)
5. Balão NÃO aparece ❌
```

### Depois (Funcionando):
```
1. Usuário clica "Start Timer" → Timer criado no backend ✅
2. Timer store atualiza activeTimer ✅
3. hasActiveTimer computed retorna true ✅
4. Watch detecta mudança em hasTimer ✅
5. Watch chama startLocalTimer() ✅
6. TimerFloatingBalloon v-if="hasTimer" → ✅ Exibe balão
7. Balão aparece com contador funcionando ✅
```

---

## Lições Aprendidas

### 1. Código no Nível Raiz de `<script setup>` não é Reativo
- Código fora de funções como `watch`, `computed`, `onMounted` só executa **uma vez**
- Para reagir a mudanças, use:
  - `watch` para observar refs/computed
  - `computed` para valores derivados
  - Lifecycle hooks (`onMounted`, `onUpdated`, etc) para efeitos colaterais

### 2. Props Mudando Requerem Watch
- Props podem mudar a qualquer momento
- Se você precisa executar código quando uma prop muda, use `watch`
- Use `{ immediate: true }` para executar o watch na primeira renderização

### 3. Padrão Correto para Inicialização Condicional
```typescript
// ❌ ERRADO - Não é reativo
if (someCondition.value) {
    doSomething();
}

// ✅ CORRETO - Reativo
watch(someCondition, (newValue) => {
    if (newValue) {
        doSomething();
    }
}, { immediate: true });
```

---

## Arquivos Modificados

```
frontend/src/components/TimerFloatingBalloon.vue
frontend/src/components/TimerConfirmModal.vue
```

---

## Commit

```
commit e771d24
Author: Tiago França <tiago@example.com>
Date:   Fri Jan 31 2026

    Corrige reatividade dos componentes de timer

    Problemas identificados e corrigidos:

    1. TimerFloatingBalloon.vue:
       - Código nas linhas 98-106 estava fora de funções reativas
       - Adicionado watch para observar mudanças em hasTimer
       - Adicionado watch para observar mudanças no timer para atualizar localTime
       - Agora o balão aparece corretamente quando um timer é iniciado

    2. TimerConfirmModal.vue:
       - Código nas linhas 107-109 só executava uma vez na criação do componente
       - Adicionado watch para observar mudanças em props.show e props.timer
       - Agora os ciclos são inicializados corretamente quando a modal é aberta

    Estes problemas impediam:
    - O balão flutuante de aparecer quando um timer era iniciado
    - A modal de confirmação de exibir os ciclos corretamente

    Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

---

## Status

✅ **RESOLVIDO**

Todos os problemas de reatividade foram corrigidos. O fluxo completo de timer agora funciona:
- ✅ Iniciar timer
- ✅ Balão flutuante aparece
- ✅ Pausar/Retomar timer
- ✅ Parar timer
- ✅ Modal de confirmação exibe ciclos
- ✅ Confirmar cria ledger entry
