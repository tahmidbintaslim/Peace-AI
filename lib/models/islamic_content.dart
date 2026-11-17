class QuranVerse {
  final int surah;
  final int verse;
  final String arabicText;
  final String translation;
  final String surahName;

  QuranVerse({
    required this.surah,
    required this.verse,
    required this.arabicText,
    required this.translation,
    required this.surahName,
  });

  String get reference => '$surahName $surah:$verse';
}

class Hadith {
  final String collection;
  final String bookNumber;
  final String hadithNumber;
  final String arabicText;
  final String translation;
  final String narrator;

  Hadith({
    required this.collection,
    required this.bookNumber,
    required this.hadithNumber,
    required this.arabicText,
    required this.translation,
    required this.narrator,
  });

  /// sunnah.com numbering ("Sahih Muslim 2553a") when [bookNumber] is empty;
  /// the older book:hadith form otherwise.
  String get reference => bookNumber.isEmpty
      ? '$collection $hadithNumber'
      : '$collection $bookNumber:$hadithNumber';
}
