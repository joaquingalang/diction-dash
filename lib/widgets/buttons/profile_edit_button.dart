import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({
    super.key,
    required this.text,
    required this.labelText,
    required this.onTap,
  });

  final String text;
  final String labelText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Text Indicator
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              text,
              style: TextStyle(
                color: kGrayColor600,
                fontSize: 13,
              ),
            ),
          ),

          // Edit Button
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: kGrayColor100,
                border: Border.all(
                  color: kGrayColor300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  labelText,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.edit,
                  size: 30,
                  color: kGrayColor500,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
