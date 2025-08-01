import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_highland/BookingPatientController.dart';

import 'package:flutter_highland/Highlandhome.dart';
import 'package:flutter_highland/feedbackController.dart';

import 'package:flutter_highland/newbookingappointcontroller.dart';
import 'package:flutter_highland/responsive.dart';

import 'package:provider/provider.dart';

// ScaleSize class to adjust text scaling
class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(0.5, min(val, maxTextScaleFactor));
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => feedbackController()),
        ChangeNotifierProvider(create: (_) => Newbookingappointcontroller()),
        Provider<BookingPatientController>(
          create: (_) => BookingPatientController(),
        ),
      ],
      child: const MainScreen(),
    ),
  );
}

// ✅ MainScreen widget with Global Responsiveness
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleSize.textScaleFactor(context);

    return MaterialApp(
      title: 'Highland',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: child!,
        );
      },
      theme: ThemeData(
        fontFamily: 'Filson Pro',
      ),
      debugShowCheckedModeBanner: false,

      // ✅ Use Responsive Wrapper for All Pages
      home: Responsive(
        mobile: MobileLayout(),
        tablet: TabletLayout(),
        desktop: DesktopLayout(),
      ),
    );
  }
}

// ✅ Different Layouts (Applies Responsiveness to All Pages)
class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Highland (Mobile)")),
      body: Highlandhome(),
    );
  }
}

class TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Highland (Tablet)")),
      body: Highlandhome(),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: Text("Highland (Desktop)")),
      body: Highlandhome(),
    );
  }
}
