import 'dart:io';
import 'package:flutter/material.dart';
import 'leermenu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LeerOverzicht(),
      ),
    );
  }
}

class LeerOverzicht extends StatelessWidget {
  const LeerOverzicht({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Card(
          child: ElevatedButton(
            onPressed: () {
              Card() {}
            },
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('A card that can be tapped'),
            ),
          ),
        ),
      ]),
    );
  }
}
