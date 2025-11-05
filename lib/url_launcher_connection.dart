import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HighlandSocialBar extends StatelessWidget {
  final double iconSize;

  const HighlandSocialBar({super.key, this.iconSize = 18});

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
  // Widget _buildSocialIcon(String assetPath, String url) {
  //   return InkWell(
  //     onTap: () => _launchURL(url),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //       child: SizedBox(
  //         height: iconSize,
  //         width: iconSize,
  //         child: Image.asset(
  //           assetPath,
  //           fit: BoxFit.contain,
  //           color: Colors.orange, // 🔶 Tint color applied
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildSocialIcon(String assetPath, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: iconSize,
          width: iconSize,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            color:
                const Color(0xFF0EA69F), // ✅ Custom teal-green color (#0EA69F)
          ),
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
            'assets/img/twitter2.png',
            'https://x.com/HHospital_mng',
          ),
          _buildSocialIcon(
            'assets/img/facebook1.png',
            'https://www.facebook.com/highlandhospitalmangalore',
          ),
          _buildSocialIcon(
            'assets/img/instagram1.png',
            'https://www.instagram.com/highlandhospital.mng/#',
          ),
          _buildSocialIcon(
            'assets/img/linkedin2.png',
            'https://www.linkedin.com/company/highlandhospital-mng',
          ),
        ],
      ),
    );
  }
}
