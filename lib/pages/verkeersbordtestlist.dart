import 'package:flutter/material.dart';
import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';
import 'verkeersbordtest.dart';
import 'dart:math';

class VerkeersbordenTestListPage extends StatefulWidget {
  final String titel;
  const VerkeersbordenTestListPage({Key? key, required this.titel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerkeersbordTestListPageState(titel);
}

class _VerkeersbordTestListPageState extends State {
  String titel;

  _VerkeersbordTestListPageState(this.titel);

//declareer variabelen die we later vullen en gebruiken
  List<Verkeersbord> verkeersbordList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5.0),
        // roept methode op waarin de inhoud staat die we gaan tonen
        child: verkeersbordListItems(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // tijdens initialisatie roepen we de getverkeersborden op, om de list te vullen
    _getVerkeersborden();
  }

// vult de verkeersbordList met alle verkeersborden, die we ophalen uit de API
// past ook count aan voor het aantal items in de list
  void _getVerkeersborden() {
    VerkeersbordApi.fetchVerkeerborden().then((result) {
      if (mounted) {
        setState(() {
          verkeersbordList = result;
          count = result.length;
        });
      }
    });
  }

  //listview die we bovenaan gebruiken als child
  ListView verkeersbordListItems() {
    return ListView.builder(
        // het aantal keer dat we de itembuilder doorlopen
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          //afbeelding declareren om later te gebruiken, aan de hand van hoevaak we al door itembuilder zijn geloopt.
          AssetImage afbeeldinglink =
              AssetImage(verkeersbordList[position].afbeeldingLink);
          return Container(
              child: (() {
            // we kijken na of het verkeersbord in deze categorie toebehoort.
            // zo ja, tonen we een card.
            // zo nee, doen we niets met het verkeersbord en loopen we opnieuw door itembuilder
            if (verkeersbordList[position].categorie == titel) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                // we maken en knop die doorverwijst naar de detailpagina van het huidig verkeersborden in de loop
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          // we geven de nodige data mee aan DetailPage
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    position: position,
                                    list: verkeersbordList,
                                  )));
                    },
                    child: Column(
                      children: [
                        // we zorgen ervoor dat de juiste afbeelding bij het juiste verkeersbord staat.
                        Image(
                          image: afbeeldinglink,
                          height: 150.0,
                        ),
                      ],
                    )),
              );
            }
          }()));
        });
  }
}
