import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:peace_ai/services/islamic_knowledge_service.dart';

/// api/search.mjs searches a JSON copy of the built-in texts. This keeps the
/// copy in step with the dataset. After changing the dataset, regenerate it:
///   UPDATE_KNOWLEDGE=1 flutter test test/knowledge_export_test.dart
void main() {
  test('api/knowledge.json matches the built-in dataset', () {
    final service = IslamicKnowledgeService();
    final items = [
      for (final v in service.getAllVerses())
        {'reference': v.reference, 'text': '${v.translation} (Quran, ${v.surahName})'},
      for (final h in service.getAllHadiths())
        {
          'reference': h.reference,
          'text': '${h.translation} Narrated by ${h.narrator}. ${h.collection}.',
        },
    ];
    final expected = '${const JsonEncoder.withIndent('  ').convert(items)}\n';
    final file = File('api/knowledge.json');
    if (Platform.environment['UPDATE_KNOWLEDGE'] == '1') file.writeAsStringSync(expected);
    expect(file.readAsStringSync(), expected);
  });
}
