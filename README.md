# OpenClaw Railway Template

One-click deployment for your personal AI assistant. Chat with Claude via Telegram, Discord, Slack, or WhatsApp.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/TEMPLATE_ID)

## Quick Start

### 1. Get Your Credentials

| What | Where |
|------|-------|
| Anthropic API key | https://console.anthropic.com/settings/keys |
| Telegram bot token | Message [@BotFather](https://t.me/BotFather), send `/newbot` |
| Your Telegram user ID | Message [@userinfobot](https://t.me/userinfobot) |

### 2. Deploy

Click the deploy button above and set these variables:

| Variable | Value |
|----------|-------|
| `ANTHROPIC_API_KEY` | Your API key |
| `TELEGRAM_BOT_TOKEN` | Token from @BotFather |
| `TELEGRAM_ALLOWED_USERS` | Your user ID from @userinfobot |

### 3. Add Storage (Recommended)

Without a volume, conversation history is lost on redeploy.

**Via CLI:**
```bash
railway link
railway volume add --mount-path /root/.openclaw
```

**Via UI:**
1. Open your project in Railway dashboard
2. Right-click on the service in the canvas view
3. Select **Attach Volume**
4. Mount path: `/root/.openclaw`

### 4. Chat

Message your bot on Telegram!

## Shell Access

To run commands inside your container:

```bash
railway link
railway ssh
```

Then run:
```bash
openclaw health
openclaw channels list
```

## All Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ANTHROPIC_API_KEY` | Yes | Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | For Telegram | Bot token from @BotFather |
| `TELEGRAM_ALLOWED_USERS` | For Telegram | Your user ID (prevents others from using your bot) |
| `OPENAI_API_KEY` | Optional | Alternative to Anthropic |

## Links

- [OpenClaw Docs](https://docs.openclaw.ai)
- [Railway Docs](https://docs.railway.com)
