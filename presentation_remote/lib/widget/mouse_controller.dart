import 'package:flutter/material.dart';
import 'package:presentation_remote/logic/transimitter_manager.dart';

class MouseController extends StatefulWidget {
  const MouseController({Key? key}) : super(key: key);

  @override
  _MouseControllerState createState() => _MouseControllerState();
}

class _MouseControllerState extends State<MouseController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              const Center(
                  child: Text(
                "Mouse",
                style: TextStyle(fontSize: 30),
              )),
              GestureDetector(
                onLongPress: () async {
                  await TransimitterManager.send(click: "R");
                },
                onTap: () async {
                  await TransimitterManager.send(click: "L");
                },
                onPanUpdate: (details) async {
                  // Swiping in Hor direction.
                  int? x = 0, y = 0;
                  if (details.delta.dx > 0) {
                    x = 1;
                  } else if (details.delta.dx < 0) {
                    x = -1;
                  }
                  // Swiping in Ver direction.
                  if (details.delta.dy > 0) {
                    y = 1;
                  } else if (details.delta.dy < 0) {
                    y = -1;
                  }
                  await TransimitterManager.send(mouseX: x, mouseY: y);
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: ListTile(
                          onTap: () async {
                            await TransimitterManager.send(click: "L");
                          },
                          title: const Text(
                            "Left CLick",
                            textAlign: TextAlign.center,
                          ))),
                  Expanded(
                      child: ListTile(
                          onTap: () async {
                            await TransimitterManager.send(click: "R");
                          },
                          title: const Text(
                            "Right CLick",
                            textAlign: TextAlign.center,
                          ))),
                ],
              )),
        )
      ],
    );
  }
}
