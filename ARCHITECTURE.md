# Peace AI Architecture

This document describes the architecture and design decisions of the Peace AI application.

## Overview

Peace AI is built using Flutter, following clean architecture principles with clear separation of concerns. The application is designed to be scalable, maintainable, and testable.

## Architecture Diagram

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  (Screens & Widgets)                    │
│  - SplashScreen                         │
│  - ChatScreen                           │
│  - MessageBubble                        │
│  - ChatInput                            │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│           Business Logic Layer          │
│  (Services)                             │
│  - AIResponseService                    │
│  - IslamicKnowledgeService              │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│              Data Layer                 │
│  (Models)                               │
│  - Message                              │
│  - QuranVerse                           │
│  - Hadith                               │
└─────────────────────────────────────────┘
```

## Layers

### 1. Presentation Layer

Handles UI and user interactions.

#### Screens
- **SplashScreen**: Welcome screen with app branding
- **ChatScreen**: Main interface for user-AI interaction

#### Widgets
- **MessageBubble**: Displays individual chat messages
- **ChatInput**: Text input field for user queries

**Responsibilities**:
- Render UI components
- Handle user input
- Display data from services
- Navigate between screens

### 2. Business Logic Layer

Contains application logic and data processing.

#### Services

**IslamicKnowledgeService**
- Manages Quran verses and Hadith collections
- Provides search functionality
- Returns random verses/hadiths
- Data source for Islamic content

**AIResponseService**
- Processes user queries
- Generates intelligent responses
- Integrates with IslamicKnowledgeService
- Performs keyword matching and context analysis

**Responsibilities**:
- Business rules implementation
- Data transformation
- Query processing
- Response generation

### 3. Data Layer

Defines data structures and models.

#### Models

**Message**
- Represents chat messages
- Supports serialization/deserialization
- Includes user/AI identification
- Tracks timestamps and references

**QuranVerse**
- Stores Quranic verse data
- Arabic text and translation
- Surah and verse numbers
- Reference formatting

**Hadith**
- Stores Hadith data
- Collection information
- Narrator details
- Reference formatting

**Responsibilities**:
- Data structure definition
- Serialization logic
- Type safety

## Design Patterns

### 1. Service Pattern
Services encapsulate business logic and data access, making the code more maintainable and testable.

### 2. Model Pattern
Models represent data structures and provide methods for data manipulation.

### 3. Widget Composition
UI is built using composable widgets following Flutter best practices.

## Data Flow

### User Query Flow

```
User Input
    ↓
ChatInput Widget
    ↓
ChatScreen (State Management)
    ↓
AIResponseService.generateResponse()
    ↓
IslamicKnowledgeService.searchQuran/searchHadith()
    ↓
Response Generation
    ↓
ChatScreen (Update State)
    ↓
MessageBubble (Display)
    ↓
User Sees Response
```

## State Management

Currently uses **StatefulWidget** with local state management:

- Simple and suitable for current app complexity
- State is contained within individual screens
- No external state management library needed yet

**Future Considerations**:
- Provider or Riverpod for global state
- BLoC for complex state management
- GetX for reactive programming

## Key Features

### 1. Cross-Platform Support

Built with Flutter to support:
- **Mobile**: iOS and Android
- **Web**: Progressive Web App (PWA)
- **Desktop**: Windows, macOS, and Linux

### 2. Responsive Design

- Adapts to different screen sizes
- Material Design 3 theming
- Light and dark mode support

### 3. Islamic Content Management

- Structured storage of Quranic verses
- Organized Hadith collections
- Proper reference formatting
- Arabic text with translations

### 4. Intelligent Response System

Current implementation:
- Keyword-based matching
- Context-aware responses
- Multi-source integration (Quran + Hadith)

Future enhancements:
- Natural Language Processing (NLP)
- Machine Learning models
- Vector embeddings for semantic search
- Integration with comprehensive Islamic databases

## File Structure

```
lib/
├── main.dart                     # Application entry point
├── models/                       # Data models
│   ├── message.dart             # Chat message model
│   └── islamic_content.dart     # Quran & Hadith models
├── screens/                      # Screen widgets
│   ├── splash_screen.dart       # Splash screen
│   └── chat_screen.dart         # Chat interface
├── services/                     # Business logic
│   ├── islamic_knowledge_service.dart  # Data service
│   └── ai_response_service.dart        # AI logic
└── widgets/                      # Reusable widgets
    ├── message_bubble.dart      # Message display
    └── chat_input.dart          # Input field

test/
└── widget_test.dart             # Unit tests

android/                          # Android config
ios/                             # iOS config
web/                             # Web config
```

## Testing Strategy

### Unit Tests
- Test data models (serialization/deserialization)
- Test service logic (search, response generation)
- Test business rules

### Widget Tests
- Test UI components render correctly
- Test user interactions
- Test state changes

### Integration Tests
- Test complete user flows
- Test platform-specific features

## Performance Considerations

### Current Implementation

1. **Memory Efficiency**
   - In-memory data structures
   - Efficient widget rebuilding
   - Proper disposal of resources

2. **UI Performance**
   - Minimal widget rebuilds
   - Efficient list rendering with ListView.builder
   - Smooth animations

### Future Optimizations

1. **Data Management**
   - Local database (SQLite/Hive)
   - Lazy loading for large datasets
   - Caching strategies

2. **Response Time**
   - Asynchronous processing
   - Background computation
   - Progressive loading

## Security Considerations

1. **Data Privacy**
   - No user data collection currently
   - Local storage only
   - No external API calls

2. **Content Integrity**
   - Authentic Islamic sources
   - Proper verification needed for production
   - Scholar review recommended

## Scalability

### Current Limitations

- Limited Quran/Hadith database
- Simple keyword matching
- In-memory storage only

### Scalability Path

1. **Database Integration**
   - Full Quran database
   - Comprehensive Hadith collections
   - Efficient indexing and search

2. **API Integration**
   - External Islamic knowledge APIs
   - Cloud-based AI services
   - Real-time updates

3. **Advanced Features**
   - User accounts and profiles
   - Bookmarks and favorites
   - Sharing capabilities
   - Multilingual support
   - Voice input/output

## Dependencies

### Core Dependencies
- `flutter`: UI framework
- `cupertino_icons`: iOS-style icons

### Utility Dependencies
- `http`: HTTP client for API calls (future use)
- `shared_preferences`: Local key-value storage (future use)

### Development Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code quality

## Deployment

### Mobile (Android/iOS)
- Standard Flutter build process
- Platform-specific configurations in android/ and ios/

### Web
- Static hosting (Firebase Hosting, Netlify, Vercel)
- PWA capabilities for offline support

### Desktop
- Platform-specific installers
- Auto-update mechanisms (future)

## Future Enhancements

1. **AI/ML Integration**
   - Train custom models on Islamic texts
   - Implement vector embeddings
   - Semantic search capabilities

2. **Content Expansion**
   - Complete Quran (114 surahs)
   - Major Hadith collections (Bukhari, Muslim, etc.)
   - Tafsir (commentary) integration

3. **User Features**
   - Authentication and profiles
   - Learning progress tracking
   - Daily reminders
   - Social features

4. **Technical Improvements**
   - Offline-first architecture
   - Advanced caching
   - Performance monitoring
   - Analytics integration

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to the architecture and codebase.

## References

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [Clean Architecture Principles](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
