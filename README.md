# Claude Flow Docker

Run [Claude Flow](https://github.com/ruvnet/claude-flow) in Docker to work on your codebase with AI agent orchestration.

## Quick Start

Run Claude Flow on your current directory:

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  [command]
```

## Common Usage

### Initialize Claude Flow in your project

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  init
```

### Run AI swarm on your codebase

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  swarm "refactor this codebase for better performance"
```

### Start Hive Mind wizard

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  hive-mind wizard
```

## Persistent Configuration

To keep Claude Flow configuration between runs:

```bash
# Create alias for convenience
alias claude-flow='docker run -it --rm \
  -v $(pwd):/workspace \
  -v $HOME/.claude-flow:/home/claude/.claude-flow \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)'

# Now use like a regular command
claude-flow init
claude-flow swarm "build a REST API"
claude-flow hive-mind status
```

## What's Included

- **claude-flow@alpha** - Latest alpha version
- **@anthropic-ai/claude-code** - Claude Code CLI integration  
- **Runtime tools** - git, bash, curl, jq
- **Security** - Runs as non-root user
- **Your code** - Mounted at `/workspace`

## Alternative Methods

### Build once, run multiple times

For better performance with repeated use:

```bash
# Build image once
docker build -t claude-flow https://github.com/rdmolony/claude-flow-docker.git

# Run multiple times (faster)
docker run -it --rm -v $(pwd):/workspace -w /workspace claude-flow init
docker run -it --rm -v $(pwd):/workspace -w /workspace claude-flow swarm "analyze code"
```

### Without volume mounting

For testing or help commands:

```bash
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) --help
```

## Troubleshooting

The "permission denied" error for `/app/.claude-flow` is expected and doesn't affect functionality.

## Links

- [Claude Flow GitHub](https://github.com/ruvnet/claude-flow)
- [Discord Community](https://discord.agentics.org)