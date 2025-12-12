import 'package:flutter/material.dart';
import 'package:beginners_course/pages/profile_page.dart';
import 'package:beginners_course/pages/settings_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late String currentDate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.forward();
    _updateDate();
  }

  void _updateDate() {
    setState(() {
      currentDate = DateFormat('dd, MMMM, yyyy').format(DateTime.now());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // List of pages for navigation
  late final List<Widget> _pages = [
    HomeContent(currentDate: currentDate),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Navigate from drawer
  void _navigateFromDrawer(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
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
      drawer: Drawer(
        backgroundColor: Colors.purple[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Icon(Icons.favorite, size: 48)),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () => _navigateFromDrawer(context, '/homepage'),
            ),
            ListTile(
              leading: const Icon(Icons.person_pin_circle),
              title: const Text("T E X T I N G"),
              onTap: () => _navigateFromDrawer(context, '/customtextfield'),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text("T O  D O"),
              onTap: () => _navigateFromDrawer(context, '/todopage'),
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text("W E A T H E R"),
              onTap: () => _navigateFromDrawer(context, '/weatherpage'),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text("W O R K O U T"),
              onTap: () => _navigateFromDrawer(context, '/workoutpage'),
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text("T R A C K E R"),
              onTap: () => _navigateFromDrawer(context, '/periodTracker'),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper_rounded),
              title: const Text("N E W S"),
              onTap: () => _navigateFromDrawer(context, '/rssFeedPage'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.currentDate});
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    const String userName = " "; //change this in settings
//  final String moodCounter = " "; // change your daily mood
    // const String goodNews =
    //     "You've completed all tasks for today"; // New page with RSS news articles
    // const String lastWorkoutDays = "2";
    final String currentDate =
        DateFormat('MMMM dd, yyyy').format(DateTime.now());

    // final String lastPeriod = " ";

    return Container(
      color: Colors.purple[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Welcome card with avatar
            Card(
              elevation: 4,
              shadowColor: Colors.purple[30],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.purple[200],
                      child: Text(
                        userName.isNotEmpty ? userName[0] : "?",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Sanja",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Date card with calendar icon
            Card(
              elevation: 4,
              shadowColor: Colors.purple[30],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.purple[400],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      currentDate,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Good News card with icon
            // Card(
            //   elevation: 4,
            //   shadowColor: Colors.purple[30],
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Row(
            //           children: [
            //             Icon(
            //               Icons.celebration,
            //               color: Colors.amber,
            //               size: 28,
            //             ),
            //             SizedBox(width: 12),
            //             Text(
            //               "Good News of Today:",
            //               style: TextStyle(
            //                 fontSize: 22,
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.purple,
            //               ),
            //             ),
            //           ],
            //         ),
            //         const Divider(height: 20),
            //         Text(
            //           goodNews,
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: Colors.grey[800],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),

            // Workout card with icon
            // Card(
            //   elevation: 4,
            //   shadowColor: Colors.purple[30],
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Row(
            //           children: [
            //             Icon(
            //               Icons.fitness_center,
            //               color: Colors.blue,
            //               size: 28,
            //             ),
            //             SizedBox(width: 12),
            //             Text(
            //               "Last day since workout:",
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.purple,
            //               ),
            //             ),
            //           ],
            //         ),
            //         const Divider(height: 20),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               lastWorkoutDays,
            //               style: const TextStyle(
            //                 fontSize: 36,
            //                 fontWeight: FontWeight.bold,
            //                 color: Color.fromARGB(255, 245, 119, 161),
            //               ),
            //             ),
            //             const SizedBox(width: 8),
            //             Text(
            //               "days ago",
            //               style: TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.grey[800],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),

            // Period
            // Card(
            //   elevation: 4,
            //   shadowColor: Colors.purple[30],
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Row(
            //           children: [
            //             Icon(
            //               Icons.bloodtype,
            //               color: Colors.red,
            //               size: 28,
            //             ),
            //             SizedBox(width: 12),
            //             Text(
            //               "Last day since period: ",
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.purple,
            //               ),
            //             ),
            //           ],
            //         ),
            //         const Divider(height: 20),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               lastWorkoutDays,
            //               style: const TextStyle(
            //                 fontSize: 36,
            //                 fontWeight: FontWeight.bold,
            //                 color: Color.fromARGB(255, 245, 119, 161),
            //               ),
            //             ),
            //             const SizedBox(width: 8),
            //             Text(
            //               "days ago",
            //               style: TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.grey[800],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
