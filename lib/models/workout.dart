import 'exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final DateTime date;
  final int durationMinutes;
  final int caloriesBurned;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.date,
    required this.durationMinutes,
    required this.caloriesBurned,
  });

  Workout copyWith({
    String? id,
    String? name,
    String? description,
    List<Exercise>? exercises,
    DateTime? date,
    int? durationMinutes,
    int? caloriesBurned,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      date: date ?? this.date,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
    );
  }
}
