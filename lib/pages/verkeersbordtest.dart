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

  // Hier declareer ik alle variabelen die ik in verschillende functies gebruik
  bool shouldDisplay = false;
  String bericht = "";
  int nextposition = 0;
  String alertButtonText = "";
  String foutbericht = "";
  MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => DetailPage(position: 0, list: List.empty()));
  List<int> values = [];
  Random random = Random();
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

// Als ik deze functie oproep, wordt het foutbericht geupdate (dit is een Text widget bovenaan de antwoordknoppen)
  void _setFoutbericht(String foutbericht) {
    setState(() {
      this.foutbericht = foutbericht;
    });
  }

// Door deze functie op te roepen update ik wat er in de "Juist!"-knop komt te staan (de knop die verschijnt wanneer je op het juiste antwoord klikt)
  void _setMessage(String bericht) {
    setState(() {
      this.bericht = bericht;
    });
  }

// In deze functie update ik de route waar de "Juist!"-knop naar verwijst
  void _setRoute(MaterialPageRoute route) {
    setState(() {
      this.route = route;
    });
  }

// Deze functie word gecalled wanneer er op een van de mogelijke antwoorden word geklikt
  void answer({bool antwoordJuist = false}) {
    nextposition = position;
    String currentCategorie = list[position].categorie;
    route = MaterialPageRoute(
        builder: (context) => DetailPage(position: nextposition, list: list));
    if (antwoordJuist) {
      bericht = "Juist! Volgende -->";
      list[position].gehaald = "1";
      // Hier itereer ik door de verkeersbordenlijst, op zoek naar het volgende verkeersbord binnen dezelfde categorie
      while ((nextposition == position ||
              list[nextposition].categorie != currentCategorie) &&
          nextposition < list.length) {
        nextposition += 1;
        // Wanneer ik op het einde van de lijst kom, betekend dit dat we de laatste vraag in de categorie juist hebben beantwoord.
        if (nextposition == list.length) {
          // Hier verander ik dan ook het bericht en de route van de "Juist!"-knop zodat je naar het hoofdscherm terugkeert ipv naar het volgende verkeersbord
          bericht = "Profitiat, deze categorie is klaar!";
          route = MaterialPageRoute(builder: (context) => RouteToHome());
          _setRoute(route);
        }
        if (nextposition == list.length) {
          nextposition = 0;
        }
      }
      antwoordJuist = false;
    }
    // Hier komen we terecht wanneer het antwoord fout is, we geven een foutbericht mee, en zetten de waarde "gehaald" op 0 (hier berekenen we de totaalpunten mee)
    else {
      list[position].gehaald = "0";
      foutbericht = "Fout! Probeer opnieuw.";
      _setFoutbericht(foutbericht);
    }
    _setMessage(bericht);
    // Hier updaten we ook de API zodat de puntentelling wordt bijgehouden
    VerkeersbordApi.updateVerkeersbord(list[position].id, list[position])
        .then((result) {});
  }

// Hierin staat de hele pagina layout
  Scaffold toonAntwoorden() {
    AssetImage avatarAsset = AssetImage(list[position]
        .afbeeldingLink); // De afbeelding van het geselecteerde verkeersbord
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
                        // In deze column staat het foutbericht, de 4 mogelijke antwoorden en de knop om naar de volgende vraag te gaan (initieel onzichtbaar)
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(foutbericht),
                          const SizedBox(height: 30),
                          TextButton(
                            // Fout antwoord
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
                            // Fout antwoord
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
                            // Fout antwoord
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
                              // Juist antwoord - wanneer hierop geklikt wordt, wordt de knop getoont om verder te gaan
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
                                  // Dit is de knop om verder te gaan (of naar de homepage, als je heel de categorie hebt gehad)
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
