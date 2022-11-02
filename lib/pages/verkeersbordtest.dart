import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';

class DetailPage extends StatelessWidget {
  final String titel;
  final String beschrijving;
  final String afbeeldingLink;
  final String fout1;
  final String fout2;
  final String fout3;
  DetailPage(
      {Key? key,
      required this.titel,
      required this.beschrijving,
      required this.afbeeldingLink,
      required this.fout1,
      required this.fout2,
      required this.fout3})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    AssetImage avatarAsset = AssetImage(afbeeldingLink);
    return Scaffold(
      appBar: AppBar(
        title: Text(titel),
      ),
      body: Container(
          margin: const EdgeInsets.all(20.0),
          width: 2000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Wat betekent dit bord?",
                key: key,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Flexible(
                  child: Image(
                image: avatarAsset,
                width: 300.0,
              )),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {},
                    child: Text(titel),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {},
                    child: Text(fout1),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {},
                    child: Text(fout2),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {},
                    child: Text(fout3),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
