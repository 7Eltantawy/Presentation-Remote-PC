import 'package:flutter/material.dart';
import 'package:presentation_remote/src/core/utils/app_print.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AirScreen extends StatefulWidget {
  const AirScreen({super.key});

  @override
  State<AirScreen> createState() => _AirScreenState();
}

class _AirScreenState extends State<AirScreen> {
  AccelerometerEvent? point;
  @override
  void initState() {
    appPrint("Air Mode");
    super.initState();
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        appPrint(event);
        point = event;
      },
      onError: (error) {
        appPrint(error);
      },
      cancelOnError: true,
    );
// [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.air,
              size: 100,
            ),
            Text(point?.toString() ?? "N/A"),
          ],
        ),
      ),
    );
  }
}
