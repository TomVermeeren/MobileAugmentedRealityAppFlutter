import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/arborden.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // geeft mee welke features wikitude gaat moeten gebruiken
  List<String> features = ["image_tracking"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // als je op de knop klikt ga je naar de methode (deze opent wikitude)
        child: ElevatedButton(
            onPressed: navigateToVerkeersborden,
            child: const Text("Scan verkeersborden!")),
      ),
    );
  }

// methode die hierboven gecalld wordt
  void navigateToVerkeersborden() {
    // kijkt na of ons device compatibel is met wikitude
    checkDeviceCompatibility().then((value) => {
          // als het compatibel is dan..
          if (value.success)
            {
              // vraag camera permissies
              requestARPermissions().then((value) => {
                    // als het is toegestaan
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          // stuur door naar pagina ArBordenPage
                          MaterialPageRoute(
                              builder: (context) => const ArBordenPage()),
                        )
                      }
                    // als het niet is toegestaan
                    else
                      {
                        // er gebeurt niets behalve debug logs
                        debugPrint("AR permissions denied"),
                        debugPrint(value.message)
                      }
                  })
            }
          // als het niet compatibel is..
          else
            // er gebeurt niets behalve debug logs
            {debugPrint("Device incompatible"), debugPrint(value.message)}
        });
  }

// methode om na te kijken of ons device compatibel is met wikitude
  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

// methode om permissies voor camera te vragen
  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(features);
  }
}
