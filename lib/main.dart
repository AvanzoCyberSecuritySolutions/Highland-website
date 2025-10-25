// import 'dart:math';
// import 'package:flutter/material.dart';

// import 'package:flutter_highland/booking_patient_controller.dart';
// import 'package:flutter_highland/feedback_controller.dart';

// import 'package:flutter_highland/highland_home.dart';
// import 'package:flutter_highland/newbooking_appoint_controller.dart';

// import 'package:flutter_highland/responsive.dart';

// import 'package:provider/provider.dart';

// // ScaleSize class to adjust text scaling
// class ScaleSize {
//   static double textScaleFactor(BuildContext context,
//       {double maxTextScaleFactor = 1}) {
//     final width = MediaQuery.of(context).size.width;
//     double val = (width / 1400) * maxTextScaleFactor;
//     return max(0.5, min(val, maxTextScaleFactor));
//   }
// }

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FeedbackController()),
//         ChangeNotifierProvider(create: (_) => Newbookingappointcontroller()),
//         Provider<BookingPatientController>(
//           create: (_) => BookingPatientController(),
//         ),
//       ],
//       child: const MainScreen(),
//     ),
//   );
// }

// // ✅ MainScreen widget with Global Responsiveness
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final textScaleFactor = ScaleSize.textScaleFactor(context);

//     return MaterialApp(
//       title: 'Highland',
//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(
//             textScaleFactor: textScaleFactor,
//           ),
//           child: child!,
//         );
//       },
//       theme: ThemeData(
//         fontFamily: 'Filson Pro',
//       ),
//       debugShowCheckedModeBanner: false,

//       // ✅ Use Responsive Wrapper for All Pages
//       home: Responsive(
//         mobile: MobileLayout(),
//         tablet: TabletLayout(),
//         desktop: DesktopLayout(),
//       ),
//     );
//   }
// }

// // ✅ Different Layouts (Applies Responsiveness to All Pages)
// class MobileLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text("Highland (Mobile)")),
//       body: Highlandhome(),
//     );
//   }
// }

// class TabletLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text("Highland (Tablet)")),
//       body: Highlandhome(),
//     );
//   }
// }

// class DesktopLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //  appBar: AppBar(title: Text("Highland (Desktop)")),
//       body: Highlandhome(),
//     );
//   }
// }
// lib/main.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_highland/seo_web/about_us_page_wrapper.dart';
import 'package:flutter_highland/seo_web/seo_helper.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:flutter_highland/booking_patient_controller.dart';
import 'package:flutter_highland/feedback_controller.dart';
import 'package:flutter_highland/highland_home.dart';
import 'package:flutter_highland/newbooking_appoint_controller.dart';
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
  usePathUrlStrategy(); // For SEO-friendly URLs
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleSize.textScaleFactor(context);

    return MaterialApp(
      title: 'Highland', // General app title
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

      initialRoute: '/',
      routes: {
        '/': (context) => const HighlandHomePageWrapper(),
        '/about': (context) =>
            const AboutUsPageWrapper(), // <<< NEW: Your About Us route
        // Add other routes here as you create more pages
      },
    );
  }
}

class HighlandHomePageWrapper extends StatelessWidget {
  const HighlandHomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    updateSeoMeta(
      title: 'Highland - Your Premier Healthcare Partner',
      description:
          'Discover comprehensive healthcare services, book appointments, and get feedback at Highland. Providing top-tier patient care and medical solutions.',
      image: 'https://highland.com/assets/highland_logo_social.png',
      url: 'https://highland.com/',
    );

    return Responsive(
      mobile: MobileLayoutHighlandHome(),
      tablet: TabletLayoutHighlandHome(),
      desktop: DesktopLayoutHighlandHome(),
    );
  }
}

class MobileLayoutHighlandHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Highland (Mobile)")), // Uncomment if you want an AppBar here
      body: Highlandhome(),
    );
  }
}

class TabletLayoutHighlandHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Highland (Tablet)")), // Uncomment if you want an AppBar here
      body: Highlandhome(),
    );
  }
}

class DesktopLayoutHighlandHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Highland (Desktop)")), // Uncomment if you want an AppBar here
      body: Highlandhome(),
    );
  }
}
