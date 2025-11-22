# Peace AI

An open-source AI application with Al Quran and Hadith knowledge, built with Flutter.

## Overview

Peace AI is an Islamic knowledge assistant designed to help users learn about Islam through the Quran and Hadith. The application provides intelligent responses to user queries by referencing authentic Islamic sources.

## Features

- 🌙 **Expanded Islamic Knowledge Base**: 50+ Quranic verses from 25+ Surahs and 20+ authentic Hadiths
- 💬 **Interactive Chat Interface**: User-friendly chat interface for asking questions
- 📱 **Cross-Platform**: Built with Flutter for iOS, Android, Web, and Desktop support
- 🎨 **Modern UI**: Material Design 3 with light and dark theme support
- 🔍 **Smart Search**: Intelligent search through expanded Quran and Hadith collections
- 📖 **Source References**: Every response includes references to Quran and Hadith sources
- 🌐 **Multilingual Support**: Arabic text with English translations
- ⚡ **Quick Actions**: Instant access to common topics like Prayer, Mercy, Knowledge, and more
- 🔖 **Bookmarks**: Save your favorite responses for later reference
- 📤 **Share**: Easily copy and share responses with proper attribution
- ⚙️ **Settings**: Customize app preferences and view content statistics
- 📊 **Statistics**: View comprehensive database information and collections

## Technology Stack

- **Framework**: Flutter (Dart)
- **Architecture**: Clean architecture with separation of concerns
- **State Management**: StatefulWidget with local state
- **UI**: Material Design 3

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── message.dart         # Chat message model
│   └── islamic_content.dart # Quran and Hadith models
├── screens/                  # UI screens
│   ├── splash_screen.dart   # Welcome splash screen
│   └── chat_screen.dart     # Main chat interface
├── services/                 # Business logic
│   ├── islamic_knowledge_service.dart  # Quran/Hadith database
│   └── ai_response_service.dart        # AI response generation
└── widgets/                  # Reusable UI components
    ├── message_bubble.dart  # Chat message bubble
    └── chat_input.dart      # Message input field
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- For Android: Android Studio / Android SDK
- For iOS: Xcode (macOS only)
- For Web: Chrome browser

### Installation

1. Clone the repository:
```bash
git clone https://github.com/tahmidbintaslim/Peace-AI.git
cd Peace-AI
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
# For mobile (Android/iOS)
flutter run

# For web
flutter run -d chrome

# For desktop
flutter run -d windows  # or macos, linux
```

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Desktop
flutter build windows --release  # or macos, linux
```

## Usage

1. Launch the application
2. Wait for the splash screen to load
3. Start chatting with Peace AI about Islamic topics
4. Ask questions about:
   - Quranic verses
   - Hadith teachings
   - Islamic principles
   - Prayer and worship
   - And much more!

## Sample Questions

- "Tell me about Allah"
- "What does Islam say about mercy?"
- "Teach me about prayer"
- "What is the meaning of Al-Fatihah?"
- "Tell me about patience"
- "What does Islam say about knowledge?"
- "Teach me about charity"
- "Tell me about good character"

Or use the **Quick Actions** buttons to instantly explore popular topics!

## Future Enhancements

- [ ] Expand Quran and Hadith database
- [ ] Add more languages
- [ ] Voice input support
- [ ] Bookmark favorite responses
- [ ] Share functionality
- [ ] Advanced AI integration
- [ ] Offline mode
- [ ] Daily reminders and notifications

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available for free use.

## Acknowledgments

- Islamic scholars and sources for authentic knowledge
- Flutter team for the amazing framework
- The Muslim community for inspiration and support

## Contact

For questions or suggestions, please open an issue on GitHub.

---

**Note**: This is a basic implementation. For a production application, consider:
- Integrating with comprehensive Quran and Hadith APIs
- Adding proper AI/ML models for better responses
- Implementing user authentication
- Adding data persistence
- Enhancing security measures
- Conducting thorough Islamic scholarship review