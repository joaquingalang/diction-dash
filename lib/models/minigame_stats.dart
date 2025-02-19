import 'package:cloud_firestore/cloud_firestore.dart';

class SpellingStats {

  // Constructor
  const SpellingStats({
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100,
  });

  // Attributes
  final int level;
  final int exp;
  final int maxExp;

  factory SpellingStats.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> statData = snapshot.data() as Map<String, dynamic>;
    return SpellingStats(
      level: statData['level'],
      exp: statData['exp'],
      maxExp: statData['max_exp'],
    );
  }
}

class VocabularyStats {

  // Constructor
  const VocabularyStats({
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100,
  });

  // Attributes
  final int level;
  final int exp;
  final int maxExp;

  factory VocabularyStats.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> statData = snapshot.data() as Map<String, dynamic>;
    return VocabularyStats(
      level: statData['level'],
      exp: statData['exp'],
      maxExp: statData['max_exp'],
    );
  }
}

class GrammarStats {

  // Constructor
  const GrammarStats({
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100,
  });

  // Attributes
  final int level;
  final int exp;
  final int maxExp;

  factory GrammarStats.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> statData = snapshot.data() as Map<String, dynamic>;
    return GrammarStats(
      level: statData['level'],
      exp: statData['exp'],
      maxExp: statData['max_exp'],
    );
  }
}

class ComprehensionStats {

  // Constructor
  const ComprehensionStats({
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100,
  });

  // Attributes
  final int level;
  final int exp;
  final int maxExp;

  factory ComprehensionStats.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> statData = snapshot.data() as Map<String, dynamic>;
    return ComprehensionStats(
      level: statData['level'],
      exp: statData['exp'],
      maxExp: statData['max_exp'],
    );
  }
}

