#!/bin/bash
set -e

# Create config directory if needed
mkdir -p ~/.openclaw

# Always copy fresh config (overwrites old format if volume has stale config)
echo "Copying configuration template..."
cp ~/openclaw.config.json ~/.openclaw/openclaw.json

# Auto-generate gateway token if not provided
if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
  export OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
  echo "Generated OPENCLAW_GATEWAY_TOKEN: $OPENCLAW_GATEWAY_TOKEN"
  echo "(Save this token for remote gateway access)"
fi

# Run doctor to fix any config issues
echo "Running openclaw doctor --fix..."
openclaw doctor --fix || true

# Start gateway on Railway's PORT
echo "Starting OpenClaw gateway on port ${PORT:-18789}..."
exec openclaw gateway --port ${PORT:-18789}
