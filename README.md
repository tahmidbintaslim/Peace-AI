<div align="center">

# Peace AI

A Flutter chat app, website widget and MCP server that answer questions about Islam with stored Quran verses and hadiths, each with its reference: the whole Quran and about 3,700 hadiths, searched by meaning in Bangla or English.

[![Flutter CI](https://github.com/tahmidbintaslim/Peace-AI/actions/workflows/flutter-ci.yml/badge.svg?branch=main)](https://github.com/tahmidbintaslim/Peace-AI/actions/workflows/flutter-ci.yml)
[![License: MIT](https://img.shields.io/github/license/tahmidbintaslim/Peace-AI)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/tahmidbintaslim/Peace-AI)](https://github.com/tahmidbintaslim/Peace-AI/commits/main)
[![GitHub stars](https://img.shields.io/github/stars/tahmidbintaslim/Peace-AI?style=flat)](https://github.com/tahmidbintaslim/Peace-AI/stargazers)

</div>

## Contents

- [Quick start](#quick-start)
- [What it is](#what-it-is)
- [Direction](#direction)
- [API, MCP and widget](#api-mcp-and-widget)
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
line of explanation plus the closest stored texts, each set as a quoted block
under its reference: from the search, up to three verses or hadiths in Arabic
with Bangla and English translations; from the built-in topics and offline
fallback, at most one verse and one hadith. Some replies, such as the greeting,
the help message or the no-match message, have no verse or hadith.

Replies are built in `lib/services/ai_response_service.dart`, checked in
this order:

1. A greeting word ("salam", "hello", "hi") gets a greeting.
2. A word tied to a topic such as prayer, mercy, patience or charity gets
   that topic's fixed line and its verse or hadith.
3. "help", "guidance" or "advice" gets a help message listing the topics.
4. Anything else is searched by meaning: `api/search.mjs` (a Vercel
   function) forwards the question to peace-api, which searches all 6,236
   ayat and about 3,700 hadith from ten collections with the bge-m3
   embedding model, so Bangla questions work too. The app shows up to three
   returned texts word for word: Arabic, Bangla and English, the reference,
   and for a hadith its grade, or "Grade: not stated in the source" when the
   source gives none. The reply is labelled as a search result, not a
   ruling. The model writes nothing.
5. If that search is unreachable, rate limited or finds nothing, the
   question is searched by its significant words (common words such as
   "what", "the" or "about" are ignored) in the small built-in dataset: the
   verse translations and surah names and the hadith translations and
   narrator names. The texts are ranked by how many of those words they
   contain, and the best verse and the best hadith are shown if they tie;
   otherwise only the better one.

Keywords and search words match whole words only, so "hi" inside "this" no
longer triggers the greeting. A trailing "s" is ignored ("parents" matches
"parent"), but word matching has no real stemming: "patient" does not match
"patience". Search by meaning covers those cases when it is reachable.

peace-api limits how often each address may search (`429` with
`rate_limited` or `daily_limit`); the app then falls back to word matching.

The first message in the chat and the About dialog both say this plainly:
answers are stored texts with references, picked by a search model that
writes nothing, hadith grades are shown only when the source gives one, the texts have not been reviewed by a scholar, and for a
ruling you should ask a scholar.

Caveats about the searched corpus:

- Hadith numbering is per book as stored ("Sahih al-Bukhari, book 65,
  hadith 315"), which may not match the numbering on sunnah.com or in print.
- Most hadith have no grade in the source, so most show "Grade: not stated
  in the source". The app never adds a grade of its own.
- Some texts lack one translation; the missing language is simply not shown.
- The corpus has not been reviewed by a scholar.

The offline dataset is hard-coded in `lib/services/islamic_knowledge_service.dart`:

- 46 Quran verses from 29 surahs
- 19 hadiths (Sahih Bukhari, Sahih Muslim, Sunan At-Tirmidhi, Al-Adab Al-Mufrad),
  numbered as on sunnah.com (for example "Sahih Muslim 2553a")

The texts and translations have not been reviewed by a scholar. Check them
against a trusted source before relying on them.

## Direction

Peace AI is becoming an open-source search tool for the Quran and hadith in
Bangla and English: you ask in your own words and get the actual verses and
hadith, each with its reference and, for hadith, its grading. Search by meaning
now covers the whole Quran and about 3,700 hadith with Bangla and English
translations; gradings are shown where the source gives them, and most hadith
have none yet.

Rules the project keeps:

- **No rulings.** The app never writes a fatwa or its own interpretation. For
  a ruling it tells you to ask a scholar.
- **No answer without a source.** A model may find and rank texts, but every
  text shown is the stored original, word for word, with its reference.
- **Hadith show their grading only when the source gives one.** Otherwise
  the app says the grade is not stated.
- **Free, no ads, no tracking.** Costs are to be met by donations.

Planned work, in order:

1. Hadith grades from sources that state them, and numbering cross-checked
   against sunnah.com.
2. Review of the corpus by a scholar, and a "report an error" button on
   every answer.

## API, MCP and widget

All three return stored texts with their references and never a ruling.

### Search API

```
POST https://peace-ai-omega.vercel.app/api/search
{ "query": "ধৈর্য", "kinds": ["quran", "hadith"], "limit": 5 }
```

`query` is 1-500 characters; `kinds` and `limit` (1-10) are optional. The
reply is `{ "matches": [...], "notice": "..." }`; each match has `id`,
`kind`, `score`, `reference`, `referenceBengali` (sometimes), `url` (or
null), `arabic`, `english`, `bengali` (any may be null), `grade` (null when
the source gives none) and, for hadith, `collection`. Errors: `400` for a
bad request, `429` (`rate_limited` or `daily_limit`), `503`. CORS is open.
`api/search.mjs` validates the request and forwards it to peace-api
(`https://nbsbfhtsnitkchclxlwx.supabase.co/functions/v1/peace-api`, same
contract), which does the search and the rate limiting.

### MCP server

`https://peace-ai-omega.vercel.app/api/mcp` is a stateless MCP server over
Streamable HTTP (`api/mcp.mjs`, no dependencies). It has two tools,
`search_quran` and `search_hadith`, each taking `query` and an optional
`limit` (1-10, default 5) and returning each text's reference, Arabic,
Bangla, English and grade line, plus the notice.

- **Claude** (claude.ai or Claude Desktop): Settings, Connectors, Add custom
  connector, and paste the URL. Claude Code:
  `claude mcp add --transport http peace-ai https://peace-ai-omega.vercel.app/api/mcp`.
- **ChatGPT**: with developer mode on, Settings, Connectors, Create, and
  paste the URL (no authentication).
- **Other clients** (Cursor, VS Code and others): add a remote server of type
  `http` (Streamable HTTP) with the URL, for example
  `{ "mcpServers": { "peace-ai": { "url": "https://peace-ai-omega.vercel.app/api/mcp" } } }`.

### Website widget

```html
<script src="https://peace-ai-omega.vercel.app/widget.js" data-lang="bn"></script>
```

`site/widget.js` draws a search box where the tag is, inside a shadow root so
the host page's styles do not leak in, calls peace-api directly and lists
the texts with their references, grades and the notice. `data-lang="en"`
switches the labels and puts English before Bangla.

## Features

- Three tabs at the bottom: Ask (the chat), Saved (bookmarks) and Settings
- Chat screen with topic chips (Prayer, Mercy, Knowledge, Patience, Charity,
  Family), shown until the first question is sent
- Each reply quotes its texts under their references; hadith show their
  grade or say it is not stated
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
    ai_response_service.dart        Builds each reply (topics, meaning, words)
    meaning_search.dart             Client for api/search.mjs
    islamic_knowledge_service.dart  Built-in verses and hadiths, search
    bookmark_service.dart           Bookmarks in shared_preferences
    share_service.dart              Copy a reply to the clipboard
    theme_service.dart              Chosen theme in shared_preferences
  widgets/                   Message bubble, chat input and shared pieces
assets/fonts/                Amiri Regular 1.000 (Arabic) and the Anek Bangla
                             variable font (interface), each with its
                             licence (SIL OFL 1.1)
site/                        Static landing page (HTML, CSS, a little JS)
api/search.mjs               Search API: validates and forwards to peace-api
api/mcp.mjs                  MCP server (search_quran, search_hadith)
site/widget.js               Embeddable search widget
test/api_check.mjs           Self-check for both functions (node, mocked fetch)
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
node test/api_check.mjs   # API and MCP self-check
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

- Search by meaning needs the network; offline, free text is matched word
  by word with no stemming.
- Bookmarks saved by earlier versions show their verse twice, once in the
  old reply text and once as a quoted block.
- Most hadith have no grade in the source, hadith numbering is per book as
  stored, and the corpus has not been reviewed by a scholar.
- Search results have no score cut-off, so a question with no related text
  still gets the closest ones.
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
