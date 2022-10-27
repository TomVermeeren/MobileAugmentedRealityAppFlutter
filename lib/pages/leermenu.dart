// ignore_for_file: prefer_const_constructors
// VOORLOPIG IS DEZE NIET FUNCTIONEEL

import 'package:flutter/material.dart';
import '../pages/leergevarenbord.dart';

import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: ElevatedButton(
            child: const Text('Verbodsbord'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRoute(titel: "Test")),
              );
            },
          ),
        ),
        Flexible(
          child: Center(
            child: ElevatedButton(
              child: const Text('Gevarenbord'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyRoute(
                            titel: "Verbodsborden",
                          )),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
