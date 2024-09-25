import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';

class TitleTextWIdget extends StatelessWidget {
  final String name;
  const TitleTextWIdget({Key? key, 
  required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 2.0),
        child: Text(name, style: FontFamily.titleForm));
  }
}
