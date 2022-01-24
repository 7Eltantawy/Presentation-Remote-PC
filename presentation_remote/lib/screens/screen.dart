import 'package:flutter/material.dart';
import 'package:presentation_remote/logic/transimitter_manager.dart';
import 'package:presentation_remote/widget/swipe_gesture_recognizer.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String dir = "Direction appear here";
  @override
  void initState() {
    TransimitterManager.send(key: "Connected");
    dir = "Direction appear here";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(dir),
          centerTitle: true,
        ),
        body: SwipeGestureRecognizer(
          onSwipeDown: () async {
            setState(() {
              // dir = "onSwipeDown";
              dir = "PREVIOUS";
            });
            await TransimitterManager.send(key: "Previous");
          },
          onSwipeUp: () async {
            setState(() {
              // dir = "onSwipeUp";
              dir = "NEXT";
            });
            await TransimitterManager.send(key: "Next");
          },
          onSwipeLeft: () async {
            setState(() {
              // dir = "onSwipeLeft";
              dir = "PREVIOUS";
            });
            await TransimitterManager.send(key: "Previous");
          },
          onSwipeRight: () async {
            setState(() {
              // dir = "onSwipeRight";
              dir = "NEXT";
            });
            await TransimitterManager.send(key: "Next");
          },
        )
        // GestureDetector(
        // onPanEnd: (details) {
        //   details.
        //   },
        // onPanUpdate: (details) {
        //   // Swiping in right direction.
        //   if (details.delta.dx > 0) {
        //     setState(() {
        //       dir = "Right";
        //       TransimitterManager.send("Next");
        //     });
        //   }

        // Swiping in left direction.
        //   if (details.delta.dx < 0) {
        //     setState(() {
        //       dir = "Left";
        //       TransimitterManager.send("Previous");
        //     });
        //   }
        // },
        // ),
        );
  }
}
