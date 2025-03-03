import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/question_bank.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/spelling/spelling_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key, required this.fluency});

  final String fluency;

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {

  // Questions & Score Manager
  late final QuestionBank _questionBank;
  List<Map<String, dynamic>>? questionList;
  int questionIndex = 0;
  int score = 0;
  int bonusPoints = 0;

  // Display Minigame Instructions
  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Spelling',
        description:
            'Listen to the audio carefully and make sure to type the word in the answer box.',
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
          game: 'spelling',
        ),
      ),
    );
  }

  // Score Answer & Move To Next Question (Or End Game Screen)
  void _scoreAnswer(String answer, int bonusPoints) {
    answer = answer.toLowerCase().trim();
    if (answer == questionList![questionIndex]['word']) {
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

  // Generate 10 Random Questions From Spelling Question Bank According To Fluency Score
  Future<void> _generateQuestions() async {
    _questionBank = QuestionBank(fluency: widget.fluency);
    questionList = await _questionBank.getSpellingQuestions(10);
    setState(() {});
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
              scrolledUnderElevation: 0,
            ),

            // Page BodyW
            body: SpellingQuestion(
              word: questionList![questionIndex]['word'],
              definition: questionList![questionIndex]['definition'],
              onAnswer: _scoreAnswer,
            ),
          )
        : Foxloadingindicator();
  }
}
