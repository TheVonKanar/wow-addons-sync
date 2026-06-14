# Platynator

## [397](https://github.com/TheMouseNest/Platynator/tree/397) (2026-05-23)
[Full Changelog](https://github.com/TheMouseNest/Platynator/compare/396...397) 

- Retail: Include notice that the stack/click region settings have moved  
    Also fix vertical offset visibility  
- Fix typo and ranges for click region widths  
- Retail: Resizing a stack/click region will resize around their mid-point  
- Another minor change for MoP PTR  
- Fixes for MoP PTR (now supports the hit test rects)  
- Use normalized anchors for click/stack region  
- Retail: Fix anchoring of click/stack regions  
- Designer: Fix error when transitioning between profiles with regions visible  
- Update migration level  
- Designer: Add "Blank" style for users who want to start with 0 widgets  
- Fix "version" field on designs getting obliterated on export  
- Retail: Add new "Region" widgets to design to control stack/click regions positions  
    This allows:  
    - Cast bar/Creature name included in the click region without extra space around the  
      nameplate being clickable.  
    - Cast bar now included in the stack region by default  
    - Manual positioning and sizing of the regions relative to each other  
      (and other widgets on the nameplate)  
    Warning:  
    - Your stack and click region scale sliders have been reset  
