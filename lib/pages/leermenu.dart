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

class RouteVerbodsbord extends StatelessWidget {
  const RouteVerbodsbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verbodsbord'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class RouteGevarenbord extends StatelessWidget {
  const RouteGevarenbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gevarenbord'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
