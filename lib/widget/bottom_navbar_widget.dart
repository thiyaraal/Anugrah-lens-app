import 'package:anugrah_lens/style/color_style.dart';
import 'package:flutter/material.dart';

class BottomNavbarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  const BottomNavbarWidget({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ColorStyle.whiteColors,
      elevation: 0,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat',
        ),
      ],
      // backgroundColor: const Color(0xFF2465ac),
      currentIndex: currentIndex,
      selectedItemColor: ColorStyle.primaryColor,
      unselectedItemColor: ColorStyle.disableColor,
      showUnselectedLabels: true,
      // selectedLabelStyle: ,
      onTap: onTap,
    );
  }
}
