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
  // declareer variables die we later aanpassen
  int _selectedIndex = 0;
  int punten = 0;
  List<Verkeersbord> list = [];

// maak list met de 3 opties die we hebben in onze navbar
  static const List<Widget> _widgetOptions = <Widget>[
    CategorieTestListPage(),
    HomePage(),
    CategorieLeerListPage()
  ];

  // als er op een item in de navbar wordt gedrukt passen we selectedindex aan (dit gaat de inhoud van de rest van de
  // pagina bepalen en ook de kleur van het icoontje)

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
    // vraag alle verkeersborden op van de api en vul de list met deze verkeersborden
    VerkeersbordApi.fetchVerkeerborden().then((result) {
      if (mounted) {
        setState(() {
          list = result;
        });
      }
    });
    punten = 0;
    // voor elk verkeersbord in de lijst die we net hebben gevuld, kijken we de "gehaald" property na. Deze gaat na of we
    // deze vraag al juist hebben beantwoord in het verleden of niet. dan telt het alle gehaalde vragen op in de punten variable
    for (Verkeersbord bord in list) {
      if (bord.gehaald == "1") {
        punten++;
      }
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 100,
        // toont onze titel en ons totaal aantal punten dat we al hebben gescoord
        title: Text(
            "Verkeersbord APP                 Punten: " + punten.toString()),
        centerTitle: true,
      ),
      // toont de pagina die we hebben geselecteerd via de navbar
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // layout van de navbar, dit is hoe de logo's eruit zien met hun naam erbij
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
        // roept methode op als we op de navbar klikken
        onTap: _onItemTapped,
      ),
    );
  }
}
