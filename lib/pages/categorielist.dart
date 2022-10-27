import 'package:flutter/material.dart';
import '../models/verkeersbord.dart';
import '../models/categorie.dart';
import '../apis/verkeersbord_api.dart';
import 'leergevarenbord.dart';

class CategorieListPage extends StatefulWidget {
  const CategorieListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategorieListPageState();
}

class _CategorieListPageState extends State {
  List<Categorie> categorieList = [];
  int count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorieen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: catergorieListItems(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCategorieen();
  }

  void _getCategorieen() {
    VerkeersbordApi.fetchCategorieen().then((result) {
      setState(() {
        categorieList = result;
        count = result.length;
      });
    });
  }

  ListView catergorieListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ElevatedButton(
            child: Text(categorieList[position].naam),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        MyRoute(titel: categorieList[position].naam)),
              );
            },
          ),
        );
      },
    );
  }
}
