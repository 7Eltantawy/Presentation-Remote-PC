import 'package:flutter/material.dart';
import 'package:presentation_remote/logic/transimitter_manager.dart';
import 'package:presentation_remote/widget/direction_pad.dart';
import 'package:presentation_remote/widget/mouse_controller.dart';
import 'package:presentation_remote/widget/swipe_gesture_recognizer.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  String dir = "Direction appear here";
  late TabController tabController;
  @override
  void initState() {
    TransimitterManager.send(key: "Connected");
    tabController = TabController(length: 3, vsync: this);
    dir = "Direction appear here";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.mouse),
                    text: "Mouse",
                  ),
                  Tab(
                    icon: Icon(Icons.keyboard),
                    text: "Arrows",
                  ),
                  Tab(
                    icon: Icon(Icons.control_point_rounded),
                    text: "All",
                  ),
                ],
              ),
              title: const Text("Presentation Remote"),
              centerTitle: true,
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ////////////////////////
                Scaffold(
                  body: Column(
                    children: const [
                      Expanded(
                        child: Card(
                            margin: EdgeInsets.all(10),
                            child: MouseController()),
                      ),
                    ],
                  ),
                ),
                ///////////////////////////
                Scaffold(
                  body: Column(
                    children: const [
                      Expanded(
                        child: Card(
                            margin: EdgeInsets.all(10), child: DirectionPad()),
                      ),
                    ],
                  ),
                ),
                /////////////////////////////////
                Scaffold(
                  body: Column(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Card(
                            margin: EdgeInsets.all(10), child: DirectionPad()),
                      ),
                      Expanded(
                        flex: 4,
                        child: Card(
                            margin: EdgeInsets.all(10),
                            child: MouseController()),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
