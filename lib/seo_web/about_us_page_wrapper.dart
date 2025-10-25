import 'package:flutter/material.dart';
import 'package:flutter_highland/responsive.dart';
import 'package:flutter_highland/seo_web/about_us_content.dart';
import 'package:flutter_highland/seo_web/seo_helper.dart';

class AboutUsPageWrapper extends StatelessWidget {
  const AboutUsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    updateSeoMeta(
      title: 'About Us - Highland Healthcare',
      description:
          'Learn more about Highland Healthcare, our mission, vision, and commitment to patient-first medical services. Discover our story and values.',
      image: 'https://highland.com/assets/about_us_banner.png',
      url: 'https://highland.com/about',
    );

    return Responsive(
      mobile: MobileLayoutAboutUs(),
      tablet: TabletLayoutAboutUs(),
      desktop: DesktopLayoutAboutUs(),
    );
  }
}

class MobileLayoutAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us (Mobile)")), // Example AppBar
      body: const AboutUsContent(),
    );
  }
}

class TabletLayoutAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us (Tablet)")), // Example AppBar
      body: const AboutUsContent(),
    );
  }
}

class DesktopLayoutAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us (Desktop)")), // Example AppBar
      body: const AboutUsContent(),
    );
  }
}
