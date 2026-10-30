# Design references

Offline copies of the Buckets design system, for agents and contributors without access to the canvas links.

| File | Contents |
| --- | --- |
| `tokens.json` | All design tokens: colors (light/dark), type, spacing, radius, shadows. Input to `tool/gen_tokens.dart`. |
| `DESIGN_SYSTEM.md` | Brand book: principles, colour and type usage, layout, icons, accessibility, rules for AI agents |
| `WRITING.md` | Voice, money/date formats, words to use, length limits |
| `COMPONENT_SPECS.md` | Visual specs of every component |
| `PATTERNS.md` | Core loop, required states, notification list, proof checks |
| `screens/` | Export the 23 canvas frames here as `NN-name.png` (e.g. `08-home.png`) |

If a value here and `docs/DOMAIN.md` disagree on behaviour, DOMAIN.md wins. If they disagree on looks, these files win.
