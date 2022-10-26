import 'dart:convert';

import 'package:flutter/material.dart';
import 'leermenu.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyNavbar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyCard(
      
    ),
    Text(
      'Scan',
      style: optionStyle,
    ),
    Text(
      'Test',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _widgetOptions.elementAt(_selectedIndex),
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
