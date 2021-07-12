import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class GoogleSigninButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPress;

  const GoogleSigninButton({required this.buttonText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => kSecondaryColor),
        elevation: MaterialStateProperty.resolveWith((states) => 6.0),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
