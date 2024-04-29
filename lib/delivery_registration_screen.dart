import 'package:flutter/material.dart';
import 'package:frontend/main_screen.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/deliveryService.dart';

class DeliveryRegistrationScreen extends StatefulWidget {
  @override
  DeliveryRegistrationScreenState createState() =>
      DeliveryRegistrationScreenState();
}

class DeliveryRegistrationScreenState
    extends State<DeliveryRegistrationScreen> {
  late int? activityIdChoose = 8;

  final ActivityService activityService = ActivityService();
  final DeliveryService deliveryService = DeliveryService();

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

  TextEditingController _evaluationController = TextEditingController();
  TextEditingController _activityIdController = TextEditingController();

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
        title: Text('Cadastro de Entrega'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nota'),
                onChanged: (value) {
                  final double? nota = double.tryParse(value);
                  if (nota != null) {
                    setState(() {
                      // Atualiza o valor do controller apenas se a conversão for bem-sucedida
                      _evaluationController.text = value;
                    });
                  }
                },
              ),
              DropdownButton<int>(
                value: activityIdChoose,
                onChanged: (newValue) {
                  setState(() {
                    activityIdChoose = newValue;
                  });
                },
                items: _activities.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem.id,
                    child: Text(valueItem.nome ?? ""),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var activityAdd = DeliveryCreate(
                      evaluation: double.tryParse(_evaluationController.text),
                      activityId: activityIdChoose);
                  try {
                    String? results =
                        await deliveryService.createDelivery(activityAdd);
                    if (results != null) {
                      _showDialog(context, results);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    } else {
                      _showDialog(context, 'Erro ao cadastrar entrega');
                    }
                  } catch (e) {
                    _showDialog(context, 'Erro ao cadastrar entrega');
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
