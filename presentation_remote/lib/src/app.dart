import 'package:flutter/material.dart';
import 'package:presentation_remote/src/features/qr_code_reader/presentation/screens/qr_code_reader.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presentation Remote',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.purple,
        ),
      ),
      home: const QRCodeReader(),
    );
  }
}
