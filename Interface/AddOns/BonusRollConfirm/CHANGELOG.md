# Changelog

## 1.1.2

- Corrected the interface version to 12.1 (120100). 1.1.1 raised it to 12.0.5, which was already a patch behind

## 1.1.1

- Updated for patch 12.0.5. The addon was still declaring 12.0.0, which flagged it as out of date and published releases against the wrong game version
- `/brc nopass` now ignores surrounding whitespace and capitalisation

## 1.1.0

- The bonus roll confirmation now shows your current loot specialization, so you can check it before spending the roll

## 1.0.1

- The `/brc nopass` setting now persists across reloads and relogs (saved per account)

## 1.0.0

- Confirmation prompt before using a bonus roll
- Confirmation prompt before passing on a bonus roll
- `/brc nopass` to toggle the pass confirmation on/off
- `/brc test` to test the confirmation popup without needing to be in content
- `/brc` to print BonusRollFrame hierarchy and hook status
