# Claude Flow Docker

Run [Claude Flow](https://github.com/ruvnet/claude-flow) in Docker to work on your codebase with AI agent orchestration.

## Quick Start

Start an interactive shell with Claude Flow available:

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)
```

Once inside the container:
```bash
# Initialize Claude Flow
claude-flow init

# Run AI swarm on your code
claude-flow swarm "refactor this codebase"

# Start Hive Mind wizard
claude-flow hive-mind wizard

# Use with Claude Code CLI
claude-flow swarm "build API" --claude
```

## Direct Command Execution

You can also run commands directly without entering the shell:

```bash
# Initialize Claude Flow in your project
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  claude-flow init

# Run AI swarm on your codebase
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  claude-flow swarm "refactor this codebase for better performance"
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

### Custom versions

Specify different versions of claude-flow or claude-code:

```bash
# Use specific versions
docker build -t claude-flow \
  --build-arg CLAUDE_FLOW_VERSION=2.0.0-alpha.90 \
  --build-arg CLAUDE_CODE_VERSION=1.0.51 \
  https://github.com/rdmolony/claude-flow-docker.git

# Use latest stable versions
docker build -t claude-flow \
  --build-arg CLAUDE_FLOW_VERSION=latest \
  --build-arg CLAUDE_CODE_VERSION=latest \
  https://github.com/rdmolony/claude-flow-docker.git
```

Default versions: `claude-flow@alpha` and `@anthropic-ai/claude-code@latest`

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