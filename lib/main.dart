import 'package:beginners_course/pages/first_page.dart';
import 'package:beginners_course/pages/home_page.dart';
import 'package:beginners_course/pages/second_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:beginners_course/pages/custom_text_field.dart'; 
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(), // Default starting page
      routes: {
        '/firstpage': (context) => FirstPage(),
        '/customtextfield': (context) => CustomTextField(), 
        '/secondpage': (context) => SecondPage(),
        '/homepage': (context) => HomePage(),
        '/settingspage': (context) => SettingsPage(),
      },
    );
  }
}
