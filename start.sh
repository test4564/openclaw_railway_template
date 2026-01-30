#!/bin/bash
set -e

# Create config directory if needed
mkdir -p ~/.openclaw

# Copy template config on first run
if [ ! -f ~/.openclaw/openclaw.json ]; then
  echo "First run: creating default configuration..."
  cp ~/openclaw.config.json ~/.openclaw/openclaw.json
fi

# Auto-generate gateway token if not provided
if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
  export OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
  echo "Generated OPENCLAW_GATEWAY_TOKEN: $OPENCLAW_GATEWAY_TOKEN"
  echo "(Save this token for remote gateway access)"
fi

# Start gateway on Railway's PORT
echo "Starting OpenClaw gateway on port ${PORT:-18789}..."
exec openclaw gateway --port ${PORT:-18789}
