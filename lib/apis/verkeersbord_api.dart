import 'package:flutter/cupertino.dart';
import 'package:flutter_verkeersborden_tom_jan/models/categorie.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';
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

  static Future<Verkeersbord> fetchVerkeersbordByImageName(String name) async {
    // name = "Voorrangsweg";
    var verkeersbordenList = [
      {
        "id": 1,
        "naam": "Zone 30",
        "beschrijving":
            "Dit verkeersbord geeft aan dat hier het begin is van een zone met een snelheidsbeperking van 30km per uur.",
        "afbeeldingLink": "assets/Verkeersbord_A1-30zb.png",
        "categorie": "Aanwijzingsborden",
        "gehaald": "0",
        "videoLink": 1
      },
      {
        "id": 2,
        "naam": "Einde zone 30",
        "beschrijving":
            "Dit verkeersbord geeft aan dat hier het einde is van een zone met een snelheidsbeperking van 30km per uur.",
        "afbeeldingLink": "assets/Verkeersbord_A1-30ze.png",
        "categorie": "Aanwijzingsborden",
        "gehaald": "0",
        "videoLink": 1
      },
      {
        "id": 3,
        "naam": "Maximum 70km/h",
        "beschrijving":
            "Vanaf het verkeersbord tot en met het volgend kruispunt, of tot elk verkeersbord van maximum 70km/h met of zonder zonale geldigheid, of tot het verkeersbord dat het begin of het einde van een bebouwde kom, van een woonerf of erf, of van een voetgangerszone aanduidt, verbod te rijden met een grotere snelheid dan deze die is aangeduid.",
        "afbeeldingLink": "assets/Verkeersbord_A1-70.png",
        "categorie": "Verbodsborden",
        "gehaald": "0",
        "videoLink": 2
      },
      {
        "id": 4,
        "naam": "Voorrangsweg",
        "beschrijving":
            "Dit verkeersbord geeft aan dat je je op een voorrangsweg bevindt.",
        "afbeeldingLink": "assets/Verkeersbord_B1.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 5,
        "naam": "Einde voorrangsweg",
        "beschrijving":
            "Dit verkeersbord geeft aan dat je het einde van de voorrangsweg naderd. Dit verkeersbord wordt geplaatst bij het naderen van het kruispunt waar de voorrangsweg dit karakter verliest, behalve aan de uitrit van een autosnelweg waar het niet geplaatst mag worden.",
        "afbeeldingLink": "assets/Verkeersbord_B2.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 6,
        "naam": "Voorrang verlenen",
        "beschrijving":
            "Dit verkeersbord plaats je in de onmiddellijke nabijheid van een plaats waar een bestuurder voorrang moet verlenen.",
        "afbeeldingLink": "assets/Verkeersbord_B6.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 7,
        "naam": "Stoppen en voorrang verlenen",
        "beschrijving":
            "Dit verkeersbord wordt geplaatst in de onmiddellijke omgeving van het kruispunt waar de bestuurder moet stoppen en voorrang verlenen.",
        "afbeeldingLink": "assets/Verkeersbord_B7.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 8,
        "naam": "Verboden toegang",
        "beschrijving":
            "Verboden toegang, in beide richtingen, voor iedere bestuurder.",
        "afbeeldingLink": "assets/Verkeersbord_C1.png",
        "categorie": "Verbodsborden",
        "gehaald": "0",
        "videoLink": 2
      },
      {
        "id": 9,
        "naam": "Verboden richting",
        "beschrijving": "Verboden richting voor iedere bestuurder.",
        "afbeeldingLink": "assets/Verkeersbord_C2.png",
        "categorie": "Verbodsborden",
        "gehaald": "0",
        "videoLink": 2
      },
      {
        "id": 10,
        "naam": "Verbod een voertuig links in te halen",
        "beschrijving":
            "Vanaf het verkeersbord tot en met het volgend kruispunt, verbod een gespan of een voertuig met meer dan twee wielen, links in te halen.",
        "afbeeldingLink": "assets/Verkeersbord_F1.png",
        "categorie": "Verbodsborden",
        "gehaald": "0",
        "videoLink": 2
      },
      {
        "id": 11,
        "naam": "Voorrang bij smalle doorgang",
        "beschrijving":
            "Verkeersbord dat een smalle doorgang aangeeft. Voorrang ten opzichte van de bestuurders die uit de tegenovergestelde richting komen.",
        "afbeeldingLink": "assets/Verkeersbord_F6.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 12,
        "naam": "Einde autosnelweg",
        "beschrijving":
            "Dit verkeersbord geeft aan dat dit het einde van een autosnelweg is.",
        "afbeeldingLink": "assets/Verkeersbord_G2.png",
        "categorie": "Aanwijzingsborden",
        "gehaald": "0",
        "videoLink": 1
      },
      {
        "id": 13,
        "naam": "Einde van de autoweg",
        "beschrijving":
            "Dit verkeersbord geeft aan dat vanaf dat hier het einde is van de autoweg. De bijzondere verkeersregels gelden vanaf hier ook niet meer.",
        "afbeeldingLink": "assets/Verkeersbord_G4.png",
        "categorie": "Aanwijzingsborden",
        "gehaald": "0",
        "videoLink": 1
      },
      {
        "id": 14,
        "naam": "Voorrang van rechts",
        "beschrijving":
            "Dit verkeersbord wordt geplaatst in de onmiddellijke omgeving van een kruispunt waar de voorrang van rechts geldt.",
        "afbeeldingLink": "assets/Verkeersbord_J8.png",
        "categorie": "Voorrangsborden",
        "gehaald": "0",
        "videoLink": 3
      },
      {
        "id": 15,
        "naam": "Rotonde",
        "beschrijving":
            "Dit verkeersbord geeft aan dat er een rotonde is, waarbij je de richting van de pijlen moet volgen.",
        "afbeeldingLink": "assets/Verkeersbord_D5.png",
        "categorie": "Gebodsborden",
        "gehaald": "0",
        "videoLink": 4
      },
      {
        "id": 16,
        "naam": "Linkerrijstrook wordt ingevoegd",
        "beschrijving":
            "Dit verkeersbord geeft aan dat de linkerrijstrook van een andere rijbaan op de huidige baan wordt ingevoegd.",
        "afbeeldingLink": "assets/Verkeersbord_J19.png",
        "categorie": "Gevaarsborden",
        "gehaald": "0",
        "videoLink": 5
      },
      {
        "id": 17,
        "naam": "Gladde rijbaan - Slipgevaar",
        "beschrijving":
            "Dit gevaarsbord geeft aan dat er slipgevaar is. De weggebruiker moet zijn snelheid en rijgedrag aanpassen.",
        "afbeeldingLink": "assets/Verkeersbord_J20.png",
        "categorie": "Gevaarsborden",
        "gehaald": "0",
        "videoLink": 5
      },
      {
        "id": 18,
        "naam": "Naderende verkeerslichten",
        "beschrijving":
            "Dit verkeersbord geeft aan dat er verkeerslichten naderen.",
        "afbeeldingLink": "assets/Verkeersbord_J32.png",
        "categorie": "Gevaarsborden",
        "gehaald": "0",
        "videoLink": 5
      },
      {
        "id": 19,
        "naam": "Opgelet kinderen",
        "beschrijving":
            "Dit gevaarsbord geeft aan dat je een plaats nadert waar specifiek veel kinderen zijn. De weggebruiker moet hier extra oplettend zijn",
        "afbeeldingLink": "assets/Verkeersbord_J21.png",
        "categorie": "Gevaarsborden",
        "gehaald": "0",
        "videoLink": 5
      },
      {
        "id": 20,
        "naam": "Verplicht de aangeduide richting te volgen (linksaf)",
        "beschrijving":
            "Dit verkeersbord geeft aan dat je verplicht bent de aangeduide richting te volgen (linksaf)",
        "afbeeldingLink": "assets/Verkeersbord_D1e.png",
        "categorie": "Gebodsborden",
        "gehaald": "0",
        "videoLink": 4
      },
      {
        "id": 21,
        "naam": "Verplicht één van de pijlen te volgen.",
        "beschrijving":
            "Dit verkeersbord geeft aan dat je verplicht bent één van de pijlen te volgen.",
        "afbeeldingLink": "assets/Verkeersbord_D3b.png",
        "categorie": "Gebodsborden",
        "gehaald": "0",
        "videoLink": 4
      },
      {
        "naam": "Verplichte weg voor voetgangers.",
        "beschrijving":
            "Dit verkeersbord geeft aan dat voetgangers hier verplicht moeten wandelen.",
        "afbeeldingLink": "assets/Verkeersbord_D11.png",
        "categorie": "Gebodsborden",
        "gehaald": "1",
        "videoLink": 4,
        "id": 22
      }
    ];

    // fetchVerkeerborden().then((result) => verkeersbordenList = result);
    debugPrint(
        "verkeersbordenlist in de api: " + verkeersbordenList.toString());

    var verkeersbord;
    for (verkeersbord in verkeersbordenList) {
      debugPrint("verkeersbord in de for loop: $verkeersbord");
      if (verkeersbord["afbeeldingLink"] == "assets/$name.png") {
        name = verkeersbord["naam"];
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
    var url = Uri.parse('https://$server/verkeersborden?naam=$name');
    debugPrint("de url in api is: " + url.toString());
    final response = await http.get(url);
    debugPrint("de response code in api is: " + response.toString());
    if (response.statusCode == 200) {
      return Verkeersbord.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Failed to load verkeersbord");
    }
  }
}
