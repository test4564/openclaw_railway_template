FROM node:22-bookworm-slim

# Install OpenClaw globally via npm (recommended approach)
RUN npm install -g openclaw@latest

# Create non-root user directory structure
RUN mkdir -p /home/node/.openclaw && chown -R node:node /home/node

# Switch to non-root user for security
USER node
WORKDIR /home/node

# Copy config template and startup script
COPY --chown=node:node openclaw.config.json /home/node/
COPY --chown=node:node start.sh /home/node/

# Make startup script executable
RUN chmod +x /home/node/start.sh

CMD ["/home/node/start.sh"]
