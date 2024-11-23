import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController myController = TextEditingController();
  String greetingMessage = "";

  // Function to greet the user
  void greetUser() {
    String userName = myController.text;

    setState(() {
      greetingMessage = "Hello, " + userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom TextField"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(greetingMessage), 
              TextField(
                controller: myController, 
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your name...", 
                ),
              ),
              ElevatedButton(
                onPressed: greetUser, 
                child: Text("Tap"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
