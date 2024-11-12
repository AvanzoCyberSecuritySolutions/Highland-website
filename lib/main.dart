import 'package:flutter/material.dart';
import 'package:flutter_highland/Highlandhome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Highland',
      routes: {
        '/home': (context) => Highlandhome(),
      },
      initialRoute: '/',
      home: Highlandhome(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}
