import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:presentation_remote/udp/udp_base.dart';
import 'package:presentation_remote/udp/udp_endpoint.dart';
import 'package:presentation_remote/udp/udp_port.dart';

class TransimitterManager {
  static String server = "192.168.1.4";
  static const int port = 1111;
  static String? password = "vads9216JX";
  // static String server = "127.0.0.1";
  // static const int port = 1111;
  // static String? password = "";

  //mouseX : "+1" rigth | "-1" left
  //mouseY : "+1" up | "-1" down
  //click : "N" None | "L" Left | "R" Rigth
  static Future<void> send({
    String? key = "",
    int? mouseX = 0,
    int? mouseY = 0,
    String? click = "N",
  }) async {
    String combinedMsg =
        password! + "," + key! + "," + "$mouseX*$mouseY*$click";
    debugPrint(combinedMsg);
    tryMe(combinedMsg);
  }

  static void tryMe(String? key) async {
    var sender = await UDP.bind(Endpoint.any(port: const Port(port)));
    await sender.send(
        "$key".codeUnits, Endpoint.broadcast(port: const Port(port)));
  }
}
