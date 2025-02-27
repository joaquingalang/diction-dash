import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/question_bank.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/comprehension/comprehension_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key, required this.fluency});

  final String fluency;

  @override
  State<ComprehensionScreen> createState() => _ComprehensionScreenState();
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {
  // Questions & Score Manager
  late final QuestionBank _questionBank;
  List<Map<String, dynamic>>? questionList;
  int questionIndex = 0;
  int score = 0;

  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Comprehension',
        description:
            'Analyze the sentence carefully, and select the most appropriate answer.',
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
    questionList = await _questionBank.getComprehensionQuestions(10);
    print('!!!');
    for (var question in questionList!) {
      print(question);
    }
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
            ),

            // Page Body
            body: ComprehensionQuestion(
              paragraph:
                  questionList![questionIndex]['paragraph'],
              question: questionList![questionIndex]['question'],
              choices: questionList![questionIndex]['choices'],
              answer: questionList![questionIndex]['answer'],
              onAnswer: _checkAnswer,
            ),
          )
        : Foxloadingindicator();
  }
}
