import 'dart:math';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verkeersborden_tom_jan/apis/verkeersbord_api.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/detailbordinfo.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/routetotestlist.dart';
import 'package:flutter_verkeersborden_tom_jan/pages/verkeersbordtestlist.dart';

import '../models/verkeersbord.dart';

class ArMultipleTargetsWidget extends StatefulWidget {
  const ArMultipleTargetsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArMultipleTargetsWidgetState();
}

class _ArMultipleTargetsWidgetState extends State<ArMultipleTargetsWidget>
    with WidgetsBindingObserver {
  late ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "1o9r1IvdiAVq1z5Itc+mTnxHKqHN4AJLFGFQMZIIk4KxVwyCDR98dtJ5uUjcrZs1bU5fZnZAT5sagoWz5S3L2boRuqihtgHqEv+3Qix3NK0BKJWJvMAamau231eeleBKHuaWBeLCrdxUKMSGHcr/K/O6xibZSw4Zhv/7SsWutwpTYWx0ZWRfXxLcVx9uTx497+NulVWSee290QPIHVpbDpkk6nPQCpC0N+l+EjdgJXv6fWQ2zDeF6SAmmO/YKP35y5s//QCDE4aHz9pRkXSCtP/3/7twxgg02zy1VMLG5RJDqCQThGCozQdJEcAVGTU/+HWBpK+QBa3NmDlJwljmYpW+jYn0ZJ9qgHD2oUWx0OJ8VolvwLucqwVjnGATpIHwS87koGTBCl3ZWn4CjZt7KIyXW+3DvwXF73zH7Cuvh6CubjnMzWHSNNmUQiLOhMgLfdjPyECsVzhKaJwf7ZoRziKm5BfneQNUy/Q6BeeizDMJx/q9msCHopGWcvsvFus9iVsLRTe7agXt6pRr4azx7Wcs2cCOYM1dqzMMYHd95JpTumRgo3imHQe312OTIUig7Wr6NrH/zNPkAC/hBx4Vo1G4k4UU52hyN1IiKxQaRLzPXSkAnhCzxMFwuiBnQUY0NdrAPHzm0UkKkY0jI78LABD+eV2UNbCrR2ESA441l9QcM2ufm/rck+yqH4A2gXts+TnhfWKreKFcWhXVVHJWmlRjsIpezDILwZEl12nAqCyU1hZVzCJhNF8MvARji8wK+DB0vL0f55FCZLKlMJ3vy2yU0fU0PZjzFhQc+cSDz7v2EiAzdgOqMwbPkoG+xOhaOqaYBgN8iSPEtkQQEjhUxQ==";
  StartupConfiguration startupConfiguration = StartupConfiguration(
      cameraPosition: CameraPosition.BACK,
      cameraResolution: CameraResolution.AUTO);
  List<String> features = ["image_tracking"];

  @override
  void initState() {
    super.initState();
    _getVerkeersborden();

    WidgetsBinding.instance.addObserver(this);

    architectWidget = ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: startupConfiguration,
      features: features,
    );
  }

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
      child: architectWidget, //ar widget
    );
  }

  @override
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
  void dispose() {
    architectWidget.pause();
    architectWidget.destroy();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> onArchitectWidgetCreated() async {
    architectWidget.load(
        "samples/03_MultipleTargets_1_MultipleTargets/index.html",
        onLoadSuccess,
        onLoadFailed);
    architectWidget.resume();
    // architectWidget.setJSONObjectReceivedCallback(
    //     (result) => onJSONObjectReceived(result));
  }

  // void onJSONObjectReceived(Map<String, dynamic> jsonObject) async {
  //   var imageScanned = ARImageResponse.fromJson(jsonObject);
  //   //get question and navigate to question/answer page
  //   VerkeersbordApi.fetchVerkeersbordByImageName(imageScanned.imageScanned)
  //       .then((result) {
  //     if (result != null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => RouteToTestList(titel: result.naam)),
  //       );
  //     }
  //   });
  // }

  var videolink = 1;
  Future<void> onLoadSuccess() async {
    debugPrint("Successfully loaded Architect World");
    architectWidget.callJavascript('World.newData($videolink)');
    architectWidget.callJavascript('World.createOverlays()');
  }

  Future<void> onLoadFailed(String error) async {
    debugPrint("Failed to load Architect World");
    debugPrint(error);
  }
}

// class ARImageResponse {
//   String imageScanned;

//   ARImageResponse({required this.imageScanned});

//   factory ARImageResponse.fromJson(Map<String, dynamic> json) {
//     return ARImageResponse(
//       imageScanned: json['image_scanned'],
//     );
//   }
// }
