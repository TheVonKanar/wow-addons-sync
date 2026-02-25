# Larias's Weekly Checklist: Localization

This repo is an **optional companion addon** that ships extra locales for **Larias's Weekly Checklist**.

## Add a locale (simple)

You add **two files** by copying the main addon's enUS files and translating them.

### 1) Strings: copy `enUS.lua`, translate

1. Copy the main addon file `Locales/enUS.lua` into this repo as `Locales/<LOCALE>.lua`.
2. In the copied file:
   - Change `local LOCALE = "enUS"` to your locale code (example: `"frFR"`).
   - Translate the **values** in the `STRINGS = { ... }` table.
   - Do not rename keys (the left side like `TAB_LIST`, `RESET_BUTTON`, etc.).

### 2) Data: copy `enUS_Data.lua`, translate

1. Copy the main addon file `Locales/enUS_Data.lua` into this repo as `Locales/<LOCALE>_Data.lua`.
2. In the copied file:
   - Change the `LOCALE` constant to your locale code.
   - Translate only `title` and `text` fields.
   - Do not change any `id` values (IDs must match enUS so checkmarks stay consistent).

### 3) Add the files to the `.toc`

Edit `LariasWeeklyChecklist_Localization.toc` and add:

```toc
Locales\<LOCALE>.lua
Locales\<LOCALE>_Data.lua
```

### 4) Test

- Enable both addons, run `/reload`, and verify the list + options strings are translated.

## Updating later

When enUS changes in the main addon, re-copy `enUS.lua` / `enUS_Data.lua` and re-apply your translations (keeping keys/IDs the same).
