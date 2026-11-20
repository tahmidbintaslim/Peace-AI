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

/// A stored text returned by the search API (api/search.mjs), shown word for
/// word with its reference. Any text field can be null when the source has
/// no such translation; [grade] is null when the source gives no grade.
class SearchMatch {
  final String kind; // "quran" or "hadith"
  final String reference;
  final String? url;
  final String? arabic;
  final String? english;
  final String? bengali;
  final String? grade;

  const SearchMatch({
    required this.kind,
    required this.reference,
    this.url,
    this.arabic,
    this.english,
    this.bengali,
    this.grade,
  });

  bool get isHadith => kind == 'hadith';

  factory SearchMatch.fromJson(Map<String, dynamic> json) => SearchMatch(
        kind: json['kind'] as String,
        reference: json['reference'] as String,
        url: json['url'] as String?,
        arabic: json['arabic'] as String?,
        english: json['english'] as String?,
        bengali: json['bengali'] as String?,
        grade: json['grade'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'reference': reference,
        'url': url,
        'arabic': arabic,
        'english': english,
        'bengali': bengali,
        'grade': grade,
      };
}
