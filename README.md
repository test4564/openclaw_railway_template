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

### 3. Add Storage (Optional but Recommended)

Without a volume, conversation history is lost on redeploy.

1. Service → **Settings** → **Volumes** → **Add Volume**
2. Mount path: `/home/node/.openclaw`
3. Add variable: `RAILWAY_RUN_UID=0`
4. Redeploy

### 4. Chat

Message your bot on Telegram!

## Shell Access

To run commands inside your container:

```bash
railway link    # connect to your project (run from any directory)
railway ssh     # shell into the running container
```

Then you can run:
```bash
openclaw health
openclaw channels list
```

Note: You don't need this repository locally - `railway link` works from any directory.

## Local Development

Clone this repo if you want to modify the template:

```bash
git clone https://github.com/BasedLukas/openclaw_railway_template.git
cd openclaw_railway_template
cp .env.example .env  # add your credentials
railway link
railway up
```

## All Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ANTHROPIC_API_KEY` | Yes | Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | For Telegram | Bot token from @BotFather |
| `TELEGRAM_ALLOWED_USERS` | For Telegram | Your user ID (prevents others from using your bot) |
| `RAILWAY_RUN_UID` | For volumes | Set to `0` |
| `OPENAI_API_KEY` | Optional | Alternative to Anthropic |

## Links

- [OpenClaw Docs](https://docs.openclaw.ai)
- [Railway Docs](https://docs.railway.app/)
