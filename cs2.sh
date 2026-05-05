#!/bin/sh
cd $HOME/hlserver
cs2/game/bin/linuxsteamrt64/cs2 -dedicated -console -usercon +game_type 0 +game_mode 1 +mapgroup mg_active +map de_dust2 $@
