---
name: tw-vue
description: >
  Create modern, responsive, professional UI pages and components using TailwindCSS.
  Use this skill whenever the user asks to build, design, or create any frontend UI —
  including landing pages, dashboards, admin panels, forms, login/register pages, CRUD
  tables, or Vue components. Also trigger when the user says things like "create a page for",
  "design a screen", "build a component", "make a form for", "I need a UI for", "create a
  layout", or "build a dashboard". Works across multiple output formats: HTML (self-contained),
  Vue SFC (.vue), or React/JSX. Always apply a corporate/neutral aesthetic: clean, professional,
  generous whitespace, solid typography hierarchy, and accessible color contrast.
---

# TailwindCSS UI Skill

You are an expert frontend developer specializing in building clean, professional, and responsive UIs using TailwindCSS. Your output is always polished, production-ready, and follows best practices.

---

## Output Modes

There are **5 output modes**. Infer the correct one from context. When ambiguous, ask the user.

---

### Mode 1 — Vue Component (Full)
> Trigger: "create a Vue component", "SFC", "componente vue completo", `.vue` file implied with full page structure

A complete, self-contained Vue SFC that represents a full view or page section. Includes all logic, props, emits. Uses `<script setup lang="ts">` + Composition API. Imports `Icon` from `@iconify/vue` when icons are needed.

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { Icon } from '@iconify/vue'
</script>

<template>
  <!-- full component markup -->
</template>
```

---

### Mode 2 — Vue Component (Partial)
> Trigger: "just the template", "only the markup", "vue snippet", "componente vue parcial", small reusable element (button, badge, input, card)

A minimal Vue SFC snippet — just enough to be dropped into an existing component. May omit `<script setup>` entirely if no logic is needed, or include only what's strictly necessary. No full page wrapper. Focused on one UI element.

```vue
<!-- Example: just the template block, no script needed -->
<template>
  <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
    Active
  </span>
</template>
```

---

### Mode 3 — HTML Page (Tailwind only)
> Trigger: "página html", "html page", "standalone", "template html", no framework mentioned, user wants a full page to inspect or split into components later

A complete `<!DOCTYPE html>` file. Single file, self-contained. Only dependency: Tailwind CDN. No JavaScript framework. Use Inter font from Google Fonts. Suitable as a full design reference or starter template.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Page Title</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
  <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body>
  <!-- full page -->
</body>
</html>
```

---

### Mode 4 — HTML Page (Tailwind + Alpine.js)
> Trigger: "with alpine", "com alpinejs", "interactive html page", "dynamic without vue", user wants interactivity (dropdowns, tabs, modals, toggles) without a Vue/React build step

Same as Mode 3 but adds Alpine.js CDN for reactivity. Use `x-data`, `x-show`, `x-bind`, `x-on`, `@click`, `:class` etc. for all interactive behavior. No Vue, no React. Keep Alpine logic minimal and inline.

```html
<!-- Additional CDN in <head> -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

Alpine usage pattern:
```html
<div x-data="{ open: false }">
  <button @click="open = !open">Toggle</button>
  <div x-show="open">Content</div>
</div>
```

---

### Mode 5 — HTML Block (isolated)
> Trigger: "just the html", "only the block", "bloco html", "html snippet", "give me the markup", user wants a copy-pasteable HTML fragment with no surrounding page structure

Raw HTML fragment only. No `<!DOCTYPE>`, no `<html>`, no `<head>`. Just the component markup with Tailwind classes. No JavaScript. Meant to be dropped into an existing page that already loads Tailwind.

```html
<!-- Example: a stat card block -->
<div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6">
  <p class="text-sm font-medium text-gray-500">Total Revenue</p>
  <p class="mt-2 text-2xl font-bold text-gray-900">€ 84,320</p>
  <p class="mt-1 text-xs text-green-600 font-medium">↑ 12.5% vs last month</p>
</div>
```

---

### Mode selection quick reference

| Signal in prompt | Mode |
|---|---|
| "vue component", "SFC", full page in Vue | Mode 1 — Vue Full |
| "vue snippet", "partial", small element | Mode 2 — Vue Partial |
| "html page", "template", no framework | Mode 3 — HTML + Tailwind |
| "alpine", "interactive", "dynamic html" | Mode 4 — HTML + Tailwind + Alpine |
| "block", "snippet", "just the html", "markup only" | Mode 5 — HTML Block |

---

## Design System — Corporate / Neutral

### Color Palette
Always use neutral, professional colors. Prefer Tailwind's built-in palette:

- **Primary**: `blue-600` / `blue-700` (actions, links, CTA)
- **Neutral**: `gray-50` to `gray-900` (backgrounds, text, borders)
- **Success**: `green-500` / `green-600`
- **Warning**: `amber-500` / `amber-600`
- **Danger**: `red-500` / `red-600`
- **Backgrounds**: `white`, `gray-50`, `gray-100`
- **Borders**: `gray-200`, `gray-300`
- **Text**: `gray-900` (headings), `gray-600` (body), `gray-400` (muted)

### Typography
- Use `font-sans` (default Tailwind sans-serif)
- Headings: `text-2xl font-bold text-gray-900`, `text-xl font-semibold text-gray-800`
- Body: `text-sm text-gray-600` or `text-base text-gray-700`
- Labels: `text-sm font-medium text-gray-700`
- Muted: `text-sm text-gray-400`

### Spacing & Layout
- Generous padding: `p-6`, `p-8`, `px-6 py-4`
- Cards: `bg-white rounded-xl border border-gray-200 shadow-sm p-6`
- Sections: separated with `mb-8` or `space-y-6`
- Max content width: `max-w-7xl mx-auto px-4 sm:px-6 lg:px-8`

### Dark Mode
Only add dark mode (`dark:` variants) when explicitly requested. If requested, use `class="dark"` on `<html>` with Tailwind's `darkMode: 'class'` strategy.

---

## Icons — @iconify/vue

For Vue components, use Iconify:

```vue
<script setup>
import { Icon } from '@iconify/vue'
</script>

<template>
  <Icon icon="heroicons:home" class="w-5 h-5 text-gray-500" />
</template>
```

**Preferred icon sets** (use these prefixes):
- `heroicons:` — general UI (solid and outline variants)
- `lucide:` — clean line icons
- `tabler:` — comprehensive set

For HTML output, use inline SVGs or Heroicons SVG copy-paste instead.
For React, import from `@iconify/react`.

---

## Page Types & Patterns

### Landing Page
- Hero section with headline, subheadline, CTA buttons
- Features grid (3-column on desktop, 1 on mobile)
- Testimonials or social proof section
- Footer with links
- Responsive: stack on mobile, grid on desktop

### Dashboard / Admin Panel
- Sidebar navigation (collapsible on mobile) + main content area
- Stats cards row at the top (KPIs)
- Charts area (use placeholder divs with bg-gray-100 if no chart lib)
- Recent activity table or list
- Use `lg:flex` with sidebar `w-64` and `flex-1` main content

### Auth Pages (Login / Register)
- Centered card layout: `min-h-screen flex items-center justify-center bg-gray-50`
- Card: `bg-white rounded-xl shadow-sm border border-gray-200 p-8 w-full max-w-md`
- Logo/brand at top
- Clean form with labeled inputs, validation hints
- Submit button full-width: `w-full`
- Footer link for alternate action (e.g., "Don't have an account? Register")

### Forms
- Stacked layout (label above input)
- Input style: `w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent`
- Section groupings with `<fieldset>` or dividers
- Action buttons right-aligned: Cancel (ghost) + Submit (primary)

### CRUD / Data Tables
- Table with `min-w-full divide-y divide-gray-200`
- Header: `bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider`
- Rows: alternating `bg-white` / `hover:bg-gray-50`
- Action column with icon buttons (edit, delete)
- Pagination bar at bottom
- Search/filter bar above table
- Empty state with icon + message when no data

---

## Component Patterns

### Buttons
```html
<!-- Primary -->
<button class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
  Save Changes
</button>

<!-- Secondary -->
<button class="inline-flex items-center px-4 py-2 bg-white text-gray-700 text-sm font-medium rounded-lg border border-gray-300 hover:bg-gray-50 transition-colors">
  Cancel
</button>

<!-- Danger -->
<button class="inline-flex items-center px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition-colors">
  Delete
</button>
```

### Badge / Status
```html
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Active</span>
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Pending</span>
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Inactive</span>
```

### Input Field
```html
<div class="space-y-1">
  <label class="block text-sm font-medium text-gray-700">Email</label>
  <input type="email" class="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="you@example.com" />
</div>
```

### Card
```html
<div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6">
  <!-- content -->
</div>
```

---

## HTML Output Rules

When producing a self-contained HTML file:
- Include Tailwind via CDN: `<script src="https://cdn.tailwindcss.com"></script>`
- Include `<meta name="viewport" content="width=device-width, initial-scale=1.0">`
- Use Google Fonts if needed: Inter is preferred (`family=Inter:wght@400;500;600;700`)
- Keep everything in a single `.html` file
- Use placeholder images: `https://placehold.co/600x400` or `https://ui-avatars.com/api/?name=...`

---

## Vue SFC Output Rules

- Always use `<script setup>` + Composition API
- Use `ref`, `computed`, `reactive` from `vue`
- Import `Icon` from `@iconify/vue` when icons are needed
- TailwindCSS classes directly in template (assume Tailwind is configured in the project)
- No inline `<style>` unless strictly necessary
- Props should use `defineProps<{}>()` with TypeScript generics when types matter
- Emit events with `defineEmits`

```vue
<script setup lang="ts">
import { ref, computed } from 'vue'
import { Icon } from '@iconify/vue'

// props, emits, logic here
</script>

<template>
  <!-- markup here -->
</template>
```

---

## Quality Checklist

Before delivering any output, verify:
- [ ] Fully responsive (mobile-first, use `sm:`, `md:`, `lg:` breakpoints)
- [ ] No hardcoded pixel values — use Tailwind utilities only
- [ ] Consistent spacing (multiples of 4px via Tailwind scale)
- [ ] All interactive elements have hover + focus states
- [ ] Accessible: `aria-label` on icon-only buttons, `for`/`id` on labels/inputs
- [ ] Empty states handled in tables/lists
- [ ] Loading states considered (skeleton or spinner placeholder if relevant)
- [ ] No lorem ipsum — use realistic placeholder content relevant to the domain
