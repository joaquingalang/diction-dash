import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/minigame_level_bar.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.text,
    required this.image,
    required this.level,
    required this.currentExp, // Progress value between 0.0 and 1.0
    required this.maxExp,
    required this.onPressed,
  });

  final String text;
  final ImageProvider<Object> image;
  final VoidCallback onPressed;
  final int level;
  final int currentExp;
  final int maxExp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: kGrayColor200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundImage: image,
                      radius: 40,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text, style: kOswaldSmall),
                        // Use Stack to overlay text on the progress bar
                        MinigameLevelBar(
                          level: level,
                          currentExp: currentExp,
                          maxExp: maxExp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}