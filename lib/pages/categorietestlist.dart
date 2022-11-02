import 'package:flutter/material.dart';
import '../models/categorie.dart';
import '../apis/verkeersbord_api.dart';
import 'routetotestlist.dart';

class CategorieTestListPage extends StatefulWidget {
  const CategorieTestListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategorieTestListPageState();
}

class _CategorieTestListPageState extends State {
  List<Categorie> categorieList = [];
  int count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: categorieTestListItems(),
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
      if (mounted) {
        setState(() {
          categorieList = result;
          count = result.length;
        });
      }
    });
  }

  ListView categorieTestListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          AssetImage afbeelding1 =
              AssetImage(categorieList[position].afbeeldingLink);

          return Container(
              margin: const EdgeInsets.all(5.0),
              child: (() {
                if (categorieList[position].id.isOdd &&
                    categorieList[position].id <= categorieList.length - 1) {
                  AssetImage afbeelding2 =
                      AssetImage(categorieList[position + 1].afbeeldingLink);
                  return Row(children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => RouteToTestList(
                                        titel: categorieList[position].naam)),
                              );
                            },
                            child: Column(children: [
                              Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image(
                                    height: 150,
                                    image: afbeelding1,
                                  )),
                              Text(categorieList[position].naam),
                            ])),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => RouteToTestList(
                                          titel: categorieList[position + 1]
                                              .naam)),
                                );
                              },
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.all(20),
                                    child: Image(
                                      height: 150,
                                      image: afbeelding2,
                                    )),
                                Text(categorieList[position + 1].naam),
                              ]))),
                    )
                  ]);
                } else if (categorieList[position].id.isOdd) {
                  return Row(children: [
                    Expanded(
                        child: Card(
                            semanticContainer: true,
                            color: Colors.white,
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => RouteToTestList(
                                            titel:
                                                categorieList[position].naam)),
                                  );
                                },
                                child: Column(children: [
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Image(
                                      height: 150,
                                      image: afbeelding1,
                                    ),
                                  ),
                                  Text(categorieList[position].naam),
                                ])))),
                    Expanded(
                      child: Text(""),
                    )
                  ]);
                }
              }()));
        });
  }
}
