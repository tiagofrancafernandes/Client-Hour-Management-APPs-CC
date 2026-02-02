# TASK-01-06 — Add Internal Note Toggle Button in Wallet Detail View

## STATUS
⬜ TODO

## RELATED PLAN
[PLAN-TASK-01-internal-note.md](../plans/PLAN-TASK-01-internal-note.md) - Step 06

## DESCRIPTION

Add a toggle button (eye icon) in the wallet detail view to show/hide the internal note field. This provides visual control over displaying sensitive internal notes.

## REQUIREMENTS

### Frontend Implementation

1. **Locate the Wallet Detail View:**
   - File: `src/views/ClientDetailView.vue` or `src/views/WalletDetailView.vue`
   - Find the wallet display section

2. **Add Internal Note Display Section:**
   ```vue
   <div v-if="hasInternalNotePermission && wallet.internal_note" class="mt-6">
       <div class="flex items-center justify-between mb-2">
           <label class="text-sm font-semibold text-gray-700">Internal Note</label>
           <button
               @click="toggleInternalNoteVisibility(wallet.id)"
               class="p-1 text-gray-500 hover:text-gray-700 transition-colors"
               :title="isInternalNoteVisible(wallet.id) ? 'Hide' : 'Show'"
           >
               <Icon
                   :icon="isInternalNoteVisible(wallet.id) ? 'mdi:eye' : 'mdi:eye-off'"
                   class="w-5 h-5"
               />
           </button>
       </div>

       <div
           v-if="isInternalNoteVisible(wallet.id)"
           class="p-3 bg-gray-50 rounded border border-gray-200 text-sm"
       >
           {{ wallet.internal_note }}
       </div>
       <div v-else class="text-gray-500 italic text-sm">
           Internal note hidden
       </div>
   </div>
   ```

3. **Add Edit Mode Support:**
   - If wallet is in edit mode, allow users with permission to edit internal_note
   - Use CTextarea component for editing:
   ```vue
   <CTextarea
       v-if="isEditing && hasInternalNotePermission"
       v-model="form.internal_note"
       label="Internal Note"
       placeholder="Add internal notes (visible only to authorized users)"
   />
   ```

4. **Import Required Composables:**
   - Import useWallets for toggle and visibility methods
   - Import auth composable for permission check

5. **Add Reactive Data:**
   - Import Icon component from Iconify
   - Set up walletId reference for toggle state

### Implementation Steps
1. Locate wallet detail view component
2. Import useWallets composable and necessary functions
3. Extract walletId from route params
4. Add conditional internal_note section in view mode
5. Add internal_note textarea in edit mode
6. Add eye icon toggle button
7. Style to match design system (from design.json)
8. Test toggle functionality
9. Test with different permissions (visible/hidden)
10. Test on responsive layouts

### Files to Modify
- Wallet detail view (likely `src/views/ClientDetailView.vue` or `src/views/WalletDetailView.vue`)

### Styling Requirements
- Use TailwindCSS classes matching design system
- Eye icon should be mdi:eye or mdi:eye-off (Iconify)
- Text color and background should match design palette
- Transition effects on hover
- Responsive on mobile/tablet/desktop

### Testing Checklist
- [ ] Toggle button appears only when user has permission
- [ ] Toggle button appears only when wallet has internal_note
- [ ] Eye icon shows/hides correctly
- [ ] Internal note content hidden by default
- [ ] Content displays when toggled
- [ ] Edit mode allows modification with permission
- [ ] Non-permitted users don't see section
- [ ] Mobile layout responsive
- [ ] Icon hover effect works
- [ ] State persists during page navigation

---

## NOTES
- Visibility state is managed in composable and persists during session
- Only users with `wallet.view_internal_note` permission see the section
- Eye icon toggle is independent of API response hiding
- Consider adding tooltip on icon explaining the toggle
- Next step is comprehensive testing of the entire feature
