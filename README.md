# Peace AI

A Flutter chat app that answers questions about Islam with Quran verses and
hadiths from a small dataset built into the app.

## What it is

You type a question (or tap a topic chip), and the app replies with a short
fixed explanation plus at most one Quran verse (Arabic text and English
translation) and at most one hadith (English translation only), each with its
reference. Some replies, such as the greeting or the no-match message, have
no verse or hadith.

Despite the name, there is no AI model and no network call. Replies come from
keyword rules in `lib/services/ai_response_service.dart`: the lowercased query
is checked for substrings tied to topics such as prayer, mercy, patience or
charity. The checks are plain substring matches, so "hi" inside "this" or
"which" triggers the greeting. A query that contains "what", "how", "help",
"guidance" or "advice" and no earlier topic word gets a fixed help message and
a verse picked by the clock. Anything else is searched as one whole phrase in
the verse translations and surah names, then in the hadith translations and
narrator names, so a multi-word question rarely matches.

The dataset is hard-coded in `lib/services/islamic_knowledge_service.dart`:

- 46 Quran verses from 29 surahs
- 20 hadiths (Sahih Bukhari, Sahih Muslim, Sunan At-Tirmidhi, Sunan Ibn Majah)

The texts and translations have not been reviewed by a scholar. Check them
against a trusted source before relying on them.

## Features

- Chat screen with topic chips (Prayer, Mercy, Knowledge, Patience, Charity,
  Family), shown until the first question is sent
- Each reply lists its Quran or hadith references
- Bookmarks, saved on the device with `shared_preferences`
- Share button that opens a dialog to copy a reply and its references to the
  clipboard or view the formatted text (there is no system share sheet)
- Settings screen with an About dialog, the app version and a Content
  Statistics screen. The statistics are hard-coded ("50+" verses from "25+"
  surahs, "20+" hadiths) and do not match the dataset above
- Light and dark Material 3 themes that follow the system setting (the theme
  picker in Settings does not change or save the theme yet)

## Project structure

```
lib/
  main.dart                  App entry point, themes, routes
  models/                    Message, QuranVerse and Hadith models
  screens/                   Splash, chat, bookmarks and settings screens
  services/
    ai_response_service.dart        Keyword rules that build each reply
    islamic_knowledge_service.dart  Built-in verses and hadiths, search
    bookmark_service.dart           Bookmarks in shared_preferences
    share_service.dart              Copy a reply to the clipboard
  widgets/                   Message bubble and chat input
test/widget_test.dart        Unit tests for models and services
```

The other Markdown files (`ARCHITECTURE.md`, `FEATURES.md`, `SETUP.md`,
`APPLICATION_FLOW.md` and others) are notes written alongside the first
version. Where they disagree with this README or the code, the code is right.

## Running it

Requirements: Flutter SDK with Dart 3 (`sdk: '>=3.0.0 <4.0.0'` in
`pubspec.yaml`). CI pins Flutter 3.16.0, and the steps below assume that
version. `pubspec.lock` is committed, so `flutter pub get` resolves the same
package versions CI uses.

The `android/` and `ios/` folders are complete Flutter 3.16 projects, so no
`flutter create` step is needed. The Android build uses Groovy Gradle scripts,
Gradle 7.5 and Android Gradle Plugin 7.3, which need Java 17 (Gradle 7.5 does
not run on Java 21) and an Android SDK with platform 34. The Gradle wrapper
script and jar are not committed; Flutter generates them on the first Android
build, as its own templates do. The iOS app builds on macOS with Xcode 15 and
CocoaPods. The `web/` folder has no icons, and desktop folders do not exist.

```bash
git clone https://github.com/tahmidbintaslim/Peace-AI.git
cd Peace-AI
flutter pub get
flutter run -d chrome   # or an Android/iOS device
flutter test
flutter build apk --release
flutter build ios --release --no-codesign   # macOS only
```

Release APKs are signed with the debug key (`android/app/build.gradle`); set
up your own signing before publishing to a store.

## Status

Prototype, last changed in November 2025. The CI workflow
(`.github/workflows/flutter-ci.yml`) checks `dart format`, runs `flutter
analyze` and `flutter test`, and builds a release APK and the web app on
Ubuntu, plus an unsigned iOS release build on macOS.
The `http` package is declared in `pubspec.yaml` but not used.

## Contributing

Issues and pull requests are welcome. See `CONTRIBUTING.md`.

## License

MIT. See [LICENSE](LICENSE).
