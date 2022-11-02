import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';

class DetailPage extends StatelessWidget {
  final String titel;
  final String beschrijving;
  final String afbeeldingLink;
  DetailPage(
      {Key? key,
      required this.titel,
      required this.beschrijving,
      required this.afbeeldingLink})
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
              Flexible(
                  child: Image(
                image: avatarAsset,
                width: 300.0,
              )),
              Flexible(
                child: Text(
                  beschrijving,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
    );
  }
}
