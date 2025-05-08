import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  ExerciseDetailScreen({required this.exercise});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showExerciseInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.fitness_center,
                size: 80,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Sets',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSetsList(),
            SizedBox(height: 24),
            _buildMuscleGroupTag(),
            SizedBox(height: 24),
            Text(
              'History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildSetsList() {
    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.exercise.sets.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final set = widget.exercise.sets[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  set.completed
                      ? Colors.green
                      : Theme.of(context).colorScheme.primary,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              set.reps > 0
                  ? 'Reps: ${set.reps}'
                  : 'Duration: ${set.duration.inMinutes} min',
            ),
            subtitle: set.weight > 0 ? Text('Weight: ${set.weight} kg') : null,
            trailing: Checkbox(
              value: set.completed,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  widget.exercise.sets[index].completed = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMuscleGroupTag() {
    return Wrap(
      spacing: 8,
      children:
          widget.exercise.muscleGroup.split(', ').map((muscle) {
            return Chip(
              label: Text(muscle),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildHistory() {
    // Mock history data
    final List<Map<String, dynamic>> history = [
      {'date': 'April 20, 2025', 'performance': '3 sets, 12/10/8 reps, 20kg'},
      {'date': 'April 17, 2025', 'performance': '3 sets, 10/8/8 reps, 17.5kg'},
      {'date': 'April 14, 2025', 'performance': '3 sets, 10/8/6 reps, 15kg'},
    ];

    return Card(
      elevation: 2,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            title: Text(item['date']),
            subtitle: Text(item['performance']),
            leading: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  void _showExerciseInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.exercise.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(widget.exercise.description),
                SizedBox(height: 16),
                Text(
                  'Muscle Groups',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(widget.exercise.muscleGroup),
                SizedBox(height: 16),
                Text(
                  'Instructions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '1. Start position: Stand with feet shoulder-width apart.\n'
                  '2. Bend at the knees and hips to lower your body.\n'
                  '3. Keep your back straight and chest up.\n'
                  '4. Lower until thighs are parallel with the floor.\n'
                  '5. Push through your heels to return to standing position.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
