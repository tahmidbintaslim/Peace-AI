import '../models/message.dart';
import 'islamic_knowledge_service.dart';

/// One keyword rule: any of [keywords] as a whole word selects the topic.
class _Topic {
  final List<String> keywords;
  final String text;
  final String? verseQuery;
  final String? hadithQuery;

  const _Topic(this.keywords, this.text, {this.verseQuery, this.hadithQuery});
}

class AIResponseService {
  final IslamicKnowledgeService _knowledgeService = IslamicKnowledgeService();
  static int _replyCount = 0;

  static const List<String> _greetings = [
    'salam',
    'salaam',
    'assalamu',
    'hello',
    'hi',
  ];

  static const List<String> _helpWords = ['help', 'guidance', 'advice'];

  static const String _topicList = '• Allah and His attributes\n'
      '• Prayer and worship\n'
      '• Mercy and compassion\n'
      '• Knowledge and learning\n'
      '• Patience\n'
      '• Charity and kindness\n'
      '• Good character and honesty\n'
      '• Family and community\n'
      '• Remembrance of Allah';

  static const List<_Topic> _topics = [
    _Topic(
      ['allah', 'god', 'creator', 'lord'],
      'Allah is the One True God, the Creator of all things.',
      verseQuery: 'allah',
    ),
    _Topic(
      ['prayer', 'salah', 'namaz', 'pray', 'worship'],
      'Prayer (Salah) is one of the Five Pillars of Islam. Muslims pray five '
      'times daily: Fajr (dawn), Dhuhr (noon), Asr (afternoon), Maghrib '
      '(sunset), and Isha (night).',
      hadithQuery: 'prayer',
    ),
    _Topic(
      [
        'mercy',
        'merciful',
        'compassion',
        'kind',
        'kindness',
        'forgiveness',
        'forgive',
      ],
      'Allah is the Most Merciful and Compassionate.',
      verseQuery: 'merciful',
      hadithQuery: 'mercy',
    ),
    _Topic(
      ['knowledge', 'learn', 'learning', 'study', 'education'],
      'Seeking knowledge is highly valued in Islam.',
      hadithQuery: 'knowledge',
    ),
    _Topic(
      [
        'patience',
        'patient',
        'perseverance',
        'sabr',
        'endure',
        'hardship',
        'difficulty',
      ],
      'Patience is a core virtue in Islam.',
      verseQuery: 'patience',
      hadithQuery: 'patient',
    ),
    _Topic(
      ['charity', 'give', 'giving', 'sadaqah', 'zakat', 'help others'],
      'Charity and helping others are fundamental in Islam.',
      hadithQuery: 'charity',
    ),
    _Topic(
      ['character', 'behavior', 'conduct', 'manners', 'akhlaq', 'ethics'],
      'Good character is essential in Islam.',
      hadithQuery: 'character',
    ),
    _Topic(
      [
        'brother',
        'sister',
        'unity',
        'brotherhood',
        'sisterhood',
        'community',
        'ummah',
      ],
      'Unity and brotherhood are emphasized in Islam.',
      verseQuery: 'brothers',
      hadithQuery: 'brother',
    ),
    _Topic(
      ['truth', 'honesty', 'honest', 'truthful', 'sincere'],
      'Honesty and truthfulness are core Islamic values.',
      hadithQuery: 'truth',
    ),
    _Topic(
      ['parent', 'parents', 'mother', 'father', 'family'],
      'Respecting and honoring parents is a major teaching in Islam.',
      verseQuery: 'parent',
      hadithQuery: 'parent',
    ),
    _Topic(
      ['remember', 'remembrance', 'dhikr', 'zikr', 'glorify'],
      'Remembering Allah brings peace to the heart.',
      verseQuery: 'remembrance',
      hadithQuery: 'remember',
    ),
  ];

  /// Builds the reply to [userQuery]. The reply text is only the short
  /// explanation; the verse and hadith are carried as references and shown
  /// from the dataset, word for word.
  Future<Message> generateResponse(String userQuery) async {
    final words = IslamicKnowledgeService.wordsOf(userQuery);

    if (_hasAny(words, _greetings)) {
      return _reply(
        'Assalamu Alaikum! Peace be upon you. Ask a question or name a '
        'topic, and I will show a verse or hadith with its reference.',
      );
    }

    for (final topic in _topics) {
      if (!_hasAny(words, topic.keywords)) continue;
      final references = <String>[];
      if (topic.verseQuery != null) {
        final verses = _knowledgeService.searchQuran(topic.verseQuery!);
        if (verses.isNotEmpty) references.add(verses.first.reference);
      }
      if (topic.hadithQuery != null) {
        final hadiths = _knowledgeService.searchHadith(topic.hadithQuery!);
        if (hadiths.isNotEmpty) references.add(hadiths.first.reference);
      }
      if (references.isNotEmpty) return _reply(topic.text, references);
    }

    if (_hasAny(words, _helpWords)) {
      return _reply(
        'Ask in your own words or name a topic. Each answer is a Quran '
        'verse or a hadith from the built-in texts, shown with its '
        'reference. Topics with a fixed answer:\n\n$_topicList',
      );
    }

    // Free text: rank verses and hadiths by how many of the question's
    // significant words they contain, and show the best of each kind.
    final verses = _knowledgeService.rankQuran(userQuery);
    final hadiths = _knowledgeService.rankHadith(userQuery);
    final verseScore = verses.isEmpty
        ? 0
        : IslamicKnowledgeService.matchCount(
            userQuery,
            IslamicKnowledgeService.verseSearchText(verses.first),
          );
    final hadithScore = hadiths.isEmpty
        ? 0
        : IslamicKnowledgeService.matchCount(
            userQuery,
            IslamicKnowledgeService.hadithSearchText(hadiths.first),
          );
    final best = verseScore > hadithScore ? verseScore : hadithScore;
    if (best > 0) {
      final searched =
          IslamicKnowledgeService.significantWords(userQuery).join(', ');
      return _reply(
        'Closest match in the built-in texts for the words: $searched.',
        [
          if (verseScore == best) verses.first.reference,
          if (hadithScore == best) hadiths.first.reference,
        ],
      );
    }

    return _reply(
      'Nothing in the built-in texts matches "$userQuery". The app holds '
      'only ${_knowledgeService.totalVerses} verses and '
      '${_knowledgeService.totalHadiths} hadiths. Topics with a fixed '
      'answer:\n\n$_topicList',
    );
  }

  Message _reply(String text, [List<String> references = const []]) {
    final now = DateTime.now();
    return Message(
      // The counter keeps ids unique when two replies share a timestamp.
      id: '${now.microsecondsSinceEpoch}-${_replyCount++}',
      text: text,
      isUser: false,
      timestamp: now,
      references: references.isNotEmpty ? references : null,
    );
  }

  // True when any keyword occurs in [words] as whole words, so "hi" does
  // not match inside "this".
  bool _hasAny(List<String> words, List<String> keywords) {
    return keywords.any(
      (k) => IslamicKnowledgeService.wordsOf(k).every(words.contains),
    );
  }
}
