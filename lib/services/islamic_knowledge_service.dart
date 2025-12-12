import '../models/islamic_content.dart';

class IslamicKnowledgeService {
  // Sample Quran verses - In production, this would come from a database or API
  final List<QuranVerse> _quranVerses = [
    // Al-Fatihah (The Opening)
    QuranVerse(
      surah: 1,
      verse: 1,
      arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      translation:
          'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
      surahName: 'Al-Fatihah',
    ),
    QuranVerse(
      surah: 1,
      verse: 2,
      arabicText: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
      translation: 'All praise is due to Allah, Lord of the worlds.',
      surahName: 'Al-Fatihah',
    ),
    QuranVerse(
      surah: 1,
      verse: 5,
      arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
      translation: 'It is You we worship and You we ask for help.',
      surahName: 'Al-Fatihah',
    ),
    QuranVerse(
      surah: 1,
      verse: 6,
      arabicText: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      translation: 'Guide us to the straight path.',
      surahName: 'Al-Fatihah',
    ),

    // Al-Baqarah (The Cow)
    QuranVerse(
      surah: 2,
      verse: 255,
      arabicText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
      translation:
          'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence.',
      surahName: 'Al-Baqarah',
    ),
    QuranVerse(
      surah: 2,
      verse: 286,
      arabicText: 'لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
      translation: 'Allah does not burden a soul beyond that it can bear.',
      surahName: 'Al-Baqarah',
    ),
    QuranVerse(
      surah: 2,
      verse: 153,
      arabicText:
          'يَا أَيُّهَا الَّذِينَ آمَنُوا اسْتَعِينُوا بِالصَّبْرِ وَالصَّلَاةِ',
      translation:
          'O you who have believed, seek help through patience and prayer.',
      surahName: 'Al-Baqarah',
    ),
    QuranVerse(
      surah: 2,
      verse: 186,
      arabicText: 'وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ',
      translation:
          'And when My servants ask you concerning Me - indeed I am near.',
      surahName: 'Al-Baqarah',
    ),
    QuranVerse(
      surah: 2,
      verse: 216,
      arabicText: 'وَعَسَىٰ أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ',
      translation:
          'Perhaps you dislike a thing and it is good for you; and perhaps you love a thing and it is bad for you. And Allah knows, while you know not.',
      surahName: 'Al-Baqarah',
    ),

    // Ali Imran (Family of Imran)
    QuranVerse(
      surah: 3,
      verse: 159,
      arabicText: 'وَشَاوِرْهُمْ فِي الْأَمْرِ',
      translation: 'And consult them in the matter.',
      surahName: 'Ali Imran',
    ),
    QuranVerse(
      surah: 3,
      verse: 173,
      arabicText: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      translation:
          'Sufficient for us is Allah, and He is the best Disposer of affairs.',
      surahName: 'Ali Imran',
    ),
    QuranVerse(
      surah: 3,
      verse: 200,
      arabicText: 'يَا أَيُّهَا الَّذِينَ آمَنُوا اصْبِرُوا وَصَابِرُوا',
      translation: 'O you who have believed, persevere and endure.',
      surahName: 'Ali Imran',
    ),

    // An-Nisa (The Women)
    QuranVerse(
      surah: 4,
      verse: 58,
      arabicText:
          'إِنَّ اللَّهَ يَأْمُرُكُمْ أَن تُؤَدُّوا الْأَمَانَاتِ إِلَىٰ أَهْلِهَا',
      translation:
          'Indeed, Allah commands you to render trusts to whom they are due.',
      surahName: 'An-Nisa',
    ),
    QuranVerse(
      surah: 4,
      verse: 135,
      arabicText:
          'يَا أَيُّهَا الَّذِينَ آمَنُوا كُونُوا قَوَّامِينَ بِالْقِسْطِ',
      translation:
          'O you who have believed, be persistently standing firm in justice.',
      surahName: 'An-Nisa',
    ),

    // Al-Ma'idah (The Table Spread)
    QuranVerse(
      surah: 5,
      verse: 2,
      arabicText: 'وَتَعَاوَنُوا عَلَى الْبِرِّ وَالتَّقْوَىٰ',
      translation: 'And cooperate in righteousness and piety.',
      surahName: 'Al-Ma\'idah',
    ),
    QuranVerse(
      surah: 5,
      verse: 32,
      arabicText:
          'مَن قَتَلَ نَفْسًا بِغَيْرِ نَفْسٍ أَوْ فَسَادٍ فِي الْأَرْضِ فَكَأَنَّمَا قَتَلَ النَّاسَ جَمِيعًا',
      translation:
          'Whoever kills a soul, it is as if he had slain mankind entirely.',
      surahName: 'Al-Ma\'idah',
    ),

    // Ar-Ra'd (The Thunder)
    QuranVerse(
      surah: 13,
      verse: 28,
      arabicText: 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
      translation: 'Verily, in the remembrance of Allah do hearts find rest.',
      surahName: 'Ar-Ra\'d',
    ),

    // An-Nahl (The Bee)
    QuranVerse(
      surah: 16,
      verse: 90,
      arabicText: 'إِنَّ اللَّهَ يَأْمُرُ بِالْعَدْلِ وَالْإِحْسَانِ',
      translation: 'Indeed, Allah orders justice and good conduct.',
      surahName: 'An-Nahl',
    ),
    QuranVerse(
      surah: 16,
      verse: 97,
      arabicText:
          'مَنْ عَمِلَ صَالِحًا مِّن ذَكَرٍ أَوْ أُنثَىٰ وَهُوَ مُؤْمِنٌ فَلَنُحْيِيَنَّهُ حَيَاةً طَيِّبَةً',
      translation:
          'Whoever does righteousness, whether male or female, while he is a believer - We will surely cause him to live a good life.',
      surahName: 'An-Nahl',
    ),

    // Al-Isra (The Night Journey)
    QuranVerse(
      surah: 17,
      verse: 23,
      arabicText:
          'وَقَضَىٰ رَبُّكَ أَلَّا تَعْبُدُوا إِلَّا إِيَّاهُ وَبِالْوَالِدَيْنِ إِحْسَانًا',
      translation:
          'And your Lord has decreed that you not worship except Him, and to parents, good treatment.',
      surahName: 'Al-Isra',
    ),
    QuranVerse(
      surah: 17,
      verse: 36,
      arabicText: 'وَلَا تَقْفُ مَا لَيْسَ لَكَ بِهِ عِلْمٌ',
      translation: 'And do not pursue that of which you have no knowledge.',
      surahName: 'Al-Isra',
    ),

    // Al-Kahf (The Cave)
    QuranVerse(
      surah: 18,
      verse: 46,
      arabicText: 'الْمَالُ وَالْبَنُونَ زِينَةُ الْحَيَاةِ الدُّنْيَا',
      translation:
          'Wealth and children are the adornment of worldly life. But the enduring good deeds are better to your Lord.',
      surahName: 'Al-Kahf',
    ),

    // Al-Anbiya (The Prophets)
    QuranVerse(
      surah: 21,
      verse: 107,
      arabicText: 'وَمَا أَرْسَلْنَاكَ إِلَّا رَحْمَةً لِّلْعَالَمِينَ',
      translation:
          'And We have not sent you, [O Muhammad], except as a mercy to the worlds.',
      surahName: 'Al-Anbiya',
    ),

    // An-Nur (The Light)
    QuranVerse(
      surah: 24,
      verse: 35,
      arabicText: 'اللَّهُ نُورُ السَّمَاوَاتِ وَالْأَرْضِ',
      translation: 'Allah is the Light of the heavens and the earth.',
      surahName: 'An-Nur',
    ),

    // Al-Furqan (The Criterion)
    QuranVerse(
      surah: 25,
      verse: 63,
      arabicText:
          'وَعِبَادُ الرَّحْمَٰنِ الَّذِينَ يَمْشُونَ عَلَى الْأَرْضِ هَوْنًا',
      translation:
          'And the servants of the Most Merciful are those who walk upon the earth in humility.',
      surahName: 'Al-Furqan',
    ),

    // Luqman
    QuranVerse(
      surah: 31,
      verse: 18,
      arabicText:
          'وَلَا تُصَعِّرْ خَدَّكَ لِلنَّاسِ وَلَا تَمْشِ فِي الْأَرْضِ مَرَحًا',
      translation:
          'And do not turn your cheek in contempt toward people and do not walk through the earth exultantly.',
      surahName: 'Luqman',
    ),

    // Al-Ahzab (The Combined Forces)
    QuranVerse(
      surah: 33,
      verse: 35,
      arabicText: 'إِنَّ الْمُسْلِمِينَ وَالْمُسْلِمَاتِ',
      translation:
          'Indeed, the Muslim men and Muslim women, the believing men and believing women... Allah has prepared for them forgiveness and a great reward.',
      surahName: 'Al-Ahzab',
    ),

    // Fatir (Originator)
    QuranVerse(
      surah: 35,
      verse: 3,
      arabicText: 'يَا أَيُّهَا النَّاسُ اذْكُرُوا نِعْمَتَ اللَّهِ عَلَيْكُمْ',
      translation: 'O mankind, remember the favor of Allah upon you.',
      surahName: 'Fatir',
    ),

    // Az-Zumar (The Troops)
    QuranVerse(
      surah: 39,
      verse: 53,
      arabicText:
          'قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ',
      translation:
          'Say, O My servants who have transgressed against themselves, do not despair of the mercy of Allah.',
      surahName: 'Az-Zumar',
    ),

    // Ash-Shura (The Consultation)
    QuranVerse(
      surah: 42,
      verse: 38,
      arabicText: 'وَأَمْرُهُمْ شُورَىٰ بَيْنَهُمْ',
      translation:
          'And whose affair is conducted by mutual consultation among them.',
      surahName: 'Ash-Shura',
    ),

    // Al-Hujurat (The Rooms)
    QuranVerse(
      surah: 49,
      verse: 10,
      arabicText: 'إِنَّمَا الْمُؤْمِنُونَ إِخْوَةٌ',
      translation: 'The believers are but brothers.',
      surahName: 'Al-Hujurat',
    ),
    QuranVerse(
      surah: 49,
      verse: 13,
      arabicText: 'إِنَّ أَكْرَمَكُمْ عِندَ اللَّهِ أَتْقَاكُمْ',
      translation:
          'Indeed, the most noble of you in the sight of Allah is the most righteous of you.',
      surahName: 'Al-Hujurat',
    ),

    // Adh-Dhariyat (The Winnowing Winds)
    QuranVerse(
      surah: 51,
      verse: 56,
      arabicText: 'وَمَا خَلَقْتُ الْجِنَّ وَالْإِنسَ إِلَّا لِيَعْبُدُونِ',
      translation:
          'And I did not create the jinn and mankind except to worship Me.',
      surahName: 'Adh-Dhariyat',
    ),

    // Ar-Rahman (The Beneficent)
    QuranVerse(
      surah: 55,
      verse: 13,
      arabicText: 'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ',
      translation: 'So which of the favors of your Lord would you deny?',
      surahName: 'Ar-Rahman',
    ),

    // Al-Mulk (The Sovereignty)
    QuranVerse(
      surah: 67,
      verse: 2,
      arabicText:
          'الَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا',
      translation:
          'He who created death and life to test you as to which of you is best in deed.',
      surahName: 'Al-Mulk',
    ),

    // Al-Insan (The Man)
    QuranVerse(
      surah: 76,
      verse: 3,
      arabicText:
          'إِنَّا هَدَيْنَاهُ السَّبِيلَ إِمَّا شَاكِرًا وَإِمَّا كَفُورًا',
      translation:
          'Indeed, We guided him to the way, be he grateful or ungrateful.',
      surahName: 'Al-Insan',
    ),

    // Al-A'la (The Most High)
    QuranVerse(
      surah: 87,
      verse: 14,
      arabicText: 'قَدْ أَفْلَحَ مَن تَزَكَّىٰ',
      translation: 'He has certainly succeeded who purifies himself.',
      surahName: 'Al-A\'la',
    ),

    // Al-Balad (The City)
    QuranVerse(
      surah: 90,
      verse: 17,
      arabicText:
          'ثُمَّ كَانَ مِنَ الَّذِينَ آمَنُوا وَتَوَاصَوْا بِالصَّبْرِ وَتَوَاصَوْا بِالْمَرْحَمَةِ',
      translation:
          'And then being among those who believed and advised one another to patience and advised one another to compassion.',
      surahName: 'Al-Balad',
    ),

    // Ash-Sharh (The Relief)
    QuranVerse(
      surah: 94,
      verse: 5,
      arabicText: 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
      translation: 'For indeed, with hardship will be ease.',
      surahName: 'Ash-Sharh',
    ),
    QuranVerse(
      surah: 94,
      verse: 6,
      arabicText: 'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
      translation: 'Indeed, with hardship will be ease.',
      surahName: 'Ash-Sharh',
    ),

    // Al-Asr (The Declining Day)
    QuranVerse(
      surah: 103,
      verse: 1,
      arabicText: 'وَالْعَصْرِ',
      translation: 'By time, indeed mankind is in loss.',
      surahName: 'Al-Asr',
    ),
    QuranVerse(
      surah: 103,
      verse: 3,
      arabicText:
          'إِلَّا الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ وَتَوَاصَوْا بِالْحَقِّ وَتَوَاصَوْا بِالصَّبْرِ',
      translation:
          'Except for those who have believed and done righteous deeds and advised each other to truth and advised each other to patience.',
      surahName: 'Al-Asr',
    ),

    // Al-Ikhlas (The Sincerity)
    QuranVerse(
      surah: 112,
      verse: 1,
      arabicText: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
      translation: 'Say, He is Allah, [who is] One.',
      surahName: 'Al-Ikhlas',
    ),
    QuranVerse(
      surah: 112,
      verse: 2,
      arabicText: 'اللَّهُ الصَّمَدُ',
      translation: 'Allah, the Eternal Refuge.',
      surahName: 'Al-Ikhlas',
    ),

    // Al-Falaq (The Daybreak)
    QuranVerse(
      surah: 113,
      verse: 1,
      arabicText: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ',
      translation: 'Say, I seek refuge in the Lord of daybreak.',
      surahName: 'Al-Falaq',
    ),

    // An-Nas (Mankind)
    QuranVerse(
      surah: 114,
      verse: 1,
      arabicText: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
      translation: 'Say, I seek refuge in the Lord of mankind.',
      surahName: 'An-Nas',
    ),
  ];

  // Sample Hadiths - In production, this would come from a database or API
  final List<Hadith> _hadiths = [
    // Faith and Intentions
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '1',
      hadithNumber: '1',
      arabicText: 'إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ',
      translation:
          'Verily, actions are by intentions, and every person will have what they intended.',
      narrator: 'Umar bin Al-Khattab',
    ),

    // Islamic Brotherhood
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '2',
      hadithNumber: '47',
      arabicText:
          'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ',
      translation:
          'The Muslim is the one from whose tongue and hand the Muslims are safe.',
      narrator: 'Abdullah bin Amr',
    ),
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '13',
      hadithNumber: '6011',
      arabicText:
          'لَا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لِأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ',
      translation:
          'None of you truly believes until he loves for his brother what he loves for himself.',
      narrator: 'Anas bin Malik',
    ),

    // Mercy and Compassion
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '78',
      hadithNumber: '651',
      arabicText: 'ارْحَمُوا تُرْحَمُوا',
      translation:
          'Show mercy to others and you will receive mercy. Forgive others and Allah will forgive you.',
      narrator: 'Abdullah bin Amr',
    ),
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '32',
      hadithNumber: '6373',
      arabicText: 'الرَّاحِمُونَ يَرْحَمُهُمُ الرَّحْمَنُ',
      translation:
          'The merciful will be shown mercy by the Most Merciful. Be merciful to those on earth and He who is in the heavens will have mercy upon you.',
      narrator: 'Abdullah bin Amr',
    ),

    // Knowledge and Learning
    Hadith(
      collection: 'Sunan Ibn Majah',
      bookNumber: '1',
      hadithNumber: '224',
      arabicText: 'طَلَبُ الْعِلْمِ فَرِيضَةٌ عَلَى كُلِّ مُسْلِمٍ',
      translation: 'Seeking knowledge is an obligation upon every Muslim.',
      narrator: 'Anas bin Malik',
    ),
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '35',
      hadithNumber: '6518',
      arabicText:
          'مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ',
      translation:
          'Whoever travels a path in search of knowledge, Allah will make easy for him a path to Paradise.',
      narrator: 'Abu Hurairah',
    ),

    // Good Character
    Hadith(
      collection: 'Sunan At-Tirmidhi',
      bookNumber: '27',
      hadithNumber: '2002',
      arabicText:
          'إِنَّ مِنْ أَحَبِّكُمْ إِلَيَّ وَأَقْرَبِكُمْ مِنِّي مَجْلِسًا يَوْمَ الْقِيَامَةِ أَحَاسِنَكُمْ أَخْلَاقًا',
      translation:
          'The most beloved of you to me and the nearest to me in the Hereafter are those with the best character.',
      narrator: 'Jabir bin Abdullah',
    ),
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '32',
      hadithNumber: '6354',
      arabicText: 'الْبِرُّ حُسْنُ الْخُلُقِ',
      translation: 'Righteousness is good character.',
      narrator: 'An-Nawwas bin Sam\'an',
    ),

    // Prayer
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '4',
      hadithNumber: '668',
      arabicText: 'الصَّلَاةُ نُورٌ',
      translation: 'Prayer is light.',
      narrator: 'Abu Malik Al-Ash\'ari',
    ),
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '8',
      hadithNumber: '505',
      arabicText:
          'أَرْأَيْتُمْ لَوْ أَنَّ نَهْرًا بِبَابِ أَحَدِكُمْ يَغْتَسِلُ فِيهِ كُلَّ يَوْمٍ خَمْسًا',
      translation:
          'If there was a river at the door of any one of you and he bathed in it five times a day, would any dirt remain on him? That is the example of the five prayers with which Allah wipes out sins.',
      narrator: 'Abu Hurairah',
    ),

    // Patience and Gratitude
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '42',
      hadithNumber: '7138',
      arabicText: 'عَجَبًا لِأَمْرِ الْمُؤْمِنِ إِنَّ أَمْرَهُ كُلَّهُ خَيْرٌ',
      translation:
          'How wonderful is the affair of the believer, for all his affairs are good. If something good happens to him, he is grateful, and if something bad happens, he is patient.',
      narrator: 'Suhaib',
    ),

    // Charity and Kindness
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '24',
      hadithNumber: '1433',
      arabicText: 'كُلُّ مَعْرُوفٍ صَدَقَةٌ',
      translation: 'Every good deed is charity.',
      narrator: 'Jabir bin Abdullah',
    ),
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '12',
      hadithNumber: '2586',
      arabicText: 'تَبَسُّمُكَ فِي وَجْهِ أَخِيكَ صَدَقَةٌ',
      translation: 'Your smile in the face of your brother is charity.',
      narrator: 'Abu Dharr',
    ),

    // Justice and Honesty
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '33',
      hadithNumber: '6541',
      arabicText:
          'عَلَيْكُمْ بِالصِّدْقِ فَإِنَّ الصِّدْقَ يَهْدِي إِلَى الْبِرِّ',
      translation:
          'Be truthful, for truthfulness leads to righteousness, and righteousness leads to Paradise.',
      narrator: 'Abdullah bin Mas\'ud',
    ),

    // Family and Parents
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '78',
      hadithNumber: '5971',
      arabicText: 'رِضَا الرَّبِّ فِي رِضَا الْوَالِدِ',
      translation:
          'The pleasure of the Lord is in the pleasure of the parent, and the displeasure of the Lord is in the displeasure of the parent.',
      narrator: 'Abdullah bin Amr',
    ),

    // Unity and Cooperation
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '32',
      hadithNumber: '6586',
      arabicText:
          'الْمُؤْمِنُ لِلْمُؤْمِنِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا',
      translation:
          'The believer to another believer is like a building whose different parts enforce each other.',
      narrator: 'Abu Musa',
    ),

    // Remembrance of Allah
    Hadith(
      collection: 'Sahih Bukhari',
      bookNumber: '75',
      hadithNumber: '6407',
      arabicText:
          'كَلِمَتَانِ خَفِيفَتَانِ عَلَى اللِّسَانِ ثَقِيلَتَانِ فِي الْمِيزَانِ',
      translation:
          'There are two words which are light on the tongue, heavy on the scales: SubhanAllah wa bihamdihi, SubhanAllah al-Azim (Glory be to Allah and praise Him, Glory be to Allah the Almighty).',
      narrator: 'Abu Hurairah',
    ),

    // Avoiding Sin
    Hadith(
      collection: 'Sahih Muslim',
      bookNumber: '33',
      hadithNumber: '6543',
      arabicText: 'إِيَّاكُمْ وَالظَّنَّ فَإِنَّ الظَّنَّ أَكْذَبُ الْحَدِيثِ',
      translation:
          'Beware of suspicion, for suspicion is the worst of false tales.',
      narrator: 'Abu Hurairah',
    ),

    // Hope and Fear
    Hadith(
      collection: 'Sunan At-Tirmidhi',
      bookNumber: '49',
      hadithNumber: '3540',
      arabicText:
          'لَوْ تَعْلَمُونَ مَا أَعْلَمُ لَضَحِكْتُمْ قَلِيلًا وَلَبَكَيْتُمْ كَثِيرًا',
      translation:
          'If you knew what I know, you would laugh little and weep much.',
      narrator: 'Abu Hurairah',
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
    return _quranVerses[DateTime.now().millisecondsSinceEpoch %
        _quranVerses.length];
  }

  Hadith? getRandomHadith() {
    if (_hadiths.isEmpty) return null;
    return _hadiths[DateTime.now().millisecondsSinceEpoch % _hadiths.length];
  }

  // Get all Quran verses
  List<QuranVerse> getAllVerses() {
    return List.unmodifiable(_quranVerses);
  }

  // Get all Hadiths
  List<Hadith> getAllHadiths() {
    return List.unmodifiable(_hadiths);
  }

  // Get verse by surah and verse number
  QuranVerse? getVerse(int surah, int verse) {
    try {
      return _quranVerses.firstWhere(
        (v) => v.surah == surah && v.verse == verse,
      );
    } catch (e) {
      return null;
    }
  }

  // Get verses by surah name
  List<QuranVerse> getVersesBySurah(String surahName) {
    return _quranVerses
        .where(
          (verse) => verse.surahName.toLowerCase() == surahName.toLowerCase(),
        )
        .toList();
  }

  // Get statistics
  int get totalVerses => _quranVerses.length;
  int get totalHadiths => _hadiths.length;

  // Get unique surah names
  List<String> getSurahNames() {
    final names = <String>{};
    for (var verse in _quranVerses) {
      names.add(verse.surahName);
    }
    return names.toList()..sort();
  }
}
