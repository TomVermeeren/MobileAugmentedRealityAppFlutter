import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/routetohome.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordtestlist.dart';

class RouteToTestList extends StatelessWidget {
  // titel wordt meegegeven
  final String titel;
  RouteToTestList({Key? key, required this.titel}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //toont de titel van de categorie verkeersborden die we aan het bekijken zijn
      appBar: AppBar(
        title: Text(titel),
      ),
      //toont alle verkeersborden van de categorie waar we op hebben geklikt
      body: Center(
        child: VerkeersbordenTestListPage(titel: titel),
      ),
    );
  }
}
