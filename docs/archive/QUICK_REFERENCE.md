# Peace AI - Quick Reference

A quick reference guide for developers working with Peace AI.

## Project Structure

```
Peace-AI/
├── lib/                          # Main source code
│   ├── main.dart                # App entry point
│   ├── models/                  # Data models
│   ├── screens/                 # UI screens
│   ├── services/                # Business logic
│   └── widgets/                 # Reusable components
├── test/                        # Tests
├── android/                     # Android configuration
├── ios/                         # iOS configuration
├── web/                         # Web configuration
└── assets/                      # Images, data files
```

## Quick Commands

### Development

```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# Run with hot reload enabled (default)
flutter run --hot

# List all devices
flutter devices
```

### Building

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

### Testing & Quality

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze

# Format code
dart format .

# Check formatting
dart format --output=none --set-exit-if-changed .
```

### Maintenance

```bash
# Clean build artifacts
flutter clean

# Update dependencies
flutter pub upgrade

# Check Flutter installation
flutter doctor

# Verbose doctor output
flutter doctor -v

# Check for outdated packages
flutter pub outdated
```

## Code Organization

### Models (`lib/models/`)

Define data structures:
```dart
class Message {
  final String id;
  final String text;
  final bool isUser;
  // ...
}
```

### Services (`lib/services/`)

Business logic and data management:
```dart
class AIResponseService {
  Future<Message> generateResponse(String query) {
    // AI logic here
  }
}
```

### Screens (`lib/screens/`)

Full-page views:
```dart
class ChatScreen extends StatefulWidget {
  // Screen implementation
}
```

### Widgets (`lib/widgets/`)

Reusable UI components:
```dart
class MessageBubble extends StatelessWidget {
  // Widget implementation
}
```

## Common Tasks

### Adding a New Screen

1. Create file in `lib/screens/`
2. Define the widget
3. Add route in `main.dart`
4. Navigate using `Navigator.pushNamed()`

### Adding a New Service

1. Create file in `lib/services/`
2. Define the service class
3. Import and use in screens/widgets

### Adding a New Model

1. Create file in `lib/models/`
2. Define the class with fields
3. Add `toJson()` and `fromJson()` methods

### Adding Assets

1. Place files in `assets/` directory
2. Update `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/logo.png
    - assets/data/quran.json
```
3. Load in code:
```dart
Image.asset('assets/images/logo.png')
```

### Adding Dependencies

1. Edit `pubspec.yaml`:
```yaml
dependencies:
  package_name: ^version
```
2. Run `flutter pub get`
3. Import in code:
```dart
import 'package:package_name/package_name.dart';
```

## Debugging

### Debug Mode

```bash
# Run in debug mode (default)
flutter run

# Run in profile mode
flutter run --profile

# Run in release mode
flutter run --release
```

### Debug Shortcuts

While app is running, press:
- `r` - Hot reload
- `R` - Hot restart
- `p` - Toggle performance overlay
- `o` - Toggle platform (Android/iOS)
- `q` - Quit

### Common Debug Tools

```dart
// Print to console
print('Debug message');

// Debug print (only in debug mode)
debugPrint('Debug message');

// Assert
assert(condition, 'Error message');
```

## State Management

### StatefulWidget Pattern (Current)

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String _data = '';

  void _updateData(String newData) {
    setState(() {
      _data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_data);
  }
}
```

## Routing

### Named Routes (Current)

```dart
// Define in main.dart
routes: {
  '/': (context) => SplashScreen(),
  '/chat': (context) => ChatScreen(),
}

// Navigate
Navigator.pushNamed(context, '/chat');

// Navigate with replacement
Navigator.pushReplacementNamed(context, '/chat');

// Go back
Navigator.pop(context);
```

## Theming

### Current Theme Setup

```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF1B5E20),
  ),
  useMaterial3: true,
)
```

### Using Theme

```dart
// Get theme
Theme.of(context).colorScheme.primary

// Get text theme
Theme.of(context).textTheme.titleLarge
```

## Platform-Specific Code

### Check Platform

```dart
import 'dart:io' show Platform;

if (Platform.isAndroid) {
  // Android-specific
} else if (Platform.isIOS) {
  // iOS-specific
}
```

### Web Detection

```dart
import 'package:flutter/foundation.dart';

if (kIsWeb) {
  // Web-specific
}
```

## Performance Tips

1. **Use const constructors** when possible
2. **Avoid rebuilding widgets** unnecessarily
3. **Use ListView.builder** for long lists
4. **Dispose controllers** in dispose()
5. **Use async/await** for long operations

## Testing Patterns

### Unit Test

```dart
test('description', () {
  expect(actual, equals(expected));
});
```

### Widget Test

```dart
testWidgets('description', (WidgetTester tester) async {
  await tester.pumpWidget(MyWidget());
  expect(find.text('Hello'), findsOneWidget);
});
```

## Useful Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Material 3](https://m3.material.io/)
- [Flutter Packages](https://pub.dev/)

## Getting Help

1. Check the [README.md](README.md)
2. Read [SETUP.md](SETUP.md) for setup issues
3. See [ARCHITECTURE.md](ARCHITECTURE.md) for design info
4. Read [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
5. Open an issue on GitHub

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "No devices found" | Start emulator or connect device |
| "Gradle sync failed" | Run `flutter clean && flutter pub get` |
| "Build failed" | Check error message, run `flutter doctor` |
| "Hot reload not working" | Press `R` for hot restart |
| "Package not found" | Run `flutter pub get` |

## Version Control

### Ignore Patterns

See `.gitignore` for files that should not be committed.

### Commit Messages

Follow conventional commits:
- `feat: add new feature`
- `fix: fix bug`
- `docs: update documentation`
- `style: format code`
- `test: add tests`
- `refactor: refactor code`

---

**Last Updated**: 2025-11-17
