import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/titelennavbar.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';

class RouteToHome extends StatelessWidget {
  RouteToHome({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Camera Demo',
        debugShowCheckedModeBanner: false,
        // toont navbar onderaan het scherm
        home: MyNavbar());
  }
}
