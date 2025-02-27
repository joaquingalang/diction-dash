import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'dart:io';

class QuestionBank {
  const QuestionBank({required this.fluency});

  final String fluency;

  // Get Ratio Based On Frequency
  Map<String, double> getDifficultyRatio() {
    Map<String, dynamic> difficultyRatios = {
      'BEGINNER': {
        'easy': 0.7,
        'medium': 0.3,
      },
      'ELEMENTARY': {
        'easy': 0.5,
        'medium': 0.4,
        'hard': 0.1,
      },
      'INTERMEDIATE': {
        'easy': 0.3,
        'medium': 0.5,
        'hard': 0.2,
      },
      'ADVANCED': {
        'easy': 0.1,
        'medium': 0.5,
        'hard': 0.4,
      },
      'EXPERT': {
        'medium': 0.4,
        'hard': 0.6,
      },
    };
    return difficultyRatios[fluency];
  }

  // Fetch 10 Spelling Questions Based on Fluency
  Future<List<Map<String, dynamic>>> getSpellingQuestions(int questions) async {
    // Get spelling question from JSON file
    String jsonString =
        await rootBundle.loadString('assets/questions/spelling_bank.json');
    Map<String, dynamic> spellingQuestions =
        jsonDecode(jsonString) as Map<String, dynamic>;

    // Get ratio based on fluency
    Map<String, double> difficultyRatio = getDifficultyRatio();

    // For each difficulty level generate number of questions and append it to a list
    List<Map<String, dynamic>> questionList = [];
    for (String difficulty in difficultyRatio.keys) {
      List difficultyQuestions = spellingQuestions[difficulty];
      double ratio = difficultyRatio[difficulty]!;
      int numOfQuestions = (questions * ratio).toInt();
      List<int> questionIndices = [];

      // Generate 10 unique integers
      while (questionIndices.length < numOfQuestions) {
        Random random = Random();
        int maxRange = difficultyQuestions.length;
        int questionIndex = random.nextInt(maxRange);
        if (!questionIndices.contains(questionIndex)) {
          questionIndices.add(questionIndex);
        }
      }

      // Generate corresponding questions from unique integers
      for (int questionIndex in questionIndices) {
        Map<String, dynamic> newQuestion = difficultyQuestions[questionIndex];
        questionList.add(newQuestion);
      }
    }

    // Shuffle question list
    questionList.shuffle();

    // Return question list
    return questionList;
  }

  // Fetch 10 Vocabulary Questions Based on Fluency
  Future<List<Map<String, dynamic>>> getVocabularyQuestions(
      int questions) async {
    // Get spelling question from JSON file
    String jsonString =
        await rootBundle.loadString('assets/questions/vocabulary_bank.json');
    Map<String, dynamic> vocabularyQuestions = jsonDecode(jsonString) as Map<String, dynamic>;

    // Get ratio based on fluency
    Map<String, double> difficultyRatio = getDifficultyRatio();
    Random random = Random();

    // For each difficulty level generate number of questions and append it to a list
    List<Map<String, dynamic>> questionList = [];
    for (String difficulty in difficultyRatio.keys) {
      List difficultyQuestions = vocabularyQuestions[difficulty];
      double ratio = difficultyRatio[difficulty]!;
      int numOfQuestions = (questions * ratio).toInt();
      List<int> questionIndices = [];

      // Generate 10 unique integers
      while (questionIndices.length < numOfQuestions) {
        int maxRange = difficultyQuestions.length;
        int questionIndex = random.nextInt(maxRange);
        if (!questionIndices.contains(questionIndex)) {
          questionIndices.add(questionIndex);
        }
      }

      String jsonString =
      await rootBundle.loadString('assets/questions/word_choices.json');
      Map<String, dynamic> wordChoices = jsonDecode(jsonString) as Map<String, dynamic>;
      List words = wordChoices['words'];

      // Generate corresponding questions from unique integers
      for (int questionIndex in questionIndices) {

        // Read vocabulary question data
        Map<String, dynamic> question = difficultyQuestions[questionIndex];

        // Choose a synonym as the correct answer
        List synonyms = question['synonyms'];
        String synonym = synonyms[random.nextInt(synonyms.length)];

        // Generate three unique random words as choices
        List<String> choices = [];
        while (choices.length < 3) {
          int maxRange = words.length;
          int wordIndex = random.nextInt(maxRange);
          String word = words[wordIndex];
          if (!choices.contains(word)) {
            choices.add(word);
          }
        }

        // Add the correct answer to choices and shuffle
        choices.add(synonym);
        choices.shuffle();

        // Initialize the new question with all of its components
        Map<String, dynamic> newQuestion = {
          'word': question['word'],
          'choices': choices,
          'answer': synonym,
        };
        questionList.add(newQuestion);
      }
    }

    // Shuffle question list
    questionList.shuffle();

    // Return question list
    return questionList;
  }

  // Fetch 10 Grammar Questions Based on Fluency
  Future<List<Map<String, dynamic>>> getGrammarQuestions(int questions) async {
    // Get grammar questions from JSON file
    String jsonString =
        await rootBundle.loadString('assets/questions/grammar_bank.json');
    Map<String, dynamic> grammarQuestions =
        jsonDecode(jsonString) as Map<String, dynamic>;

    // Get ratio based on fluency
    Map<String, double> difficultyRatio = getDifficultyRatio();

    // For each difficulty level generate number of questions and append it to a list
    List<Map<String, dynamic>> questionList = [];
    for (String difficulty in difficultyRatio.keys) {
      List difficultyQuestions = grammarQuestions[difficulty];
      double ratio = difficultyRatio[difficulty]!;
      int numOfQuestions = (questions * ratio).toInt();
      List<int> questionIndices = [];

      // Generate 10 unique integers
      while (questionIndices.length < numOfQuestions) {
        Random random = Random();
        int maxRange = difficultyQuestions.length;
        int questionIndex = random.nextInt(maxRange);
        if (!questionIndices.contains(questionIndex)) {
          questionIndices.add(questionIndex);
        }
      }

      // Generate corresponding questions from unique integers
      for (int questionIndex in questionIndices) {
        Map<String, dynamic> newQuestion = difficultyQuestions[questionIndex];
        questionList.add(newQuestion);
      }
    }

    // Shuffle question list
    questionList.shuffle();

    // Return question list
    return questionList;
  }

  // Fetch 10 Comprehension Questions Based on Fluency
  Future<List<Map<String, dynamic>>> getComprehensionQuestions(int questions) async {
    // Get comprehension questions from JSON file
    String jsonString =
    await rootBundle.loadString('assets/questions/comprehension_bank.json');
    Map<String, dynamic> comprehensionQuestions = jsonDecode(jsonString) as Map<String, dynamic>;

    // Get ratio based on fluency
    Map<String, double> difficultyRatio = getDifficultyRatio();

    // For each difficulty level generate number of questions and append it to a list
    List<Map<String, dynamic>> questionList = [];
    for (String difficulty in difficultyRatio.keys) {
      List difficultyQuestions = comprehensionQuestions[difficulty];
      double ratio = difficultyRatio[difficulty]!;
      int numOfQuestions = (questions * ratio).toInt();
      List<int> questionIndices = [];

      // Generate 10 unique integers
      while (questionIndices.length < numOfQuestions) {
        Random random = Random();
        int maxRange = difficultyQuestions.length;
        int questionIndex = random.nextInt(maxRange);
        if (!questionIndices.contains(questionIndex)) {
          questionIndices.add(questionIndex);
        }
      }

      // Generate corresponding questions from unique integers
      for (int questionIndex in questionIndices) {
        Map<String, dynamic> newQuestion = difficultyQuestions[questionIndex];
        questionList.add(newQuestion);
      }
    }

    // Shuffle question list
    questionList.shuffle();

    // Return question list
    return questionList;
  }

}
