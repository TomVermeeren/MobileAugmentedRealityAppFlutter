import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  static String server = 'common-points-bake-94-227-20-155.loca.lt';

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
