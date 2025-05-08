import '../models/workout.dart';
import '../models/exercise.dart';
import 'dart:async';

class WorkoutService {
  List<Workout> _workouts = [];

  Stream<List<Workout>> get workouts => _workoutController.stream;
  final _workoutController = StreamController<List<Workout>>.broadcast();

  WorkoutService() {
    _loadInitialData();
  }

  void _loadInitialData() {
    // In a real app, you would load this from a database or API
    _workouts = [
      Workout(
        id: '1',
        name: 'Morning Cardio',
        description: 'Start your day with energizing cardio exercises',
        exercises: [
          Exercise(
            id: '1',
            name: 'Running',
            description: 'Outdoor running',
            muscleGroup: 'Legs',
            imageUrl: 'assets/images/running.jpg',
            sets: [Set(duration: Duration(minutes: 20), completed: true)],
          ),
          Exercise(
            id: '2',
            name: 'Jumping Jacks',
            description: 'Full body cardio exercise',
            muscleGroup: 'Full Body',
            imageUrl: 'assets/images/jumping_jacks.jpg',
            sets: [
              Set(reps: 30, completed: true),
              Set(reps: 30, completed: true),
              Set(reps: 30, completed: true),
            ],
          ),
        ],
        date: DateTime.now().subtract(Duration(days: 1)),
        durationMinutes: 30,
        caloriesBurned: 250,
      ),
      // Add more sample workouts here
    ];
    _workoutController.add(_workouts);
  }

  Future<void> addWorkout(Workout workout) async {
    _workouts.add(workout);
    _workoutController.add(_workouts);
  }

  Future<void> updateWorkout(Workout workout) async {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      _workouts[index] = workout;
      _workoutController.add(_workouts);
    }
  }

  Future<void> deleteWorkout(String id) async {
    _workouts.removeWhere((w) => w.id == id);
    _workoutController.add(_workouts);
  }

  void dispose() {
    _workoutController.close();
  }
}
