import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../widgets/workout_card.dart';
import 'exercise_detail_screen.dart';
import 'workout_timer_screen.dart';


class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = [
    'All',
    'Strength',
    'Cardio',
    'Flexibility',
    'Custom',
  ];

  final List<Workout> _workouts = [
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
    Workout(
      id: '2',
      name: 'Upper Body Strength',
      description: 'Focus on building upper body strength',
      exercises: [
        Exercise(
          id: '3',
          name: 'Push-ups',
          description: 'Classic chest and triceps exercise',
          muscleGroup: 'Chest, Triceps',
          imageUrl: 'assets/images/pushups.jpg',
          sets: [
            Set(reps: 15, completed: true),
            Set(reps: 12, completed: true),
            Set(reps: 10, completed: false),
          ],
        ),
        Exercise(
          id: '4',
          name: 'Pull-ups',
          description: 'Upper body pulling exercise',
          muscleGroup: 'Back, Biceps',
          imageUrl: 'assets/images/pullups.jpg',
          sets: [
            Set(reps: 8, completed: true),
            Set(reps: 6, completed: false),
            Set(reps: 6, completed: false),
          ],
        ),
      ],
      date: DateTime.now().subtract(Duration(days: 2)),
      durationMinutes: 45,
      caloriesBurned: 320,
    ),
    Workout(
      id: '3',
      name: 'Lower Body Focus',
      description: 'Build strength in your legs and glutes',
      exercises: [
        Exercise(
          id: '5',
          name: 'Squats',
          description: 'Compound lower body exercise',
          muscleGroup: 'Legs, Glutes',
          imageUrl: 'assets/images/squats.jpg',
          sets: [
            Set(reps: 15, weight: 20, completed: false),
            Set(reps: 15, weight: 20, completed: false),
            Set(reps: 15, weight: 20, completed: false),
          ],
        ),
        Exercise(
          id: '6',
          name: 'Lunges',
          description: 'Single leg exercise for balance and strength',
          muscleGroup: 'Legs, Glutes',
          imageUrl: 'assets/images/lunges.jpg',
          sets: [
            Set(reps: 12, completed: false),
            Set(reps: 12, completed: false),
            Set(reps: 12, completed: false),
          ],
        ),
      ],
      date: DateTime.now().subtract(Duration(days: 0)),
      durationMinutes: 40,
      caloriesBurned: 280,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: _categories.map((category) => Tab(text: category)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _categories.map((category) {
                    return _buildWorkoutsList(category);
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsList(String category) {
    // Filter workouts based on category
    List<Workout> filteredWorkouts = _workouts;
    if (category != 'All') {
      // For demonstration, we'll just show all workouts
      // In a real app, you would filter based on category
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredWorkouts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              _showWorkoutDetails(filteredWorkouts[index]);
            },
            child: WorkoutCard(workout: filteredWorkouts[index]),
          ),
        );
      },
    );
  }

  void _showWorkoutDetails(Workout workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workout.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                workout.description,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(Icons.timer, '${workout.durationMinutes} min'),
                  _buildInfoItem(
                    Icons.local_fire_department,
                    '${workout.caloriesBurned} cal',
                  ),
                  _buildInfoItem(
                    Icons.fitness_center,
                    '${workout.exercises.length} exercises',
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Exercises',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ExerciseDetailScreen(exercise: exercise),
                          ),
                        );
                      },
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(exercise.name),
                      subtitle: Text(
                        '${exercise.sets.length} sets • ${exercise.muscleGroup}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkoutTimerScreen(durationMinutes: workout.durationMinutes),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Start Workout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        SizedBox(height: 4),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
