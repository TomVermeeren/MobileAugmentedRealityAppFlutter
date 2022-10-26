// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});
  @override
  _State createState() => _State();
}

class _State extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            _KlikOpMenuKnop() {}
            ;
          },
          child: const SizedBox(
            height: 70,
            child: Center(
              child: Text('Verbodsborden', style: TextStyle(fontSize: 20.0)),
            ),
          ),
        ),
      ),
    ]);
  }
}
