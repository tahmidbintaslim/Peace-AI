import '../models/islamic_content.dart';

class IslamicKnowledgeService {
  // Sample Quran verses - In production, this would come from a database or API
  final List<QuranVerse> _quranVerses = [
    QuranVerse(
      surah: 1,
      verse: 1,
      arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      translation: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
      surahName: 'Al-Fatihah',
    ),
    QuranVerse(
      surah: 2,
      verse: 255,
      arabicText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
      translation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence.',
      surahName: 'Al-Baqarah',
    ),
    QuranVerse(
      surah: 112,
      verse: 1,
      arabicText: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
      translation: 'Say, He is Allah, [who is] One.',
      surahName: 'Al-Ikhlas',
    ),
    QuranVerse(
      surah: 3,
      verse: 159,
      arabicText: 'وَشَاوِرْهُمْ فِي الْأَمْرِ',
      translation: 'And consult them in the matter.',
      surahName: 'Ali Imran',
    ),
    QuranVerse(
      surah: 49,
      verse: 13,
      arabicText: 'إِنَّ أَكْرَمَكُمْ عِندَ اللَّهِ أَتْقَاكُمْ',
      translation: 'Indeed, the most noble of you in the sight of Allah is the most righteous of you.',
      surahName: 'Al-Hujurat',
    ),
  ];

  // Sample Hadiths - In production, this would come from a database or API
  final List<Hadith> _hadiths = [
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '2',
      hadithNumber: '47',
      arabicText: 'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ',
      translation: 'The Muslim is the one from whose tongue and hand the Muslims are safe.',
      narrator: 'Abdullah bin Amr',
    ),
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '1',
      hadithNumber: '1',
      arabicText: 'إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ',
      translation: 'Verily, actions are by intentions.',
      narrator: 'Umar bin Al-Khattab',
    ),
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '78',
      hadithNumber: '651',
      arabicText: 'ارْحَمُوا تُرْحَمُوا',
      translation: 'Show mercy to others and you will receive mercy.',
      narrator: 'Abdullah bin Amr',
    ),
  ];

  List<QuranVerse> searchQuran(String query) {
    final lowerQuery = query.toLowerCase();
    return _quranVerses.where((verse) {
      return verse.translation.toLowerCase().contains(lowerQuery) ||
          verse.surahName.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Hadith> searchHadith(String query) {
    final lowerQuery = query.toLowerCase();
    return _hadiths.where((hadith) {
      return hadith.translation.toLowerCase().contains(lowerQuery) ||
          hadith.narrator.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  QuranVerse? getRandomVerse() {
    if (_quranVerses.isEmpty) return null;
    return _quranVerses[DateTime.now().millisecondsSinceEpoch % _quranVerses.length];
  }

  Hadith? getRandomHadith() {
    if (_hadiths.isEmpty) return null;
    return _hadiths[DateTime.now().millisecondsSinceEpoch % _hadiths.length];
  }
}
