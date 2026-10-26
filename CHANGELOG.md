# Changelog

All notable changes to the Peace AI project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-17

### Added
- Initial release of Peace AI
- Flutter-based cross-platform application (iOS, Android, Web, Desktop)
- Chat interface for user interactions
- AI response system with Islamic knowledge base
- Quran verses database with Arabic text and English translations
- Hadith collection from authentic sources
- Splash screen with branding
- Material Design 3 UI with light and dark theme support
- Message bubble widget for chat display
- Chat input widget with send functionality
- Islamic knowledge service for data management
- AI response service for query processing
- Message and Islamic content models
- Comprehensive test suite
- Complete documentation (README, SETUP, ARCHITECTURE, CONTRIBUTING)
- GitHub Actions CI/CD workflow
- MIT License

### Features
- 🌙 Islamic knowledge base with Quran and Hadith
- 💬 Interactive chat interface
- 📱 Cross-platform support (iOS, Android, Web, Desktop)
- 🎨 Modern Material Design 3 UI
- 🔍 Smart keyword-based search
- 📖 Source references for all responses
- 🌐 Arabic text with English translations
- 🌓 Light and dark theme support

### Documentation
- README.md - Project overview and features
- SETUP.md - Detailed setup instructions
- ARCHITECTURE.md - Technical architecture documentation
- CONTRIBUTING.md - Contribution guidelines
- QUICK_REFERENCE.md - Developer quick reference
- CHANGELOG.md - Version history

### Testing
- Unit tests for models
- Unit tests for services
- Service integration tests
- Test coverage for core functionality

### Platform Support
- Android (API 21+)
- iOS (iOS 12+)
- Web (Modern browsers)
- Windows
- macOS
- Linux

## [Unreleased]

### Added (October 2026)
- Complete Flutter 3.16 Android and iOS platform projects
- GitHub Pages deployment of the web build (`.github/workflows/deploy-pages.yml`)
- Web icons, favicon and maskable icons that `web/index.html` and the manifest already referenced
- Dependabot configuration for pub packages and GitHub Actions
- Widget test for the Content Statistics screen

### Changed (October 2026)
- Content Statistics reads its counts from the dataset instead of hard-coded "50+" / "25+" / "20+" values
- Removed the unused `http` dependency
- CI: Java 17, unsigned iOS build on macOS, read-only token, `actions/checkout@v4` in every job
- Moved the first-draft notes (ARCHITECTURE, FEATURES, SETUP and others) to `docs/archive/`
- Applied `dart format` and removed the unused import that failed `flutter analyze`

### Added (November 2025)
- Expanded Quran database (46 verses from 29 surahs)
- Expanded Hadith collection (20 hadiths from four collections)
- Quick action buttons for common queries (Prayer, Mercy, Knowledge, Patience, Charity, Family)
- Bookmarks feature to save favorite responses
- Share functionality to copy and share responses
- Settings screen with theme preferences and app information
- Statistics screen showing content overview and collections
- Enhanced AI response system with 10+ query categories
- Additional Islamic Knowledge Service methods (getVerse, getVersesBySurah, getSurahNames, etc.)

### Improved
- AI response generation with better context awareness
- Search capabilities across expanded database
- UI/UX with action buttons and better navigation
- Message bubbles with bookmark and share options
- Welcome message with comprehensive topic list

### Planned Features
- [ ] Expand Quran database (all 114 surahs)
- [ ] Comprehensive Hadith collections (Sahih Bukhari, Sahih Muslim, etc.)
- [ ] Advanced AI/ML integration
- [ ] Natural Language Processing for better query understanding
- [ ] Vector embeddings for semantic search
- [ ] User authentication and profiles
- [ ] Bookmark and favorites functionality
- [ ] Share responses feature
- [ ] Daily reminders and notifications
- [ ] Multilingual support (Arabic, Urdu, French, etc.)
- [ ] Voice input and output
- [ ] Offline mode with local database
- [ ] Reading progress tracking
- [ ] Tafsir (commentary) integration
- [ ] Prayer times feature
- [ ] Qibla direction
- [ ] Islamic calendar

### Technical Improvements
- [ ] Performance optimization
- [ ] Advanced caching strategies
- [ ] Analytics integration
- [ ] Error tracking and reporting
- [ ] Automated testing expansion
- [ ] End-to-end tests
- [ ] Performance benchmarks

---

## Version History

### Version Numbering

We use Semantic Versioning (MAJOR.MINOR.PATCH):
- MAJOR: Incompatible API changes
- MINOR: New functionality (backwards compatible)
- PATCH: Bug fixes (backwards compatible)

### Release Notes

Each release includes:
- New features
- Bug fixes
- Breaking changes (if any)
- Deprecations (if any)
- Migration guide (for breaking changes)

---

**Note**: This is the initial release. Future versions will be listed here with detailed changelogs.
