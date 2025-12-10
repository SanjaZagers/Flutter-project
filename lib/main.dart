import 'package:beginners_course/data/workout_data.dart';
import 'package:beginners_course/pages/first_page.dart';
import 'package:beginners_course/pages/home_page.dart';
import 'package:beginners_course/pages/periodTracker_page.dart';
import 'package:beginners_course/pages/todo_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:beginners_course/pages/custom_text_field.dart';
import 'package:beginners_course/pages/weather_page.dart';
import 'package:beginners_course/pages/workout_page.dart';
import 'package:beginners_course/pages/rssfeed_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('mybox');
  await Hive.openBox("workout_database");
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(), // Default starting page
        routes: {
          '/firstpage': (context) => const FirstPage(),
          '/customtextfield': (context) => const CustomTextField(),
          '/todopage': (context) => const ToDoPage(),
          '/homepage': (context) => const HomePage(),
          '/settingspage': (context) => const SettingsPage(),
          '/weatherpage': (context) => const WeatherPage(),
          '/workoutpage': (context) => const WorkoutPage(),
          '/periodTracker': (context) => const PeriodTracker(),
          "/rssfeedpage": (context) => const RssFeedPage(),
        },
      ),
    );
  }
}
