import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class OvalButton extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final void Function()? onPressed;
  final Widget child;

  const OvalButton({
    super.key,
    this.color = kOrangeColor600,
    this.borderColor,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            width: 5,
            color: (borderColor == null) ? color : borderColor!,
          ),
        ),
        child: child,
      ),
    );
  }
}
