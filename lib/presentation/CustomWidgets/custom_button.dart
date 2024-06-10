import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double minWidth;
  final Color color;
  final Function onTap;
  const CustomButton({
    super.key,
    required this.title,
    required this.minWidth,
    required this.color,
    required this.onTap(),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      minWidth: minWidth,
      onPressed: () => onTap(),
      child: Text(title),
    );
  }
}
