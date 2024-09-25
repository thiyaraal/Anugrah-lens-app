// font style dengan font family roboto
import 'package:anugrah_lens/style/color_style.dart';
import 'package:flutter/material.dart';

// textstyle nya : h1  = 32, h2 = 24, h3 = 20, title = 18, subtitle = 16, body = 14, caption = 12
class FontFamily {
  static TextStyle h1 = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: ColorStyle.secondaryColor,
    fontFamily: 'Roboto',
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
     color: ColorStyle.secondaryColor,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
        color: ColorStyle.secondaryColor,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ColorStyle.secondaryColor,
    fontFamily: 'Roboto',
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
  );
  static const TextStyle titleForm = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorStyle.primaryColor,
    fontFamily: 'Roboto',
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorStyle.textColors,
    fontFamily: 'Roboto',
  );
}
