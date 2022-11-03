import 'package:flutter_verkeersborden_tom_jan/models/categorie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  static String server = 'empty-cameras-hang-94-227-20-155.loca.lt';

  static Future<List<Categorie>> fetchCategorieen() async {
    var url = Uri.https(server, '/categorieen');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((categorie) => Categorie.fromJson(categorie))
          .toList();
    } else {
      throw Exception('Categorieen konden niet geladen worden.');
    }
  }

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
