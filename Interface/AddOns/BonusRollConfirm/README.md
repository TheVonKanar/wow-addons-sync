# BonusRollConfirm

A small World of Warcraft addon that pops up a confirmation prompt before you spend a bonus roll, so you never burn one by accident.

## What it does

When the bonus roll dialog appears, BonusRollConfirm adds an extra confirmation step before the currency is spent. Confirm to proceed, or cancel to keep your roll.

The confirmation also shows the loot specialization the roll will award for, so you get a chance to notice you are in the wrong one before the roll is gone. If you have not set an explicit loot spec, it shows your current spec instead.

## Installation

1. Copy this folder into `World of Warcraft/_retail_/Interface/AddOns/` (or use the packaged `BonusRollConfirm.zip`).
2. Restart the game or `/reload`.

## Files

- `BonusRollConfirm.lua` - addon logic
- `BonusRollConfirm.toc` - addon manifest
- `make_zip.ps1` - packages a release zip
- `CHANGELOG.md` - version history

See [CHANGELOG.md](CHANGELOG.md) for version history.
