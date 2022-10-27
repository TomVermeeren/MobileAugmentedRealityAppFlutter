import 'package:flutter/material.dart';
import '../models/verkeersbord.dart';
import '../apis/verkeersbord_api.dart';
import 'leergevarenbord.dart';

class VerkeersbordenListPage extends StatefulWidget {
  const VerkeersbordenListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerkeersbordListPageState();
}

class _VerkeersbordListPageState extends State {
  List<Verkeersbord> verkeersbordList = [];
  int count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verkeersborden"),
      ),
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
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ElevatedButton(
            child: Text(verkeersbordList[position].naam),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        MyRoute(titel: verkeersbordList[position].naam)),
              );
            },
          ),
        );
      },
    );
  }
}
