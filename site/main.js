// Language switch (Bangla is in the HTML; English lives here) and the hero's
// screen pills. No dependencies, no network calls.
(function () {
  var en = {
    title: 'Peace AI: Quran verses and hadith, each with its reference',
    skip: 'Skip to content',
    navLabel: 'Sections of the site',
    langLabel: 'Language',
    navHow: 'How it works',
    navShows: 'What it shows',
    navHonest: 'Limits',
    navOpen: 'Open source',
    open: 'Open the app',
    source: 'View the source',
    heroEyebrow: 'Quran and hadith · every text with its reference',
    heroTitle: 'Ask a question, read verses and hadith with their references',
    heroLead: 'Type a question or pick a topic, and Peace AI matches your words against the verses and hadith stored inside the app, then shows the text with its reference. Free, with no ads and no account.',
    factsTitle: 'What is inside the app',
    factVersesLabel: 'Quran verses',
    factVerses: '46',
    factHadithLabel: 'Hadiths',
    factHadith: '20',
    factHowLabel: 'Texts are picked',
    factHow: 'By matching words',
    factNoAi: 'Not an AI model',
    factOffline: 'No network call',
    factNote: 'Verses are in Arabic with an English translation; hadiths are in English translation. The texts have not been reviewed by a scholar.',
    tickFree: 'Free',
    tickAds: 'No ads',
    tickTrack: 'No tracking',
    tickOpen: 'Open source',
    shotAlt: 'Screenshot of the Peace AI app: a verse and a hadith, each with its reference',
    shotDarkAlt: 'Screenshot of the Peace AI app in the dark theme',
    pillsLabel: 'App screens',
    pillAsk: 'Ask',
    pillHadith: 'Hadith',
    pillSaved: 'Saved',
    pillSettings: 'Settings',
    howEyebrow: 'How it works',
    howTitle: 'Three steps',
    howSub: 'No account, nothing to set up.',
    step1: 'Step 1',
    step1Title: 'Type a question or pick a topic',
    step1Body: 'Write your question in English, or tap one of six topics such as Prayer, Mercy or Patience.',
    step2: 'Step 2',
    step2Title: 'The app matches your words',
    step2Body: 'The words of your question are matched against the translations of the stored verses and hadith. Everything happens on your device.',
    step3: 'Step 3',
    step3Title: 'Read it with its reference, keep it',
    step3Body: 'See the closest verse or hadith with its reference. Save it, or copy the text, if you like.',
    showsEyebrow: 'What it shows',
    showsTitle: 'The actual text, beside its reference',
    showsSub: 'The two texts below are taken word for word from the app’s dataset, set the way the app sets them.',
    f1Tag: 'Replies',
    f1Title: 'Every reply carries its reference',
    f1Body: 'A reply holds at most one verse and one hadith. A verse comes with its surah name and verse number; a hadith with its collection, number and narrator.',
    f1a: 'Verses: Arabic text and English translation',
    f1b: 'Hadith: English translation and narrator',
    f1c: 'When nothing matches, the app says so plainly',
    f2Tag: 'Saving',
    f2Title: 'Keep it, copy it, read at night',
    f2Body: 'Any reply that carries a reference can be saved. Saved texts stay on your device.',
    f2a: 'A separate list of saved replies',
    f2b: 'Copy the text with its references to the clipboard',
    f2c: 'Light and dark themes; your choice is remembered',
    honestEyebrow: 'Plainly',
    honestTitle: 'What it is, and what it is not',
    honestSub: 'Despite the “AI” in the name, today’s app is a small, simple prototype.',
    isTitle: 'What it has',
    is1: '46 Quran verses and 20 hadiths, each with its reference',
    is2: 'Replies are built on your device; the app makes no network call',
    is3: 'Free; no ads, no tracking',
    is4: 'All the code is open, under the MIT licence',
    notTitle: 'What it does not have',
    not1: 'No AI model; texts are picked by keyword rules',
    not2: 'The texts have not been reviewed by a scholar; check them against a trusted source',
    not3: 'It gives no rulings; for those, ask a scholar',
    not4: 'No Bangla translation of the verses or hadith yet; questions must be in English too',
    not5: 'No search by meaning; if the words of your question are not in a text, it finds nothing',
    openTitle: 'Open source, open to everyone',
    openBody: 'Peace AI is written in Flutter and released under the MIT licence. Read the code, run it yourself, and tell us when you find a mistake.',
    openGithub: 'View on GitHub',
    openGuide: 'Contributing guide',
    c1Title: 'Report a mistake in a text',
    c1Body: 'If you see an error in a verse, a translation or a reference, open an issue on GitHub.',
    c1Link: 'Open an issue',
    c2Title: 'Work on the code',
    c2Body: 'Clone the repository, run it, then send a pull request. The steps are in the README.',
    c2Link: 'Running it',
    c3Title: 'What is planned',
    c3Body: 'Complete sources with permission, search by meaning, a Bangla translation and review by a scholar. None of this is built yet.',
    c3Link: 'Read the plan',
    footTag: 'Quran verses and hadith, each with its reference.',
    footLabel: 'Footer',
    footApp: 'App',
    footProject: 'Project',
    footSource: 'Source code',
    footReport: 'Report a problem',
    footLicense: 'MIT licence',
    footSibling: 'By the same maker',
    footRamadan: 'Ramadan Planner',
    footFonts: 'Fonts: Anek Bangla and Amiri (SIL Open Font License).',
    footPromise: 'Free · No ads · No tracking · © 2026 Peace AI'
  };

  var bn = { title: document.title };
  var texts = document.querySelectorAll('[data-i]');
  var attrs = document.querySelectorAll('[data-i-attr]');
  texts.forEach(function (el) { bn[el.dataset.i] = el.textContent; });
  attrs.forEach(function (el) {
    var pair = el.dataset.iAttr.split(':');
    bn[pair[1]] = el.getAttribute(pair[0]);
  });

  function setLang(lang) {
    var dict = lang === 'en' ? en : bn;
    document.documentElement.lang = lang;
    document.title = dict.title;
    texts.forEach(function (el) { el.textContent = dict[el.dataset.i]; });
    attrs.forEach(function (el) {
      var pair = el.dataset.iAttr.split(':');
      el.setAttribute(pair[0], dict[pair[1]]);
    });
    document.querySelectorAll('[data-lang]').forEach(function (b) {
      b.setAttribute('aria-pressed', String(b.dataset.lang === lang));
    });
    try { localStorage.setItem('lang', lang); } catch (e) { /* private mode */ }
  }

  document.querySelectorAll('[data-lang]').forEach(function (b) {
    b.addEventListener('click', function () { setLang(b.dataset.lang); });
  });
  var saved = new URLSearchParams(location.search).get('lang');
  try { saved = saved || localStorage.getItem('lang'); } catch (e) { /* private mode */ }
  if (saved === 'en') setLang('en');

  var shot = document.getElementById('hero-shot');
  var pills = document.querySelectorAll('[data-shot]');
  pills.forEach(function (b) {
    b.addEventListener('click', function () {
      shot.src = 'assets/' + b.dataset.shot + '.webp';
      pills.forEach(function (p) { p.setAttribute('aria-pressed', String(p === b)); });
    });
  });
})();
