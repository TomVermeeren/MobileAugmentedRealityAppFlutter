import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/detailbordinfo.dart';
import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';
import 'routetoleerlist.dart';

class VerkeersbordenLeerListPage extends StatefulWidget {
  final String titel;
  const VerkeersbordenLeerListPage({Key? key, required this.titel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerkeersbordLeerListPageState(titel);
}

class _VerkeersbordLeerListPageState extends State {
  String titel;

  _VerkeersbordLeerListPageState(this.titel);

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
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  titel: verkeersbordList[position].naam,
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
                        Text(verkeersbordList[position].naam)
                      ],
                    )),
              );
            }
          }()));
        });
  }
}
