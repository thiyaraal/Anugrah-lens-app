import 'package:flutter/material.dart';

class RadioButtonWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final String text;
  final ValueChanged<String?> onChanged;

  const RadioButtonWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(text),
      ],
    );
  }
}
