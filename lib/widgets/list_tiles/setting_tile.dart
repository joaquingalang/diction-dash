import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kGrayColor200, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: kGrayColor100,
        leading: Icon(iconData, size: 30),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}