import 'package:beginners_course/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple,
      content: SizedBox(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // get user input

          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Add a new task"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // save buttons
              MyButton(text: "Save", onPressed: onSave),

              const SizedBox(width: 8),

// cancel button
              MyButton(text: "Cancel", onPressed: onCancel),
            ],
          )
          //buttons -> save / cancel
        ]),
      ),
    );
  }
}
