# OpenClaw Railway Template

One-click deployment for your personal AI assistant. Chat with Claude via Telegram, Discord, Slack, or WhatsApp.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/F-nXuC?referralCode=XFhxHc&utm_medium=integration&utm_source=template&utm_campaign=generic)

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

## Shell Access

To run commands inside your container:

```bash
railway link
railway shell
```

