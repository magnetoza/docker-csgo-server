## Counter-Strike 2 + Docker

[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/Gonzih/docker-cs2-server/blob/master/LICENSE.md)

CS2 dedicated server in Docker. CS2 replaced CS:GO in September 2023 and uses the subtick system (no 128-tick configuration needed).

### Docker hub image

```shell
docker pull gonzih/cs2-server
```

### Details

By default the image launches with autoupdate enabled (see `cs2.sh`).
You can create a new Dockerfile based on this image (`FROM gonzih/cs2-server`) and customize it with plugins, configs, CMD and ENTRYPOINT instructions.

```shell
# Build image and tag it as cs2-server
docker build -t cs2-server github.com/Gonzih/docker-cs2-server

# Run image with default options (CMD in Dockerfile)
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server

# Run as Classic Casual server on de_mirage
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server +game_type 0 +game_mode 0 +mapgroup mg_active +map de_mirage

# Run as Classic Competitive server on de_dust2
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server +game_type 0 +game_mode 1 +mapgroup mg_active +map de_dust2

# Run as Deathmatch server on de_inferno
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server +game_type 1 +game_mode 2 +mapgroup mg_active +map de_inferno

# To run a LAN server add +sv_lan 1
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server +game_type 0 +game_mode 1 +mapgroup mg_active +map de_nuke +sv_lan 1
```

### Available CS2 maps

Active duty pool: `de_dust2`, `de_mirage`, `de_inferno`, `de_nuke`, `de_overpass`, `de_anubis`, `de_ancient`

### Running a public server

To run a public server you need to [register a Game Server Login Token (GSL token)](https://steamcommunity.com/dev/managegameservers) and pass it via `+sv_setsteamaccount`:

```shell
docker run -d -p 27015:27015 -p 27015:27015/udp cs2-server \
  +game_type 0 +game_mode 1 \
  +mapgroup mg_active +map de_dust2 \
  +sv_setsteamaccount YOUR_GSL_TOKEN_HERE \
  -net_port_try 1
```

### Ports

| Port       | Protocol | Description          |
|------------|----------|----------------------|
| 27015      | UDP/TCP  | Game / RCON port     |

### Notes

- CS2 uses a **subtick** system — there is no `-tickrate 128` argument. Subtick is always on.
- Requires at least 60 GB of disk space for the game files.
- The container will automatically update the game on startup; restart to apply game updates.
