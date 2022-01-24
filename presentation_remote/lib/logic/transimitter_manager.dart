import 'dart:async';
import 'package:presentation_remote/udp/udp_base.dart';
import 'package:presentation_remote/udp/udp_endpoint.dart';
import 'package:presentation_remote/udp/udp_port.dart';

class TransimitterManager {
  static String server = "127.0.0.1";
  static const int port = 1111;
  static String? password = "";

  static Future<void> send(
      {String? key, int? mouseX = 0, int? mouseY = 0}) async {
    tryMe(password! + "," + key! + "," + "$mouseX*$mouseY");
  }

  static void tryMe(String? key) async {
    var sender = await UDP.bind(Endpoint.any(port: const Port(port)));
    await sender.send(
        "$key".codeUnits, Endpoint.broadcast(port: const Port(port)));
  }
}
