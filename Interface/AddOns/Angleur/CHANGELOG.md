# Angleur

## [2.7.8](https://github.com/LegolandoBloom/Angleur/tree/2.7.8) (2026-02-21)
[Full Changelog](https://github.com/LegolandoBloom/Angleur/compare/2.7.7...2.7.8) [Previous Releases](https://github.com/LegolandoBloom/Angleur/releases)

- updated tooltip  
- adjusted tooltip  
- Added new "Made By" Frame with tooltip regarding my stance on plagiarism  
- Fixed accidental global with old Legolando\_HelpTipTemplate  
    deleted now obsoleted CVar code  
- fixed translation replacement of platerClash not showing up  
- removed dev print from mists.lua  
    removed unnecessary and disruptive padding for fishing method button tooltips on Retail  
- removed forgotten,  reduntant(and bug creating) EventLoader from Mists  
- improved TempCVar handler, now handles each OnUpdate separately with pool frames(no longer bugs out with multiple entries with one Set() call  
- Tiny tab Master Volume slider now correctly remembers its position(doesn't change funcionality)  
- moved UltraFocusAudio, UltraFocusAutoLoot, Background Audio, Soft Interact(Retail) and Soft Interact(Classic) to the new TempCVar system  
    Fixed newly introduced lua error with softicon checkbox image  
- moved UltraFocusBackground from main files to init.lua to be deleted entirely later(replaced)  
    Updated TempCVarHandler(now takes variable amount of keys in Set() and Release())  
- updated interface version number  
- Replacing all instances of:  
    - Angleur\_HandleTempCVars  
    - Angleur\_UltraFocusInteractOff  
    - AngleurClassic\_ToggleSoftInteract  
    with the new TempCVarHandler method  
- added the new TempCVarHandlerTemplate  
- adding new ubiquitous method for temp CVar handling 1  
- removed unused localization from slash commands  
    /ang added to slash commands(same function as /angang and /angleur)  
- moving loading/unloading functions from all flavors of Angleur.lua to the shared init.lua 2  
- moving loading/unloading functions from all flavors of Angleur.lua to the shared init.lua 1  
- debug level is now properly loaded when logging in instead of resetting back to default  
    (will still be set to default if debug mode is disabled)  
    Will now print in chat what debug level is chosen  
- Added debug level selection to UI  
    Added new debug text to items\_mists -> bait  
    Debug Level is now checked each time a debug print is called  
