import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class MinigameInstructionSheet extends StatelessWidget {
  const MinigameInstructionSheet({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            // Offset
            SizedBox(height: 10),

            // Bottom Sheet Draggable Bar
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: kGrayColor500,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // Offset
            SizedBox(height: 15),

            // Minigame
            Text(
              title,
              style: kSubtext32.copyWith(fontWeight: FontWeight.bold),
            ),

            // Text Offset
            SizedBox(height: 20),

            // Description
            Text(
              description,
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}