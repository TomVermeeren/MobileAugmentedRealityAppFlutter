import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/apis/verkeersbord_api.dart';
import '../models/verkeersbord.dart';
import 'dart:math';
import 'routetotestlist.dart';
import 'routetohome.dart';

class DetailPage extends StatefulWidget {
  final int position;
  final List<Verkeersbord> list;
  const DetailPage({Key? key, required this.position, required this.list})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailPageState(position, list);
}

class _DetailPageState extends State {
  int position;
  List<Verkeersbord> list;

  _DetailPageState(this.position, this.list);
  String message = "";
  int nextposition = 0;
  String alertButtonText = "";
  String foutbericht = "";
  Verkeersbord verkeersbord = new Verkeersbord(
      id: 20,
      naam: "naam",
      beschrijving: "beschrijving",
      afbeeldingLink: "afbeeldingLink",
      categorie: "categorie",
      gehaald: "gehaald");
  int punten = 0;
  Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: toonAntwoorden(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setMessage("Default", alertButtonText);
  }

  void _setFoutbericht(String foutbericht) {
    setState(() {
      this.foutbericht = foutbericht;
    });
  }

  void _setMessage(String message, String alertButtonText) {
    setState(() {
      this.message = message;
      this.verkeersbord = verkeersbord;
      this.alertButtonText = alertButtonText;
    });
  }

// deze functie word gecalled wanneer er op een van de mogelijke antwoorden word geklikt
  void answer(bool antwoordJuist) {
    nextposition = position;
    String currentCategorie = list[position].categorie;

    if (antwoordJuist) {
      message = "Correct!";
      alertButtonText = "Volgende vraag";
      list[position].gehaald = "1";
      VerkeersbordApi.updateVerkeersbord(position, list[position]);
      while ((nextposition == position ||
              list[nextposition].categorie != currentCategorie) &&
          nextposition < 21) {
        nextposition += 1;
        if (nextposition == 21) {
          alertButtonText = "Categorie menu";
          message = "Profitiat, deze categorie is klaar!";
          _setMessage(message, alertButtonText);
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        }
        if (nextposition == 21) {
          nextposition = 0;
        }
      }

      _setMessage(message, alertButtonText);

      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    } else {
      foutbericht = "Fout! Probeer opnieuw.";
      _setFoutbericht(foutbericht);
    }
  }

  Scaffold toonAntwoorden() {
    // Positie bepalen van volgend verkeersbord binnen deze categorie
    var max = 0;

    if (list.length == 0) {
      max = 1;
    } else {
      max = list.length - 1;
    }
    // Dit legt de posities van de foute antwoorden vast, deze mogen niet gelijk zijn aan elkaar of aan het juiste antwoord
    List<int> values = [];
    int nextvalue = 0;
    for (int i = 0; i < 3; i++) {
      do {
        nextvalue = random.nextInt(max);
      } while (values.contains(nextvalue) || nextvalue == position);
      values.add(nextvalue);
    }

    AssetImage avatarAsset = AssetImage(list[position].afbeeldingLink);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Container(
          margin: const EdgeInsets.all(20.0),
          width: 2000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Wat betekent dit bord?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Flexible(
                  child: Image(
                image: avatarAsset,
                width: 300.0,
              )),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(true);
                    },
                    child: Text(list[position].naam),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(false);
                    },
                    child: Text(list[values[0]].naam),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(false);
                    },
                    child: Text(list[values[1]].naam),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(false);
                    },
                    child: Text(list[values[2]].naam),
                  ),
                  Text(foutbericht + punten.toString())
                ],
              )
            ],
          )),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    // ignore: unnecessary_new
    return new AlertDialog(
      title: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => RouteToTestList(
                          titel: list[position].categorie,
                        )));
          },
          child: const Text('Terug naar menu'),
        ),
        TextButton(
          onPressed: () {
            if (alertButtonText.contains("Categorie")) {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => RouteToHome()));
            } else {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DetailPage(
                            position: nextposition,
                            list: list,
                          )));
            }
          },
          child: Text(alertButtonText),
        ),
      ],
    );
  }
}
