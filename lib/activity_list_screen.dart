import 'package:flutter/material.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/activity_registration_screen.dart';

class ActivityListScreen extends StatefulWidget {
  @override
  _ActivityListScreenState createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  final ActivityService activityService = ActivityService();
  late List<Map<String, String>> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    List<Map<String, String>> activities =
        await activityService.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Atividades'),
      ),
      body: _activities != null
          ? ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _activities[index]['nome'] ?? '',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    _activities[index]['descricao'] ?? '',
                    style: TextStyle(fontSize: 14.0),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityRegistrationScreen(),
            ),
          ).then((_) => _loadActivities());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
