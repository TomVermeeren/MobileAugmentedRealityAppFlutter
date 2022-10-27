import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  static String server = 'quiet-banks-slide-81-246-184-163.loca.lt';

  static Future<List<Verkeersbord>> fetchVerkeerborden() async {
    var url = Uri.https(server, '/verkeersborden');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((verkeersbord) => Verkeersbord.fromJson(verkeersbord))
          .toList();
    } else {
      throw Exception('Verkeersborden konden niet geladen worden.');
    }
  }
}
