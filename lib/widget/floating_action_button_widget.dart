import 'package:anugrah_lens/style/color_style.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor; 

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor = ColorStyle.secondaryColor,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      shape: const CircleBorder(),
      child: Icon(icon, color: iconColor),
    );
  }
}
