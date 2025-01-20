import 'package:beginners_course/pages/first_page.dart';
import 'package:beginners_course/pages/home_page.dart';
import 'package:beginners_course/pages/todo_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:beginners_course/pages/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('mybox');
  var box = await Hive.openBox('mybox');

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
        '/customtextfield': (context) => const CustomTextField(),
        '/todopage': (context) => const ToDoPage(),
        '/homepage': (context) => const HomePage(),
        '/settingspage': (context) => const SettingsPage(),
      },
    );
  }
}
