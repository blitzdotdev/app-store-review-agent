# Reviewer

AI agent that role-plays as an Apple App Store Reviewer. Catches rejections before Apple does.

## What It Does

Say **"review my app"** and Reviewer spawns as an agent that inspects your Xcode project the same way an Apple reviewer would — checking source code, entitlements, privacy manifests, metadata, and configuration against 100+ App Store Review Guidelines.

It finds the violations, cites the exact guideline, points to the offending file, and tells you how to fix it. Then it offers to fix what it can automatically.

No external CLI tools required.

## Install

### Claude Code (recommended)

Clone into your project's `.claude/` directory:

```bash
cd your-xcode-project
git submodule add https://github.com/blitzdotdev/app-store-review-agent.git .claude/app-store-review-agent
```

This gives Claude Code the `agents/reviewer.md` agent definition and all reference materials. The agent is immediately available.

Then just say:

```
review my app
```

Claude Code will spawn the Reviewer agent automatically.

### Codex / OpenCode / Other Agents

Clone or submodule into your project root:

```bash
git submodule add https://github.com/blitzdotdev/app-store-review-agent.git reviewer
```

Then point your agent at the `SKILL.md` (included for compatibility):

```
@reviewer/SKILL.md review my app
```

Or copy the `SKILL.md` contents into your agent's system prompt / instructions file.

### Manual (any agent)

Just paste this into your conversation:

```
Read the file reviewer/SKILL.md and follow its instructions to review my app.
```

## Repo Structure

```
app-store-review-agent/
├── .claude-plugin/
│   └── plugin.json              # Claude Code plugin metadata
├── agents/
│   └── reviewer.md              # Claude Code agent definition (spawns as subagent)
├── references/
│   ├── guidelines/
│   │   ├── README.md            # Complete index of 100+ Apple guidelines
│   │   └── by-app-type/        # 10 app-type specific checklists
│   └── rules/
│       ├── metadata/            # Competitor terms, trademarks, China, etc.
│       ├── subscription/        # ToS/PP, misleading pricing
│       ├── privacy/             # Privacy manifest, unnecessary data
│       ├── design/              # SIWA, minimum functionality
│       └── entitlements/        # Unused entitlements
├── SKILL.md                     # Generic skill file (Codex, OpenCode compat)
├── README.md
└── LICENSE
```

## What It Checks

### Metadata

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [competitor_terms](./references/rules/metadata/competitor_terms.md) | 2.3.1 | Android, Google Play, and other competitor brands |
| [apple_trademark](./references/rules/metadata/apple_trademark.md) | 5.2.5 | Apple device images in icon, Apple trademark misuse |
| [china_storefront](./references/rules/metadata/china_storefront.md) | 5 | OpenAI/ChatGPT/Gemini references (China) |
| [accurate_metadata](./references/rules/metadata/accurate_metadata.md) | 2.3.4 | Device frames in app preview videos |
| [subscription_metadata](./references/rules/metadata/subscription_metadata.md) | 3.1.2 | Missing ToS/EULA and Privacy Policy links |

### Subscriptions

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [missing_tos_pp](./references/rules/subscription/missing_tos_pp.md) | 3.1.2 | No Terms or Privacy Policy in app/metadata |
| [misleading_pricing](./references/rules/subscription/misleading_pricing.md) | 3.1.2 | Monthly price more prominent than billed amount |

### Privacy

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [unnecessary_data](./references/rules/privacy/unnecessary_data.md) | 5.1.1 | Requiring irrelevant personal data |
| [privacy_manifest](./references/rules/privacy/privacy_manifest.md) | 5.1.1 | Missing `PrivacyInfo.xcprivacy` |

### Design

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [sign_in_with_apple](./references/rules/design/sign_in_with_apple.md) | 4.0 | Asking name/email after SIWA |
| [minimum_functionality](./references/rules/design/minimum_functionality.md) | 4.2 | WebView wrappers, apps with < 3 screens, no unique value |

### Entitlements

| Rule | Guideline | What It Catches |
|------|-----------|----------------|
| [unused_entitlements](./references/rules/entitlements/unused_entitlements.md) | 2.4.5(i) | Unused entitlements in Xcode project |

## Guideline Reference

Complete index of all 100+ Apple Review Guidelines and 10 app-type specific checklists in [`references/guidelines/`](./references/guidelines/).

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
