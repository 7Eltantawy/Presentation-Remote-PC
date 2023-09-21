import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presentation_remote/src/core/extension/string.dart';
import 'package:presentation_remote/src/core/logic/transmitter_manager.dart';
import 'package:presentation_remote/src/features/dashboard/presentation/screens/dashboard.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeReader extends StatefulWidget {
  const QRCodeReader({super.key});

  @override
  State<StatefulWidget> createState() => _QRCodeReaderState();
}

class _QRCodeReaderState extends State<QRCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool startScan = false;
  String? password = "";
  String? server = "";
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void restart() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const QRCodeReader(),
      ),
    );
  }

  Widget startWidget() {
    return Center(
      child: InkWell(
        child: Center(
          child: Text(
            "Click to Scan QR".toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.greenAccent),
          ),
        ),
        onTap: () {
          setState(() {
            startScan = true;
          });
        },
      ),
    );
  }

  Widget retryWidget() {
    return Center(
      child: ListTile(
        title: Text(
          "Restart scan QR".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40, color: Colors.redAccent),
        ),
        onTap: () {
          setState(() {
            restart();
          });
        },
      ),
    );
  }

  Widget msgSplitter(String? result) {
    return const Text("data");
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      if ('${result!.code?.split(",")[1]}'.isIP()) {
        setState(() {
          // 'IP: ${result!.code?.split(",")[1]}\nPassword: ${result!.code?.split(",")[0]} '
          TransmitterManager.server = '${result!.code?.split(",")[1].trim()}';
          TransmitterManager.password = '${result!.code?.split(",")[0].trim()}';
          TransmitterManager.send(key: "Connected");
        });
      }
    }
    return Scaffold(
      body: !startScan
          ? startWidget()
          : Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: (result == null)
                      ? QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        )
                      : retryWidget(),
                ),
                Expanded(
                  flex: (result != null) ? 2 : 1,
                  child: Center(
                    child: Column(
                      children: [
                        if (result != null)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'IP: ${result!.code?.split(",")[1]}\nPassword: ${result!.code?.split(",")[0]} ',
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Scanned code',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ListTile(
                          title: (result != null)
                              ? const Text(
                                  "Start Session!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                  ),
                                )
                              : const Text(
                                  "Waiting ....",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                          onTap: () {
                            if (result != null) {
                              if ('${result!.code?.split(",")[1]}'.isIP()) {
                                setState(() {
                                  // 'IP: ${result!.code?.split(",")[1]}\nPassword: ${result!.code?.split(",")[0]} '
                                  TransmitterManager.server =
                                      '${result!.code?.split(",")[1].trim()}';
                                  TransmitterManager.password =
                                      '${result!.code?.split(",")[0].trim()}';
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                );
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
