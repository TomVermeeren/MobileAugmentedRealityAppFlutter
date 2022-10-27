import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/detailbordinfo.dart';
import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';
import 'leergevarenbord.dart';

class VerkeersbordenListPage extends StatefulWidget {
  final String titel;
  const VerkeersbordenListPage({Key? key, required this.titel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerkeersbordListPageState(titel);
}

class _VerkeersbordListPageState extends State {
  String titel;

  _VerkeersbordListPageState(this.titel);

  List<Verkeersbord> verkeersbordList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: verkeersbordListItems(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getVerkeersborden();
  }

  void _getVerkeersborden() {
    VerkeersbordApi.fetchVerkeerborden().then((result) {
      setState(() {
        verkeersbordList = result;
        count = result.length;
      });
    });
  }

  ListView verkeersbordListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          AssetImage afbeeldinglink =
              AssetImage(verkeersbordList[position].afbeeldingLink);
          return Container(
              child: (() {
            if (verkeersbordList[position].categorie == titel) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: Column(
                    children: [
                      IconButton(
                          icon: Image.asset(
                              verkeersbordList[position].afbeeldingLink),
                          iconSize: 100.0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        titel: verkeersbordList[position].naam,
                                        beschrijving: verkeersbordList[position]
                                            .beschrijving,
                                        afbeeldingLink:
                                            verkeersbordList[position]
                                                .afbeeldingLink)));
                          }),
                      Text(verkeersbordList[position].naam)
                    ],
                  ));
            }
          }()));
        });
  }
}
