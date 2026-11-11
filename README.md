<div align="center">

# Peace AI

A Flutter chat app that answers questions about Islam with Quran verses and hadiths from a small built-in dataset.

[![Flutter CI](https://github.com/tahmidbintaslim/Peace-AI/actions/workflows/flutter-ci.yml/badge.svg?branch=main)](https://github.com/tahmidbintaslim/Peace-AI/actions/workflows/flutter-ci.yml)
[![License: MIT](https://img.shields.io/github/license/tahmidbintaslim/Peace-AI)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/tahmidbintaslim/Peace-AI)](https://github.com/tahmidbintaslim/Peace-AI/commits/main)
[![GitHub stars](https://img.shields.io/github/stars/tahmidbintaslim/Peace-AI?style=flat)](https://github.com/tahmidbintaslim/Peace-AI/stargazers)

</div>

## Contents

- [Quick start](#quick-start)
- [What it is](#what-it-is)
- [Direction](#direction)
- [Features](#features)
- [Project structure](#project-structure)
- [Running it](#running-it)
- [Status and roadmap](#status-and-roadmap)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

## Quick start

You need the Flutter SDK (CI uses 3.24.5).

```bash
git clone https://github.com/tahmidbintaslim/Peace-AI.git
cd Peace-AI
flutter pub get
flutter run -d chrome
```

See [Running it](#running-it) for Android, iOS and release builds.

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

## Direction

Peace AI is becoming an open-source search tool for the Quran and hadith in
Bangla and English: you ask in your own words and get the actual verses and
hadith, each with its reference and, for hadith, its grading. None of this is
built yet. The app today is the keyword prototype described above.

Rules the project keeps:

- **No rulings.** The app never writes a fatwa or its own interpretation. For
  a ruling it tells you to ask a scholar.
- **No answer without a source.** A model may find and rank texts, but every
  text shown is the stored original, word for word, with its reference.
- **Hadith show their grading.**
- **Free, no ads, no tracking.** Costs are to be met by donations.

Planned work, in order:

1. Replace the hand-typed dataset with complete sources whose licences allow
   it. The Tanzil Arabic Quran text is CC BY 3.0 for verbatim copies with
   credit. Translations are copyrighted, so each one needs written permission
   from its publisher before it ships.
2. Search by meaning over that corpus, so a question such as "how to be
   patient when sick" finds the right texts. Results are retrieved, never
   generated.
3. A Bangla translation beside the English one.
4. Review of the dataset by a scholar, and a "report an error" button on
   every answer.

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
`pubspec.yaml`). CI pins Flutter 3.24.5, and the steps below assume that
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

## Status and roadmap

Prototype, last changed in November 2025. The CI workflow
(`.github/workflows/flutter-ci.yml`) checks `dart format`, runs `flutter
analyze` and `flutter test`, and builds a release APK and the web app on
Ubuntu, plus an unsigned iOS release build on macOS.

Known limitations, all visible in the code today:

- No AI model and no network call: replies come from keyword rules, and the
  plain substring checks can misfire ("hi" inside "this" triggers the
  greeting).
- Multi-word questions rarely match, since free text is searched as one
  whole phrase.
- The dataset is small (46 verses, 20 hadiths) and has not been reviewed by
  a scholar.
- The Content Statistics screen shows hard-coded figures that do not match
  the dataset.
- The theme picker in Settings does not change or save the theme.
- Sharing copies text to the clipboard; there is no system share sheet.
- The `http` package is declared in `pubspec.yaml` but not used.
- Release APKs are signed with the debug key.
- The `web/` folder has no icons, and there are no desktop builds.

Each item above is a candidate for future work. [Direction](#direction)
lists the planned order. There is no release date.

## Contributing

Issues and pull requests are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Security

To report a vulnerability, see [SECURITY.md](SECURITY.md).

## License

MIT. See [LICENSE](LICENSE).
