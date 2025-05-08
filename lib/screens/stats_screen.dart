import 'package:flutter/material.dart';
import '../widgets/stats_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _periods = ['Week', 'Month', 'Year'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _periods.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: _periods.map((period) => Tab(text: period)).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    _periods.map((period) {
                      return _buildStatsContent(period);
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsContent(String period) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Container(height: 200, child: StatsChart(period: period)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('Workouts', '12', Icons.fitness_center),
                      _buildSummaryItem(
                        'Calories',
                        '4,320',
                        Icons.local_fire_department,
                      ),
                      _buildSummaryItem('Minutes', '345', Icons.timer),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Activity Breakdown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildActivityBreakdown(),
          SizedBox(height: 24),
          Text(
            'Achievements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildActivityBreakdown() {
    final List<Map<String, dynamic>> activities = [
      {'name': 'Strength Training', 'percentage': 45, 'color': Colors.blue},
      {'name': 'Cardio', 'percentage': 30, 'color': Colors.red},
      {'name': 'Flexibility', 'percentage': 15, 'color': Colors.purple},
      {'name': 'Other', 'percentage': 10, 'color': Colors.green},
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              activities.map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activity['name']),
                          Text('${activity['percentage']}%'),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: activity['percentage'] / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          activity['color'],
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    final List<Map<String, dynamic>> achievements = [
      {
        'title': '5 Day Streak',
        'description': 'Completed workouts for 5 consecutive days',
        'icon': Icons.whatshot,
        'color': Colors.orange,
        'completed': true,
      },
      {
        'title': 'Early Bird',
        'description': 'Completed a workout before 7 AM',
        'icon': Icons.wb_sunny,
        'color': Colors.amber,
        'completed': true,
      },
      {
        'title': 'Muscle Builder',
        'description': 'Completed 10 strength training workouts',
        'icon': Icons.fitness_center,
        'color': Colors.blue,
        'completed': false,
      },
      {
        'title': 'Marathon Runner',
        'description': 'Ran a total of 26.2 miles',
        'icon': Icons.directions_run,
        'color': Colors.green,
        'completed': false,
      },
    ];

    return Card(
      elevation: 2,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  achievement['completed']
                      ? achievement['color']
                      : Colors.grey[300],
              child: Icon(achievement['icon'], color: Colors.white),
            ),
            title: Text(
              achievement['title'],
              style: TextStyle(
                fontWeight:
                    achievement['completed']
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
            subtitle: Text(achievement['description']),
            trailing:
                achievement['completed']
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.lock, color: Colors.grey),
          );
        },
      ),
    );
  }
}
