import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class ProfileEditTextField extends StatefulWidget {
  const ProfileEditTextField({
    super.key,
    required this.labelText,
    required this.initialValue,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  final String labelText;
  final String initialValue;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  State<ProfileEditTextField> createState() => _ProfileEditTextFieldState();
}

class _ProfileEditTextFieldState extends State<ProfileEditTextField> {

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [

          // Label Text
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.labelText,
                style: const TextStyle(
                  fontSize: 13,
                  color: kGrayColor600,
                ),
              ),
            ),
          ),

          // Profile Edit Text Field
          Container(
            color: kGrayColor100,
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              cursorColor: kOrangeColor500,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.edit,
                  size: 30,
                  color: kGrayColor500,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kGrayColor300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kGrayColor300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
