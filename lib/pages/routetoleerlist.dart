import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';

class RouteToLeerList extends StatelessWidget {
  // titel wordt meegegeven
  final String titel;
  RouteToLeerList({Key? key, required this.titel}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //toont de titel van de categorie verkeersborden die we aan het bekijken zijn
      appBar: AppBar(
        title: Text(titel),
      ),
      body: Center(
        //toont alle verkeersborden van de categorie waar we op hebben geklikt
        child: ElevatedButton(
          onPressed: () {},
          child: VerkeersbordenLeerListPage(titel: this.titel),
        ),
      ),
    );
  }
}
