import 'package:flutter/widgets.dart';
import 'package:presentation_remote/logic/transimitter_manager.dart';

import 'swipe_gesture_recognizer.dart';

class DirectionPad extends StatefulWidget {
  const DirectionPad({Key? key}) : super(key: key);

  @override
  _DirectionPadState createState() => _DirectionPadState();
}

class _DirectionPadState extends State<DirectionPad> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
            child: Text(
          "Arrows",
          style: TextStyle(fontSize: 30),
        )),
        SwipeGestureRecognizer(
          onSwipeDown: () async {
            await TransimitterManager.send(key: "Down");
          },
          onSwipeUp: () async {
            await TransimitterManager.send(key: "Up");
          },
          onSwipeLeft: () async {
            await TransimitterManager.send(key: "Left");
          },
          onSwipeRight: () async {
            await TransimitterManager.send(key: "Right");
          },
        ),
      ],
    );
  }
}
