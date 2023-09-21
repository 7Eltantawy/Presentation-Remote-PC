import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation_remote/logic/transmitter_manager.dart';
import 'package:presentation_remote/widget/direction_pad.dart';
import 'package:presentation_remote/widget/mouse_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  static const _volumeBtnChannel = MethodChannel("volume_button_channel");

  late TabController? tabController;

  double? tempVol = 0;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    _volumeBtnChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "volume_down") {
          volumeButtonDown();
        }
        if (call.arguments == "volume_up") {
          volumeButtonUp();
        }
      }

      return Future.value();
    });
  }

  Future volumeButtonUp() async {
    await TransmitterManager.send(key: "Up");
  }

  Future volumeButtonDown() async {
    await TransmitterManager.send(key: "Down");
  }

  @override
  void dispose() {
    super.dispose();

    TransmitterManager.send(key: "Disconnected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: const [
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
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: MouseController(),
                  ),
                ),
              ],
            ),
          ),
          Scaffold(
            body: Column(
              children: [
                Expanded(
                  child:
                      Card(margin: EdgeInsets.all(10), child: DirectionPad()),
                ),
              ],
            ),
          ),
          Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child:
                      Card(margin: EdgeInsets.all(10), child: DirectionPad()),
                ),
                Expanded(
                  flex: 4,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: MouseController(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
