// import 'package:flutter/material.dart';
// import 'pages/titelennavbar.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static const String _title = 'Verkeersborden app Jan & Tom';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: _title,
//       home: MyNavbar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/scan.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/titelennavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Verkeersborden App',
      debugShowCheckedModeBanner: false,
      // toont de navbar
      home: MyNavbar(),
    );
  }
}
