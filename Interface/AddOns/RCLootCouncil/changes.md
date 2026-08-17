## Changes

Updated for patch 12.2.

### Column API

*For developers.*  
The voting frame now has an official API for adding, updating, moving, and removing columns.
This should make it a lot easier for you guys developing 3rd party RCLootCouncil modules.

The ways of adding columns are preserved for backwards compatibility, but it will probably be removed in the feature to streamline control of columns - you will have plenty of time to update to using the new API.

### Session Data storage

The history can now store relevant session data such as responses, rolls and more. Session data is viewable per award (session) through a new column in the history (`/rc h`). 

This does consume a rather large amount of both comms bandwidth and storage in the history - for this reason the system is opt-in through two new settings in the history section of the options menu (`/rc c`):
- Send Session Data **Off by default**  
The Master Looter/Group Leader will need to enable this to send out the data when awarding items.
- Save Session Data **On by default**  
Causes any sent session data to be saved in the history - turn off if increased storage worries you.

Note: Only responses you click on the Loot Frame (except pass) is saved, i.e. (auto)passes and various status texts are not.

*Huge shoutout to [groeterud](https://github.com/groeterud) for his work on this (#277)*


### Simulationcraft integration

If you have Simulationcraft installed and run the `/simc` command during a RCLootCouncil session, all items in the session are now included in the Simulationcraft output!

