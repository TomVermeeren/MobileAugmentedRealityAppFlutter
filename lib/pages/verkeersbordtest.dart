import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/apis/verkeersbord_api.dart';
import '../models/verkeersbord.dart';
import 'dart:math';
import 'routetotestlist.dart';
import 'routetohome.dart';

class DetailPage extends StatefulWidget {
  final int position;
  const DetailPage({Key? key, required this.position}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailPageState(position);
}

class _DetailPageState extends State {
  int position;
  List<Verkeersbord> list;
  BuildContext? dcontext;
  bool shouldDisplay = false;
  dismissDailog() {
    if (dcontext != null) {
      Navigator.pop(dcontext!);
    }
  }

  _DetailPageState(this.position);
  List<Verkeersbord> list = [];
  String message = "";
  int nextposition = 0;
  String alertButtonText = "";
  String foutbericht = "";
  List<int> values = [];
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
    punten = 0;
    for (Verkeersbord bord in list) {
      if (bord.gehaald == "1") {
        punten++;
      }
    }

    // Hier stellen we de posities van de foute antwoorden vast, deze mogen niet gelijk zijn aan elkaar of aan het juiste antwoord
    var max = 0;

    if (list.length == 0) {
      max = 1;
    } else {
      max = list.length - 1;
    }
    int nextvalue = 0;
    for (int i = 0; i < 3; i++) {
      do {
        nextvalue = random.nextInt(max);
      } while (values.contains(nextvalue) || nextvalue == position);
      values.add(nextvalue);
    }
  }

  void _setFoutbericht(String foutbericht) {
    setState(() {
      this.foutbericht = foutbericht;
    });
  }

  void _setMessage(String message, String alertButtonText) {
    setState(() {
      this.message = message;
      VerkeersbordApi.fetchVerkeerborden().then((result) {
        if (mounted) {
          setState(() {
            list = result;
          });
        }
      });
      punten = 0;
      for (Verkeersbord bord in list) {
        if (bord.gehaald == "1") {
          punten++;
        }
      }
      this.alertButtonText = alertButtonText;
    });
  }

// deze functie word gecalled wanneer er op een van de mogelijke antwoorden word geklikt
  void answer({bool antwoordJuist = false}) {
    nextposition = position;
    String currentCategorie = list[position].categorie;

    if (antwoordJuist) {
      message = "Correct!";
      alertButtonText = "Volgende vraag";
      list[position].gehaald = "1";

      while ((nextposition == position ||
              list[nextposition].categorie != currentCategorie) &&
          nextposition < list.length) {
        nextposition += 1;
        if (nextposition == list.length) {
          alertButtonText = "Categorie menu";
          message = "Profitiat, deze categorie is klaar!";
          _setMessage(message, alertButtonText);
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        }
        if (nextposition == list.length) {
          nextposition = 0;
        }
      }
      antwoordJuist = false;
      _setMessage(message, alertButtonText);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    } else {
      list[position].gehaald = "0";
      foutbericht = "Fout! Probeer opnieuw.";
      _setFoutbericht(foutbericht);
      _setMessage(message, alertButtonText);
    }
    VerkeersbordApi.updateVerkeersbord(list[position].id, list[position])
        .then((result) {});
  }

  Scaffold toonAntwoorden() {
    // Positie bepalen van volgend verkeersbord binnen deze categorie

    // Dit legt de posities van de foute antwoorden vast, deze mogen niet gelijk zijn aan elkaar of aan het juiste antwoord

    AssetImage avatarAsset = AssetImage(list[position].afbeeldingLink);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Container(
          margin: const EdgeInsets.all(20.0),
          width: 2000,
          height: 2000,
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
                      answer(antwoordJuist: false);
                    },
                    child: Text(list[values[0]].naam),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(antwoordJuist: false);
                    },
                    child: Text(list[values[1]].naam),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      answer(antwoordJuist: false);
                    },
                    child: Text(list[values[2]].naam),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.lightBlue),
                      onPressed: () {
                        // answer(antwoordJuist: true);
                        setState(() {
                          shouldDisplay = !shouldDisplay;
                        });
                      },
                      child: Text(list[position].naam)),
                  shouldDisplay
                      ? Flexible(
                          child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            fixedSize: const Size(200, 30),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          position: nextposition,
                                          list: list,
                                        )));
                          },
                          child: const Text("Volgende"),
                        ))
                      : const Spacer(),
                  Text(foutbericht + punten.toString())
                ],
              )
            ],
          )),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    // ignore: unnecessary_new

    return AlertDialog(
      title: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (alertButtonText.contains("Categorie")) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RouteToHome()));
            } else {
              _setMessage(message, alertButtonText);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            position: nextposition,
                          )));
            }
          },
          child: Text(alertButtonText),
        ),
      ],
    );
  }
}
