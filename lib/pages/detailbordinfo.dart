import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordlist.dart';

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
      body: Center(
          child: Column(
        children: [
          Image(
            image: avatarAsset,
            width: 100.0,
          ),
          Text(beschrijving),
        ],
      )),
    );
  }
}
