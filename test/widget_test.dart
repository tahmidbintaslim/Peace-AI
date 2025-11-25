import 'package:flutter_test/flutter_test.dart';
import 'package:peace_ai/models/message.dart';
import 'package:peace_ai/models/islamic_content.dart';
import 'package:peace_ai/services/islamic_knowledge_service.dart';
import 'package:peace_ai/services/ai_response_service.dart';

void main() {
  group('Message Model Tests', () {
    test('Message can be created and serialized', () {
      final message = Message(
        id: '1',
        text: 'Test message',
        isUser: true,
        timestamp: DateTime.now(),
      );

      expect(message.id, '1');
      expect(message.text, 'Test message');
      expect(message.isUser, true);

      final json = message.toJson();
      expect(json['id'], '1');
      expect(json['text'], 'Test message');
    });

    test('Message can be deserialized from JSON', () {
      final json = {
        'id': '1',
        'text': 'Test message',
        'isUser': true,
        'timestamp': DateTime.now().toIso8601String(),
      };

      final message = Message.fromJson(json);
      expect(message.id, '1');
      expect(message.text, 'Test message');
      expect(message.isUser, true);
    });

    test('Message with references can be serialized', () {
      final message = Message(
        id: '1',
        text: 'Test message',
        isUser: false,
        timestamp: DateTime.now(),
        references: ['Al-Fatihah 1:1', 'Sahih Bukhari 2:47'],
      );

      expect(message.references, isNotNull);
      expect(message.references!.length, 2);

      final json = message.toJson();
      expect(json['references'], isNotNull);
      expect((json['references'] as List).length, 2);
    });
  });

  group('Islamic Content Models Tests', () {
    test('QuranVerse reference format is correct', () {
      final verse = QuranVerse(
        surah: 1,
        verse: 1,
        arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        translation: 'In the name of Allah',
        surahName: 'Al-Fatihah',
      );

      expect(verse.reference, 'Al-Fatihah 1:1');
    });

    test('Hadith reference format is correct', () {
      final hadith = Hadith(
        collection: 'Sahih Bukhari',
        bookNumber: '2',
        hadithNumber: '47',
        arabicText: 'Arabic text',
        translation: 'Translation',
        narrator: 'Abdullah',
      );

      expect(hadith.reference, 'Sahih Bukhari 2:47');
    });
  });

  group('Islamic Knowledge Service Tests', () {
    late IslamicKnowledgeService service;

    setUp(() {
      service = IslamicKnowledgeService();
    });

    test('Can search Quran by keyword', () {
      final results = service.searchQuran('merciful');
      expect(results, isNotEmpty);
    });

    test('Can search Hadith by keyword', () {
      final results = service.searchHadith('mercy');
      expect(results, isNotEmpty);
    });

    test('Can get random verse', () {
      final verse = service.getRandomVerse();
      expect(verse, isNotNull);
    });

    test('Can get random hadith', () {
      final hadith = service.getRandomHadith();
      expect(hadith, isNotNull);
    });

    test('Can get all verses', () {
      final verses = service.getAllVerses();
      expect(verses, isNotEmpty);
      expect(verses.length, greaterThan(5)); // Should have expanded database
    });

    test('Can get all hadiths', () {
      final hadiths = service.getAllHadiths();
      expect(hadiths, isNotEmpty);
      expect(hadiths.length, greaterThan(3)); // Should have expanded database
    });

    test('Can get unique surah names', () {
      final names = service.getSurahNames();
      expect(names, isNotEmpty);
      expect(names, contains('Al-Fatihah'));
      expect(names, contains('Al-Baqarah'));
    });

    test('Can get verse by surah and verse number', () {
      final verse = service.getVerse(1, 1);
      expect(verse, isNotNull);
      expect(verse!.surah, 1);
      expect(verse.verse, 1);
      expect(verse.surahName, 'Al-Fatihah');
    });

    test('Returns null for non-existent verse', () {
      final verse = service.getVerse(999, 999);
      expect(verse, isNull);
    });

    test('Can get verses by surah name', () {
      final verses = service.getVersesBySurah('Al-Fatihah');
      expect(verses, isNotEmpty);
      for (var verse in verses) {
        expect(verse.surahName, 'Al-Fatihah');
      }
    });

    test('Has correct statistics', () {
      expect(service.totalVerses, greaterThan(0));
      expect(service.totalHadiths, greaterThan(0));
    });
  });

  group('AI Response Service Tests', () {
    late AIResponseService service;

    setUp(() {
      service = AIResponseService();
    });

    test('Generates response for greeting', () async {
      final response = await service.generateResponse('hello');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
      expect(response.isUser, false);
    });

    test('Generates response with references for Allah query', () async {
      final response = await service.generateResponse('tell me about Allah');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
      expect(response.references, isNotNull);
    });

    test('Generates response for prayer query', () async {
      final response = await service.generateResponse('what is prayer?');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
    });

    test('Generates response for mercy query', () async {
      final response = await service.generateResponse('tell me about mercy');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
      expect(response.references, isNotNull);
    });

    test('Generates response for knowledge query', () async {
      final response = await service.generateResponse('seeking knowledge');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
    });

    test('Generates response for patience query', () async {
      final response = await service.generateResponse('patience');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
    });

    test('Generates response for charity query', () async {
      final response = await service.generateResponse('charity');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
    });

    test('Response has timestamp', () async {
      final response = await service.generateResponse('test');
      expect(response.timestamp, isNotNull);
    });

    test('Response has unique ID', () async {
      final response1 = await service.generateResponse('test1');
      final response2 = await service.generateResponse('test2');
      expect(response1.id, isNot(equals(response2.id)));
    });

    test('Handles unknown queries gracefully', () async {
      final response = await service.generateResponse('xyzabc123unknown');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
      expect(response.text, contains('knowledge base'));
    });
  });
}
