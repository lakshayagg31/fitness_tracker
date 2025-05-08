import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  ExerciseListItem({required this.exercise, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
  }
}
