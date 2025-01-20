import 'package:beginners_course/pages/home_page.dart';
import 'package:beginners_course/pages/profile_page.dart';
import 'package:beginners_course/pages/todo_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:beginners_course/pages/custom_text_field.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const HomePage(),
    const CustomTextField(),
    const ToDoPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("1ste page")),
      body: _pages[_selectedIndex],

      //hamburger
      drawer: Drawer(
          backgroundColor: Colors.deepPurple[100],
          child: Column(children: [
            const DrawerHeader(child: Icon(Icons.favorite, size: 48)),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_pin_circle),
              title: const Text("T E X T I N G"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/customtextfield');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text("T O  D O"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/todopage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G S"),
              onTap: () {
                Navigator.pushNamed(context, '/settingspage');
              },
            )
          ])),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigationBottomBar,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ]),
    );
  }
}
