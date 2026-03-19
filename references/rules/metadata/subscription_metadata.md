# Rule: Missing Subscription Metadata in App Store Listing
- **Guideline**: 3.1.2 – Business – Payments – Subscriptions
- **Severity**: REJECTION
- **Category**: metadata

## What to Check
Apps offering **auto-renewable subscriptions** must include all of the following in both the app and App Store metadata:

### Required in the App
- Title of auto-renewing subscription
- Length of subscription
- Price of subscription (and price per unit if appropriate)
- Functional link to **Privacy Policy**
- Functional link to **Terms of Use (EULA)**

### Required in App Store Metadata
- **Privacy Policy URL** — Set in the Privacy Policy field in App Store Connect
- **Terms of Use (EULA)** — Either:
  - A functional link in the **App Description**, OR
  - A custom EULA added in the **EULA field** in App Store Connect
  - If using Apple's standard EULA, include a link to it in the description

## How to Detect

### Check in-app subscription screens
```bash
# Find subscription-related UI code
grep -rn "subscribe\|paywall\|purchase\|StoreKit\|RevenueCat\|Superwall" --include="*.swift" .

# Check if terms/privacy links exist in subscription UI
grep -rn "terms\|privacy\|eula\|TermsOfService\|PrivacyPolicy" --include="*.swift" .
```

### Check local metadata (if fastlane or similar)
```bash
# Check if description contains ToS/EULA link
grep -i "terms of use\|terms of service\|terms and conditions\|eula\|end user license" ./fastlane/metadata/*/description.txt ./metadata/*/description.txt 2>/dev/null

# Look for actual URLs in descriptions
grep -oE "https?://[^ ]+" ./fastlane/metadata/*/description.txt ./metadata/*/description.txt 2>/dev/null
```

### In App Store Connect (manual check)
- App Information -> Privacy Policy URL field must not be empty
- App Information -> EULA field should have custom EULA or description should reference Apple's standard EULA

### Check in-app subscription flow
Verify the app's subscription purchase screen includes:
- Subscription title and duration
- Price
- Tappable Privacy Policy link
- Tappable Terms of Use link
- "Restore Purchases" button

## Resolution
1. Add a Terms of Use / EULA link to the app description for **every locale**
2. Add a Privacy Policy URL in App Store Connect -> App Information -> Privacy Policy URL
3. Optionally, add a custom EULA in App Store Connect -> App Information -> EULA
4. Ensure the in-app subscription screen shows all required information with working links

### Description Template
Add this block at the bottom of your app description:
```
Terms of Use: https://yourdomain.com/terms
Privacy Policy: https://yourdomain.com/privacy
```

## Example Rejection
> **Guideline 3.1.2 - Business - Payments - Subscriptions**
>
> Issue Description
>
> The submission did not include all the required information for apps offering auto-renewable subscriptions.
>
> The following information needs to be included in the App Store metadata:
>
> - A functional link to the Terms of Use (EULA). If you are using the standard Apple Terms of Use (EULA), include a link to the Terms of Use in the App Description. If you are using a custom EULA, add it in App Store Connect.
>
> Next Steps
>
> Update the App Store metadata to include the information specified above.
