import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Careers extends StatelessWidget {
  const Careers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Careers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // ✅ Title text also white for consistency
          ),
        ),
        backgroundColor: const Color(0xFF1FBCB1), // Teal header
        centerTitle: true, // ✅ Center title
        iconTheme: const IconThemeData(
          color: Colors.white, // ✅ Back arrow color white
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Disclaimer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // 🟧 Marquee text section
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEE9821),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.yellow, width: 1.5),
                ),
                child: Marquee(
                  text: '🔔 Check for latest vacancies 🔔   ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 50.0,
                  velocity: 60.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                'Please check this page regularly for updates on new job openings and career opportunities at Highland Hospitals.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
