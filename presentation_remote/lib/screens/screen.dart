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
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Theme.of(context).backgroundColor,
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    const Center(
                        child: Text(
                      "Arrows",
                      style: TextStyle(fontSize: 30),
                    )),
                    SwipeGestureRecognizer(
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(10),
                color: Theme.of(context).backgroundColor,
                child: Stack(
                  children: [
                    const Center(
                        child: Text(
                      "Mouse",
                      style: TextStyle(fontSize: 30),
                    )),
                    GestureDetector(
                      onPanUpdate: (details) async {
                        // Swiping in Hor direction.
                        int? x = 0, y = 0;
                        if (details.delta.dx > 0) {
                          setState(() {
                            dir = "Hor: +1";
                          });
                          x = 1;
                        } else if (details.delta.dx < 0) {
                          setState(() {
                            dir = "Hor: -1";
                          });
                          x = -1;
                        }
                        // Swiping in Ver direction.
                        if (details.delta.dy > 0) {
                          setState(() {
                            dir = "Ver: +1";
                          });
                          y = 1;
                        } else if (details.delta.dy < 0) {
                          setState(() {
                            dir = "Ver: -1";
                          });
                          y = -1;
                        }
                        await TransimitterManager.send(mouseX: x, mouseY: y);
                      },
                    ),
                  ],
                ),
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
                                setState(() {
                                  // dir = "onSwipeRight";
                                  dir = "Left CLick";
                                });
                                await TransimitterManager.send(click: "L");
                              },
                              title: const Text(
                                "Left CLick",
                                textAlign: TextAlign.center,
                              ))),
                      Expanded(
                          child: ListTile(
                              onTap: () async {
                                setState(() {
                                  // dir = "onSwipeRight";
                                  dir = "Right CLick";
                                });
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
