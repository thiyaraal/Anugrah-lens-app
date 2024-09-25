import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 34,
        width: double.infinity,
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
        // buat dekorasinya dengan border radius 8 dan stroker 1
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: ColorStyle.disableColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: ColorStyle.disableColor,
            ),
            SizedBox(width: 10.0),
            Text("Cari nama pelanggan",
                style: FontFamily.caption
                    .copyWith(color: ColorStyle.disableColor)),
          ],
        ),
      ),
    );
  }
}
