import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/categorielist.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordlist.dart';
import 'leermenu.dart';
import 'leeroverzicht.dart';
import 'scan.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyNavbar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyCard(),
    HomePage(),
    CategorieListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainAxisSize.min;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 100,
        title: const Text("Verkeersborden Tom & Jan"),
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
