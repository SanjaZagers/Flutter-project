import 'package:hive/hive.dart';

class ToDoDatabase {
List toDoList = []; 

  //reference box
  final _myBox = Hive.box('mybox'); 

//first time ever opening
  void createInitalData() {
    toDoList = [
      ['Make tutorial', false], 
      ['Do exersise', false],   
    ]; 
  }

// load data
void loadData() {
 toDoList = _myBox.get('TODOLIST'); 
}
// update changes 
void updateDatabase() {
  _myBox.put('TODOLIST', toDoList); 
}
}