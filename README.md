# Claude Flow Docker

A minimal Docker image for [Claude Flow](https://github.com/ruvnet/claude-flow) - an enterprise-grade AI agent orchestration platform.

## Quick Start

Run Claude Flow directly from this GitHub repository without cloning:

```bash
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)
```

## What's Included

- **claude-flow@alpha** - Latest alpha version of Claude Flow
- **@anthropic-ai/claude-code** - Claude Code CLI integration
- **Runtime dependencies** - git, bash, curl, jq
- **Security** - Runs as non-root user

## Usage Methods

### Method 1: Direct Run (Recommended for Testing)

Build and run in a single command:

```bash
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)
```

**Pros:**
- Single command execution
- No image cleanup needed
- Always uses latest version
- Clean output (build logs suppressed)

### Method 2: Traditional Build & Run

Build with a tag for reuse:

```bash
# Build once
docker build -t claude-flow https://github.com/rdmolony/claude-flow-docker.git

# Run multiple times
docker run --rm claude-flow
docker run --rm claude-flow init
docker run --rm claude-flow hive-mind wizard
```

**Pros:**
- Reusable image
- Faster subsequent runs
- Good for production use

### Method 3: Curl & Pipe

Download Dockerfile and build:

```bash
curl -sL https://raw.githubusercontent.com/rdmolony/claude-flow-docker/main/Dockerfile | \
  docker build -t claude-flow - && \
  docker run --rm claude-flow
```

**Pros:**
- Can modify Dockerfile before building
- Useful for customization

## Running Claude Flow Commands

Pass commands directly to the container:

```bash
# Show help
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)

# Initialize Claude Flow
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) init

# Start Hive Mind wizard
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) hive-mind wizard

# Run swarm intelligence
docker run --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) swarm "build REST API"
```

## Interactive Mode

For interactive commands, add `-it`:

```bash
docker run -it --rm $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) hive-mind wizard
```

## Persistent Data

To persist Claude Flow data between runs:

```bash
# Create a volume
docker volume create claude-flow-data

# Run with mounted volume
docker run --rm \
  -v claude-flow-data:/home/claude/.claude-flow \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  init
```

## Building Locally

If you've cloned this repository:

```bash
# Build
docker build -t claude-flow .

# Run
docker run --rm claude-flow
```

## Environment Variables

Pass environment variables with `-e`:

```bash
docker run --rm \
  -e ANTHROPIC_API_KEY=your-key-here \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git) \
  swarm "analyze codebase"
```

## Dockerfile Details

The image:
- Uses `node:20-alpine` for minimal size
- Installs packages globally via npm
- Runs as non-root user (uid 1001)
- Exposes port 3000 for MCP server
- Sets up health checks

## Troubleshooting

### Permission Errors

The "permission denied" error for `/app/.claude-flow` is expected and doesn't affect functionality. The app falls back to user directory.

### Network Issues

If you need network access from the container:

```bash
docker run --rm --network host \
  $(docker build -q https://github.com/rdmolony/claude-flow-docker.git)
```

## License

This Docker configuration is provided as-is. Claude Flow is created by [rUv](https://github.com/ruvnet).

## Links

- [Claude Flow GitHub](https://github.com/ruvnet/claude-flow)
- [Claude Flow Documentation](https://github.com/ruvnet/claude-flow/tree/main/docs)
- [Discord Community](https://discord.agentics.org)