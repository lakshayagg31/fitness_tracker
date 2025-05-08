import '../models/user_profile.dart';
import 'dart:async';

class UserService {
  UserProfile? _userProfile;

  Stream<UserProfile?> get userProfile => _userProfileController.stream;
  final _userProfileController = StreamController<UserProfile?>.broadcast();

  UserService() {
    _loadUserProfile();
  }

  void _loadUserProfile() {
    // In a real app, you would load this from a database or API
    _userProfile = UserProfile(
      id: '1',
      name: 'Ribhav',
      age: 28,
      weight: 75.5,
      height: 178,
      gender: 'Male',
      dailyStepGoal: 10000,
      dailyCalorieGoal: 2500,
      weeklyWorkoutGoal: 4,
    );
    _userProfileController.add(_userProfile);
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    _userProfile = userProfile;
    _userProfileController.add(_userProfile);
  }

  void dispose() {
    _userProfileController.close();
  }
}
