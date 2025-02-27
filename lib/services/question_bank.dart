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

  // Fetch 10 Vocabulary Questions Based on Fluency

  // Fetch 10 Grammar Questions Based on Fluency
  Future<List<Map<String, dynamic>>> getGrammarQuestions(int questions) async {

    // Get Grammar Question
    String jsonString = await rootBundle.loadString('assets/questions/grammar_bank.json');
    Map<String, dynamic> grammarQuestions = jsonDecode(jsonString) as Map<String, dynamic>;

    // Get ratio based on fluency
    // Define Map<String, int> with difficulty level as key and number of questions as values
    Map<String, double> difficultyRatio = getDifficultyRatio();

    // For each difficulty level generate number of questions and append it to List
    // Ensure the questions are not the same
    List<Map<String, dynamic>> questionList = [];

    for (String difficulty in difficultyRatio.keys) {
      List difficultyQuestions = grammarQuestions[difficulty];
      double ratio = difficultyRatio[difficulty]!;
      int numOfQuestions = (questions * ratio).toInt();
      List<int> questionIndices = [];

      while (questionIndices.length < numOfQuestions) {
        Random random = Random();
        int maxRange = difficultyQuestions.length;
        int questionIndex = random.nextInt(maxRange);
        if (!questionIndices.contains(questionIndex)) {
          questionIndices.add(questionIndex);
        }
      }

      for (int questionIndex in questionIndices) {
        Map<String, dynamic> newQuestion = difficultyQuestions[questionIndex];
        questionList.add(newQuestion);
      }
    }

    // Shuffle list
    questionList.shuffle();

    // Return list
    return questionList;
  }

  // Fetch 10 Comprehension Questions Based on Fluency

}