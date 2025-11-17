# Contributing to Peace AI

Thank you for your interest in contributing to Peace AI! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Your environment details (OS, Flutter version, etc.)

### Suggesting Enhancements

We welcome enhancement suggestions! Please open an issue with:
- A clear description of the enhancement
- Why this enhancement would be useful
- Any implementation ideas you have

### Pull Requests

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature-name`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes with clear commit messages
6. Push to your fork
7. Submit a pull request

## Development Setup

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Git
- Code editor (VS Code, Android Studio, or IntelliJ IDEA recommended)

### Setting Up Your Development Environment

1. Install Flutter by following the official guide: https://flutter.dev/docs/get-started/install

2. Clone your fork:
```bash
git clone https://github.com/YOUR-USERNAME/Peace-AI.git
cd Peace-AI
```

3. Install dependencies:
```bash
flutter pub get
```

4. Verify your setup:
```bash
flutter doctor
```

5. Run the app:
```bash
flutter run
```

## Code Style

- Follow the official Dart style guide
- Use `flutter analyze` to check for issues
- Format code with `dart format .`
- Ensure all tests pass before submitting

## Testing

### Running Tests

```bash
flutter test
```

### Writing Tests

- Write unit tests for new services and models
- Write widget tests for new UI components
- Ensure test coverage for critical functionality

## Islamic Content Guidelines

When adding or modifying Islamic content:

1. **Authenticity**: Only use authentic sources (Quran and authentic Hadith)
2. **References**: Always include proper references (Surah:Verse or Collection:Book:Number)
3. **Accuracy**: Double-check translations and Arabic text
4. **Respect**: Maintain respectful language and proper Islamic terminology

## Commit Message Guidelines

- Use clear, descriptive commit messages
- Start with a verb (Add, Fix, Update, Remove, etc.)
- Keep the first line under 50 characters
- Add detailed description if needed

Examples:
```
Add search functionality for Hadith collections
Fix navigation bug in chat screen
Update Quran verse database with new entries
```

## Code Review Process

1. All pull requests will be reviewed by maintainers
2. Address any feedback or requested changes
3. Once approved, your PR will be merged

## Community

- Be respectful and inclusive
- Help others in discussions
- Share knowledge and learn together

## Questions?

If you have questions, feel free to:
- Open an issue
- Start a discussion
- Reach out to the maintainers

Thank you for contributing to Peace AI!
