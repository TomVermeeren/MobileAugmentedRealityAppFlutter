import 'package:flutter/material.dart';
import '../widgets/armultipletargets.dart';

class ArBordenPage extends StatefulWidget {
  const ArBordenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArBordenPageState();
}

class _ArBordenPageState extends State<ArBordenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dino's"),
      ),
      body: const Center(
          // Here we load the Widget with the AR Dino experience
          child: ArMultipleTargetsWidget()),
    );
  }
}