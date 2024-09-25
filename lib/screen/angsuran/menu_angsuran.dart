// ignore_for_file: unnecessary_null_comparison

import 'package:anugrah_lens/screen/angsuran/angsuran_screen.dart';
import 'package:anugrah_lens/screen/angsuran/cash_screen.dart';
import 'package:anugrah_lens/screen/angsuran/selesai_screen.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';

class MenuAngsuranScreen extends StatefulWidget {
  final String idCustomer;
  final String customerName;

  MenuAngsuranScreen({
    Key? key,
    required this.idCustomer,
    required this.customerName,
  }) : super(key: key);

  @override
  State<MenuAngsuranScreen> createState() => _MenuAngsuranScreenState();
}

class _MenuAngsuranScreenState extends State<MenuAngsuranScreen> {
  bool isAngsuranActive = true;
  bool isCashActive = false;
  bool isSelesaiActive = false;

  void changeMenu(String menu) {
    setState(() {
      if (menu == "Angsuran") {
        isAngsuranActive = true;
        isCashActive = false;
        isSelesaiActive = false;
      } else if (menu == "Cash") {
        isAngsuranActive = false;
        isCashActive = true;
        isSelesaiActive = false;
      } else if (menu == "Selesai") {
        isAngsuranActive = false;
        isCashActive = false;
        isSelesaiActive = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.customerName,
          style: FontFamily.title,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildMenuButton("Angsuran", isAngsuranActive),
                _buildMenuButton("Cash", isCashActive),
                _buildMenuButton("Selesai", isSelesaiActive),
              ],
            ),
          ),
          if (isAngsuranActive)
            AngsuranScreen(
              idCustomer: widget.idCustomer,
              customerName: widget.customerName,
            )
          else if (isCashActive)
            CashScreen(
              idCustomer: widget.idCustomer,
              customerName: widget.customerName,

            )
          else if (isSelesaiActive)
            SelesaiScreen(
              idCustomer: widget.idCustomer,
              customerName: widget.customerName,

            ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String menu, bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isActive ? ColorStyle.primaryColor : ColorStyle.disableColor,
              width: 2,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            changeMenu(menu);
          },
          child: Text(
            menu,
            style: FontFamily.caption.copyWith(
              fontSize: 14,
              color: isActive
                  ? ColorStyle.primaryColor
                  : ColorStyle.disableColor.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
