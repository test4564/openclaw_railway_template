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

### 1. Get Your API Key

You'll need an Anthropic API key:
- Go to https://console.anthropic.com/settings/keys
- Create a new API key
- Copy it for the deployment

### 2. Deploy to Railway

Click the "Deploy on Railway" button above, then:
1. Set `ANTHROPIC_API_KEY` to your Anthropic API key
2. (Optional) Set `TELEGRAM_BOT_TOKEN` to connect Telegram immediately
3. Click "Deploy"

### 3. Add Telegram Bot (Recommended)

1. Open Telegram and message [@BotFather](https://t.me/BotFather)
2. Send `/newbot` and follow the prompts
3. Copy the bot token
4. Add it to `TELEGRAM_BOT_TOKEN` in Railway variables
5. Redeploy

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ANTHROPIC_API_KEY` | **Yes** | Your Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | Recommended | Telegram bot token from @BotFather |
| `DISCORD_BOT_TOKEN` | Optional | Discord bot token |
| `SLACK_BOT_TOKEN` | Optional | Slack bot token |
| `SLACK_APP_TOKEN` | Optional | Slack app token (for Socket Mode) |
| `OPENAI_API_KEY` | Optional | Alternative to Anthropic |
| `OPENCLAW_GATEWAY_TOKEN` | Auto-generated | For remote gateway access |

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

## Persistent Storage

This template uses a Railway volume mounted at `/home/node/.openclaw` to persist:
- Configuration files
- Conversation history
- Session data
- Credentials

Data survives redeploys and restarts.

## Verifying Deployment

Check the Railway logs for:
```
Starting OpenClaw gateway on port ...
```

You can also run in Railway's terminal:
```bash
openclaw health
```

## Troubleshooting

### Bot not responding

1. Check Railway logs for errors
2. Verify `ANTHROPIC_API_KEY` is set correctly
3. For Telegram, ensure the bot token is valid

### Gateway token

If you need the auto-generated gateway token, check the deployment logs on first run.

## Links

- [OpenClaw Documentation](https://github.com/anthropics/openclaw)
- [Railway Documentation](https://docs.railway.app/)
- [Anthropic Console](https://console.anthropic.com/)

## License

MIT
