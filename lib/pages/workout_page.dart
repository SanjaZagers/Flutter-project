// ignore_for_file: prefer_const_constructors

import 'package:beginners_course/components/heat_map.dart';
import 'package:beginners_course/data/workout_data.dart';
import 'package:beginners_course/pages/workingout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).intializeWorkoutList();
  }

// text controller
  final newWorkoutNameController = TextEditingController();

  //Create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create new workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text("save"),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ),
        ],
      ),
    );
  }

// go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkingoutPage(
            workoutName: workoutName,
          ),
        ));
  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workout data list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
  }

  // clear controller
  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: const Text("workout tracker"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            // HEAT MAP
            MyHeatMap(
              datasets: value.heatMapDataSet,
              startDateYYYYMMDD: value.getStartDate(),
            ),
            // WORKOUT LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => ListTile(
                title: Text(value.getWorkoutList()[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () =>
                      goToWorkoutPage(value.getWorkoutList()[index].name),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
