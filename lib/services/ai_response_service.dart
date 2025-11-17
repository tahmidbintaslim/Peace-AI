import '../models/message.dart';
import '../models/islamic_content.dart';
import 'islamic_knowledge_service.dart';

class AIResponseService {
  final IslamicKnowledgeService _knowledgeService = IslamicKnowledgeService();

  Future<Message> generateResponse(String userQuery) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(milliseconds: 500));

    final lowerQuery = userQuery.toLowerCase();
    String responseText = '';
    List<String> references = [];

    // Analyze user query and provide appropriate response
    if (_containsAny(lowerQuery, ['peace', 'salam', 'salaam', 'greeting'])) {
      responseText = 'Assalamu Alaikum! Peace be upon you. How can I help you learn about Islam today?';
    } else if (_containsAny(lowerQuery, ['allah', 'god', 'creator'])) {
      final verse = _knowledgeService.searchQuran('allah').isNotEmpty
          ? _knowledgeService.searchQuran('allah').first
          : _knowledgeService.getRandomVerse();
      if (verse != null) {
        responseText = 'Allah is the One True God, the Creator of all things. Here\'s what the Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
    } else if (_containsAny(lowerQuery, ['prayer', 'salah', 'namaz', 'pray'])) {
      responseText = 'Prayer (Salah) is one of the Five Pillars of Islam. It is the direct connection between a believer and Allah. '
          'Muslims pray five times daily: Fajr (dawn), Dhuhr (noon), Asr (afternoon), Maghrib (sunset), and Isha (night).';
      final hadith = _knowledgeService.searchHadith('prayer').isNotEmpty
          ? _knowledgeService.searchHadith('prayer').first
          : _knowledgeService.getRandomHadith();
      if (hadith != null) {
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['mercy', 'merciful', 'compassion', 'kind'])) {
      final verses = _knowledgeService.searchQuran('merciful');
      if (verses.isNotEmpty) {
        final verse = verses.first;
        responseText = 'Allah is the Most Merciful and Compassionate. The Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
      final hadiths = _knowledgeService.searchHadith('mercy');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText += '\n\nThe Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['help', 'guidance', 'advice', 'what', 'how'])) {
      final verse = _knowledgeService.getRandomVerse();
      final hadith = _knowledgeService.getRandomHadith();
      
      responseText = 'I am Peace AI, designed to help you learn about Islam through the Quran and Hadith. '
          'You can ask me about:\n\n'
          '• Allah and His attributes\n'
          '• Prayer and worship\n'
          '• Mercy and compassion\n'
          '• Islamic teachings and values\n\n'
          'Here\'s a verse from the Quran:\n\n';
      
      if (verse != null) {
        responseText += '${verse.arabicText}\n\n${verse.translation}';
        references.add(verse.reference);
      }
    } else {
      // General search in both Quran and Hadith
      final quranResults = _knowledgeService.searchQuran(userQuery);
      final hadithResults = _knowledgeService.searchHadith(userQuery);

      if (quranResults.isNotEmpty) {
        final verse = quranResults.first;
        responseText = 'I found this in the Quran:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      } else if (hadithResults.isNotEmpty) {
        final hadith = hadithResults.first;
        responseText = 'I found this Hadith:\n\n'
            '${hadith.translation}\n\n'
            'Narrated by: ${hadith.narrator}';
        references.add(hadith.reference);
      } else {
        responseText = 'I understand you\'re asking about "$userQuery". While I don\'t have specific information '
            'about that in my current knowledge base, I encourage you to explore the Quran and authentic Hadith collections. '
            'You can also rephrase your question or ask about general Islamic topics like prayer, mercy, or Allah.';
      }
    }

    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: responseText,
      isUser: false,
      timestamp: DateTime.now(),
      references: references.isNotEmpty ? references : null,
    );
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }
}
