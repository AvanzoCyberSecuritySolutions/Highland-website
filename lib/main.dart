import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_highland/BookingPatientController.dart';
import 'package:flutter_highland/newbookingappointcontroller.dart';
import 'package:flutter_highland/newbookings.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'Feedback_controller.dart'; // Ensure this path is correct
import 'Highlandhome.dart'; // Ensure this path is correct
// Import the NewBookings page

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
        ChangeNotifierProvider(create: (_) => FeedbackController()),
        ChangeNotifierProvider(create: (_) => Newbookingappointcontroller()),
        Provider<BookingPatientController>(
          create: (_) => BookingPatientController(),
        ),
      ],
      child: const MainScreen(),
    ),
  );
}

// MainScreen widget to setup MaterialApp and routes
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
        routes: {
          '/home': (context) => Highlandhome(),
          '/new-bookings': (context) =>
              NewBookings(), // Add route for NewBookings
        },
        initialRoute: '/home', // Set initial route to '/home'
        debugShowCheckedModeBanner: false, // Disable the debug banner
      );
    });
  }
}
