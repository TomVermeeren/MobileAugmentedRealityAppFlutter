import 'package:flutter/material.dart';
import '../models/categorie.dart';
import '../apis/verkeersbord_api.dart';
import 'routetotestlist.dart';

class CategorieTestListPage extends StatefulWidget {
  const CategorieTestListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategorieTestListPageState();
}

class _CategorieTestListPageState extends State {
  // we maken een categorielist aan die we later gaan vullen
  List<Categorie> categorieList = [];
  // count gaat dienen voor het aantal items in onze list
  int count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      // we voegen een lijst van al onze items toe in de container
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: categorieTestListItems(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // bij initialisatie wordt de categorie lijst gevuld en de count aangepast met het aantal items in de lijst
    _getCategorieen();
  }

  // deze methode haalt de categorieën op van de api en vult de eerder gedeclareerde lijst ermee. Past ook de count aan.
  void _getCategorieen() {
    VerkeersbordApi.fetchCategorieen().then((result) {
      if (mounted) {
        setState(() {
          categorieList = result;
          count = result.length;
        });
      }
    });
  }

// Hier staat de inhoud die we bovenaan in de widget gebruiken.
  ListView categorieTestListItems() {
    // we geven een listview terug waar al onze categorieën in zitten.
    return ListView.builder(
        itemCount: count,
        // position zorgt ervoor dat deze itembuilder eigenlijk een for loop is, waarbij alles om de beurt wordt geplakt
        itemBuilder: (BuildContext context, int position) {
          //declareer afbeelding link om later te gebruiken in opmaak
          AssetImage afbeelding1 =
              AssetImage(categorieList[position].afbeeldingLink);

          return Container(
              margin: const EdgeInsets.all(5.0),
              child: (() {
                // Als er een oneven aantal categorieën is en we zijn bij de laatste categorie aangekomen,
                // dan geven we deze opmaak terug, als het aantal categorieën even is, of we zijn nog niet
                // bij de laatste aangekomen, dan plakken we de opmaak bij de else functie hieronder
                if (categorieList[position].id.isOdd &&
                    categorieList[position].id <= categorieList.length - 1) {
                  // declareer afbeelding aan de hand van het huidige aantal keer dat er al door itembuilder is geloopt
                  AssetImage afbeelding2 =
                      AssetImage(categorieList[position + 1].afbeeldingLink);
                  return Row(children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        //button die ons doorverwijst naar de lijst van verkeersborden van de categorie waar we op klikken
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => RouteToTestList(
                                        titel: categorieList[position].naam)),
                              );
                            },
                            // geeft onze afbeelding terug met de naam van de categorie
                            child: Column(children: [
                              Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image(
                                    height: 150,
                                    image: afbeelding1,
                                  )),
                              Text(categorieList[position].naam),
                            ])),
                      ),
                    ),
                    // Hier hetzelfde als bij bovenstaande Expanded, dit is voor het tweede item in de rij
                    Expanded(
                      child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => RouteToTestList(
                                          titel: categorieList[position + 1]
                                              .naam)),
                                );
                              },
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.all(20),
                                    child: Image(
                                      height: 150,
                                      image: afbeelding2,
                                    )),
                                Text(categorieList[position + 1].naam),
                              ]))),
                    )
                  ]);
                  // als het huidige aantal keer dat we door de itembuilder geloopt zijn oneven is, dan voeren we deze code uit.
                } else if (categorieList[position].id.isOdd) {
                  return Row(children: [
                    Expanded(
                        child: Card(
                            semanticContainer: true,
                            color: Colors.white,
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => RouteToTestList(
                                            titel:
                                                categorieList[position].naam)),
                                  );
                                },
                                child: Column(children: [
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Image(
                                      height: 150,
                                      image: afbeelding1,
                                    ),
                                  ),
                                  Text(categorieList[position].naam),
                                ])))),
                    Expanded(
                      child: Text(""),
                    )
                  ]);
                }
              }()));
        });
  }
}
