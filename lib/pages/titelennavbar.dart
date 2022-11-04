import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/categorieleerlist.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/categorietestlist.dart';
import '../apis/verkeersbord_api.dart';
import '../models/verkeersbord.dart';
import 'scan.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyNavbar> {
  int _selectedIndex = 0;
  int punten = 0;
  List<Verkeersbord> list = [];

  static const List<Widget> _widgetOptions = <Widget>[
    CategorieTestListPage(),
    HomePage(),
    CategorieLeerListPage()
  ];

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MainAxisSize.min;
    VerkeersbordApi.fetchVerkeerborden().then((result) {
      if (mounted) {
        setState(() {
          list = result;
        });
      }
    });
    punten = 0;
    for (Verkeersbord bord in list) {
      if (bord.gehaald == "1") {
        punten++;
      }
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 100,
        title: Text(
            "Verkeersbord APP                 Punten: " + punten.toString()),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Leer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Test',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
