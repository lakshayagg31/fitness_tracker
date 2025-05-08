import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile _userProfile = UserProfile(
    id: '1',
    name: 'Ribhav',
    age: 28,
    weight: 75.5,
    height: 178.0,
    gender: 'Male',
    dailyStepGoal: 10000,
    dailyCalorieGoal: 2500,
    weeklyWorkoutGoal: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 24),
            _buildStatsSection(),
            SizedBox(height: 24),
            _buildGoalsSection(),
            SizedBox(height: 24),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                _userProfile.name.substring(0, 1),
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userProfile.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${_userProfile.age} years • ${_userProfile.gender}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildProfileStat('Height', '${_userProfile.height} cm'),
                      SizedBox(width: 16),
                      _buildProfileStat('Weight', '${_userProfile.weight} kg'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Stats',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildStatRow('Total Workouts', '36'),
                Divider(),
                _buildStatRow('Total Minutes', '1,245'),
                Divider(),
                _buildStatRow('Total Calories Burned', '18,450'),
                Divider(),
                _buildStatRow('Current Streak', '3 days'),
                Divider(),
                _buildStatRow('Best Streak', '14 days'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Goals',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildGoalItem(
                  'Daily Steps',
                  _userProfile.dailyStepGoal.toString(),
                  Icons.directions_walk,
                ),
                Divider(),
                _buildGoalItem(
                  'Daily Calories',
                  _userProfile.dailyCalorieGoal.toString(),
                  Icons.local_fire_department,
                ),
                Divider(),
                _buildGoalItem(
                  'Weekly Workouts',
                  _userProfile.weeklyWorkoutGoal.toString(),
                  Icons.fitness_center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 16),
          Expanded(child: Text(label, style: TextStyle(fontSize: 16))),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 18),
            onPressed: () {
              // Edit goal
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    final List<Map<String, dynamic>> settings = [
      {
        'title': 'Account Settings',
        'icon': Icons.person,
        'onTap': () {
          // Navigate to account settings
        },
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications,
        'onTap': () {
          // Navigate to notifications settings
        },
      },
      {
        'title': 'Privacy',
        'icon': Icons.privacy_tip,
        'onTap': () {
          // Navigate to privacy settings
        },
      },
      {
        'title': 'Help & Support',
        'icon': Icons.help,
        'onTap': () {
          // Navigate to help & support
        },
      },
      {
        'title': 'About',
        'icon': Icons.info,
        'onTap': () {
          // Navigate to about page
        },
      },
      {
        'title': 'Log Out',
        'icon': Icons.exit_to_app,
        'onTap': () {
          // Log out
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Card(
          elevation: 2,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: settings.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final setting = settings[index];
              return ListTile(
                leading: Icon(
                  setting['icon'],
                  color:
                      setting['title'] == 'Log Out'
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  setting['title'],
                  style: TextStyle(
                    color: setting['title'] == 'Log Out' ? Colors.red : null,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: setting['onTap'],
              );
            },
          ),
        ),
      ],
    );
  }
}
