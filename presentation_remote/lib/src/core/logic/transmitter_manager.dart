import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:presentation_remote/src/core/udp/udp_base.dart';
import 'package:presentation_remote/src/core/udp/udp_endpoint.dart';
import 'package:presentation_remote/src/core/udp/udp_port.dart';

class TransmitterManager {
  static String server = "127.0.0.1";
  static const int port = 1111;
  static String? password = "";

  //mouseX : "+1" right | "-1" left
  //mouseY : "+1" up | "-1" down
  //click : "N" None | "L" Left | "R" Right
  static Future<void> send({
    String? key = "",
    int? mouseX = 0,
    int? mouseY = 0,
    String? click = "N",
  }) async {
    final String combinedMsg = "${password!},${key!},$mouseX*$mouseY*$click";
    debugPrint(combinedMsg);
    tryMe(combinedMsg);
  }

  static Future<void> tryMe(String? key) async {
    final sender = await UDP.bind(Endpoint.any(port: const Port(port)));
    await sender.send(
      "$key".codeUnits,
      Endpoint.broadcast(port: const Port(port)),
    );
  }
}
