import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peace_ai/screens/settings_screen.dart';
import 'package:peace_ai/services/share_service.dart';
import 'package:peace_ai/services/theme_service.dart';
import 'package:peace_ai/widgets/message_bubble.dart';
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

    test('Message with search matches survives a JSON round trip', () {
      final message = Message(
        id: '1',
        text: 'Reply',
        isUser: false,
        timestamp: DateTime(2025),
        matches: const [
          SearchMatch(
            kind: 'hadith',
            reference: 'Sahih al-Bukhari, book 1, hadith 1',
            english: 'Actions are by intentions.',
          ),
        ],
      );
      final back = Message.fromJson(
        jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>,
      );
      expect(back.matches!.single.reference, message.matches!.single.reference);
      expect(back.matches!.single.grade, isNull);
      expect(back.matches!.single.bengali, isNull);
    });

    test('Message with references can be serialized', () {
      final message = Message(
        id: '1',
        text: 'Test message',
        isUser: false,
        timestamp: DateTime.now(),
        references: ['Al-Fatihah 1:1', 'Sahih Bukhari 10'],
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

    test('Hadith without a book number uses sunnah.com numbering', () {
      final hadith = Hadith(
        collection: 'Sahih Muslim',
        bookNumber: '',
        hadithNumber: '2553a',
        arabicText: '',
        translation: 'Translation',
        narrator: 'An-Nawwas',
      );
      expect(hadith.reference, 'Sahih Muslim 2553a');
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
      expect(service.totalVerses, service.getAllVerses().length);
      expect(service.totalHadiths, service.getAllHadiths().length);
      final collections = service.hadithCollections;
      expect(collections.values.reduce((a, b) => a + b), service.totalHadiths);
      expect(collections.keys, contains('Sahih Bukhari'));
    });

    test('Every reference resolves to its own text', () {
      for (final verse in service.getAllVerses()) {
        expect(service.findByReference(verse.reference), same(verse));
      }
      for (final hadith in service.getAllHadiths()) {
        expect(service.findByReference(hadith.reference), same(hadith));
      }
      expect(service.findByReference('No Such Book 1:1'), isNull);
    });

    test('Significant words drop stop words and match whole words', () {
      expect(
        IslamicKnowledgeService.significantWords('What does this say?'),
        isEmpty,
      );
      expect(
        IslamicKnowledgeService.significantWords('the rights of parents'),
        {'right', 'parent'},
      );
      expect(IslamicKnowledgeService.matchCount('hi', 'this thing'), 0);
    });

    test('Ranks by number of matching words', () {
      final verses = service.getAllVerses();
      // A question built from two words of one verse must rank it first.
      final target = verses.firstWhere(
        (v) =>
            IslamicKnowledgeService.significantWords(v.translation).length > 2,
      );
      final words = IslamicKnowledgeService.significantWords(
        target.translation,
      ).toList();
      final query = 'what about ${words[0]} and the ${words[1]} ${words[2]}';
      final ranked = service.rankQuran(query);
      expect(ranked, isNotEmpty);
      final top = IslamicKnowledgeService.matchCount(
        query,
        IslamicKnowledgeService.verseSearchText(ranked.first),
      );
      expect(top, 3);
      for (final verse in ranked) {
        final score = IslamicKnowledgeService.matchCount(
          query,
          IslamicKnowledgeService.verseSearchText(verse),
        );
        expect(score, inInclusiveRange(1, top));
      }
      expect(service.rankQuran('xyzabc123unknown'), isEmpty);
    });
  });

  group('AI Response Service Tests', () {
    late AIResponseService service;

    setUp(() {
      service = AIResponseService();
    });

    test('Free text shows the texts the search by meaning returns', () async {
      const verse = SearchMatch(
        kind: 'quran',
        reference: 'Al-Baqarah 2:286',
        arabic: 'لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
        english: 'Allah does not burden a soul beyond that it can bear.',
        bengali: 'আল্লাহ কাউকে তার সাধ্যের বাইরে দায়িত্ব দেন না।',
      );
      final meaning = AIResponseService(meaningSearch: (_) async => [verse]);
      final response = await meaning.generateResponse('আমি খুব দুঃখে আছি');
      expect(response.matches, [verse]);
      expect(response.references, isNull);
      expect(response.text, contains('not a ruling'));
    });

    test('Topics keep their fixed answer without calling the search', () async {
      var called = false;
      final meaning = AIResponseService(meaningSearch: (_) async {
        called = true;
        return const [];
      });
      final response = await meaning.generateResponse('tell me about mercy');
      expect(called, isFalse);
      expect(response.references, isNotNull);
    });

    test('Falls back to word matching when search by meaning finds nothing',
        () async {
      final meaning = AIResponseService(meaningSearch: (_) async => const []);
      final response = await meaning.generateResponse('forgiveness of sins');
      expect(response.text, isNot(contains('not a ruling')));
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

    test('Greeting needs a whole word, not "hi" inside "this"', () async {
      final greeting = await service.generateResponse('Hi there');
      expect(greeting.text, contains('Assalamu Alaikum'));

      final other = await service.generateResponse('this xyzabc123unknown');
      expect(other.text, isNot(contains('Assalamu Alaikum')));
    });

    test('Multi-word question finds a text by its words', () async {
      final hadith = IslamicKnowledgeService().getAllHadiths().firstWhere(
            (h) => h.translation.contains('laugh little and weep much'),
          );
      final response = await service.generateResponse(
        'Why would we laugh little and weep?',
      );
      expect(response.references, contains(hadith.reference));
    });

    test('Every reference in a reply resolves in the dataset', () async {
      final response = await service.generateResponse('tell me about mercy');
      final knowledge = IslamicKnowledgeService();
      for (final reference in response.references!) {
        expect(knowledge.findByReference(reference), isNotNull);
      }
    });

    test('Handles unknown queries gracefully', () async {
      final response = await service.generateResponse('xyzabc123unknown');
      expect(response, isNotNull);
      expect(response.text, isNotEmpty);
      expect(response.text, contains('Nothing in the built-in texts'));
      expect(response.references, isNull);
    });
  });

  group('Theme Service Tests', () {
    test('Saves the chosen theme and loads it again', () async {
      SharedPreferences.setMockInitialValues({});
      await ThemeService.load();
      expect(ThemeService.mode.value, ThemeMode.system);

      await ThemeService.setMode(ThemeMode.dark);
      expect(ThemeService.mode.value, ThemeMode.dark);

      ThemeService.mode.value = ThemeMode.system;
      await ThemeService.load();
      expect(ThemeService.mode.value, ThemeMode.dark);
    });
  });

  group('Source display Tests', () {
    final verse = IslamicKnowledgeService().getVerse(1, 1)!;
    final message = Message(
      id: 'm1',
      text: 'Explanation',
      isUser: false,
      timestamp: DateTime(2025),
      references: [verse.reference, 'Unknown Book 9:9'],
    );

    test('Shared text carries the verse and its reference', () {
      final text = ShareService.formatMessage(message);
      expect(text, contains(verse.arabicText));
      expect(text, contains(verse.translation));
      expect(text, contains('(${verse.reference})'));
      expect(text, contains('(Unknown Book 9:9)'));
    });

    testWidgets('Reply shows the verse with its reference', (tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: MessageBubble(message: message)),
          ),
        ),
      );
      expect(find.textContaining(verse.reference), findsOneWidget);
      expect(find.text(verse.translation), findsOneWidget);
      // A reference missing from the dataset is still shown.
      expect(find.textContaining('Unknown Book 9:9'), findsOneWidget);
    });

    const hadith = SearchMatch(
      kind: 'hadith',
      reference: 'Sahih al-Bukhari, book 1, hadith 1',
      arabic: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
      english: 'Actions are by intentions.',
      bengali: 'কাজ নিয়ত অনুযায়ী।',
    );
    final searched = Message(
      id: 'm2',
      text: 'Closest in meaning. This is a search result, not a ruling.',
      isUser: false,
      timestamp: DateTime(2025),
      matches: const [hadith],
    );

    testWidgets('Reply shows search texts with reference and missing grade',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: MessageBubble(message: searched),
            ),
          ),
        ),
      );
      expect(find.textContaining(hadith.reference), findsOneWidget);
      expect(find.text(hadith.arabic!), findsOneWidget);
      expect(find.text(hadith.bengali!), findsOneWidget);
      expect(find.text(hadith.english!), findsOneWidget);
      expect(find.text('Grade: not stated in the source'), findsOneWidget);
      expect(find.textContaining('not a ruling'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    test('Shared text carries the search texts and reference', () {
      final text = ShareService.formatMessage(searched);
      expect(text, contains(hadith.bengali));
      expect(text, contains('(${hadith.reference})'));
      expect(text, contains('Grade: not stated in the source'));
    });

    testWidgets('Statistics are counted from the dataset', (tester) async {
      final knowledge = IslamicKnowledgeService();
      await tester.pumpWidget(const MaterialApp(home: StatisticsScreen()));
      expect(find.text('${knowledge.totalVerses}'), findsOneWidget);
      expect(find.text('${knowledge.totalHadiths}'), findsOneWidget);
      expect(find.text('50+'), findsNothing);
    });

    test('Notice says where answers come from', () {
      final notice = sourceNotice(IslamicKnowledgeService());
      expect(notice, contains('46 Quran verses and 19 hadiths'));
      expect(notice, contains('not been reviewed by a scholar'));
      expect(notice, contains('For a ruling, ask a scholar'));
    });
  });
}
