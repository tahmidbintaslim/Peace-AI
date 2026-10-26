# Peace AI - Setup Guide

This guide will help you set up and run Peace AI on your local machine.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Running the Application](#running-the-application)
4. [Platform-Specific Setup](#platform-specific-setup)
5. [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Flutter SDK**: Version 3.0.0 or higher
  - Download from: https://flutter.dev/docs/get-started/install
  - Verify installation: `flutter --version`

- **Dart SDK**: Version 3.0.0 or higher (comes with Flutter)
  - Verify installation: `dart --version`

- **Git**: For cloning the repository
  - Download from: https://git-scm.com/downloads

### Platform-Specific Requirements

#### For Android Development

- Android Studio or Android SDK Command-line Tools
- Android SDK Platform 21 or higher
- Android Virtual Device (AVD) or physical Android device

#### For iOS Development (macOS only)

- Xcode 13 or higher
- CocoaPods
- iOS Simulator or physical iOS device

#### For Web Development

- Chrome browser (for debugging)

#### For Desktop Development

- **Windows**: Visual Studio 2022 or Visual Studio Build Tools
- **macOS**: Xcode
- **Linux**: Additional dependencies as per Flutter documentation

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/tahmidbintaslim/Peace-AI.git
cd Peace-AI
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

This will download all required packages listed in `pubspec.yaml`.

### Step 3: Verify Setup

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation. Address any issues shown.

## Running the Application

### On Mobile (Android/iOS)

1. Connect your device or start an emulator/simulator

2. List available devices:
```bash
flutter devices
```

3. Run the app:
```bash
flutter run
```

Or specify a device:
```bash
flutter run -d <device-id>
```

### On Web

```bash
flutter run -d chrome
```

Or build for production:
```bash
flutter build web --release
```

The built files will be in the `build/web` directory.

### On Desktop

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

#### Linux
```bash
flutter run -d linux
```

## Platform-Specific Setup

### Android Setup

1. **Enable Developer Options** on your Android device:
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings > Developer Options
   - Enable "USB Debugging"

2. **Connect your device** via USB

3. **Accept USB debugging** prompt on your device

4. **Run the app**:
```bash
flutter run
```

### iOS Setup (macOS only)

1. **Open iOS Simulator**:
```bash
open -a Simulator
```

2. **Install CocoaPods dependencies**:
```bash
cd ios
pod install
cd ..
```

3. **Run the app**:
```bash
flutter run
```

For physical iOS devices, you'll need:
- Apple Developer account
- Xcode signing configuration

### Web Setup

No additional setup required beyond Flutter installation.

To run on a specific port:
```bash
flutter run -d chrome --web-port=8080
```

### Desktop Setup

#### Windows

1. Enable desktop support:
```bash
flutter config --enable-windows-desktop
```

2. Build and run:
```bash
flutter run -d windows
```

#### macOS

1. Enable desktop support:
```bash
flutter config --enable-macos-desktop
```

2. Build and run:
```bash
flutter run -d macos
```

#### Linux

1. Install dependencies:
```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

2. Enable desktop support:
```bash
flutter config --enable-linux-desktop
```

3. Build and run:
```bash
flutter run -d linux
```

## Building for Production

### Android APK

```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

Then open in Xcode to archive and submit.

### Web

```bash
flutter build web --release
```

Deploy the `build/web` directory to your web server.

### Desktop

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## Development Tips

### Hot Reload

While the app is running, press:
- `r` - Hot reload
- `R` - Hot restart
- `p` - Show performance overlay
- `q` - Quit

### Debugging

1. **Enable verbose logging**:
```bash
flutter run -v
```

2. **Check for issues**:
```bash
flutter analyze
```

3. **Format code**:
```bash
dart format .
```

4. **Run tests**:
```bash
flutter test
```

## Troubleshooting

### Common Issues

#### "Flutter command not found"

**Solution**: Ensure Flutter is in your PATH:
```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export PATH="$PATH:/path/to/flutter/bin"
```

#### "Android licenses not accepted"

**Solution**:
```bash
flutter doctor --android-licenses
```

#### "CocoaPods not installed" (iOS/macOS)

**Solution**:
```bash
sudo gem install cocoapods
```

#### Build fails with "Gradle error"

**Solution**:
1. Clean the project:
```bash
flutter clean
flutter pub get
```

2. Rebuild:
```bash
flutter run
```

#### "No devices found"

**Solution**:
- For mobile: Ensure USB debugging is enabled and device is connected
- For emulator: Start your emulator first
- For web: Install Chrome browser

### Getting Help

If you encounter issues:

1. Check the [Flutter documentation](https://flutter.dev/docs)
2. Search [Flutter issues on GitHub](https://github.com/flutter/flutter/issues)
3. Open an issue in this repository with:
   - Error message
   - Output of `flutter doctor -v`
   - Steps to reproduce

## Next Steps

Once you have the app running:

1. Explore the codebase
2. Try asking the AI questions
3. Read the [README.md](README.md) for more information
4. Check [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

---

**Need help?** Open an issue on GitHub!
