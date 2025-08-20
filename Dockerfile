# Minimal Claude Flow Docker Image
# Installs claude-flow and @anthropic-ai/claude-code from npm

FROM node:20-alpine

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
RUN npm install -g claude-flow@alpha @anthropic-ai/claude-code

# Create directories for user
RUN mkdir -p /home/claude/.claude-flow && \
    chown -R claude:claude /home/claude

# Switch to non-root user
USER claude

# Set environment variables
ENV NODE_ENV=production \
    CLAUDE_FLOW_HOME=/home/claude/.claude-flow \
    PATH="/app/bin:${PATH}"

# Expose port for MCP server
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD claude-flow --version || exit 1

# Default command
ENTRYPOINT ["claude-flow"]
CMD ["--help"]