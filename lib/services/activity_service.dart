import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert'; // Importe a biblioteca para lidar com JSON

class ActivityService {
  Future<void> createActivity(String nome, String descricao) async {
    var body = {
      'nome': nome,
      'descricao': descricao,
    };

    try {
      final response = await http.post(Uri.parse('${Config.baseUrl}/activity'),
          headers: <String, String>{
            'Content-Type':
                'application/json; charset=UTF-8', // Defina o cabeçalho Content-Type
          }, // Use a base URL da classe Config
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        print('Atividade criada com sucesso');
      } else {
        print(
            'Falha ao criar Atividade: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Erro ao criar Atividade: $e');
    }
  }
}
