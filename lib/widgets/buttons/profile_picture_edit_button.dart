import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class ProfilePictureEditButton extends StatelessWidget {
  const ProfilePictureEditButton({
    super.key,
    this.imageUrl,
    required this.onTap,
  });

  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: (imageUrl != null)
            ? NetworkImage(imageUrl!)
            : AssetImage('assets/images/placeholder_profile.png'),
        radius: 70,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kGrayColor600,
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 25),
          ),
        ),
      ),
    );
  }
}
