// import 'package:flutter/material.dart';
// // Assuming Highlandhome is needed for navigation back or context

// import 'package:flutter_highland/highland_home.dart';
// // Import other necessary pages if navigation is added later
// // import 'package:flutter_highland/constants/Color_Constant.dart'; // If needed

// class About extends StatefulWidget {
//   // final TextEditingController _desktopContactNameController =
//   //     TextEditingController();
//   // final TextEditingController _desktopContactEmailController =
//   //     TextEditingController();
//   // final TextEditingController _desktopContactMobileController =
//   //     TextEditingController();
//   // final TextEditingController _desktopContactMessageController =
//   //     TextEditingController();
//   // final _desktopContactFormKey =
//   //     GlobalKey<FormState>(); // For desktop form validation

//   About({super.key});

//   @override
//   State<About> createState() => _AboutState();
// }

// class _AboutState extends State<About> with TickerProviderStateMixin {
//   late AnimationController _marqueeController;
//   late Animation<Offset> _scrollAnimation;

//   final TextEditingController _contactNameController = TextEditingController();
//   final TextEditingController _contactEmailController = TextEditingController();
//   final TextEditingController _contactMobileController =
//       TextEditingController();
//   final TextEditingController _contactMessageController =
//       TextEditingController();
//   final _contactFormKey = GlobalKey<FormState>(); // Key for the new form
//   // --- End Controllers and Key ---

//   // Simplified menu items - maybe remove entirely if not used in AppBar actions
//   // final List<String> menuItems = ['Home'];

//   // Method to handle menu item tap (if menu items are added back)
//   void onMenuItemTapped(String menuItem) {
//     if (menuItem == 'Home') {
//       // Navigate back to Highlandhome or use Navigator.pop() if appropriate
//       // Example: Assuming Highlandhome is the main screen
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => Highlandhome()),
//         (Route<dynamic> route) => false, // Remove all routes below
//       );
//     } else {
//       print('Tapped: $menuItem');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _marqueeController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 15), // Adjusted duration
//     )..repeat();

//     _scrollAnimation = Tween<Offset>(
//       begin: Offset(1.0, 0.0),
//       end: Offset(-3.0, 0.0), // Adjust end offset based on text length
//     ).animate(CurvedAnimation(
//       parent: _marqueeController,
//       curve: Curves.linear,
//     ));
//   }

//   @override
//   void dispose() {
//     _marqueeController.dispose();
//     // --- Dispose NEW Controllers ---
//     _contactNameController.dispose();
//     _contactEmailController.dispose();
//     _contactMobileController.dispose();
//     _contactMessageController.dispose();
//     // --- End Dispose ---
//     super.dispose();
//   }

//   // --- Responsive Breakpoints ---
//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 650; // Adjusted breakpoint for mobile

//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width < 1100 &&
//       MediaQuery.of(context).size.width >= 650;

//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 1100;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenSize = mediaQuery.size;
//     final screenWidth = screenSize.width;
//     // Determine device type
//     final bool mobile = isMobile(context);
//     final bool tablet = isTablet(context);
//     final bool desktop = isDesktop(context);

//     // --- Dynamic Sizes ---
//     double paragraphFontSize =
//         mobile ? 22 : (tablet ? 24 : (desktop ? 26 : 28));
//     double titleFontSize = mobile ? 24 : (tablet ? 26 : (desktop ? 30 : 32));
//     double messageTitleSize = mobile ? 23 : (tablet ? 25 : (desktop ? 28 : 30));
//     double messageBodySize = mobile ? 20 : (tablet ? 22 : (desktop ? 24 : 26));
//     double contactIconSize = mobile ? 36 : 40; // Increased icon size further
//     double contactTitleSize = mobile ? 20 : (tablet ? 22 : (desktop ? 24 : 26));
//     double contactDescSize = mobile ? 18 : (tablet ? 20 : (desktop ? 22 : 24));
//     double sectionPadding =
//         mobile ? 22 : (tablet ? 32 : (desktop ? 42 : 48)); // Larger padding
//     double headingSize = mobile ? 24 : (tablet ? 26 : (desktop ? 28 : 30));
//     double bodyTextMedium = mobile ? 20 : (tablet ? 21 : (desktop ? 23 : 25));
//     double buttonTextSize = mobile ? 21 : (tablet ? 22 : (desktop ? 24 : 26));

//     return Scaffold(
//       appBar: AppBar(
//         // Custom Back Button
//         leading: IconButton(
//           icon: Padding(
//             padding: EdgeInsets.only(left: mobile ? 10 : 20), // Adjust padding
//             child: Icon(Icons.arrow_back_ios,
//                 color: Colors.white, size: mobile ? 20 : 24),
//           ),
//           tooltip: 'Back',
//           onPressed: () => Navigator.pop(context), // Standard back action
//         ),
//         title: Text(
//           'About Highland Hospital',
//           style: TextStyle(
//             fontSize: mobile ? 18 : 20, // Responsive title size
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true, // Center title for better look
//         backgroundColor: Color(0xFF1BA08F), // Consistent color theme
//         elevation: 2.0,
//         // Optional: Add Home action if needed
//         // actions: [
//         //   TextButton(
//         //     onPressed: () => onMenuItemTapped('Home'),
//         //     child: Text(
//         //       'Home',
//         //       style: TextStyle(
//         //           color: Colors.white,
//         //           fontSize: mobile ? 14 : 16,
//         //           fontWeight: FontWeight.bold),
//         //     ),
//         //     style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: mobile ? 10: 20)),
//         //   )
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Top Border (Optional - maybe remove if AppBar has color)
//             // Container(
//             //   width: screenWidth,
//             //   height: 3,
//             //   decoration: BoxDecoration(color: Color(0xFFEE9B27)),
//             // ),
//             SizedBox(height: sectionPadding), // Initial padding

//             // Main About Text Card
//             _buildAboutTextCard(context, mobile, tablet, desktop,
//                 paragraphFontSize, sectionPadding),
//             SizedBox(height: sectionPadding * 1.2),

//             // Chairman Message
//             _buildMessageSection(
//               context: context,
//               mobile: mobile,
//               tablet: tablet,
//               desktop: desktop,
//               imageUrl: "assets/img/Dr.c.p.abdul rahman.jpg",
//               title: "Message from the Chairman",
//               name: "Dr. C P Abdulla Rahman",
//               message:
//                   '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ embodies our commitment to creating a compassionate, inclusive healthcare environment for everyone who walks through our doors. Founded with a vision to deliver high-quality, accessible care, we have dedicated over 30 years to meeting the evolving needs of our community. Every patient experience is shaped by our guiding values of integrity, respect, and empathy, upheld by a skilled team who share our dedication to healing and hope. It is a privilege to serve Mangalore and beyond, and we remain deeply committed to enhancing the health and wellness of our community with every step forward. Highland Hospital is more than a healthcare institution; it is a legacy of care, compassion, and unwavering dedication to the well-being of each patient who entrusts us with their health."''',
//               isImageLeft: true,
//               titleSize: messageTitleSize,
//               bodySize: messageBodySize,
//               sectionPadding: sectionPadding,
//             ),
//             SizedBox(height: sectionPadding),

//             // Managing Director Message
//             _buildMessageSection(
//               context: context,
//               mobile: mobile,
//               tablet: tablet,
//               desktop: desktop,
//               imageUrl: "assets/img/Dr.c.p.abdulla yasser.jpg",
//               title: "Message from the Managing Director",
//               name: "Dr. C P Abdulla Yasser",
//               message:
//                   '''“As Managing Director of Highland Hospital, I am honored to carry forward the legacy that ‘YOUR HEALTH, OUR CARE’ represents. Each day, we work tirelessly to blend innovative medical practices with a human touch, recognizing that healthcare is not solely about treatments—it is about trust, dignity, and partnership. Our commitment to excellence is driven by a dedication to improve not only outcomes but also patient experiences. Highland Hospital is a place where cutting-edge technology meets compassion, and where our values of empathy, integrity, and quality drive everything we do. We envision a healthcare environment where every individual, regardless of circumstance, can feel safe, cared for, and respected. With a relentless focus on this mission, we continue to build on our legacy to serve our patients and community with unmatched dedication.”''',
//               isImageLeft: false, // Image on the right
//               titleSize: messageTitleSize,
//               bodySize: messageBodySize,
//               sectionPadding: sectionPadding,
//             ),
//             SizedBox(height: sectionPadding),

//             // CEO Message
//             _buildMessageSection(
//               context: context,
//               mobile: mobile,
//               tablet: tablet,
//               desktop: desktop,
//               imageUrl: "assets/img/Mr.Mohammed yoonus.jpg",
//               title: "Message from the CEO",
//               name: "Mr. Mohammed Yoonus",
//               message:
//                   '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ reflects our relentless pursuit of operational excellence and our dedication to patient-centered care. As CEO, I believe that every facet of our hospital’s operations should serve to elevate the patient experience, making healthcare efficient, compassionate, and accessible to all. Our team is focused on implementing advanced technologies and evidence-based practices, while continually striving to maintain the warmth and respect our patients deserve. We invest in both our people and our resources to uphold Highland Hospital’s reputation as a trusted healthcare provider. By nurturing an environment of support and collaboration, we aim to transform healthcare delivery, ensuring each patient experiences a seamless, caring journey toward better health. This is the Highland promise, a commitment to quality, respect, and an unwavering focus on the well-being of our patients and community.”''',
//               isImageLeft: true,
//               titleSize: messageTitleSize,
//               bodySize: messageBodySize,
//               sectionPadding: sectionPadding,
//             ),
//             SizedBox(height: sectionPadding * 1.5),

//             // Contact Info Section
//             _buildContactInfoSection(
//                 context,
//                 mobile,
//                 tablet,
//                 desktop,
//                 contactIconSize,
//                 contactTitleSize,
//                 contactDescSize,
//                 sectionPadding),
//             // SizedBox(height: sectionPadding * 1.5), // No extra space needed before next section if it has background

//             // Specialities & Contact Form Section
//             _buildSpecialitiesAndFormSectionAbout(
//                 context,
//                 screenSize,
//                 desktop,
//                 tablet,
//                 mobile,
//                 headingSize,
//                 bodyTextMedium,
//                 buttonTextSize,
//                 sectionPadding),
//             SizedBox(height: sectionPadding),

//             // Disclaimer Marquee (Hidden on mobile)
//             mobile // Check if it's mobile
//                 // If mobile, show the static disclaimer
//                 ? _buildStaticDisclaimerAbout(
//                     context, bodyTextMedium) // Use appropriate base text size
//                 // If not mobile (tablet or desktop), show the scrolling marquee
//                 : _buildDisclaimerMarqueeAbout(context, desktop, tablet, mobile,
//                     headingSize * 0.85), // Use
//             _buildFooterAbout(
//                 context, desktop, tablet, mobile, bodyTextMedium * 0.9),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- Helper Widgets ---

//   Widget _buildAboutTextCard(BuildContext context, bool mobile, bool tablet,
//       bool desktop, double paragraphFontSize, double sectionPadding) {
//     return Card(
//       elevation: mobile ? 4.0 : 6.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(mobile ? 8.0 : 12.0),
//       ),
//       margin: EdgeInsets.symmetric(horizontal: sectionPadding, vertical: 8.0),
//       child: Padding(
//         padding: EdgeInsets.all(mobile ? 12.0 : (tablet ? 16.0 : 20.0)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildParagraph(
//                 '''Founded by Dr. C P Abdulla Rahman and Mrs. Y Razia Rahman, Highland Hospital in Mangalore has been a cornerstone of healthcare excellence for over three decades. Built on the ethos of “YOUR HEALTH, OUR CARE,” the hospital embodies a commitment to delivering compassionate and accessible healthcare services to all. From its humble beginnings, Highland has grown into a trusted healthcare provider, blending cutting-edge medical technology with personalized care that puts patients at the center of everything we do.''',
//                 paragraphFontSize),
//             SizedBox(height: mobile ? 12 : 16),
//             _buildParagraph(
//                 '''Our multidisciplinary team of healthcare professionals, driven by a shared mission of improving lives, provides world-class treatment across a wide range of medical specialties. Whether it’s preventive care, advanced surgeries, or rehabilitation services, Highland Hospital is dedicated to ensuring that every patient receives the highest standard of care in a comfortable and supportive environment.''',
//                 paragraphFontSize),
//             SizedBox(height: mobile ? 12 : 16),
//             _buildParagraph(
//                 '''Our journey doesn’t stop at medical care. Highland Hospital has been deeply involved in philanthropic initiatives that ensure healthcare is accessible to underserved communities, making a positive impact on countless lives. These initiatives, inspired by the founders’ vision, continue to grow under the leadership of Dr. C P Abdulla Yasser, ensuring that our commitment to community welfare remains unwavering.''',
//                 paragraphFontSize),
//             SizedBox(height: mobile ? 12 : 16),
//             _buildParagraph(
//                 '''Today, Highland Hospital stands as a beacon of trust and innovation, recognized for its contributions to healthcare and its role in uplifting the community. As we look to the future, we are continually evolving, driven by a passion for excellence, empathy, and integrity. Through every service and every interaction, we strive to create a healthcare ecosystem that not only treats illness but fosters long-term health and well-being. Our dedication to “YOUR HEALTH, OUR CARE” ensures that Highland Hospital remains a sanctuary for healing, hope, and compassionate care, not just for Mangalore, but for all who seek our services.''',
//                 paragraphFontSize),
//           ],
//         ),
//       ),
//     );
//   }

//   // Reusable Paragraph Builder
//   Widget _buildParagraph(String content, double fontSize) {
//     return Text(
//       content,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: Colors.grey[700], // Consistent color
//         height: 1.6, // Line spacing
//         // fontFamily: 'Roboto', // Optional: Specify font
//         // fontWeight: FontWeight.w400, // Normal weight
//       ),
//       textAlign: TextAlign.justify,
//     );
//   }

//   // Reusable Message Section Builder
//   Widget _buildMessageSection({
//     required BuildContext context,
//     required bool mobile,
//     required bool tablet,
//     required bool desktop,
//     required String imageUrl,
//     required String title,
//     required String name,
//     required String message,
//     required bool isImageLeft,
//     required double titleSize,
//     required double bodySize,
//     required double sectionPadding,
//   }) {
//     double imageWidth = mobile ? 120 : (tablet ? 160 : 180);
//     double imageHeight = mobile ? 180 : (tablet ? 240 : 270);
//     double borderRadius = mobile ? 10 : 15;

//     Widget imageWidget = Container(
//       width: imageWidth,
//       height: imageHeight,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(imageUrl),
//           fit: BoxFit.cover,
//           onError: (exception, stackTrace) =>
//               print('Error loading image: $imageUrl'), // Add error handling
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black26,
//               blurRadius: mobile ? 4 : 6,
//               offset: Offset(2, 2))
//         ],
//       ),
//       // Optional: Add placeholder for loading or error
//       child: Image.asset(imageUrl, fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//         return Container(
//             color: Colors.grey[300],
//             child: Center(
//                 child: Icon(Icons.person, size: 50, color: Colors.grey[600])));
//       }),
//     );

//     Widget textWidget = Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
//         children: [
//           Text(
//             title, // Like "Message from the Chairman"
//             style: TextStyle(
//               fontSize: titleSize * 0.9, // Slightly smaller title
//               fontWeight: FontWeight.w600,
//               color: Colors.blueGrey[700],
//               // letterSpacing: 1.1,
//             ),
//           ),
//           Text(
//             name, // Like "Dr. C P Abdulla Rahman"
//             style: TextStyle(
//               fontSize: titleSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.blueGrey[800],
//               letterSpacing: 1.2,
//               shadows: [
//                 Shadow(
//                     color: Colors.black12, blurRadius: 2, offset: Offset(1, 1)),
//               ],
//             ),
//           ),
//           SizedBox(height: mobile ? 8 : 12),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: bodySize,
//               color: Colors.grey[700],
//               height: 1.6,
//             ),
//             textAlign: TextAlign.justify,
//           ),
//         ],
//       ),
//     );

//     List<Widget> children = isImageLeft
//         ? [imageWidget, SizedBox(width: mobile ? 15 : 20), textWidget]
//         : [textWidget, SizedBox(width: mobile ? 15 : 20), imageWidget];

//     if (mobile) {
//       // Stack vertically on mobile
//       children = [
//         imageWidget,
//         SizedBox(height: 15),
//         // Need to wrap textWidget correctly if it was Expanded before
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(title,
//               style: TextStyle(
//                   fontSize: titleSize * 0.9,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.blueGrey[700])),
//           Text(name,
//               style: TextStyle(
//                   fontSize: titleSize,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueGrey[800],
//                   letterSpacing: 1.2,
//                   shadows: [
//                     Shadow(
//                         color: Colors.black12,
//                         blurRadius: 2,
//                         offset: Offset(1, 1)),
//                   ])),
//           SizedBox(height: 8),
//           Text(message,
//               style: TextStyle(
//                   fontSize: bodySize, color: Colors.grey[700], height: 1.6),
//               textAlign: TextAlign.justify),
//         ]),
//       ];
//       return Container(
//         padding: EdgeInsets.all(mobile ? 12 : 16),
//         margin: EdgeInsets.symmetric(horizontal: sectionPadding),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),
//           color: Colors.white, // Use white or light grey
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: mobile ? 6 : 8.0,
//               spreadRadius: mobile ? 1 : 2.0,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment:
//               mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//           children: children,
//         ),
//       );
//     } else {
//       // Use Row for tablet/desktop
//       return Container(
//         padding: EdgeInsets.all(tablet ? 18 : 24),
//         margin: EdgeInsets.symmetric(horizontal: sectionPadding),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),
//           color: Colors.grey[100], // Light background for contrast
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 8.0,
//               spreadRadius: 4.0,
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment:
//               CrossAxisAlignment.center, // Align items vertically center
//           children: children,
//         ),
//       );
//     }
//   }

//   // Contact Info Section
//   Widget _buildContactInfoSection(
//       BuildContext context,
//       bool mobile,
//       bool tablet,
//       bool desktop,
//       double iconSize,
//       double titleSize,
//       double descSize,
//       double sectionPadding) {
//     Widget locationCol = _buildContactColumnItem(
//         mobile: mobile,
//         icon: Icons.location_on,
//         title: 'Location',
//         description:
//             'Mother Theresa Road,\nKankanady, Mangaluru,\nKarnataka 575002, India.',
//         iconSize: iconSize,
//         titleSize: titleSize,
//         descriptionSize: descSize);
//     Widget emergencyCol = _buildContactColumnItem(
//         mobile: mobile,
//         icon: Icons.phone,
//         title: 'Emergency 24x7',
//         description: '0824-4235555',
//         iconSize: iconSize,
//         titleSize: titleSize,
//         descriptionSize: descSize);
//     Widget emailCol = _buildContactColumnItem(
//         mobile: mobile,
//         icon: Icons.email,
//         title: 'Email',
//         description: 'reachus@highlandhospital.in',
//         iconSize: iconSize,
//         titleSize: titleSize,
//         descriptionSize: descSize);

//     return Container(
//       width: double.infinity,
//       color: Color(0xFF1FBCB1), // Background color
//       padding: EdgeInsets.symmetric(
//           vertical: sectionPadding * 1.5, horizontal: sectionPadding),
//       child: mobile
//           ? Column(
//               // Stack vertically on mobile
//               crossAxisAlignment: CrossAxisAlignment.start, // Align items left
//               children: [
//                 locationCol,
//                 SizedBox(height: 20),
//                 emergencyCol,
//                 SizedBox(height: 20),
//                 emailCol,
//               ],
//             )
//           : Row(
//               // Row layout for tablet/desktop
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceAround, // Space out columns
//               crossAxisAlignment: CrossAxisAlignment.start, // Align tops
//               children: [
//                 Expanded(child: locationCol),
//                 SizedBox(width: tablet ? 15 : 20), // Spacing
//                 Expanded(child: emergencyCol),
//                 SizedBox(width: tablet ? 15 : 20), // Spacing
//                 Expanded(child: emailCol),
//               ],
//             ),
//     );
//   }

//   // Helper for individual Contact Info Column Item
//   Widget _buildContactColumnItem(
//       {required bool mobile,
//       required IconData icon,
//       required String title,
//       required String description,
//       required double iconSize,
//       required double titleSize,
//       required double descriptionSize}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment:
//           mobile ? MainAxisAlignment.start : MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: Color(0xFFEE9821), size: iconSize), // Accent color
//         SizedBox(width: mobile ? 10 : 15),
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: titleSize,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white), // White text
//               ),
//               SizedBox(height: 4),
//               Text(
//                 description,
//                 style: TextStyle(
//                     fontSize: descriptionSize,
//                     color: Colors.white.withOpacity(0.9),
//                     height: 1.3), // White text
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // --- Specialities & Contact Form Section (Adapted for About Page) ---
//   Widget _buildSpecialitiesAndFormSectionAbout(
//       BuildContext context,
//       Size screenSize,
//       bool isDesktop,
//       bool isTablet,
//       bool isMobile,
//       double headingSize,
//       double bodyTextMedium,
//       double buttonTextSize,
//       double sectionPadding) {
//     // Define the widgets for specialities and form (no change here)
//     Widget specialities1 = _buildSpecialitiesListAbout(context,
//         isMobile: isMobile,
//         title: 'Specialities',
//         specialties: [
//           'General Medicine',
//           'General Surgery',
//           'Orthopaedic & Trauma Care',
//           'Total Knee & Hip Replacement',
//           'Arthroscopy & Sports Medicine',
//           'Pediatric & Pediatric Surgery',
//           'Nephrology',
//           'Gastroenterology',
//         ],
//         headingSize: headingSize,
//         bodyTextMedium: bodyTextMedium);

//     Widget specialities2 = _buildSpecialitiesListAbout(context,
//         isMobile: isMobile,
//         title: '', // No title for the second list
//         specialties: [
//           'Ophthalmology',
//           'E.N.T Micro Surgery',
//           'Neurology and Neuro Surgery',
//           'Plastic & Reconstructive Surgery',
//           'Maxillofacial Surgery',
//           'Microvascular Surgery',
//           'Endocrinology',
//           'Urology & Andrology',
//         ],
//         headingSize: headingSize,
//         bodyTextMedium: bodyTextMedium);

//     Widget contactForm = _buildContactUsFormAbout(
//         context, isMobile, headingSize, bodyTextMedium, buttonTextSize);

//     // Return the container with conditional layout logic
//     return Container(
//       color: Color(0xFFF5F5F5), // Slightly different background
//       padding: EdgeInsets.all(sectionPadding),
//       child: isMobile
//           // --- Mobile Layout ---
//           ? Column(
//               // Main column for mobile: Holds the Row of specialities and the form below
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Row for the two specialities lists
//                 Row(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start, // Align tops of lists
//                   children: [
//                     Expanded(
//                       // Use Expanded to allow lists to share horizontal space
//                       child: specialities1,
//                     ),
//                     SizedBox(width: 15), // Add spacing between the two lists
//                     Expanded(
//                       // Use Expanded for the second list as well
//                       child: specialities2,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                     height:
//                         25), // Space between the specialities row and the contact form
//                 contactForm, // Place the contact form below the row
//               ],
//             )
//           // --- Tablet/Desktop Layout ---
//           : Row(
//               // Keep the original Row layout for tablet/desktop
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(flex: 2, child: specialities1),
//                 SizedBox(width: 20),
//                 Expanded(flex: 2, child: specialities2),
//                 SizedBox(width: 30),
//                 Expanded(flex: 3, child: contactForm),
//               ],
//             ),
//     );
//   }

//   // --- Helper for Specialities List (About Page) ---
//   // No changes needed in _buildSpecialitiesListAbout itself, but ensure it uses
//   // Flexible/Expanded internally if needed, though the structure you have
//   // with Row(Icon, Flexible(Text)) is generally good.

//   Widget _buildSpecialitiesListAbout(BuildContext context,
//       {required bool isMobile,
//       required String title,
//       required List<String> specialties,
//       required double headingSize,
//       required double bodyTextMedium}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title.isNotEmpty)
//           Text(
//             title,
//             style: TextStyle(
//                 color: Color.fromARGB(255, 24, 14, 14), // Darker text
//                 fontSize: headingSize,
//                 fontWeight: FontWeight.bold),
//           ),
//         if (title.isNotEmpty) SizedBox(height: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: specialties
//               .map((spec) => Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               right: 8.0,
//                               top: 5), // Adjust icon alignment if needed
//                           child: Icon(Icons.circle,
//                               size: 8,
//                               color: Color(0xFF1BA08F)), // Theme color bullet
//                         ),
//                         Flexible(
//                           // Crucial: Allows text to wrap within available space
//                           child: Text(
//                             spec,
//                             style: TextStyle(
//                                 color: Color.fromARGB(
//                                     255, 50, 50, 50), // Slightly lighter text
//                                 fontSize: bodyTextMedium,
//                                 height: 1.3), // Line height
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildStaticDisclaimerAbout(BuildContext context, double textSize) {
//     return RichText(
//       textAlign: TextAlign.center, // Center the text block
//       text: TextSpan(
//         // Base style for the static text
//         style: TextStyle(
//             color: Colors.black54, fontSize: textSize * 0.95, height: 1.4),
//         children: <TextSpan>[
//           // Make "Disclaimer:" bold and slightly larger
//           TextSpan(
//               text: 'Disclaimer: ',
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: textSize)),
//           // The main message
//           const TextSpan(text: 'We do not charge for hiring!'),
//         ],
//       ),
//     );
//   }

//   // Helper for Contact Us Form (About Page) - Reuses validation logic
//   Widget _buildContactUsFormAbout(BuildContext context, bool isMobile,
//       double headingSize, double bodyTextMedium, double buttonTextSize) {
//     // Define controllers and key locally for this form instance
//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController emailController = TextEditingController();
//     final TextEditingController mobileController = TextEditingController();
//     final TextEditingController messageController = TextEditingController();
//     final formKey = GlobalKey<FormState>();

//     // Dispose controllers when the state is disposed if they were state variables
//     // If defined locally like here, they are garbage collected automatically.

//     return Form(
//       key: formKey, // Still using form key
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Contact us',
//             style: TextStyle(
//               color: const Color.fromARGB(255, 15, 12, 12),
//               fontSize: headingSize,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),

//           // --- Name Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               ),
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),

//           // --- Email Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: TextField(
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 labelText: 'Email:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               ),
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),

//           // --- Mobile Number Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: TextField(
//               controller: mobileController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Mobile Number:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               ),
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),

//           // --- Message Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: TextField(
//               controller: messageController,
//               maxLines: isMobile ? 3 : 4,
//               decoration: const InputDecoration(
//                 labelText: 'Message:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               ),
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // --- Submit Button ---
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Center(
//                 child: SizedBox(
//                   width: isMobile ? double.infinity : 240, // Responsive width
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Validation logic
//                       bool hasError = false;
//                       String errorMessage = 'Please fill all required fields.';

//                       final emailValid =
//                           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(emailController.text);
//                       final phoneValid = RegExp(r'^[0-9]{10}$')
//                           .hasMatch(mobileController.text);

//                       if (nameController.text.isEmpty ||
//                           emailController.text.isEmpty ||
//                           mobileController.text.isEmpty ||
//                           messageController.text.isEmpty) {
//                         hasError = true;
//                       } else if (!emailValid || !phoneValid) {
//                         hasError = true;
//                         errorMessage = 'Please check email/phone format.';
//                       }

//                       if (hasError) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(errorMessage),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                         return;
//                       }

//                       // On success
//                       print("Form Submitted (Styled Version):");
//                       print(
//                           "Name: ${nameController.text}, Email: ${emailController.text}, Mobile: ${mobileController.text}, Message: ${messageController.text}");

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Message Submitted!'),
//                           backgroundColor: Colors.green,
//                         ),
//                       );

//                       // Clear fields
//                       nameController.clear();
//                       emailController.clear();
//                       mobileController.clear();
//                       messageController.clear();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE7A20E),
//                       foregroundColor: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(vertical: isMobile ? 12 : 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
//                       ),
//                       textStyle: TextStyle(
//                         fontSize: buttonTextSize,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     child: const Text('Submit'),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   // Helper for Contact Form Text Field (About Page Styling)
//   Widget _buildContactTextFieldAbout(
//       {required TextEditingController controller,
//       required String label,
//       required bool isMobile,
//       TextInputType keyboardType = TextInputType.text,
//       int maxLines = 1,
//       required double inputFontSize,
//       String? Function(String?)? validator}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       style: TextStyle(fontSize: inputFontSize, color: Colors.black87),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(fontSize: inputFontSize, color: Colors.grey[700]),
//         fillColor: Colors.white,
//         filled: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
//           borderSide: BorderSide(color: Color(0xFF1BA08F), width: 1.5),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
//           borderSide: BorderSide(color: Colors.red, width: 1.0),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
//           borderSide: BorderSide(color: Colors.red, width: 1.5),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//             horizontal: 15, vertical: maxLines > 1 ? 15 : 10),
//       ),
//       validator: validator ??
//           (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter $label';
//             }
//             return null;
//           },
//     );
//   }

//   Widget _buildDisclaimerMarqueeAbout(BuildContext context, bool isDesktop,
//       bool isTablet, bool isMobile, double textSize) {

//     return ClipRect(
//       child: SlideTransition(
//         position: _scrollAnimation,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Disclaimer: ',
//                 style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: textSize,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(width: 10),
//               Text(
//                 'We do not charge for hiring!', // Shortened message
//                 style:
//                     TextStyle(color: Colors.black54, fontSize: textSize * 0.95),
//               ),
//               SizedBox(width: 50), // Spacing
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Footer ---
//   Widget _buildFooterAbout(BuildContext context, bool isDesktop, bool isTablet,
//       bool isMobile, double footerTextSize) {
//     return Container(
//       width: double.infinity,
//       color: Color(0xFF1BA08D), // Theme color
//       padding: EdgeInsets.symmetric(
//           vertical: isMobile ? 10 : 15, horizontal: isMobile ? 15 : 30),
//       child: isMobile
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   '© Highland Hospitals. All Rights Reserved',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: footerTextSize,
//                       fontWeight: FontWeight.w500),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
//                   style: TextStyle(
//                       color: Colors.white.withOpacity(0.8),
//                       fontSize: footerTextSize * 0.9),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             )
//           : Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     '© Highland Hospitals. All Rights Reserved',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: footerTextSize,
//                         fontWeight: FontWeight.w500),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Flexible(
//                   child: Text(
//                     'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
//                     style: TextStyle(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: footerTextSize),
//                     textAlign: TextAlign.right,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highland/controller/contact_inquiry_controller.dart';
// Assuming Highlandhome is needed for navigation back or context

import 'package:flutter_highland/highland_home.dart';
import 'package:flutter_highland/model/contact_enquiry.dart';
import 'package:provider/provider.dart';
// Import other necessary pages if navigation is added later
// import 'package:flutter_highland/constants/Color_Constant.dart'; // If needed

class About extends StatefulWidget {
  // final TextEditingController _desktopContactNameController =
  //     TextEditingController();
  // final TextEditingController _desktopContactEmailController =
  //     TextEditingController();
  // final TextEditingController _desktopContactMobileController =
  //     TextEditingController();
  // final TextEditingController _desktopContactMessageController =
  //     TextEditingController();
  // final _desktopContactFormKey =
  //     GlobalKey<FormState>(); // For desktop form validation

  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  late AnimationController _marqueeController;
  late Animation<Offset> _scrollAnimation;

  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactMobileController =
      TextEditingController();
  final TextEditingController _contactMessageController =
      TextEditingController();
  final _contactFormKey = GlobalKey<FormState>(); // Key for the new form
  // --- End Controllers and Key ---

  // Simplified menu items - maybe remove entirely if not used in AppBar actions
  // final List<String> menuItems = ['Home'];

  // Method to handle menu item tap (if menu items are added back)
  void onMenuItemTapped(String menuItem) {
    if (menuItem == 'Home') {
      // Navigate back to Highlandhome or use Navigator.pop() if appropriate
      // Example: Assuming Highlandhome is the main screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Highlandhome()),
        (Route<dynamic> route) => false, // Remove all routes below
      );
    } else {
      print('Tapped: $menuItem');
    }
  }

  @override
  void initState() {
    super.initState();
    _marqueeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15), // Adjusted duration
    )..repeat();

    _scrollAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(-3.0, 0.0), // Adjust end offset based on text length
    ).animate(CurvedAnimation(
      parent: _marqueeController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _marqueeController.dispose();
    // --- Dispose NEW Controllers ---
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactMobileController.dispose();
    _contactMessageController.dispose();
    // --- End Dispose ---
    super.dispose();
  }

  // --- Responsive Breakpoints ---
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650; // Adjusted breakpoint for mobile

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final screenWidth = screenSize.width;
    // Determine device type
    final bool mobile = isMobile(context);
    final bool tablet = isTablet(context);
    final bool desktop = isDesktop(context);

    // --- Dynamic Sizes ---
    // ***** THE ONLY CHANGES ARE HERE *****
    double paragraphFontSize =
        mobile ? 16 : (tablet ? 18 : 20); // Made text smaller
    double messageBodySize =
        mobile ? 16 : (tablet ? 18 : 20); // Made this smaller to match
    // **********************************

    double titleFontSize = mobile ? 24 : (tablet ? 26 : (desktop ? 30 : 32));
    double messageTitleSize = mobile ? 23 : (tablet ? 25 : (desktop ? 28 : 30));
    double contactIconSize = mobile ? 36 : 40; // Increased icon size further
    double contactTitleSize = mobile ? 20 : (tablet ? 22 : (desktop ? 24 : 26));
    double contactDescSize = mobile ? 18 : (tablet ? 20 : (desktop ? 22 : 24));
    double sectionPadding =
        mobile ? 22 : (tablet ? 32 : (desktop ? 42 : 48)); // Larger padding
    double headingSize = mobile ? 24 : (tablet ? 26 : (desktop ? 28 : 30));
    double bodyTextMedium = mobile ? 20 : (tablet ? 21 : (desktop ? 23 : 25));
    double buttonTextSize = mobile ? 21 : (tablet ? 22 : (desktop ? 24 : 26));

    return Scaffold(
      appBar: AppBar(
        // Custom Back Button
        leading: IconButton(
          icon: Padding(
            padding: EdgeInsets.only(left: mobile ? 10 : 20), // Adjust padding
            child: Icon(Icons.arrow_back, // <--- This is the new standard icon
                color: Colors.white,
                size: mobile ? 20 : 24),
          ),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context), // Standard back action
        ),
        title: Text(
          'About Highland Hospital',
          style: TextStyle(
            fontSize: mobile ? 18 : 20, // Responsive title size
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Center title for better look
        backgroundColor: Color(0xFF1BA08F), // Consistent color theme
        elevation: 2.0,
        // Optional: Add Home action if needed
        // actions: [
        //   TextButton(
        //     onPressed: () => onMenuItemTapped('Home'),
        //     child: Text(
        //       'Home',
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontSize: mobile ? 14 : 16,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: mobile ? 10: 20)),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Border (Optional - maybe remove if AppBar has color)
            // Container(
            //   width: screenWidth,
            //   height: 3,
            //   decoration: BoxDecoration(color: Color(0xFFEE9B27)),
            // ),
            SizedBox(height: sectionPadding), // Initial padding

            // Main About Text Card
            _buildAboutTextCard(context, mobile, tablet, desktop,
                paragraphFontSize, sectionPadding),
            SizedBox(height: sectionPadding * 1.2),

            // Chairman Message
            _buildMessageSection(
              context: context,
              mobile: mobile,
              tablet: tablet,
              desktop: desktop,
              imageUrl: "assets/img/Dr.c.p.abdul rahman.jpg",
              title: "Message from the Chairman",
              name: "Dr. C P Abdulla Rahman",
              message:
                  '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ embodies our commitment to creating a compassionate, inclusive healthcare environment for everyone who walks through our doors. Founded with a vision to deliver high-quality, accessible care, we have dedicated over 30 years to meeting the evolving needs of our community. Every patient experience is shaped by our guiding values of integrity, respect, and empathy, upheld by a skilled team who share our dedication to healing and hope. It is a privilege to serve Mangalore and beyond, and we remain deeply committed to enhancing the health and wellness of our community with every step forward. Highland Hospital is more than a healthcare institution; it is a legacy of care, compassion, and unwavering dedication to the well-being of each patient who entrusts us with their health."''',
              isImageLeft: true,
              titleSize: messageTitleSize,
              bodySize: messageBodySize,
              sectionPadding: sectionPadding,
            ),
            SizedBox(height: sectionPadding),

            // Managing Director Message
            _buildMessageSection(
              context: context,
              mobile: mobile,
              tablet: tablet,
              desktop: desktop,
              imageUrl: "assets/img/Dr.c.p.abdulla yasser.jpg",
              title: "Message from the Managing Director",
              name: "Dr. C P Abdulla Yasser",
              message:
                  '''“As Managing Director of Highland Hospital, I am honored to carry forward the legacy that ‘YOUR HEALTH, OUR CARE’ represents. Each day, we work tirelessly to blend innovative medical practices with a human touch, recognizing that healthcare is not solely about treatments—it is about trust, dignity, and partnership. Our commitment to excellence is driven by a dedication to improve not only outcomes but also patient experiences. Highland Hospital is a place where cutting-edge technology meets compassion, and where our values of empathy, integrity, and quality drive everything we do. We envision a healthcare environment where every individual, regardless of circumstance, can feel safe, cared for, and respected. With a relentless focus on this mission, we continue to build on our legacy to serve our patients and community with unmatched dedication.”''',
              isImageLeft: false, // Image on the right
              titleSize: messageTitleSize,
              bodySize: messageBodySize,
              sectionPadding: sectionPadding,
            ),
            SizedBox(height: sectionPadding),

            // CEO Message
            _buildMessageSection(
              context: context,
              mobile: mobile,
              tablet: tablet,
              desktop: desktop,
              imageUrl: "assets/img/Mr.Mohammed yoonus.jpg",
              title: "Message from the CEO",
              name: "Mr. Mohammed Yoonus",
              message:
                  '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ reflects our relentless pursuit of operational excellence and our dedication to patient-centered care. As CEO, I believe that every facet of our hospital’s operations should serve to elevate the patient experience, making healthcare efficient, compassionate, and accessible to all. Our team is focused on implementing advanced technologies and evidence-based practices, while continually striving to maintain the warmth and respect our patients deserve. We invest in both our people and our resources to uphold Highland Hospital’s reputation as a trusted healthcare provider. By nurturing an environment of support and collaboration, we aim to transform healthcare delivery, ensuring each patient experiences a seamless, caring journey toward better health. This is the Highland promise, a commitment to quality, respect, and an unwavering focus on the well-being of our patients and community.”''',
              isImageLeft: true,
              titleSize: messageTitleSize,
              bodySize: messageBodySize,
              sectionPadding: sectionPadding,
            ),
            SizedBox(height: sectionPadding * 1.5),

            // Contact Info Section
            _buildContactInfoSection(
                context,
                mobile,
                tablet,
                desktop,
                contactIconSize,
                contactTitleSize,
                contactDescSize,
                sectionPadding),
            // SizedBox(height: sectionPadding * 1.5), // No extra space needed before next section if it has background

            // Specialities & Contact Form Section
            _buildSpecialitiesAndFormSectionAbout(
                context,
                screenSize,
                desktop,
                tablet,
                mobile,
                headingSize,
                bodyTextMedium,
                buttonTextSize,
                sectionPadding),
            SizedBox(height: sectionPadding),

            // Disclaimer Marquee (Hidden on mobile)
            // mobile // Check if it's mobile
            //     // If mobile, show the static disclaimer
            //     ? _buildStaticDisclaimerAbout(
            //         context, bodyTextMedium) // Use appropriate base text size
            //     // If not mobile (tablet or desktop), show the scrolling marquee
            //     : _buildDisclaimerMarqueeAbout(context, desktop, tablet, mobile,
            //         headingSize * 0.85), // Use
            _buildFooterAbout(
                context, desktop, tablet, mobile, bodyTextMedium * 0.9),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAboutTextCard(BuildContext context, bool mobile, bool tablet,
      bool desktop, double paragraphFontSize, double sectionPadding) {
    return Card(
      elevation: mobile ? 4.0 : 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mobile ? 8.0 : 12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: sectionPadding, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(mobile ? 12.0 : (tablet ? 16.0 : 20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildParagraph(
                '''Founded by Dr. C P Abdulla Rahman and Mrs. Y Razia Rahman, Highland Hospital in Mangalore has been a cornerstone of healthcare excellence for over three decades. Built on the ethos of “YOUR HEALTH, OUR CARE,” the hospital embodies a commitment to delivering compassionate and accessible healthcare services to all. From its humble beginnings, Highland has grown into a trusted healthcare provider, blending cutting-edge medical technology with personalized care that puts patients at the center of everything we do.''',
                paragraphFontSize),
            SizedBox(height: mobile ? 12 : 16),
            _buildParagraph(
                '''Our multidisciplinary team of healthcare professionals, driven by a shared mission of improving lives, provides world-class treatment across a wide range of medical specialties. Whether it’s preventive care, advanced surgeries, or rehabilitation services, Highland Hospital is dedicated to ensuring that every patient receives the highest standard of care in a comfortable and supportive environment.''',
                paragraphFontSize),
            SizedBox(height: mobile ? 12 : 16),
            _buildParagraph(
                '''Our journey doesn’t stop at medical care. Highland Hospital has been deeply involved in philanthropic initiatives that ensure healthcare is accessible to underserved communities, making a positive impact on countless lives. These initiatives, inspired by the founders’ vision, continue to grow under the leadership of Dr. C P Abdulla Yasser, ensuring that our commitment to community welfare remains unwavering.''',
                paragraphFontSize),
            SizedBox(height: mobile ? 12 : 16),
            _buildParagraph(
                '''Today, Highland Hospital stands as a beacon of trust and innovation, recognized for its contributions to healthcare and its role in uplifting the community. As we look to the future, we are continually evolving, driven by a passion for excellence, empathy, and integrity. Through every service and every interaction, we strive to create a healthcare ecosystem that not only treats illness but fosters long-term health and well-being. Our dedication to “YOUR HEALTH, OUR CARE” ensures that Highland Hospital remains a sanctuary for healing, hope, and compassionate care, not just for Mangalore, but for all who seek our services.''',
                paragraphFontSize),
          ],
        ),
      ),
    );
  }

  // Reusable Paragraph Builder
  Widget _buildParagraph(String content, double fontSize) {
    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.grey[700], // Consistent color
        height: 1.6, // Line spacing
        // fontFamily: 'Roboto', // Optional: Specify font
        // fontWeight: FontWeight.w400, // Normal weight
      ),
      textAlign: TextAlign.justify,
    );
  }

  // Reusable Message Section Builder
  Widget _buildMessageSection({
    required BuildContext context,
    required bool mobile,
    required bool tablet,
    required bool desktop,
    required String imageUrl,
    required String title,
    required String name,
    required String message,
    required bool isImageLeft,
    required double titleSize,
    required double bodySize,
    required double sectionPadding,
  }) {
    double imageWidth = mobile ? 120 : (tablet ? 160 : 180);
    double imageHeight = mobile ? 180 : (tablet ? 240 : 270);
    double borderRadius = mobile ? 10 : 15;

    Widget imageWidget = Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) =>
              print('Error loading image: $imageUrl'), // Add error handling
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: mobile ? 4 : 6,
              offset: Offset(2, 2))
        ],
      ),
      // Optional: Add placeholder for loading or error
      child: Image.asset(imageUrl, fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
        return Container(
            color: Colors.grey[300],
            child: Center(
                child: Icon(Icons.person, size: 50, color: Colors.grey[600])));
      }),
    );

    Widget textWidget = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
        children: [
          Text(
            title, // Like "Message from the Chairman"
            style: TextStyle(
              fontSize: titleSize * 0.9, // Slightly smaller title
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[700],
              // letterSpacing: 1.1,
            ),
          ),
          Text(
            name, // Like "Dr. C P Abdulla Rahman"
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                    color: Colors.black12, blurRadius: 2, offset: Offset(1, 1)),
              ],
            ),
          ),
          SizedBox(height: mobile ? 8 : 12),
          Text(
            message,
            style: TextStyle(
              fontSize: bodySize,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );

    List<Widget> children = isImageLeft
        ? [imageWidget, SizedBox(width: mobile ? 15 : 20), textWidget]
        : [textWidget, SizedBox(width: mobile ? 15 : 20), imageWidget];

    if (mobile) {
      // Stack vertically on mobile
      children = [
        imageWidget,
        SizedBox(height: 15),
        // Need to wrap textWidget correctly if it was Expanded before
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  fontSize: titleSize * 0.9,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[700])),
          Text(name,
              style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(1, 1)),
                  ])),
          SizedBox(height: 8),
          Text(message,
              style: TextStyle(
                  fontSize: bodySize, color: Colors.grey[700], height: 1.6),
              textAlign: TextAlign.justify),
        ]),
      ];
      return Container(
        padding: EdgeInsets.all(mobile ? 12 : 16),
        margin: EdgeInsets.symmetric(horizontal: sectionPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white, // Use white or light grey
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: mobile ? 6 : 8.0,
              spreadRadius: mobile ? 1 : 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: children,
        ),
      );
    } else {
      // Use Row for tablet/desktop
      return Container(
        padding: EdgeInsets.all(tablet ? 18 : 24),
        margin: EdgeInsets.symmetric(horizontal: sectionPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[100], // Light background for contrast
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align items vertically center
          children: children,
        ),
      );
    }
  }

  // Contact Info Section
  Widget _buildContactInfoSection(
      BuildContext context,
      bool mobile,
      bool tablet,
      bool desktop,
      double iconSize,
      double titleSize,
      double descSize,
      double sectionPadding) {
    Widget locationCol = _buildContactColumnItem(
        mobile: mobile,
        icon: Icons.location_on,
        title: 'Location',
        description:
            'Mother Theresa Road,\nKankanady, Mangaluru,\nKarnataka 575002, India.',
        iconSize: iconSize,
        titleSize: titleSize,
        descriptionSize: descSize);
    Widget emergencyCol = _buildContactColumnItem(
        mobile: mobile,
        icon: Icons.phone,
        title: 'Emergency 24x7',
        description: '0824-4235555',
        iconSize: iconSize,
        titleSize: titleSize,
        descriptionSize: descSize);
    Widget emailCol = _buildContactColumnItem(
        mobile: mobile,
        icon: Icons.email,
        title: 'Email',
        description: 'reachus@highlandhospital.in',
        iconSize: iconSize,
        titleSize: titleSize,
        descriptionSize: descSize);

    return Container(
      width: double.infinity,
      color: Color(0xFF1FBCB1), // Background color
      padding: EdgeInsets.symmetric(
          vertical: sectionPadding * 1.5, horizontal: sectionPadding),
      child: mobile
          ? Column(
              // Stack vertically on mobile
              crossAxisAlignment: CrossAxisAlignment.start, // Align items left
              children: [
                locationCol,
                SizedBox(height: 20),
                emergencyCol,
                SizedBox(height: 20),
                emailCol,
              ],
            )
          : Row(
              // Row layout for tablet/desktop
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Space out columns
              crossAxisAlignment: CrossAxisAlignment.start, // Align tops
              children: [
                Expanded(child: locationCol),
                SizedBox(width: tablet ? 15 : 20), // Spacing
                Expanded(child: emergencyCol),
                SizedBox(width: tablet ? 15 : 20), // Spacing
                Expanded(child: emailCol),
              ],
            ),
    );
  }

  // Helper for individual Contact Info Column Item
  Widget _buildContactColumnItem(
      {required bool mobile,
      required IconData icon,
      required String title,
      required String description,
      required double iconSize,
      required double titleSize,
      required double descriptionSize}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          mobile ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color(0xFFEE9821), size: iconSize), // Accent color
        SizedBox(width: mobile ? 10 : 15),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // White text
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                    fontSize: descriptionSize,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.3), // White text
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Specialities & Contact Form Section (Adapted for About Page) ---
  Widget _buildSpecialitiesAndFormSectionAbout(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double headingSize,
      double bodyTextMedium,
      double buttonTextSize,
      double sectionPadding) {
    // Define the widgets for specialities and form (no change here)
    Widget specialities1 = _buildSpecialitiesListAbout(context,
        isMobile: isMobile,
        title: 'Specialities',
        specialties: [
          'General Medicine',
          'General Surgery',
          'Orthopaedic & Trauma Care',
          'Total Knee & Hip Replacement',
          'Arthroscopy & Sports Medicine',
          'Pediatric & Pediatric Surgery',
          'Nephrology',
          'Gastroenterology',
        ],
        headingSize: headingSize,
        bodyTextMedium: bodyTextMedium);

    Widget specialities2 = _buildSpecialitiesListAbout(context,
        isMobile: isMobile,
        title: '', // No title for the second list
        specialties: [
          'Ophthalmology',
          'E.N.T Micro Surgery',
          'Neurology and Neuro Surgery',
          'Plastic & Reconstructive Surgery',
          'Maxillofacial Surgery',
          'Microvascular Surgery',
          'Endocrinology',
          'Urology & Andrology',
        ],
        headingSize: headingSize,
        bodyTextMedium: bodyTextMedium);

    Widget contactForm = _buildContactUsFormAbout(
        context, isMobile, headingSize, bodyTextMedium, buttonTextSize);

    // Return the container with conditional layout logic
    return Container(
      color: Color(0xFFF5F5F5), // Slightly different background
      padding: EdgeInsets.all(sectionPadding),
      child: isMobile
          // --- Mobile Layout ---
          ? Column(
              // Main column for mobile: Holds the Row of specialities and the form below
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row for the two specialities lists
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align tops of lists
                  children: [
                    Expanded(
                      // Use Expanded to allow lists to share horizontal space
                      child: specialities1,
                    ),
                    SizedBox(width: 15), // Add spacing between the two lists
                    Expanded(
                      // Use Expanded for the second list as well
                      child: specialities2,
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        25), // Space between the specialities row and the contact form
                contactForm, // Place the contact form below the row
              ],
            )
          // --- Tablet/Desktop Layout ---
          : Row(
              // Keep the original Row layout for tablet/desktop
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: specialities1),
                SizedBox(width: 20),
                Expanded(flex: 2, child: specialities2),
                SizedBox(width: 30),
                Expanded(flex: 3, child: contactForm),
              ],
            ),
    );
  }

  // --- Helper for Specialities List (About Page) ---
  // No changes needed in _buildSpecialitiesListAbout itself, but ensure it uses
  // Flexible/Expanded internally if needed, though the structure you have
  // with Row(Icon, Flexible(Text)) is generally good.

  Widget _buildSpecialitiesListAbout(BuildContext context,
      {required bool isMobile,
      required String title,
      required List<String> specialties,
      required double headingSize,
      required double bodyTextMedium}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
                color: Color.fromARGB(255, 24, 14, 14), // Darker text
                fontSize: headingSize,
                fontWeight: FontWeight.bold),
          ),
        if (title.isNotEmpty) SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: specialties
              .map((spec) => Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0,
                              top: 5), // Adjust icon alignment if needed
                          child: Icon(Icons.circle,
                              size: 8,
                              color: Color(0xFF1BA08F)), // Theme color bullet
                        ),
                        Flexible(
                          // Crucial: Allows text to wrap within available space
                          child: Text(
                            spec,
                            style: TextStyle(
                                color: Color.fromARGB(
                                    255, 50, 50, 50), // Slightly lighter text
                                fontSize: bodyTextMedium,
                                height: 1.3), // Line height
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Widget _buildStaticDisclaimerAbout(BuildContext context, double textSize) {
  //   return RichText(
  //     textAlign: TextAlign.center, // Center the text block
  //     text: TextSpan(
  //       // Base style for the static text
  //       style: TextStyle(
  //           color: Colors.black54, fontSize: textSize * 0.95, height: 1.4),
  //       children: <TextSpan>[
  //         // Make "Disclaimer:" bold and slightly larger
  //         TextSpan(
  //             text: 'Disclaimer: ',
  //             style:
  //                 TextStyle(fontWeight: FontWeight.bold, fontSize: textSize)),
  //         // The main message
  //         const TextSpan(text: 'We do not charge for hiring!'),
  //       ],
  //     ),
  //   );
  // }

  // Helper for Contact Us Form (About Page) - Reuses validation logic
  // Widget _buildContactUsFormAbout(BuildContext context, bool isMobile,
  //     double headingSize, double bodyTextMedium, double buttonTextSize) {
  //   // Define controllers and key locally for this form instance
  //   final TextEditingController nameController = TextEditingController();
  //   final TextEditingController emailController = TextEditingController();
  //   final TextEditingController mobileController = TextEditingController();
  //   final TextEditingController messageController = TextEditingController();
  //   final formKey = GlobalKey<FormState>();

  //   // Dispose controllers when the state is disposed if they were state variables
  //   // If defined locally like here, they are garbage collected automatically.

  //   return Form(
  //     key: formKey, // Still using form key
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Contact us',
  //           style: TextStyle(
  //             color: const Color.fromARGB(255, 15, 12, 12),
  //             fontSize: headingSize,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 10),

  //         // --- Name Field ---
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 5),
  //           child: TextField(
  //             controller: nameController,
  //             decoration: const InputDecoration(
  //               labelText: 'Name:',
  //               fillColor: Colors.white,
  //               filled: true,
  //               border: OutlineInputBorder(),
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //             ),
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),

  //         // --- Email Field ---
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 5),
  //           child: TextField(
  //             controller: emailController,
  //             keyboardType: TextInputType.emailAddress,
  //             decoration: const InputDecoration(
  //               labelText: 'Email:',
  //               fillColor: Colors.white,
  //               filled: true,
  //               border: OutlineInputBorder(),
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //             ),
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),

  //         // --- Mobile Number Field ---
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 5),
  //           child: TextField(
  //             controller: mobileController,
  //             keyboardType: TextInputType.phone,
  //             decoration: const InputDecoration(
  //               labelText: 'Mobile Number:',
  //               fillColor: Colors.white,
  //               filled: true,
  //               border: OutlineInputBorder(),
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //             ),
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),

  //         // --- Message Field ---
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 5),
  //           child: TextField(
  //             controller: messageController,
  //             maxLines: isMobile ? 3 : 4,
  //             decoration: const InputDecoration(
  //               labelText: 'Message:',
  //               fillColor: Colors.white,
  //               filled: true,
  //               border: OutlineInputBorder(),
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //             ),
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),

  //         const SizedBox(height: 10),

  //         // --- Submit Button ---
  //         Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 10),
  //             child: Center(
  //               child: SizedBox(
  //                 width: isMobile ? double.infinity : 240, // Responsive width
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     // Validation logic
  //                     bool hasError = false;
  //                     String errorMessage = 'Please fill all required fields.';

  //                     final emailValid =
  //                         RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
  //                             .hasMatch(emailController.text);
  //                     final phoneValid = RegExp(r'^[0-9]{10}$')
  //                         .hasMatch(mobileController.text);

  //                     if (nameController.text.isEmpty ||
  //                         emailController.text.isEmpty ||
  //                         mobileController.text.isEmpty ||
  //                         messageController.text.isEmpty) {
  //                       hasError = true;
  //                     } else if (!emailValid || !phoneValid) {
  //                       hasError = true;
  //                       errorMessage = 'Please check email/phone format.';
  //                     }

  //                     if (hasError) {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text(errorMessage),
  //                           backgroundColor: Colors.red,
  //                         ),
  //                       );
  //                       return;
  //                     }

  //                     // On success
  //                     print("Form Submitted (Styled Version):");
  //                     print(
  //                         "Name: ${nameController.text}, Email: ${emailController.text}, Mobile: ${mobileController.text}, Message: ${messageController.text}");

  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       const SnackBar(
  //                         content: Text('Message Submitted!'),
  //                         backgroundColor: Colors.green,
  //                       ),
  //                     );

  //                     // Clear fields
  //                     nameController.clear();
  //                     emailController.clear();
  //                     mobileController.clear();
  //                     messageController.clear();
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: const Color(0xFFE7A20E),
  //                     foregroundColor: Colors.white,
  //                     padding:
  //                         EdgeInsets.symmetric(vertical: isMobile ? 12 : 15),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
  //                     ),
  //                     textStyle: TextStyle(
  //                       fontSize: buttonTextSize,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   child: const Text('Submit'),
  //                 ),
  //               ),
  //             ))
  //       ],
  //     ),
  //   );
  // }
  Widget _buildContactUsFormAbout(
    BuildContext context,
    bool isMobile,
    double headingSize,
    double bodyTextMedium,
    double buttonTextSize,
  ) {
    // Define controllers and form key locally
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => ContactInquiryController(),
      child: Consumer<ContactInquiryController>(
        builder: (context, controller, _) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟣 Heading
                Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: headingSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // 🟢 Name Field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name:',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                ),

                // 🟢 Email Field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email:',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please enter email';
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(v)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                // 🟢 Mobile Number Field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // allow only digits
                      LengthLimitingTextInputFormatter(
                          10), // limit to 10 digits
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number:',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      final phoneRegex = RegExp(r'^[0-9]{10}$');
                      if (!phoneRegex.hasMatch(v)) {
                        return 'Enter valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ),
                // 🟢 Message Field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: messageController,
                    maxLines: isMobile ? 3 : 4,
                    decoration: const InputDecoration(
                      labelText: 'Message:',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Please enter a message'
                        : null,
                  ),
                ),

                const SizedBox(height: 10),

                // 🟠 Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: SizedBox(
                      width: isMobile ? double.infinity : 240,
                      child: ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;

                                final inquiry = ContactInquiry(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: mobileController.text,
                                  message: messageController.text,
                                );

                                final success = await controller
                                    .submitContactInquiry(inquiry);

                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(controller.successMessage ??
                                          'Sent successfully!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  nameController.clear();
                                  emailController.clear();
                                  mobileController.clear();
                                  messageController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(controller.errorMessage ??
                                          'Something went wrong'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE7A20E),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 12 : 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(isMobile ? 8 : 10),
                          ),
                          textStyle: TextStyle(
                            fontSize: buttonTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Submit'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper for Contact Form Text Field (About Page Styling)
  Widget _buildContactTextFieldAbout(
      {required TextEditingController controller,
      required String label,
      required bool isMobile,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      required double inputFontSize,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(fontSize: inputFontSize, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: inputFontSize, color: Colors.grey[700]),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Color(0xFF1BA08F), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 15, vertical: maxLines > 1 ? 15 : 10),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
    );
  }

  // --- Disclaimer Marquee ---
  Widget _buildDisclaimerMarqueeAbout(BuildContext context, bool isDesktop,
      bool isTablet, bool isMobile, double textSize) {
    // Marquee is hidden on mobile via the main build method check
    return ClipRect(
      child: SlideTransition(
        position: _scrollAnimation,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Disclaimer: ',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                'We do not charge for hiring!', // Shortened message
                style:
                    TextStyle(color: Colors.black54, fontSize: textSize * 0.95),
              ),
              SizedBox(width: 50), // Spacing
            ],
          ),
        ),
      ),
    );
  }

  // --- Footer ---
  Widget _buildFooterAbout(BuildContext context, bool isDesktop, bool isTablet,
      bool isMobile, double footerTextSize) {
    return Container(
      width: double.infinity,
      color: Color(0xFF1BA08D), // Theme color
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 10 : 15, horizontal: isMobile ? 15 : 30),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '© Highland Hospitals. All Rights Reserved',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: footerTextSize,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: footerTextSize * 0.9),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '© Highland Hospitals. All Rights Reserved',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: footerTextSize,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: Text(
                    'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: footerTextSize),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
