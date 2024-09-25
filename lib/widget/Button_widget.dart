import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final Color? color;
  final bool isLoading; // Tambahkan flag isLoading

  ElevatedButtonWidget({
    Key? key,
    required this.text,
    this.color,
    required this.onPressed,
    this.height,
    this.isLoading = false, // Default tidak loading
  }) : super(key: key);

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isLoading
            ? null // Nonaktifkan saat loading
            : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              widget.color ?? ColorStyle.primaryColor, // Warna tombol sesuai TextField
          padding: EdgeInsets.symmetric(
              horizontal: 16, vertical: 12), // Padding dalam tombol
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Sudut membulat sesuai TextField
          ),
        ),
        child: widget.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                widget.text,
                style: FontFamily.titleForm.copyWith(
                  color: ColorStyle.whiteColors, // Warna teks sesuai TextField
                ),
              ),
      ),
    );
  }
}
