import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/routetohome.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordtestlist.dart';

class RouteToTestList extends StatelessWidget {
  final String titel;
  RouteToTestList({Key? key, required this.titel}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titel),
      ),
      body: Center(
        child: VerkeersbordenTestListPage(titel: titel),
      ),
    );
  }
}
