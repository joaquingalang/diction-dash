import 'package:diction_dash/services/question_bank.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
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

  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Vocabulary',
        description: 'Select the choice that has the same meaning as the provided word.',
      ),
    );
  }

  void _endGameScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndGameScreen(score: score, maxScore: 10),
      ),
    );
  }

  // Generate 10 Random Questions From Vocabulary Question Bank According To Fluency Score
  Future<void> _generateQuestions() async {
    _questionBank = QuestionBank(fluency: widget.fluency);
    questionList = await _questionBank.getVocabularyQuestions(10);
    setState(() {});
  }

  // Check If Current Question Is Correct & Move To Next Question
  void _checkAnswer(String answer) {
    if (answer == questionList![questionIndex]['answer']) {
      setState(() {
        score++;
      });
    }
    if (questionIndex < questionList!.length-1) {
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
        onAnswer: _checkAnswer,
      ),
    );
  }
}
