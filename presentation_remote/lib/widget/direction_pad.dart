import 'package:flutter/widgets.dart';
import 'package:presentation_remote/logic/transmitter_manager.dart';

import 'package:presentation_remote/widget/swipe_gesture_recognizer.dart';

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
          ),
        ),
        SwipeGestureRecognizer(
          onSwipeDown: () async {
            await TransmitterManager.send(key: "Down");
          },
          onSwipeUp: () async {
            await TransmitterManager.send(key: "Up");
          },
          onSwipeLeft: () async {
            await TransmitterManager.send(key: "Left");
          },
          onSwipeRight: () async {
            await TransmitterManager.send(key: "Right");
          },
        ),
      ],
    );
  }
}
