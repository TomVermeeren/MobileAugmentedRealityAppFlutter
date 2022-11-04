import 'package:flutter/cupertino.dart';
import 'package:flutter_verkeersborden_tom_jan/models/categorie.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/verkeersbord.dart';

class VerkeersbordApi {
  static String server = 'twenty-rats-wonder-81-246-184-163.loca.lt';

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

  static Future<Verkeersbord> fetchVerkeersbordByImageName(String name) async {
    // name = "Voorrangsweg";
    List<Verkeersbord> verkeersbordenList = [];
    var url = Uri.https(server, '/verkeersborden');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      verkeersbordenList = jsonResponse
          .map((verkeersbord) => Verkeersbord.fromJson(verkeersbord))
          .toList();
    } else {
      throw Exception('Verkeersborden konden niet geladen worden.');
    }
    // fetchVerkeerborden().then((result) => verkeersbordenList = result);
    debugPrint(
        "verkeersbordenlist in de api: " + verkeersbordenList.toString());

    for (Verkeersbord verkeersbord in verkeersbordenList) {
      debugPrint("verkeersbord in de for loop: $verkeersbord");
      if (verkeersbord.afbeeldingLink == "assets/$name.png") {
        name = verkeersbord.naam;
        debugPrint("Name is gelijk aan: " + name);
      }
    }
    debugPrint("de image scanned na het einde van de for loop is: $name");
    // var verkeersbord;
    // for (verkeersbord in verkeersbordenList){
    //   if(verkeersbord[afbeeldingLink] == name ){
    //     name
    //   }
    // }
    debugPrint("de naam in api is: " + name);
    url = Uri.parse('https://$server/verkeersborden?naam=$name');
    debugPrint("de url in api is: " + url.toString());
    response = await http.get(url);
    debugPrint("de response code in api is: " +
        Verkeersbord.fromJson(jsonDecode(response.body)[0]).toString());
    if (response.statusCode == 200) {
      return Verkeersbord.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Failed to load verkeersbord");
    }
  }
}
