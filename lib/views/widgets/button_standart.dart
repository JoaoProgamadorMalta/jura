import 'package:flutter/material.dart';

class ButtonStandart extends StatelessWidget {
  const ButtonStandart({super.key, this.icon, this.iconButton, this.colorText, this.colorBorder, this.width, this.height, this.backgroundColor, required this.text, required this.onPressed, this.borderRadius});
  final Color? colorBorder;
  final Color? backgroundColor;
  final double? borderRadius;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? colorText;
  final bool? iconButton;
  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if(iconButton == true){
      return ElevatedButton.icon(
        style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(width ?? 200, height ?? 50)),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor?? const Color.fromARGB(255, 197, 153, 32),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            side: BorderSide(color: colorBorder ??Colors.black),
          ),
        ),
      ),
      icon: icon,
        onPressed: onPressed, 
        label: Text(text, style: TextStyle(color: colorText ?? Colors.white),)
      );
    }

    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(width ?? 200, height ?? 50)),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor?? const Color.fromARGB(255, 197, 153, 32),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            side: BorderSide(color: colorBorder ??Colors.black),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: colorText ?? Colors.white)),
    );
  }
}
