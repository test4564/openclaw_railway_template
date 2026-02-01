#!/bin/bash
set -e

# Create required directories with proper permissions
mkdir -p ~/.openclaw/workspace
mkdir -p ~/.openclaw/agents/main/sessions
mkdir -p ~/.openclaw/credentials
mkdir -p ~/.openclaw/agents/main/agent
chmod 700 ~/.openclaw

# Auto-generate gateway token if not provided
if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
  export OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
  echo "Generated OPENCLAW_GATEWAY_TOKEN: $OPENCLAW_GATEWAY_TOKEN"
  echo "(Save this token for remote gateway access)"
fi

# Build config dynamically
echo "Building configuration..."

# Start with base config
cat > ~/.openclaw/openclaw.json << 'BASECONFIG'
{
  "agents": {
    "defaults": {
      "workspace": "~/.openclaw/workspace",
      "models": {
        "google/gemini-3-pro-preview": {
          "alias": "gemini"
        },
        "opencode/claude-opus-4-5": {
          "alias": "Opus"
        },
        "opencode/glm-4.7-free": {},
        "opencode/kimi-k2.5-free": {},
        "opencode/minimax-m2.1-free": {},
        "opencode/big-pickle": {},
        "opencode/gpt-5-nano": {}
      },
      "model": {
        "primary": "opencode/glm-4.7-free"
      }
    }
  },
  "gateway": {
    "mode": "local",
    "auth": {
BASECONFIG

echo "      \"token\": \"$OPENCLAW_GATEWAY_TOKEN\"" >> ~/.openclaw/openclaw.json

cat >> ~/.openclaw/openclaw.json << 'MIDCONFIG'
    }
  },
  "auth": {
    "profiles": {
      "google:default": {
        "provider": "google",
        "mode": "api_key"
      },
      "opencode:default": {
        "provider": "opencode",
        "mode": "api_key"
      }
    }
  },
  "plugins": {
    "entries": {
      "telegram": {
        "enabled": true
      }
    }
  },
  "skills": {
    "install": {
      "nodeManager": "bun"
    }
  },
  "hooks": {
    "internal": {
      "enabled": true,
      "entries": {
        "boot-md": {
          "enabled": true
        },
        "command-logger": {
          "enabled": true
        },
        "session-memory": {
          "enabled": true
        }
      }
    }
  },
  "channels": {
MIDCONFIG

# Add Telegram if configured
if [ -n "$TELEGRAM_BOT_TOKEN" ]; then
  if [ -z "$TELEGRAM_ALLOWED_USERS" ]; then
    echo "ERROR: TELEGRAM_BOT_TOKEN is set but TELEGRAM_ALLOWED_USERS is not."
    echo "Anyone could use your bot and drain your API credits!"
    echo "Set TELEGRAM_ALLOWED_USERS to your Telegram user ID (message @userinfobot to get it)."
    exit 1
  fi

  echo "Enabling Telegram for user(s): $TELEGRAM_ALLOWED_USERS"
  cat >> ~/.openclaw/openclaw.json << TELEGRAMCONFIG
    "telegram": {
      "enabled": true,
      "botToken": "$TELEGRAM_BOT_TOKEN",
      "dmPolicy": "pairing",
      "allowFrom": ["tg:$TELEGRAM_ALLOWED_USERS"]
    }
TELEGRAMCONFIG
fi

# Close the config
cat >> ~/.openclaw/openclaw.json << 'ENDCONFIG'
  }
}
ENDCONFIG

chmod 600 ~/.openclaw/openclaw.json

# create ~/.openclaw/agents/main/agent/auth-profiles.json
cat > ~/.openclaw/agents/main/agent/auth-profiles.json << AUTHCONFIG
{
  "version": 1,
  "profiles": {
    "google:default": {
      "type": "api_key",
      "provider": "google",
      "key": "$GOOGLE_API_KEY"
    },
    "opencode:default": {
      "type": "api_key",
      "provider": "opencode",
      "key": "$OPENCODE_API_KEY"
    }
  }
}
AUTHCONFIG

chmod 600 ~/.openclaw/agents/main/agent/auth-profiles.json

# Run doctor to fix any config issues
echo "Running openclaw doctor --fix..."
openclaw doctor --fix || true

# Start gateway on Railway's PORT
echo "Starting OpenClaw gateway on port ${PORT:-18789}..."
exec openclaw gateway --port ${PORT:-18789}
