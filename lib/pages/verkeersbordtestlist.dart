import 'package:flutter/material.dart';
import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';
import 'verkeersbordtest.dart';
import 'dart:math';

class VerkeersbordenTestListPage extends StatefulWidget {
  final String titel;
  const VerkeersbordenTestListPage({Key? key, required this.titel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerkeersbordTestListPageState(titel);
}

class _VerkeersbordTestListPageState extends State {
  String titel;

  _VerkeersbordTestListPageState(this.titel);

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
    var max = 0;
    if (verkeersbordList.length == 0) {
      max = 1;
    } else {
      max = verkeersbordList.length - 1;
    }
    var intValue1 = Random().nextInt(max);
    var intValue2 = Random().nextInt(max);
    var intValue3 = Random().nextInt(max);

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          // for (int value in intValues) {
          //   value = Random().nextInt(verkeersbordList.length - 1);
          // }
          AssetImage afbeeldinglink =
              AssetImage(verkeersbordList[position].afbeeldingLink);
          return Container(
              child: (() {
            if (verkeersbordList[position].categorie == titel) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  titel: verkeersbordList[position].naam,
                                  fout1: verkeersbordList[intValue1].naam,
                                  fout2: verkeersbordList[intValue2].naam,
                                  fout3: verkeersbordList[intValue3].naam,
                                  beschrijving:
                                      verkeersbordList[position].beschrijving,
                                  afbeeldingLink: verkeersbordList[position]
                                      .afbeeldingLink)));
                    },
                    child: Column(
                      children: [
                        Image(
                          image: afbeeldinglink,
                          height: 150.0,
                        ),
                      ],
                    )),
              );
            }
          }()));
        });
  }
}
