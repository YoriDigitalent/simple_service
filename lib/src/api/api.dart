import 'package:simple_service/src/model/model.dart';

import 'package:http/http.dart' show Client;

class Api {
  final String baseUrl = 'http://flutter.app:8005';
  Client client = Client();

  Future<List<Bio>> getBio() async {
    final response = await client.get(Uri.parse('$baseUrl/api/bio'));
    if (response.statusCode == 200) {
      return bioFromJson(response.body);
    } else {
      throw Exception;
    }
  }

  Future<bool> createBio(Bio data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/bio'),
      headers: {"content-type": "application/json"},
      body: bioToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
