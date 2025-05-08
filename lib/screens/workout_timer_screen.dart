import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final int durationMinutes; // total duration of workout
  WorkoutTimerScreen({required this.durationMinutes});

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  late int totalSeconds;
  late int remainingSeconds;
  Timer? _timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.durationMinutes * 60;
    remainingSeconds = totalSeconds;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        // Optional: show dialog or navigate
        showCompletionDialog();
      }
    });
    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Workout Complete!'),
        content: Text('Great job finishing your workout.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          )
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatTime(remainingSeconds),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? pauseTimer : startTimer,
                  child: Text(isRunning ? 'Pause' : 'Start'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
