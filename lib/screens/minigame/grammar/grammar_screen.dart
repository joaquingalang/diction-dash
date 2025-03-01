import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/question_bank.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/grammar/grammar_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key, required this.fluency});

  final String fluency;

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
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
        title: 'Grammar',
        description:
            'Analyze the sentence carefully, and determine if it is grammatically correct or incorrect',
      ),
    );
  }

  // Navigate to End Game Screen w/ Score
  void _endGameScreen(BuildContext context) {
    int maxScore = questionList!.length;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndGameScreen(
          score: score,
          maxScore: maxScore,
          bonusPoints: bonusPoints,
        ),
      ),
    );
  }

  // Generate 10 Random Questions From Spelling Question Bank According To Fluency Score
  Future<void> _generateQuestions() async {
    _questionBank = QuestionBank(fluency: widget.fluency);
    questionList = await _questionBank.getGrammarQuestions(10);
    setState(() {});
  }

  // Check If Current Question Is Correct & Move To Next Question
  void _scoreAnswer(bool answer, int bonusPoints) {
    if (answer == questionList![questionIndex]['isCorrect']) {
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
    return (questionList != null)
        ? Scaffold(
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
              title: QuestionBar(
                  currentItem: questionIndex + 1,
                  maxItems: questionList!.length),
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
            body: GrammarQuestion(
              phrase: questionList![questionIndex]['phrase'],
              isCorrect: questionList![questionIndex]['isCorrect'],
              onAnswer: _scoreAnswer,
            ),
          )
        : Foxloadingindicator();
  }
}
