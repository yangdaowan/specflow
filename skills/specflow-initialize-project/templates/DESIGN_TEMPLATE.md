# DESIGN

> 目标：为 AI 编码提供统一的 UI/UX 事实来源，避免每次按“个人审美”临时发挥。

## 1) Visual Theme & Atmosphere

- Product tone:
- Brand keywords:
- UI density: compact / balanced / spacious
- Motion preference: subtle / moderate / expressive

## 2) Color Palette & Roles

- Primary:
- Secondary:
- Accent / CTA:
- Success / Warning / Error:
- Background / Surface:
- Text primary / secondary:

## 3) Typography Rules

- Heading font:
- Body font:
- Mono font (if needed):
- Type scale:

## 4) Component Styling Rules

- Button:
- Input / Select / DatePicker:
- Card / Table / List:
- Modal / Drawer / Popover:
- Empty / Error / Loading states:

## 5) Layout Principles

- Spacing scale:
- Grid:
- Max content width:
- Section rhythm:

## 6) Interaction & State

- Hover / Focus / Active rules:
- Keyboard accessibility rules:
- Async states (loading/skeleton/retry):
- Route change and modal lifecycle behavior:

## 7) Design Guardrails (Do / Don't)

Do:
- Prefer existing design system/components (for example Ant Design) before custom rebuilding.
- Keep visual hierarchy clear with labels, grouping, and whitespace.

Don't:
- Do not leak raw data values to UI (`Invalid Date`, `NaN`, raw object/array).
- Do not introduce style drift across pages for equal-level components.

## 8) Responsive Behavior

- Breakpoints:
- Touch target minimum:
- Mobile navigation behavior:
- Table/list collapse strategy:

## 9) Verification Checklist (UI Delivery Gate)

- [ ] Core screens conform to this DESIGN.md
- [ ] Component behavior is consistent across open/close/switch/reopen
- [ ] Empty/error/loading states are visible and readable
- [ ] No i18n key leakage or raw technical values in UI
