# Minimal Claude Flow Docker Image
# Installs claude-flow and @anthropic-ai/claude-code from npm

FROM node:20-alpine

# Build arguments for package versions
ARG CLAUDE_FLOW_VERSION=alpha
ARG CLAUDE_CODE_VERSION=latest

# Install runtime dependencies
RUN apk add --no-cache \
    git \
    bash \
    curl \
    jq

# Create non-root user
RUN addgroup -g 1001 -S claude && \
    adduser -S claude -u 1001

# Set working directory
WORKDIR /app

# Install claude-flow and claude-code globally as root
RUN npm install -g claude-flow@${CLAUDE_FLOW_VERSION} @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

# Create directories for user
RUN mkdir -p /home/claude/.claude-flow && \
    chown -R claude:claude /home/claude

# Note: Running as root to avoid permission issues with mounted volumes
# The container is still isolated from the host system
# USER claude

# Set environment variables
ENV NODE_ENV=production \
    CLAUDE_FLOW_HOME=/home/claude/.claude-flow \
    PATH="/app/bin:${PATH}"

# Expose port for MCP server
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD claude-flow --version || exit 1

# Default to bash shell for interactive use
# Can be overridden by passing commands directly
CMD ["/bin/bash"]