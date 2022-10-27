import 'package:flutter/material.dart';
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
          return Container(
              child: (() {
            if (verkeersbordList[position].categorie == titel) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ElevatedButton(
                      child: Text(verkeersbordList[position].naam),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MyRoute(
                                    titel: verkeersbordList[position].naam)));
                      }));
            }
          }()));
        });
  }
}
