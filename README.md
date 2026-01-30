# OpenClaw Railway Template

Deploy your own personal AI assistant gateway on Railway. Connect to Telegram, Discord, Slack, WhatsApp, and more.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/TEMPLATE_ID)

## Features

- Multi-platform messaging (Telegram, Discord, Slack, WhatsApp, Signal)
- Powered by Claude (Anthropic) or GPT-4 (OpenAI)
- Voice support on compatible platforms
- Persistent conversation history
- Tool use and web browsing capabilities

## Quick Start

### 1. Get Your Credentials

**Required:**
- Anthropic API key from https://console.anthropic.com/settings/keys

**For Telegram:**
- Message [@BotFather](https://t.me/BotFather) on Telegram, send `/newbot`, copy the token
- Message [@userinfobot](https://t.me/userinfobot) to get your Telegram user ID

### 2. Deploy to Railway

Click the "Deploy on Railway" button above, then set these variables:

| Variable | Value |
|----------|-------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | Bot token from @BotFather |
| `TELEGRAM_ALLOWED_USERS` | Your Telegram user ID (from @userinfobot) |

### 3. Add Persistent Storage (Important!)

Volumes can't be auto-configured, so after deploying:

1. Go to your service → **Settings** → **Volumes**
2. Click **Add Volume**
3. Set mount path: `/home/node/.openclaw`
4. Add environment variable: `RAILWAY_RUN_UID=0`
5. Redeploy

Without this, conversation history and settings are lost on each redeploy.

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ANTHROPIC_API_KEY` | **Yes** | Your Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | For Telegram | Bot token from @BotFather |
| `TELEGRAM_ALLOWED_USERS` | For Telegram | Your Telegram user ID (security: restricts who can use the bot) |
| `RAILWAY_RUN_UID` | For volumes | Set to `0` if using a volume |
| `DISCORD_BOT_TOKEN` | Optional | Discord bot token |
| `SLACK_BOT_TOKEN` | Optional | Slack bot token |
| `SLACK_APP_TOKEN` | Optional | Slack app token (for Socket Mode) |
| `OPENAI_API_KEY` | Optional | Alternative to Anthropic |
| `OPENCLAW_GATEWAY_TOKEN` | Auto-generated | For remote gateway access |

## Security

The `TELEGRAM_ALLOWED_USERS` variable is **required** when using Telegram. Without it, anyone who finds your bot could use it and drain your API credits.

To allow multiple users, the format is comma-separated IDs (feature coming soon).

## Adding More Channels

After deployment, you can add more channels via Railway's terminal:

```bash
# Discord
openclaw channels add --channel discord --token "your-token"

# Slack
openclaw channels add --channel slack --bot-token "xoxb-..." --app-token "xapp-..."

# WhatsApp (requires QR scan)
openclaw channels login
```

## Verifying Deployment

Check the Railway logs for:
```
Building configuration...
Enabling Telegram for user(s): <your-user-id>
Starting OpenClaw gateway on port 8080...
```

## Troubleshooting

### Bot not responding

1. Check Railway logs for errors
2. Verify `ANTHROPIC_API_KEY` is set correctly
3. For Telegram, ensure both `TELEGRAM_BOT_TOKEN` and `TELEGRAM_ALLOWED_USERS` are set

### "TELEGRAM_ALLOWED_USERS is not set" error

You must set your Telegram user ID. Message @userinfobot on Telegram to get it.

### Permission errors with volume

Add `RAILWAY_RUN_UID=0` to your environment variables.

### Gateway token

The gateway token is auto-generated on first run. Check the deployment logs to find it.

## Links

- [OpenClaw Documentation](https://docs.openclaw.ai)
- [Railway Documentation](https://docs.railway.app/)
- [Anthropic Console](https://console.anthropic.com/)

## License

MIT
