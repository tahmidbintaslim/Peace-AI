import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import '../models/islamic_content.dart';

/// Asks api/search.mjs for the stored verses and hadith closest in meaning
/// to a question, best first.
typedef MeaningSearch = Future<List<SearchMatch>> Function(String query);

// The web build is served next to the function; app builds call the site.
final Uri _endpoint = kIsWeb
    ? Uri.base.resolve('/api/search')
    : Uri.parse('https://peace-ai-omega.vercel.app/api/search');

/// How many texts one reply shows.
const int meaningSearchLimit = 3;

/// The matches, or an empty list when the search is unreachable or limited,
/// so the caller falls back to word matching.
Future<List<SearchMatch>> searchByMeaning(String query) async {
  try {
    final res = await http
        .post(_endpoint,
            headers: {'content-type': 'application/json'},
            body: jsonEncode({'query': query, 'limit': meaningSearchLimit}))
        .timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) return const [];
    return [
      for (final m in jsonDecode(res.body)['matches'] as List)
        SearchMatch.fromJson(m as Map<String, dynamic>),
    ];
  } catch (_) {
    return const [];
  }
}
