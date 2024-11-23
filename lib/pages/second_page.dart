import 'package:beginners_course/util/dialog_box.dart';
import 'package:beginners_course/util/todo_tile.dart';
import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  // text controller 
final _controller = TextEditingController(); 


  //List of todo tasks 
  List toDoList = [
    ["Make Tutorial", false], 
    ["Do exersize", false], 
  ]; 

  //checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1]; 
    });
  }

// save new task
void saveNewTask() {
  setState(() {
     toDoList.add([_controller.text, false]); 
     _controller.clear(); 
  });
  Navigator.of(context).pop(); 
}

  //create new task 
  void createNewTask() {
    showDialog(
      context: context, 
    builder: (context) {
    return DialogBox(
      controller: _controller,
      onSave: saveNewTask,
      onCancel: () => Navigator.of(context).pop,
    ); 
    },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar (
        title: Text("To Do"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add), 
    ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile (
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }
      )
    );
  }
}
