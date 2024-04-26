import 'package:flutter/material.dart';
import 'package:frontend/delivery_registration_screen.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/activity_registration_screen.dart';
import 'package:frontend/services/deliveryService.dart';

class DeliveryListScreen extends StatefulWidget {
  @override
  _DeliveryListScreenState createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen> {
  final DeliveryService deliveryService = DeliveryService();
  late List<Delivery> _deliveries = [];

  @override
  void initState() {
    super.initState();
    _loadDeliveries();
  }

  Future<void> _loadDeliveries() async {
    List<Delivery> deliveries = await deliveryService.getDeliveries();
    setState(() {
      _deliveries = deliveries;
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
        title: Text('Lista de Entregas'),
      ),
      body: _deliveries != null
          ? ListView.builder(
              itemCount: _deliveries.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                      _deliveries[index].activityId != null
                          ? "Atividade: ${_deliveries[index].activityId}"
                          : '',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                            '${(_deliveries[index].createdAt == null || _deliveries[index].createdAt == '') ? "Entrega sem data" : "\nEntrega realizada em: ${(_deliveries[index].createdAt)}"} \nNota: ${(_deliveries[index].evaluation)} \nAluno: ${(_deliveries[index].userId)}'),
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
              builder: (context) => DeliveryRegistrationScreen(),
            ),
          ).then((_) => _loadDeliveries());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
