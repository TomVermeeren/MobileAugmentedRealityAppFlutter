import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';

class RouteToLeerList extends StatelessWidget {
  final String titel;
  RouteToLeerList({Key? key, required this.titel}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titel),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: VerkeersbordenLeerListPage(titel: this.titel),
        ),
      ),
    );
  }
}
