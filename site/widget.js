// Peace AI search widget. Embed with:
//   <script src="https://peace-ai-omega.vercel.app/widget.js" data-lang="bn"></script>
// It draws a search box where the tag is, inside a shadow root, and shows
// stored Quran and hadith texts with their references. No dependencies.
(function () {
  var script = document.currentScript;
  if (!script) return;
  var API = 'https://nbsbfhtsnitkchclxlwx.supabase.co/functions/v1/peace-api';
  var en = script.getAttribute('data-lang') === 'en';
  var t = en
    ? { label: 'Search the Quran and hadith', placeholder: 'Ask in Bangla or English', go: 'Search', busy: 'Searching…', none: 'No matching texts found.', fail: 'Search is unavailable right now. Please try again later.', limited: 'Too many searches. Please try again later.', grade: 'Grade: ', noGrade: 'Grade: not stated in the source', quran: 'Quran', hadith: 'Hadith', by: 'Search by Peace AI' }
    : { label: 'কুরআন ও হাদিসে খুঁজুন', placeholder: 'বাংলা বা ইংরেজিতে প্রশ্ন লিখুন', go: 'খুঁজুন', busy: 'খোঁজা হচ্ছে…', none: 'মিলে যায় এমন কোনো লেখা পাওয়া যায়নি।', fail: 'এখন খোঁজা যাচ্ছে না। একটু পরে আবার চেষ্টা করুন।', limited: 'অনেকবার খোঁজা হয়েছে। একটু পরে আবার চেষ্টা করুন।', grade: 'মান: ', noGrade: 'মান: উৎসে উল্লেখ নেই', quran: 'কুরআন', hadith: 'হাদিস', by: 'Peace AI-এর খোঁজ' };

  var host = document.createElement('div');
  script.parentNode.insertBefore(host, script);
  var root = host.attachShadow({ mode: 'open' });
  root.innerHTML =
    '<style>' +
    ':host{display:block;font:16px/1.6 system-ui,"Noto Sans Bengali",sans-serif;color:#10302B;max-width:40rem}' +
    'form{display:flex;gap:.5rem}' +
    'input{flex:1;min-width:0;font:inherit;padding:.6rem .8rem;border:1px solid #8aa596;border-radius:.6rem;background:#fff;color:inherit}' +
    'button{font:inherit;padding:.6rem 1rem;border:0;border-radius:.6rem;background:#0E7C6B;color:#fff;cursor:pointer}' +
    'input:focus-visible,button:focus-visible{outline:3px solid #0A5F52;outline-offset:2px}' +
    'button[disabled]{opacity:.6;cursor:progress}' +
    '.sr{position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0 0 0 0)}' +
    'ol{list-style:none;margin:1rem 0 0;padding:0;display:grid;gap:.75rem}' +
    'li{background:#E3F1EE;border-radius:.8rem;padding:.75rem 1rem}' +
    '.ref{font-weight:600;color:#0E7C6B;margin:0}' +
    '.ar{font-size:1.4em;line-height:2;margin:.25rem 0}' +
    'p{margin:.25rem 0}.muted{color:#3F5A54;font-size:.875em}' +
    '</style>' +
    '<form role="search"><label class="sr" for="q"></label><input id="q" type="search" maxlength="500" required><button type="submit"></button></form>' +
    '<div aria-live="polite"><p class="muted status"></p><ol></ol><p class="muted notice"></p></div>' +
    '<p class="muted"><a href="https://peace-ai-omega.vercel.app/" target="_blank" rel="noopener"></a></p>';

  var form = root.querySelector('form');
  var input = root.querySelector('input');
  var button = root.querySelector('button');
  var status = root.querySelector('.status');
  var list = root.querySelector('ol');
  var notice = root.querySelector('.notice');
  root.querySelector('label').textContent = t.label;
  input.placeholder = t.placeholder;
  button.textContent = t.go;
  root.querySelector('a').textContent = t.by;

  function el(tag, cls, text, attrs) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    e.textContent = text; // textContent only: API text is never parsed as HTML
    for (var k in attrs || {}) e.setAttribute(k, attrs[k]);
    return e;
  }

  function render(m) {
    var li = document.createElement('li');
    li.appendChild(el('p', 'ref', (m.kind === 'hadith' ? t.hadith : t.quran) + ' · ' + ((!en && m.referenceBengali) || m.reference)));
    if (m.arabic) li.appendChild(el('p', 'ar', m.arabic, { lang: 'ar', dir: 'rtl' }));
    var first = en ? m.english : m.bengali;
    var second = en ? m.bengali : m.english;
    if (first) li.appendChild(el('p', '', first, { lang: en ? 'en' : 'bn' }));
    if (second) li.appendChild(el('p', 'muted', second, { lang: en ? 'bn' : 'en' }));
    if (m.kind === 'hadith') li.appendChild(el('p', 'muted', m.grade ? t.grade + m.grade : t.noGrade));
    return li;
  }

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var query = input.value.trim();
    if (!query) return;
    button.disabled = true;
    status.textContent = t.busy;
    list.textContent = '';
    notice.textContent = '';
    fetch(API, { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ query: query, limit: 5 }) })
      .then(function (res) {
        return res.json().then(function (body) {
          if (res.status === 429) throw new Error(t.limited);
          if (!res.ok) throw new Error(t.fail);
          return body;
        });
      })
      .then(function (body) {
        status.textContent = body.matches.length ? '' : t.none;
        body.matches.forEach(function (m) { list.appendChild(render(m)); });
        notice.textContent = body.notice || '';
      })
      .catch(function (err) {
        status.textContent = err && (err.message === t.limited) ? t.limited : t.fail;
      })
      .then(function () { button.disabled = false; });
  });
})();
