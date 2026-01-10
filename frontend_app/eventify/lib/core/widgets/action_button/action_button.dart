import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final double fontSize;
  final Color buttonColor;
  final VoidCallback? onPress;
  const ActionButton(
    {
      super.key,
      required this.buttonText,
      required this.textColor,
      required this.fontSize,
      required this.buttonColor,
      this.onPress
    }
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(18.0)
        )
      ).copyWith(
        backgroundColor: WidgetStatePropertyAll(buttonColor)
      ),
      child: Text(buttonText, style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize
      ),),
    );
  }
}