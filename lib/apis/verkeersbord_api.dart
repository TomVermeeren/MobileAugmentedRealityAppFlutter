import 'package:flutter/cupertino.dart';
import 'package:flutter_verkeersborden_tom_jan/models/categorie.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  // link naar onze API (aan te passen bij restart)
  static String server = 'twenty-rats-wonder-81-246-184-163.loca.lt';

// methode om al de categorieën op te halen uit de API
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

// methode om een verkeersborden te updaten in de API (deze wordt gebruikt om het puntensysteem te onthouden)
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

// methode om al de verkeersborden op te halen uit de API
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

// methode om het juiste verkeersbord op te halen uit de API
  static Future<Verkeersbord> fetchVerkeersbordByImageName(String name) async {
    // lijst aanmaken om zo meteen te gebruiken
    List<Verkeersbord> verkeersbordenList = [];
    // maak url
    var url = Uri.https(server, '/verkeersborden');
// check of de API up & running is
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // neem de json output en steek het in een variable
      List jsonResponse = json.decode(response.body);
      // vul de list met deze verkeersborden
      verkeersbordenList = jsonResponse
          .map((verkeersbord) => Verkeersbord.fromJson(verkeersbord))
          .toList();
    } else {
      throw Exception('Verkeersborden konden niet geladen worden.');
    }

// voor elk verkeersbord in de list gaan we kijken of de name zich in de afbeeldinglink bevind.
// dit doen we omdat we van wikitude de afbeelding link doorkrijgen.
    for (Verkeersbord verkeersbord in verkeersbordenList) {
      if (verkeersbord.afbeeldingLink == "assets/$name.png") {
        //pas name aan naar de effectieve naam, en niet de afbeelding naam.
        name = verkeersbord.naam;
      }
    }
    // we passen de url aan om alleen de inhoud van het verkeersbord dat we willen opvragen, op te vragen.
    url = Uri.parse('https://$server/verkeersborden?naam=$name');
    response = await http.get(url);
    if (response.statusCode == 200) {
      // geef de inhoud van het specifieke verkeersbord terug (om het dan te gebruiken in de communicatie tussen
      // flutter en wikitude)
      return Verkeersbord.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Failed to load verkeersbord");
    }
  }
}
