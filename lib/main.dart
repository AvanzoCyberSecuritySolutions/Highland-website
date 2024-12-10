import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_highland/Highlandhome.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(0.5, min(val, maxTextScaleFactor));
  }
}

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final textScaleFactor = ScaleSize.textScaleFactor(context);
      return MaterialApp(
        title: 'Highland',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
            child: child!,
          );
        },
        routes: {
          '/home': (context) => Highlandhome(),
        },
        initialRoute: '/',
        home: Highlandhome(),
        debugShowCheckedModeBanner: false, // Disable the debug banner
      );
    });
  }
}
