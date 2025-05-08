class UserProfile {
  final String id;
  String name;
  int age;
  double weight;
  double height;
  String gender;
  int dailyStepGoal;
  int dailyCalorieGoal;
  int weeklyWorkoutGoal;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.dailyStepGoal,
    required this.dailyCalorieGoal,
    required this.weeklyWorkoutGoal,
  });
}
