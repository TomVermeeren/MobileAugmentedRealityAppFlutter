import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/apis/verkeersbord_api.dart';
import '../models/verkeersbord.dart';
import 'dart:math';
import 'routetohome.dart';

class DetailPage extends StatefulWidget {
  // We vragen de lijst met verkeersborden mee en de positie van het verkeersbord waar we in deze pagina een test over maken
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

  bool shouldDisplay = false;
  String bericht = "";
  int nextposition = 0;
  String alertButtonText = "";
  String foutbericht = "";
  MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => DetailPage(position: 0, list: List.empty()));
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
    _setMessage("Default");
    punten = 0;
    for (Verkeersbord bord in list) {
      if (bord.gehaald == "1") {
        punten++;
      }
    }

    // Hier stellen we de posities van de foute antwoorden vast, deze mogen niet gelijk zijn aan elkaar of aan het juiste antwoord
    var max = 0;

    if (list.isEmpty) {
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

  void _setMessage(String bericht) {
    setState(() {
      this.bericht = bericht;
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
    });
  }

// deze functie word gecalled wanneer er op een van de mogelijke antwoorden word geklikt
  void answer({bool antwoordJuist = false}) {
    nextposition = position;
    String currentCategorie = list[position].categorie;
    route = MaterialPageRoute(
        builder: (context) => DetailPage(position: nextposition, list: list));
    if (antwoordJuist) {
      bericht = "Juist! Volgende -->";
      list[position].gehaald = "1";

      while ((nextposition == position ||
              list[nextposition].categorie != currentCategorie) &&
          nextposition < list.length) {
        nextposition += 1;
        if (nextposition == list.length) {
          bericht = "Profitiat, deze categorie is klaar!";
          route = MaterialPageRoute(builder: (context) => RouteToHome());
          setState(() {
            route = route;
          });
        }
        if (nextposition == list.length) {
          nextposition = 0;
        }
      }
      antwoordJuist = false;
    } else {
      list[position].gehaald = "0";
      foutbericht = "Fout! Probeer opnieuw.";
      _setFoutbericht(foutbericht);
    }
    _setMessage(bericht);

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
          child: SizedBox(
              width: 1500,
              height: 1500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(
                      width: 500,
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(foutbericht),
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
                                answer(antwoordJuist: true);
                                setState(() {
                                  shouldDisplay = !shouldDisplay;
                                });
                              },
                              child: Text(list[position].naam)),
                          shouldDisplay
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.lightGreen),
                                  onPressed: () {
                                    Navigator.push(context, route);
                                  },
                                  child: Text(bericht),
                                )
                              : const Spacer(),
                        ],
                      ))
                ],
              ))),
    );
  }
}
