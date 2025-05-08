class Exercise {
  final String id;
  final String name;
  final String description;
  final String muscleGroup;
  final String imageUrl;
  final List<Set> sets;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.imageUrl,
    required this.sets,
  });
}

class Set {
  int reps;
  double weight;
  Duration duration;
  bool completed;

  Set({
    this.reps = 0,
    this.weight = 0,
    this.duration = const Duration(seconds: 0),
    this.completed = false,
  });
}
