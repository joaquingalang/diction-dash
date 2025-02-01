import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class ProfileTextFormField extends StatelessWidget {
  const ProfileTextFormField({
    super.key,
    this.icon,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  });

  final IconData? icon;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kGrayColor100,
        child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          cursorColor: kOrangeColor500,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 35,
              color: kOrangeColor400,
            ),
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kGrayColor300,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kOrangeColor300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
