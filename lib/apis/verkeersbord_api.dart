import 'package:flutter_verkeersborden_tom_jan/models/categorie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  static String server = 'silver-lizards-guess-94-227-20-155.loca.lt';

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

  static Future<Verkeersbord> updateVerkeersbord(
      int id, Verkeersbord verkeersbord) async {
    var url = Uri.https(server, '/verkeersborden/$id');

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(verkeersbord),
    );
    if (response.statusCode == 200) {
      return Verkeersbord.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Niet gelukt om verkeersbord te updaten');
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

  // static Future<Verkeersbord> fetchVerkeersbordByImageName(String name) async {
  //   name = "Voorrangsweg";
  //   var url = Uri.https(server, '/verkeersborden?naam=$name');

  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     return Verkeersbord.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Failed to load verkeersbord");
  //   }
  // }
}
