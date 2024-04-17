import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert'; // Importe a biblioteca para lidar com JSON

class UserService {
  Future<void> createUser(String name, String email, String password) async {
    var body = {
      'name': name,
      'email': email,
      'password': password,
      'phone': ""
    };

    try {
      final response = await http.post(Uri.parse('${Config.baseUrl}/user'),
          headers: <String, String>{
            'Content-Type':
                'application/json; charset=UTF-8', // Defina o cabeçalho Content-Type
          }, // Use a base URL da classe Config
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        print('Usuário criado com sucesso');
      } else {
        print(
            'Falha ao criar usuário: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Erro ao criar usuário: $e');
    }
  }
}
