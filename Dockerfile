FROM node:22-bookworm-slim

# Install git (required for some npm dependencies)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally via npm
RUN npm install -g openclaw@latest

WORKDIR /root

# Copy startup script
COPY start.sh /root/
RUN chmod +x /root/start.sh

CMD ["/root/start.sh"]
