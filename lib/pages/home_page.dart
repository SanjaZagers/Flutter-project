import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
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
    );
  }
}
