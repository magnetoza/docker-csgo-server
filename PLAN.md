# Plan: CS:GO → CS2 Dedicated Server Migration

## Task
Rewrite the Docker-based CS:GO dedicated server to CS2. CS2 replaced CS:GO in September 2023 and uses a different binary (`cs2` vs `srcds_run`), different runtime dependencies (Ubuntu 22.04, `lib32gcc-s1`), and the subtick system (no `-tickrate 128`).

## Approach
Single-pass rewrite of all affected files. No refactoring beyond what's required; just translate CS:GO concepts to CS2 equivalents.

## Key CS2 Facts (from research)
- SteamCMD app ID: **730** (same app, updated to CS2)
- Install dir (in steamcmd script): `./cs2/`
- CS2 binary path: `cs2/game/bin/linuxsteamrt64/cs2 -dedicated`
- Config path: `cs2/game/csgo/cfg/` (still named `csgo` internally)
- No `srcds_run`, no `-tickrate 128` (subtick system)
- Ubuntu 22.04 dep: `lib32gcc-s1` (replaces `lib32gcc1`)
- Maps: de_dust2, de_mirage, de_inferno, de_nuke, de_overpass, de_anubis, de_ancient
- Ports: 27015 UDP/TCP (unchanged)
- GSL token still required for public servers

## Files to touch
- `Dockerfile` — Ubuntu 22.04, lib32gcc-s1, cs2 paths
- `cs2_ds.txt` — new SteamCMD script (app_update 730, force_install_dir ./cs2/)
- `cs2.sh` — new launch script using cs2 binary
- `update.sh` — point to cs2_ds.txt
- `server.cfg` — remove tickrate cvars, keep rate settings
- `autoexec.cfg` — CS2-appropriate defaults
- `README.md` — full rewrite for CS2
- `Makefile` — rename image to gonzih/cs2-server
- DELETE: csgo.sh, csgo_ds.txt, tf2_ds.txt

## Risks
- The cfg directory path (`game/csgo/cfg/`) is confirmed from CS2 community docs — internal name stayed `csgo`
- steamcmd validate won't delete custom server.cfg/autoexec.cfg (not shipped with game)
