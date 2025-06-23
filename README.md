# librechat-local

Customized [LibreChat][] self-hosting stack with support for docker MCP servers

## Prerequisites

This stack assumes you have installed [LM Studio][], loaded a model, and are
running the OpenAI-compatible REST API server.

The model used during most of my experimentation has been
`oh-dcft-v3.1-claude-3-5-sonnet-20241022-GGUF` (specifically, the `Q8_0`
variant). It is not visible in LM Studio's model explorer, but you can visit
[the model webpage][] and select _Use this model_ > _LM Studio_ in the dropdown
in the top right corner of the page to pull and configure a copy of it.

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

Once running, the chat interface will be available at [http://localhost:3080][].

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

## Agents

When using the _Agent Builder_ interface, you are expected to manually provide
several model parameters. Here are the parameters I used with the experiment
model:

| Setting | Value |
|---------|-------|
| Temperature | `0.8` |
| Top P | `0.95` |
| Frequency penalty | `1.1` |
| Presence penalty | `0.05` |
| Reasoning effort | `high` |

These settings were derived from the default model settings shown for this
specific model in LM Studio's interface.

[http://localhost:3080]: http://localhost:3080
[librechat]: https://librechat.ai
[lm studio]: https://lmstudio.ai/
[the model webpage]: https://huggingface.co/mradermacher/oh-dcft-v3.1-claude-3-5-sonnet-20241022-GGUF
