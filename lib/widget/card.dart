import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';

class CardNameWidget extends StatefulWidget {
  final String name;
// onpressed
  final VoidCallback onPressed;
  CardNameWidget({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  State<CardNameWidget> createState() => _CardNameWidgetState();
}

class _CardNameWidgetState extends State<CardNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.all(12.0),
          backgroundColor: ColorStyle.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
                color: Colors.transparent,
                width: 1), // Stroking with transparent to match the container
          ),
        ),
        child: Text(widget.name,
            style: FontFamily.caption.copyWith(color: ColorStyle.whiteColors)),
      ),
    );
  }
}

class CardAnsuranWidget extends StatefulWidget {
  final String glassesName;
  final String frameName;
  final String address;
  final String sisaPembayaran;
  final String label;
  final VoidCallback? onTap;
  //decoration
  final BoxDecoration decoration;
  CardAnsuranWidget(
      {Key? key,
      required this.address,
      required this.onTap,
      required this.sisaPembayaran,
      required this.frameName,
      required this.glassesName,
      required this.decoration,
      required this.label})
      : super(key: key);

  @override
  State<CardAnsuranWidget> createState() => _CardAnsuranWidgetState();
}

class _CardAnsuranWidgetState extends State<CardAnsuranWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height mengikuti besar konten
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
            color: ColorStyle.whiteColors,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: widget.decoration,
                      child: Text(
                        widget.label,
                        style: FontFamily.caption
                            .copyWith(color: ColorStyle.whiteColors),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.glassesName,
                  style: FontFamily.title
                      .copyWith(color: ColorStyle.primaryColor, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(widget.frameName, style: FontFamily.caption),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(widget.address, style: FontFamily.caption),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.sisaPembayaran,
                      style: FontFamily.caption
                          .copyWith(color: ColorStyle.secondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
