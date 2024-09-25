import 'package:anugrah_lens/firebase_options.dart';
import 'package:anugrah_lens/preferences/preferences_helper.dart';
import 'package:anugrah_lens/screen/home/bottom_screen.dart';
import 'package:anugrah_lens/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UserPreferences.init();

  final isLoggedIn = UserPreferences.isLoggedIn();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget homeScreen =
        isLoggedIn ? const FirstScreen(activeScreen: 0) : LoginScreen();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, // Warna dasar putih
            brightness: Brightness.light, // Mengatur tampilan terang
          ),
        ),
        home: homeScreen);
  }
}
