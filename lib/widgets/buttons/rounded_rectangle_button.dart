import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class RoundedRectangleButton extends StatelessWidget {

  const RoundedRectangleButton({
    super.key,
    this.backgroundColor = kOrangeColor600,
    required this.onPressed,
    required this.child,
  });

  final Color? backgroundColor;
  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ),
    );
  }
}
