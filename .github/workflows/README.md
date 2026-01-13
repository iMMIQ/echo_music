# GitHub Actions Workflows

This repository uses GitHub Actions for continuous integration and deployment.

## Workflows

### 1. CI Workflow (`.github/workflows/ci.yml`)

**Triggers:**
- Push to `master` or `main` branch
- Pull requests to `master` or `main` branch

**Jobs:**
- **Analyze**: Runs `flutter analyze` to check code quality
- **Test**: Runs tests with coverage reporting
- **Build Android**: Builds debug APK to verify the build works

**Artifacts:**
- Debug APK (available for 7 days)

### 2. Release Workflow (`.github/workflows/release.yml`)

**Triggers:**
- Push of a version tag (e.g., `v1.0.0`)

**Jobs:**
- **Build Android Release**: Creates release APK and AAB files

**Artifacts:**
- Release APK (named `echo-music-{version}.apk`)
- Release AAB (named `echo-music-{version}.aab`)
- GitHub Release with attached files

**How to trigger:**
```bash
git tag v1.0.0
git push origin v1.0.0
```

### 3. Code Quality Workflow (`.github/workflows/code-quality.yml`)

**Triggers:**
- Manual trigger (via GitHub UI)
- Every Monday at 00:00 UTC

**Jobs:**
- **Format Check**: Ensures code is properly formatted
- **Lint**: Runs `flutter analyze` and posts results to PR comments

## Badges

Add these to your README.md:

```markdown
![CI](https://github.com/iMMIQ/echo_music/workflows/CI/badge.svg)
![Code Quality](https://github.com/iMMIQ/echo_music/workflows/Code%20Quality/badge.svg)
```

## Local Development

Before pushing, run these commands locally:

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build app bundle (for Play Store)
flutter build appbundle --release
```

## Secrets

No secrets are required for basic CI/CD. For future enhancements (like Play Store deployment), you may need:

- `ANDROID_KEYSTORE_BASE64` - Base64 encoded keystore file
- `ANDROID_KEYSTORE_PASSWORD` - Keystore password
- `ANDROID_KEY_ALIAS` - Key alias
- `ANDROID_KEY_PASSWORD` - Key password
