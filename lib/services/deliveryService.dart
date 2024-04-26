import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'dart:convert';

class Delivery {
  final int id;
  final double evaluation;
  final String createdAt;
  final int activityId;
  final int userId;

  Delivery(
      {required this.id,
      required this.evaluation,
      required this.createdAt,
      required this.activityId,
      required this.userId});
}

class DeliveryCreate {
  final double? evaluation;
  final int? activityId;

  DeliveryCreate({required this.evaluation, required this.activityId});
}

class DeliveryService {
  Future<String?> createDelivery(DeliveryCreate deliveryCreate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    var body = {
      'evaluation': deliveryCreate.evaluation,
      'activityId': deliveryCreate.activityId,
    };

    try {
      final response = await http.post(Uri.parse('${Config.baseUrl}/delivery'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        return ('Atividade criada com sucesso');
      } else {
        print(
            'Falha ao criar Atividade: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro ao criar Atividade: $e');
      return null;
    }
  }

  Future<List<Delivery>> getDeliveries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse('${Config.baseUrl}/delivery'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Delivery> activities = [];
        for (var item in data) {
          activities.add(Delivery(
              id: item['id'],
              evaluation: double.tryParse(item['evaluation']) ?? -1,
              createdAt: item['createdAt'] ?? '',
              activityId: item['activityId'] ?? -1,
              userId: item['userId'] ?? -1));
        }
        return activities;
      } else {
        print(
            'Falha ao obter entregas: ${response.statusCode} ${response.body}');
        throw Exception('Failed to load activities');
      }
    } catch (e) {
      print('Erro ao obter atividades: $e');
      throw Exception('Failed to load activities');
    }
  }
}
