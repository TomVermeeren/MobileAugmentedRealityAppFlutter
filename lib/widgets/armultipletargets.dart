import 'dart:math';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/apis/verkeersbord_api.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordleerlist.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordtest.dart';

import '../models/verkeersbord.dart';

class ArMultipleTargetsWidget extends StatefulWidget {
  const ArMultipleTargetsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArMultipleTargetsWidgetState();
}

class _ArMultipleTargetsWidgetState extends State<ArMultipleTargetsWidget>
    with WidgetsBindingObserver {
  //declareert alle variabelen die we nodig gaan hebben om te gebruiken in de architectwidget
  late ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "1o9r1IvdiAVq1z5Itc+mTnxHKqHN4AJLFGFQMZIIk4KxVwyCDR98dtJ5uUjcrZs1bU5fZnZAT5sagoWz5S3L2boRuqihtgHqEv+3Qix3NK0BKJWJvMAamau231eeleBKHuaWBeLCrdxUKMSGHcr/K/O6xibZSw4Zhv/7SsWutwpTYWx0ZWRfXxLcVx9uTx497+NulVWSee290QPIHVpbDpkk6nPQCpC0N+l+EjdgJXv6fWQ2zDeF6SAmmO/YKP35y5s//QCDE4aHz9pRkXSCtP/3/7twxgg02zy1VMLG5RJDqCQThGCozQdJEcAVGTU/+HWBpK+QBa3NmDlJwljmYpW+jYn0ZJ9qgHD2oUWx0OJ8VolvwLucqwVjnGATpIHwS87koGTBCl3ZWn4CjZt7KIyXW+3DvwXF73zH7Cuvh6CubjnMzWHSNNmUQiLOhMgLfdjPyECsVzhKaJwf7ZoRziKm5BfneQNUy/Q6BeeizDMJx/q9msCHopGWcvsvFus9iVsLRTe7agXt6pRr4azx7Wcs2cCOYM1dqzMMYHd95JpTumRgo3imHQe312OTIUig7Wr6NrH/zNPkAC/hBx4Vo1G4k4UU52hyN1IiKxQaRLzPXSkAnhCzxMFwuiBnQUY0NdrAPHzm0UkKkY0jI78LABD+eV2UNbCrR2ESA441l9QcM2ufm/rck+yqH4A2gXts+TnhfWKreKFcWhXVVHJWmlRjsIpezDILwZEl12nAqCyU1hZVzCJhNF8MvARji8wK+DB0vL0f55FCZLKlMJ3vy2yU0fU0PZjzFhQc+cSDz7v2EiAzdgOqMwbPkoG+xOhaOqaYBgN8iSPEtkQQEjhUxQ==";
  StartupConfiguration startupConfiguration = StartupConfiguration(
      cameraPosition: CameraPosition.BACK,
      cameraResolution: CameraResolution.AUTO);
  List<String> features = ["image_tracking"];
  List<Verkeersbord> list = [];
  @override
  void initState() {
    super.initState();
    // roept methode op om verkeersborden op te roepen via api en lijst te vullen
    _getVerkeersborden();

    WidgetsBinding.instance.addObserver(this);

// maakt architect widget aan, aan de hand van bovenstaande variabelen
    architectWidget = ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: startupConfiguration,
      features: features,
    );
  }

// vult de verkeersbordList met verkeersborden die we ophalen uit de API
  List<Verkeersbord> verkeersbordList = [];
  void _getVerkeersborden() {
    VerkeersbordApi.fetchVerkeerborden().then((result) {
      if (mounted) {
        setState(() {
          verkeersbordList = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      // toont de architectWidget
      child: architectWidget, //ar widget
    );
  }

  @override
  // als de app sluit of opnieuw wordt geopend, passen we de state aan
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        architectWidget.pause();
        break;
      case AppLifecycleState.resumed:
        architectWidget.resume();
        break;

      default:
    }
  }

  @override
  // verwijdert de architectwidget
  void dispose() {
    architectWidget.pause();
    architectWidget.destroy();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

// als het widget is aangemaakt laden we de html pagina die erbij hoort
  Future<void> onArchitectWidgetCreated() async {
    architectWidget.load(
        "samples/03_MultipleTargets_1_MultipleTargets/index.html",
        onLoadSuccess,
        onLoadFailed);
    architectWidget.resume();
    // zorgt voor de communicatie van wikitude naar flutter. Stuurt een json object terug als we een specifieke
    // actie uitvoeren in wikitude
    architectWidget.setJSONObjectReceivedCallback(
        (result) => onJSONObjectReceived(result));
  }

  void onJSONObjectReceived(Map<String, dynamic> jsonObject) async {
    var imageScanned = ARImageResponse.fromJson(jsonObject);

    //ontvang het ingescande verkeersbord van wikitude
    //we roepen deze methode op in onze api file(daar gebeurt veel)
    VerkeersbordApi.fetchVerkeersbordByImageName(imageScanned.imageScanned)
        .then((result) {
      if (result != null) {
        // stuurt ons door naar de juiste detailpagina voor het ingescande verkeersbord.
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    position: result.id - 1,
                    list: verkeersbordList,
                  )),
        );
        // we roepen deze methode op zodat we de wikitude camera sluiten en het architectwidget destroyen, zodat we onze
        // volgende pagina kunnen zien.
        dispose();
      }
    });
  }

  var videolink = 1;
  Future<void> onLoadSuccess() async {
    debugPrint("Successfully loaded Architect World");
    //communicatie van flutter naar wikitude
    // stuurt het nummer voor de videolink door naar wikitude (daar is een functie om te bepalen welke video wordt getoont)
    architectWidget.callJavascript('World.newData($videolink)');
    // nadat we de link hebben doorgestuurd laten we al de overlays laden, zodat deze ook al werken met de videolink.
    architectWidget.callJavascript('World.createOverlays()');
  }

  Future<void> onLoadFailed(String error) async {
    debugPrint("Failed to load Architect World");
    debugPrint(error);
  }
}

// klasse om van wikitude het ingescande verkeersbord op te halen.
class ARImageResponse {
  String imageScanned;

  ARImageResponse({required this.imageScanned});

  factory ARImageResponse.fromJson(Map<String, dynamic> json) {
    return ARImageResponse(
      imageScanned: json['image_scanned'],
    );
  }
}
