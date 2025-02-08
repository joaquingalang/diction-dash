import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OvalInfoButton extends StatelessWidget {
  const OvalInfoButton({
    super.key,
    this.color = kOrangeColor600,
    required this.text,
    this.style = kButtonTextStyle,
    required this.infoDescription,
    required this.onPressed,
  });

  final Color color;
  final String text;
  final TextStyle style;
  final String infoDescription;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    // Display Info Alert
                    Alert(
                      context: context,
                      title: text,
                      desc: infoDescription,
                      style: AlertStyle(
                        titleStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        descStyle: TextStyle(
                          fontSize: 18,
                        ),
                        backgroundColor: kGrayColor200,
                        overlayColor: Colors.black26,
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          color: kOrangeColor600,
                          child: Text('CANCEL', style: kButtonTextStyle),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ).show();

                  },
                  child: const Icon(
                    Icons.info,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
