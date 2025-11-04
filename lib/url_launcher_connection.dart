import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HighlandSocialBar extends StatelessWidget {
  final double iconSize;

  const HighlandSocialBar({super.key, this.iconSize = 16});

  // Helper method to open a URL in a new tab (for web) or external browser (for mobile)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        webOnlyWindowName: '_blank', // Opens in new tab on web
        mode:
            LaunchMode.externalApplication, // Opens external browser on mobile
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // Common helper to build clickable social icon
  Widget _buildSocialIcon(String assetPath, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Image.asset(
          assetPath,
          height: iconSize,
          width: iconSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.011),
      child: Row(
        children: [
          _buildSocialIcon(
            'assets/img/twitter.png',
            'https://x.com/HHospital_mng',
          ),
          _buildSocialIcon(
            'assets/img/facebook.png',
            'https://www.facebook.com/highlandhospitalmangalore',
          ),
          _buildSocialIcon(
            'assets/img/instagram.png',
            'https://www.instagram.com/highlandhospital.mng/#',
          ),
          _buildSocialIcon(
            'assets/img/linkedin.png',
            'https://www.linkedin.com/company/highlandhospital-mng',
          ),
        ],
      ),
    );
  }
}
