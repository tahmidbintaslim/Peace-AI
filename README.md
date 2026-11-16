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
- [Landing page and deployment](#landing-page-and-deployment)
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
line of explanation plus at most one Quran verse (Arabic text and English
translation) and at most one hadith (English translation and narrator), each
set as a quoted block under its reference. Some replies, such as the greeting,
the help message or the no-match message, have no verse or hadith.

Despite the name, there is no AI model and no network call. Replies come from
keyword rules in `lib/services/ai_response_service.dart`, checked in this
order:

1. A greeting word ("salam", "hello", "hi") gets a greeting.
2. A word tied to a topic such as prayer, mercy, patience or charity gets
   that topic's fixed line and its verse or hadith.
3. "help", "guidance" or "advice" gets a help message listing the topics.
4. Anything else is searched by its significant words (common words such as
   "what", "the" or "about" are ignored) in the verse translations and surah
   names and in the hadith translations and narrator names. The texts are
   ranked by how many of those words they contain, and the best verse and
   the best hadith are shown if they tie; otherwise only the better one.

Keywords and search words match whole words only, so "hi" inside "this" no
longer triggers the greeting. A trailing "s" is ignored ("parents" matches
"parent"), but there is no real stemming or search by meaning: "patient" does
not match "patience", and a question whose words appear in no text gets the
no-match message.

The first message in the chat and the About dialog both say this plainly:
answers come from a small built-in set of texts with references, picked by
keyword rules, the texts have not been reviewed by a scholar, and for a
ruling you should ask a scholar.

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

- Three tabs at the bottom: Ask (the chat), Saved (bookmarks) and Settings
- Chat screen with topic chips (Prayer, Mercy, Knowledge, Patience, Charity,
  Family), shown until the first question is sent
- Each reply lists its Quran or hadith references
- Bookmarks, saved on the device with `shared_preferences`
- Share button that opens a dialog to copy a reply and its references to the
  clipboard or view the formatted text (there is no system share sheet)
- Settings screen with a System/Light/Dark switch, an About dialog, the app
  version and a Content Statistics screen whose figures are counted from the
  dataset
- Light and dark themes that follow the design system of
  [Ramadan Planner](https://ramadanplanner.tahmid.space/), a sibling project
  by the same author: a pale green-grey page, white rounded cards, deep teal
  buttons with pale green secondary ones, and references in the green accent
  (mint on dark green at night). The interface is set in Anek Bangla and the
  Arabic in Amiri, both bundled, with a verse-end mark carrying the ayah
  number. The theme follows the system setting until you pick Light or Dark
  in Settings; the choice is saved on the device with `shared_preferences`

## Project structure

```
lib/
  main.dart                  App entry point and routes
  theme.dart                 Colours, type scale and component themes
  models/                    Message, QuranVerse and Hadith models
  screens/                   Splash, tab shell, chat, bookmarks and settings
  services/
    ai_response_service.dart        Keyword rules that build each reply
    islamic_knowledge_service.dart  Built-in verses and hadiths, search
    bookmark_service.dart           Bookmarks in shared_preferences
    share_service.dart              Copy a reply to the clipboard
    theme_service.dart              Chosen theme in shared_preferences
  widgets/                   Message bubble, chat input and shared pieces
assets/fonts/                Amiri Regular 1.000 (Arabic) and the Anek Bangla
                             variable font (interface), each with its
                             licence (SIL OFL 1.1)
site/                        Static landing page (HTML, CSS, a little JS)
vercel.json                  Builds the landing page and the web app together
test/widget_test.dart        Unit and widget tests
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

## Landing page and deployment

`site/` is a static landing page with no build step: `index.html`,
`styles.css`, `main.js` and `assets/` (web fonts with their licences, and
screenshots taken from the Flutter web build). It is in Bangla with an
English switch, and follows the Ramadan Planner landing page: top bar, hero
with the app in a phone frame, three steps, a real verse and hadith with
their references, what the app is and is not, and how to contribute. To look
at it locally:

```bash
python3 -m http.server --directory site 8080
```

The page's "Open the app" button links to `/app/`, which exists only in a
deployment (locally it is a 404). `vercel.json` sets that deployment up for
[Vercel](https://vercel.com/): the install command shallow-clones Flutter
3.24.5 into `.flutter/` and runs `flutter pub get`; the build command runs
`flutter build web --release --base-href /app/ --no-web-resources-cdn` and
assembles `public/` with `site/` at the root and the web build under `app/`.
`--no-web-resources-cdn` bundles the CanvasKit renderer, so the deployed app
loads nothing from a third-party host. Importing the repository into Vercel
picks these settings up; no Vercel project has been created for it yet.

## Status and roadmap

Prototype, last changed in November 2026. The CI workflow
(`.github/workflows/flutter-ci.yml`) checks `dart format`, runs `flutter
analyze` and `flutter test`, and builds a release APK and the web app on
Ubuntu, plus an unsigned iOS release build on macOS.

Known limitations, all visible in the code today:

- No AI model and no network call: replies come from keyword rules.
- Free text is matched word by word, with no stemming and no search by
  meaning, so a question only finds a text that shares its words.
- Bookmarks saved by earlier versions show their verse twice, once in the
  old reply text and once as a quoted block.
- The dataset is small (46 verses, 20 hadiths) and has not been reviewed by
  a scholar.
- Sharing copies text to the clipboard; there is no system share sheet.
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
