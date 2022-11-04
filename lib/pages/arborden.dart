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
        title: const Text("Verkeersborden"),
      ),
      body: const Center(
          // We laden de widget met de AR omegeving
          child: ArMultipleTargetsWidget()),
    );
  }
}
