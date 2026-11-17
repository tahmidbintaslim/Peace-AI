import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

/// Asks api/search.mjs which built-in texts are closest in meaning to a
/// question, and returns their references, best first.
typedef MeaningSearch = Future<List<String>> Function(String query);

// The web build is served next to the function; app builds call the site.
final Uri _endpoint = kIsWeb
    ? Uri.base.resolve('/api/search')
    : Uri.parse('https://peace-ai-omega.vercel.app/api/search');

/// Below this cosine score a match is treated as unrelated. Tuned on
/// gemini-embedding-001 against the built-in texts: related questions score
/// 0.55-0.67, unrelated ones ("how to cook rice") about 0.50-0.52.
// shortcut: one cut-off for every model; recheck it if api/search.mjs falls
// back to another model.
const double minMeaningScore = 0.55;

/// References scoring at least [minMeaningScore], or an empty list when the
/// search is unreachable, so the caller falls back to word matching.
Future<List<String>> searchByMeaning(String query) async {
  try {
    final res = await http
        .post(_endpoint,
            headers: {'content-type': 'application/json'},
            body: jsonEncode({'query': query}))
        .timeout(const Duration(seconds: 8));
    if (res.statusCode != 200) return const [];
    final matches = (jsonDecode(res.body)['matches'] as List).cast<Map>();
    return [
      for (final m in matches)
        if ((m['score'] as num) >= minMeaningScore) m['reference'] as String,
    ];
  } catch (_) {
    return const [];
  }
}
