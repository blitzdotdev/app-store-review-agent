# Rule: Competitor Platform Terms in Metadata
- **Guideline**: 2.3.1 – Performance – Accurate Metadata
- **Severity**: REJECTION
- **Category**: metadata

## What to Check
App Store metadata (name, subtitle, description, keywords, promotional text, What's New) must not reference competing platforms or brands.

### Banned Terms
- `Android`, `Google Play`, `Google Play Store`
- `Samsung`, `Galaxy Store`
- `Huawei`, `AppGallery`
- `Amazon Appstore`
- `Windows Store`, `Microsoft Store`
- `APK`, `sideload`

## How to Detect

### In Xcode project files
```bash
# Check Info.plist and project files for competitor terms
grep -ri "android\|google play\|samsung\|huawei\|apk\|amazon appstore\|windows store\|microsoft store" *.xcodeproj/project.pbxproj **/Info.plist
```

### In source code (user-facing strings)
```bash
# Search localizable strings and string catalogs
grep -ri "android\|google play\|samsung\|huawei\|apk\|amazon appstore\|windows store\|microsoft store" --include="*.strings" --include="*.stringsdict" --include="*.xcstrings" .

# Search hardcoded strings in source
grep -rn "android\|google play\|samsung\|huawei\|apk\|sideload" --include="*.swift" --include="*.m" .
```

### In local metadata (if fastlane or similar)
```bash
grep -ri "android\|google play\|samsung\|huawei\|apk\|amazon appstore\|windows store\|microsoft store" ./fastlane/metadata/ ./metadata/ 2>/dev/null
```

### In App Store Connect (manual check)
Verify app name, subtitle, description, keywords, promotional text, and What's New text do not contain competitor platform references.

## Resolution
1. Remove all references to competing platforms from metadata fields
2. Replace with generic terms:
   - "Available on Android" -> "Available on multiple platforms"
   - "Also on Google Play" -> remove entirely
   - "Transfer from Android" -> "Transfer from your previous device"
3. Check App Store Connect metadata manually for any remaining references

## Example Rejection
> **Guideline 2.3.1 - Performance - Accurate Metadata**
>
> We noticed that your app's metadata includes references to other mobile platforms, which is not appropriate for the App Store. Specifically, the following content was found:
> - "Android" mentioned in the app description
>
> **Next Steps**: Remove all references to other mobile platforms from the app's metadata.
