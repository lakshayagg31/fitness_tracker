import 'package:flutter/material.dart';
import '../widgets/workout_card.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import 'workout_screen.dart';
import 'stats_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
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
  ];

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      _buildHomeContent(),
      WorkoutScreen(),
      StatsScreen(),
      ProfileScreen(),
    ]);
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDailyStats(),
            SizedBox(height: 24),
            Text(
              'Recent Workouts',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildRecentWorkouts(),
            SizedBox(height: 24),
            Text(
              'Quick Start',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildQuickStart(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyStats() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Steps', '6,243', '10,000', 0.62),
              _buildStatCard('Calories', '420', '1,200', 0.35),
              _buildStatCard('Minutes', '32', '60', 0.53),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String current,
    String goal,
    double progress,
  ) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Column(
              children: [
                Text(
                  current,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'of $goal',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentWorkouts() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _workouts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: WorkoutCard(workout: _workouts[index]),
        );
      },
    );
  }

  Widget _buildQuickStart() {
    final List<Map<String, dynamic>> quickWorkouts = [
      {
        'title': 'Full Body HIIT',
        'duration': '20 min',
        'level': 'Intermediate',
        'color': Colors.red.shade400,
      },
      {
        'title': 'Yoga Flow',
        'duration': '30 min',
        'level': 'Beginner',
        'color': Colors.purple.shade400,
      },
      {
        'title': 'Core Blast',
        'duration': '15 min',
        'level': 'Advanced',
        'color': Colors.orange.shade400,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: quickWorkouts.length,
      itemBuilder: (context, index) {
        final workout = quickWorkouts[index];
        return InkWell(
          onTap: () {
            // Handle quick start workout
          },
          child: Container(
            decoration: BoxDecoration(
              color: workout['color'],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  workout['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout['duration'],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      workout['level'],
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton:
          _selectedIndex == 1
              ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  // Add new workout
                },
              )
              : null,
    );
  }
}
