# librechat-local

## Setup

```bash
# edit UID and GID in .env to match root and docker, enable/disable registration
cp .env.example .env
# edit providers, models, MCP servers, auth tokens, etc. in librechat.yml
cp librechat.yml.example librechat.yml
# build custom API image
docker compose build api
# manually pull any MCP server images before starting the stack
docker pull mcp/aws-documentation
docker pull ...  # etc.
# first execution will pull service images
docker compose up -d
```

## Scripts

MCP server docker containers are often not cleaned up properly after LibreChat
is stopped. To avoid these dangling containers, use the provided scripts to
start, stop, and restart the stack.

| File | Purpose |
|------|---------|
| `bin/kill-mcp` | Kills and removes any dangling MCP containers |
| `bin/restart` | Restarts services after running `kill-mcp` |
| `bin/start` | Starts services after running `kill-mcp` |
| `bin/stop` | Stops services after running `kill-mcp` |
