FROM node:22-bookworm-slim

# Install git (required for some npm dependencies)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally via npm
RUN npm install -g openclaw@latest

# Create non-root user directory structure
RUN mkdir -p /home/node/.openclaw && chown -R node:node /home/node

# Switch to non-root user for security
USER node
WORKDIR /home/node

# Copy startup script
COPY --chown=node:node start.sh /home/node/
RUN chmod +x /home/node/start.sh

CMD ["/home/node/start.sh"]
