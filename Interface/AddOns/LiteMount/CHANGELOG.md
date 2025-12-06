# LiteMount

## [11.2.7-1](https://github.com/xod-wow/LiteMount/tree/11.2.7-1) (2025-12-03)
[Full Changelog](https://github.com/xod-wow/LiteMount/compare/11.2.5-16...11.2.7-1) [Previous Releases](https://github.com/xod-wow/LiteMount/releases)

- Refresh mounts and env state even in combat  
- Add mock testing for C\_Traits  
- Fix waterwalking and gathering checks  
- Add Starspark Netherdrake  
- Update ToC for 11.2.7  
- More single-env-check fixes  
- Bug fixes  
- Update environment once per activation only  
    Used to do a bunch of checks per-mount, which started out being ok but has  
    become slower with the sheer amount of mounts there are now. Selecting a  
    mount is still slower than I'd like but just calling IsUSableSpell on  
    1000+ things takes 1/20th of a second and there's no way around it.  
- Handle aura secrets in active mount / copy mount checks #396  
- Use LM.UnitAura in IsPhaseDiving for secret checks #396  
- Use GetShapeshiftForm check for Ghost Wolf instead of UnitAura #396  
- Skip secrets in LM.UnitAura #396  
- Use GetOverrideBarSkin for G-99 Breakneck to avoid UnitAura secrets in Midnight #396  
- Remove support for Tablet of Ghost Wolf  
- Strip encounter checking code out #396  
    It never worked, was unused except for a debug message, and doesn't work in Midnight  
