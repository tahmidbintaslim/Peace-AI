# Security policy

## Supported versions

Peace AI is a prototype with no tagged releases. Only the latest commit on
`main` receives fixes.

## Reporting a vulnerability

Please do not open a public issue for a security problem. Email
tahmidbintaslimrafi@gmail.com with:

- A description of the issue and its impact
- Steps to reproduce, or a proof of concept
- The commit or version you tested

There is no fixed response time for this small project. Once
an issue is confirmed, the fix lands on `main`.

## Scope

The app makes no network calls and stores bookmarks only on the device
through `shared_preferences`. Reports about the built-in Quran or hadith
text (wrong wording or references) are content bugs, not security issues;
please open a regular issue for those.
