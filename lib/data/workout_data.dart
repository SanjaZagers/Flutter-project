import 'package:beginners_course/data/workout_hive.dart';
import 'package:beginners_course/datatime/data_time.dart';
import 'package:beginners_course/models/exercise.dart';
import 'package:beginners_course/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  // HEAT MAP DATASET
  Map<DateTime, int> heatMapDataSet = {};

  // WORKOUT DATA STRUCTURE
  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3"),
      ],
    ),
    Workout(
      name: "Lower body",
      exercises: [
        Exercise(name: "Squats", weight: "10", reps: "10", sets: "3"),
      ],
    )
  ];

  void initializeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }
    loadHeatMap();
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    heatMapDataSet = {}; // Clear previous data

    for (int i = 0; i <= daysInBetween; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String yyyymmdd = convertDateTimeToYYYYMMDD(currentDate);

      int completionStatus = db.getCompletionStatus(yyyymmdd);

      heatMapDataSet[DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      )] = completionStatus;
    }

    notifyListeners();
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );
    notifyListeners();
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantWorkout(workoutName)
        .exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    db.saveToDatabase(workoutList);
    notifyListeners();

    // OPTIONAL: just update today’s value in the heatmap (instead of reloading all)
    final today = DateTime.now();
    final key = DateTime(today.year, today.month, today.day);
    heatMapDataSet[key] = heatMapDataSet[key] == 1 ? 0 : 1;
  }

  Workout getRelevantWorkout(String workoutName) {
    return workoutList.firstWhere((workout) => workout.name == workoutName);
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
  }

  String getStartDate() {
    return db.getStartDate();
  }

  void deleteWorkout(String workoutName) {
    workoutList.removeWhere((workout) => workout.name == workoutName);
    db.saveToDatabase(workoutList);
    notifyListeners();
  }
}
