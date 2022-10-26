// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../pages/leerverbodsbord.dart';
import '../pages/leergevarenbord.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});
  @override
  _State createState() => _State();
}

class _State extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: ElevatedButton(
              child: const Text('Verbodsbord'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RouteVerbodsbord()),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ElevatedButton(
              child: const Text('Gevarenbord'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RouteGevarenbord()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
