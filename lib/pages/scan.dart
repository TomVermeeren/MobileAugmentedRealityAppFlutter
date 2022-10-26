import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        height: 250,
        child: Scaffold(
          body: SafeArea(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CameraPage(cameras: value))));
              },
              child: const Text("Take a Picture"),
            )),
          ),
        ));
  }
}
