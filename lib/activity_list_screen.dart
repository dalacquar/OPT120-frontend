import 'package:flutter/material.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/activity_registration_screen.dart';

class ActivityListScreen extends StatefulWidget {
  @override
  _ActivityListScreenState createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  final ActivityService activityService = ActivityService();
  late List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    List<Activity> activities = await activityService.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
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
                      _activities[index].nome ?? '',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                            '${(_activities[index].descricao == null || _activities[index].descricao == '') ? "Tarefa sem descrição" : _activities[index].descricao}\nData de Entrega: ${(_activities[index].date_limit == null || _activities[index].date_limit == '') ? "Tarefa sem data de entrega definido" : _activities[index].date_limit}'),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              String? results = await activityService
                                  .deleteActivity(_activities[index].id == null
                                      ? 0
                                      : _activities[index].id);
                              if (results != null) {
                                _showDialog(context, results);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityListScreen(),
                                  ),
                                );
                              } else {
                                _showDialog(
                                    context, 'Erro ao excluir atividade');
                              }
                            } catch (e) {
                              _showDialog(
                                  context, 'Erro ao cadastrar atividade');
                            }
                          },
                          child: Text('Excluir atividade'),
                        ),
                      ],
                    ));
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
