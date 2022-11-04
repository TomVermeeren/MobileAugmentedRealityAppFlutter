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
      if (mounted) {
        setState(() {
          verkeersbordList = result;
          count = result.length;
        });
      }
    });
  }

  ListView verkeersbordListItems() {
    var max = 0;
    if (verkeersbordList.length == 0) {
      max = 1;
    } else {
      max = verkeersbordList.length - 1;
    }

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
                                    position: position,
                                    list: verkeersbordList,
                                  )));
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
