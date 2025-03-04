import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/utils/minigames.dart';
import 'package:diction_dash/services/question_bank.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/vocabulary/vocabulary_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key, required this.fluency});

  final String fluency;

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {

  // Questions & Score Manager
  late final QuestionBank _questionBank;
  List<Map<String, dynamic>>? questionList;
  int questionIndex = 0;
  int score = 0;
  int bonusPoints = 0;

  // Displays Minigame Instructions
  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Vocabulary',
        description:
            'Select the choice that has the same meaning as the provided word.',
      ),
    );
  }

  // Navigate To End Game Screen w/ Score, Bonus Points, and Minigame Type
  void _endGameScreen(BuildContext context) {
    int maxScore = questionList!.length;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndGameScreen(
          score: score,
          maxScore: maxScore,
          bonusPoints: bonusPoints,
          game: Minigame.vocabulary,
        ),
      ),
    );
  }

  // Generate 10 Random Questions From Vocabulary Question Bank According To Fluency Score
  Future<void> _generateQuestions() async {
    _questionBank = QuestionBank(fluency: widget.fluency);
    questionList = await _questionBank.getVocabularyQuestions(10);
    setState(() {});
  }

  // Score Answer & Move To Next Question (Or End Game Screen)
  void _scoreAnswer(String answer, int bonusPoints) {
    if (answer == questionList![questionIndex]['answer']) {
      setState(() {
        score++;
        this.bonusPoints += bonusPoints;
      });
    }
    if (questionIndex < questionList!.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      _endGameScreen(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Minigame App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: kGrayColor500,
            size: 35,
          ),
        ),
        title: QuestionBar(currentItem: questionIndex + 1, maxItems: 10),
        actions: [
          IconButton(
            onPressed: () => _displayInstructions(context),
            icon: Icon(
              Icons.help,
              color: kGrayColor500,
              size: 35,
            ),
          ),

          // Offset
          SizedBox(width: 8),
        ],
      ),

      // Page Body
      body: VocabularyQuestion(
        word: questionList![questionIndex]['word'],
        choices: questionList![questionIndex]['choices'],
        answer: questionList![questionIndex]['answer'],
        onAnswer: _scoreAnswer,
      ),
    );
  }
}
