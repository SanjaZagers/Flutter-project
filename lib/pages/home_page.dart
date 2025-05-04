import 'package:beginners_course/pages/profile_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "This should be homepage",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Lottie.asset(
            'assets/cat.json',
            width: 200,
            height: 220,
            fit: BoxFit.cover,
          ),
        ],
      ),
    ),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink,
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
          ),
        ],
      ),
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
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text("W E A T H E R"),
              onTap: () {
                Navigator.pushNamed(context, '/weatherpage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text("W O R K O U T"),
              onTap: () {
                Navigator.pushNamed(context, '/workoutpage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text("T R A C K E R"),
              onTap: () {
                Navigator.pushNamed(context, '/periodTracker');
              },
            ),
          ])),
    );
  }
}
