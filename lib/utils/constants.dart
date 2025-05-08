import 'package:flutter/material.dart';

class AppColors {
  static const primary = Colors.blue;
  static const secondary = Colors.green;
  static const accent = Colors.orange;
  static const background = Colors.white;
  static const surface = Colors.white;
  static const error = Colors.red;
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.white;
  static const onBackground = Colors.black;
  static const onSurface = Colors.black;
  static const onError = Colors.white;
}

class AppConstants {
  static const appName = 'Fitness Tracker';
  static const appVersion = '1.0.0';

  // Shared preferences keys
  static const prefUserKey = 'user_profile';
  static const prefWorkoutsKey = 'workouts';

  // API endpoints (for future implementation)
  static const baseUrl = 'https://api.fitnesstracker.com';
  static const workoutsEndpoint = '/workouts';
  static const exercisesEndpoint = '/exercises';
  static const userEndpoint = '/user';
}
