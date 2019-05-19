# Factorio-ColonelWill


A mod for streamer ColonelWill's server. Includes a number of distinct modes which are not migratable.

Investigate Spaceship Crash Cause
===================

- Tested with Factorio 0.17.41
- Add 7 tiers of expensive technology that unlock a test module. Each module is very expensive to make.
- Each of the 7 test modules must be launched in to space for testing in order to win.
- A mod GUI will show the current test module to be launched, the completed tests and future tests.
- A welcome and win message will be shown to each player. They can be accessed via the Information button in the mod Gui.

Escape Pod v2
==============

- Tested with Factorio 0.17.35
- Adds multiple expensive escape pod part technology to unlock the Escape Pod. 4 sets of 5 technologies each requiring 1k science plus 1k per workforce level researched. With each set requiring more advanced sciences, but not including space science. Then infinite technologies using all sciences including space science. Starting target is 25 escape pod part researches.
- Adds a command to increase the number of additional escape pod part technologies that must be researched to unlock the escape pod recipe: escape_pod_add_level [NUMBER OF LEVELS]
- Adds an escape pod that can only be used in a rocket and lets you ride in it. Costs the same as a satellite plus a fish. Must be unlocked through research.
- Win condition is only when an escape pod is launched in a rocket.
- Adds a recruit workforce member research that has 5 initial tiers with 5k science cost and requiring increasing science types up to space science. Levels 6-10 double the previous amount. Each research will add another 1k science cost to the escape pod technologies. Does nothing in-game, but updates the max workforce counter.
- Adds a simple GUI that shows the number of workforce recruited and how many are present. Also shows the required Escape Pod parts that have been researched and the target.
- Adds a simple static GUI that shows the donation to escape pod part costs.
- When an infinite Escape Pod research (level 21) is completed the mod will automatically add the next infinite Escape Pod research to the end of the queue if the target hasn't been met.
- When workforce research is done any progress on current escape pod technologies will be lost.

Legacy Mode Versions
============

Escape Pod v1
-----------

- Tested with Factorio 0.17.26
- Adds multiple expensive escape pod part technology to unlock the Escape Pod. Starts with 4 core technologies totalling 20k pots.
- Adds a command to increase the number of additional escape pod shiny part (1k pot) technologies that must be researched to unlock the escape pod recipe: escape_pod_add_level [NUMBER OF LEVELS]
- Adds an escape pod that can only be used in a rocket and lets you ride in it. Costs the same as a satellite. Must be unlocked through research.
- Win condition is only when an escape pod is launched in a rocket.
- Adds an infinite research that doubles in cost (starts 10k each) that is named for recruiting workforce members. Does nothing in-game.
- Adds a simple GUI that shows the number of workforce recruited and how many are present. Also shows the required Escape Pod parts that have been researched and the target.
- Adds a simple static GUI that shows the donation to escape pod part costs.
- When an infinite Escape Pod research (level 5) is completed the mod will automatically add the next infinite Escape Pod research to the end of the queue if the target hasn't been met.
