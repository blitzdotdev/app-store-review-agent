# Reviewer

AI agent that role-plays as an Apple App Store Reviewer. Catches rejections before Apple does.

## What It Does

Tell your AI coding agent to **"review my app"** and Reviewer will inspect your Xcode project the same way an Apple reviewer would — checking source code, entitlements, privacy manifests, metadata, and configuration against 100+ App Store Review Guidelines.

It finds the violations, cites the exact guideline, points to the offending file, and tells you how to fix it. Then it offers to fix what it can automatically.

No external CLI tools required. Works with any AI coding agent that supports skills (Claude Code, Codex, OpenCode, etc.).

## Install

### Claude Code

```bash
cd your-xcode-project
git submodule add https://github.com/blitzdotdev/app-store-review-agent.git .claude/skills/reviewer
```

Claude Code automatically picks up `SKILL.md` files inside `.claude/skills/`.

### Codex / OpenCode / Other Agents

Clone or submodule into your project root:

```bash
git submodule add https://github.com/blitzdotdev/app-store-review-agent.git reviewer
```

Then point your agent at the `SKILL.md`:

```
@reviewer/SKILL.md review my app
```

Or copy the `SKILL.md` contents into your agent's system prompt / instructions file.

### Manual (any agent)

Just paste this into your conversation:

```
Read the file reviewer/SKILL.md and follow its instructions to review my app.
```

## Quick Start

From your Xcode project directory:

```
review my app
```

That's it. Reviewer figures out what kind of app you have, loads the relevant guidelines, and does a full review.

## What It Checks

### Metadata (`references/rules/metadata/`)

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [competitor_terms](./references/rules/metadata/competitor_terms.md) | 2.3.1 | Android, Google Play, and other competitor brands |
| [apple_trademark](./references/rules/metadata/apple_trademark.md) | 5.2.5 | Apple device images in icon, Apple trademark misuse |
| [china_storefront](./references/rules/metadata/china_storefront.md) | 5 | OpenAI/ChatGPT/Gemini references (China) |
| [accurate_metadata](./references/rules/metadata/accurate_metadata.md) | 2.3.4 | Device frames in app preview videos |
| [subscription_metadata](./references/rules/metadata/subscription_metadata.md) | 3.1.2 | Missing ToS/EULA and Privacy Policy links |

### Subscriptions (`references/rules/subscription/`)

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [missing_tos_pp](./references/rules/subscription/missing_tos_pp.md) | 3.1.2 | No Terms or Privacy Policy in app/metadata |
| [misleading_pricing](./references/rules/subscription/misleading_pricing.md) | 3.1.2 | Monthly price more prominent than billed amount |

### Privacy (`references/rules/privacy/`)

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [unnecessary_data](./references/rules/privacy/unnecessary_data.md) | 5.1.1 | Requiring irrelevant personal data |
| [privacy_manifest](./references/rules/privacy/privacy_manifest.md) | 5.1.1 | Missing `PrivacyInfo.xcprivacy` |

### Design (`references/rules/design/`)

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [sign_in_with_apple](./references/rules/design/sign_in_with_apple.md) | 4.0 | Asking name/email after SIWA |
| [minimum_functionality](./references/rules/design/minimum_functionality.md) | 4.2 | WebView wrappers, apps with < 3 screens, no unique value |

### Entitlements (`references/rules/entitlements/`)

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [unused_entitlements](./references/rules/entitlements/unused_entitlements.md) | 2.4.5(i) | Unused entitlements in Xcode project |

## Guideline Reference

The `references/guidelines/` directory contains a complete index of all 100+ Apple Review Guidelines and 10 app-type specific checklists:

| Checklist | App Type |
|-----------|----------|
| [all_apps.md](./references/guidelines/by-app-type/all_apps.md) | Universal (every submission) |
| [subscription_iap.md](./references/guidelines/by-app-type/subscription_iap.md) | Subscriptions / In-App Purchases |
| [social_ugc.md](./references/guidelines/by-app-type/social_ugc.md) | Social / User-Generated Content |
| [kids.md](./references/guidelines/by-app-type/kids.md) | Kids Category |
| [health_fitness.md](./references/guidelines/by-app-type/health_fitness.md) | Health, Fitness & Medical |
| [games.md](./references/guidelines/by-app-type/games.md) | Games |
| [macos.md](./references/guidelines/by-app-type/macos.md) | macOS / Mac App Store |
| [ai_apps.md](./references/guidelines/by-app-type/ai_apps.md) | AI / Generative AI |
| [crypto_finance.md](./references/guidelines/by-app-type/crypto_finance.md) | Crypto, Finance & Trading |
| [vpn.md](./references/guidelines/by-app-type/vpn.md) | VPN & Networking |

Full reference: [references/guidelines/README.md](./references/guidelines/README.md)

## Adding New Rules

Create a `.md` file in the appropriate `references/rules/` subdirectory:

```markdown
# Rule: [Short Title]
- **Guideline**: [Apple Guideline Number]
- **Severity**: REJECTION | WARNING
- **Category**: metadata | subscription | privacy | design | entitlements

## What to Check
## How to Detect
## Resolution
## Example Rejection
```

## License

MIT — Based on [app-store-preflight-skills](https://github.com/truongduy2611/app-store-preflight-skills) by truongduy2611.
