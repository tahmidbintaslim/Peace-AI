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
    if (_containsAny(lowerQuery, ['peace', 'salam', 'salaam', 'greeting', 'hello', 'hi'])) {
      responseText = 'Assalamu Alaikum! Peace be upon you. How can I help you learn about Islam today?';
    } else if (_containsAny(lowerQuery, ['allah', 'god', 'creator', 'lord'])) {
      final verse = _knowledgeService.searchQuran('allah').isNotEmpty
          ? _knowledgeService.searchQuran('allah').first
          : _knowledgeService.getRandomVerse();
      if (verse != null) {
        responseText = 'Allah is the One True God, the Creator of all things. Here\'s what the Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
    } else if (_containsAny(lowerQuery, ['prayer', 'salah', 'namaz', 'pray', 'worship'])) {
      responseText = 'Prayer (Salah) is one of the Five Pillars of Islam. It is the direct connection between a believer and Allah. '
          'Muslims pray five times daily: Fajr (dawn), Dhuhr (noon), Asr (afternoon), Maghrib (sunset), and Isha (night).\n\n';
      final hadith = _knowledgeService.searchHadith('prayer').isNotEmpty
          ? _knowledgeService.searchHadith('prayer').first
          : _knowledgeService.getRandomHadith();
      if (hadith != null) {
        responseText += 'The Prophet Muhammad (peace be upon him) said:\n\n${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['mercy', 'merciful', 'compassion', 'kind', 'kindness', 'forgiveness', 'forgive'])) {
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
    } else if (_containsAny(lowerQuery, ['knowledge', 'learn', 'learning', 'study', 'education'])) {
      final hadiths = _knowledgeService.searchHadith('knowledge');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText = 'Seeking knowledge is highly valued in Islam. The Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}\n\n'
            'Islam encourages continuous learning and understanding.';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['patience', 'patient', 'perseverance', 'sabr', 'endure', 'hardship', 'difficulty'])) {
      final verses = _knowledgeService.searchQuran('patience');
      if (verses.isNotEmpty) {
        final verse = verses.first;
        responseText = 'Patience is a core virtue in Islam. The Quran teaches:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
      final hadiths = _knowledgeService.searchHadith('patient');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText += '\n\nThe Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['charity', 'give', 'giving', 'sadaqah', 'zakat', 'help others'])) {
      final hadiths = _knowledgeService.searchHadith('charity');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText = 'Charity and helping others are fundamental in Islam. The Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}\n\n'
            'Even simple acts of kindness count as charity.';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['character', 'behavior', 'conduct', 'manners', 'akhlaq', 'ethics'])) {
      final hadiths = _knowledgeService.searchHadith('character');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText = 'Good character is essential in Islam. The Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}\n\n'
            'Islam emphasizes treating others with respect, honesty, and kindness.';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['brother', 'sister', 'unity', 'brotherhood', 'sisterhood', 'community', 'ummah'])) {
      final hadiths = _knowledgeService.searchHadith('brother');
      final verses = _knowledgeService.searchQuran('brothers');
      if (verses.isNotEmpty) {
        final verse = verses.first;
        responseText = 'Unity and brotherhood are emphasized in Islam. The Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText += '\n\nThe Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['truth', 'honesty', 'honest', 'truthful', 'sincere'])) {
      final hadiths = _knowledgeService.searchHadith('truth');
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText = 'Honesty and truthfulness are core Islamic values. The Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['parent', 'parents', 'mother', 'father', 'family'])) {
      final hadiths = _knowledgeService.searchHadith('parent');
      final verses = _knowledgeService.searchQuran('parent');
      if (verses.isNotEmpty) {
        final verse = verses.first;
        responseText = 'Respecting and honoring parents is a major teaching in Islam. The Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
      if (hadiths.isNotEmpty && hadiths.first.translation.toLowerCase().contains('parent')) {
        final hadith = hadiths.first;
        responseText += '\n\nThe Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['remember', 'remembrance', 'dhikr', 'zikr', 'glorify'])) {
      final hadiths = _knowledgeService.searchHadith('remember');
      final verses = _knowledgeService.searchQuran('remembrance');
      if (verses.isNotEmpty) {
        final verse = verses.first;
        responseText = 'Remembering Allah brings peace to the heart. The Quran says:\n\n'
            '${verse.arabicText}\n\n'
            '${verse.translation}';
        references.add(verse.reference);
      }
      if (hadiths.isNotEmpty) {
        final hadith = hadiths.first;
        responseText += '\n\nThe Prophet Muhammad (peace be upon him) said:\n\n'
            '${hadith.translation}';
        references.add(hadith.reference);
      }
    } else if (_containsAny(lowerQuery, ['help', 'guidance', 'advice', 'what', 'how'])) {
      final verse = _knowledgeService.getRandomVerse();
      
      responseText = 'I am Peace AI, designed to help you learn about Islam through the Quran and Hadith. '
          'You can ask me about:\n\n'
          '• Allah and His attributes\n'
          '• Prayer and worship\n'
          '• Mercy and compassion\n'
          '• Knowledge and learning\n'
          '• Patience and gratitude\n'
          '• Charity and kindness\n'
          '• Good character and ethics\n'
          '• Family and community\n\n'
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
        
        // Add more results if available
        if (quranResults.length > 1) {
          responseText += '\n\n(I found ${quranResults.length} verses related to your query. Try asking more specifically for additional verses.)';
        }
      } else if (hadithResults.isNotEmpty) {
        final hadith = hadithResults.first;
        responseText = 'I found this Hadith:\n\n'
            '${hadith.translation}\n\n'
            'Narrated by: ${hadith.narrator}';
        references.add(hadith.reference);
        
        // Add more results if available
        if (hadithResults.length > 1) {
          responseText += '\n\n(I found ${hadithResults.length} hadiths related to your query.)';
        }
      } else {
        responseText = 'I understand you\'re asking about "$userQuery". While I don\'t have specific information '
            'about that in my current knowledge base, I encourage you to explore the Quran and authentic Hadith collections. '
            '\n\nYou can ask about topics like:\n'
            '• Prayer and worship\n'
            '• Patience and gratitude\n'
            '• Knowledge and learning\n'
            '• Good character and manners\n'
            '• Family and community\n';
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
