import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final List<String> menuItems = [
    'Home',
    'About',
    'Services',
    'Departments',
    'Careers',
    'News',
    'Feedback',
    'Nursing',
    'International - Patient',
    'CONTACT',
  ];

  // Method to handle menu item tap
  void onMenuItemTapped(String menuItem) {
    print('Tapped: $menuItem');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Highland Hospital',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF3FAE9E),
          elevation: 12, // Added more elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Menu Navigation with Better Design
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(menuItems.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () => onMenuItemTapped(menuItems[index]),
                        child: menuItems[index] == 'CONTACT'
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEE9821),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: Text(
                                  menuItems[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            : Text(
                                menuItems[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 5, 10)),
                              ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),

              // Divider
              Divider(
                thickness: 2,
                color: Color(0xFFEE9B27),
              ),
              SizedBox(height: 20),

              // Single Card containing all the paragraphs
              Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Paragraph 1
                      Text(
                        '''Founded by Dr. C P Abdulla Rahman and Mrs. Y Razia Rahman, Highland Hospital in Mangalore has been a cornerstone of healthcare excellence for over three decades. Built on the ethos of “YOUR HEALTH, OUR CARE,” the hospital embodies a commitment to delivering compassionate and accessible healthcare services to all. From its humble beginnings, Highland has grown into a trusted healthcare provider, blending cutting-edge medical technology with personalized care that puts patients at the center of everything we do.''',
                        style: TextStyle(
                            fontSize: 24, color: Colors.grey[700], height: 1.6),
                      ),
                      SizedBox(height: 16), // Space between paragraphs

                      // Paragraph 2
                      Text(
                        '''Our multidisciplinary team of healthcare professionals, driven by a shared mission of improving lives, provides world-class treatment across a wide range of medical specialties. Whether it’s preventive care, advanced surgeries, or rehabilitation services, Highland Hospital is dedicated to ensuring that every patient receives the highest standard of care in a comfortable and supportive environment.''',
                        style: TextStyle(
                            fontSize: 24, color: Colors.grey[700], height: 1.6),
                      ),
                      SizedBox(height: 16), // Space between paragraphs

                      // Paragraph 3
                      Text(
                        '''Our journey doesn’t stop at medical care. Highland Hospital has been deeply involved in philanthropic initiatives that ensure healthcare is accessible to underserved communities, making a positive impact on countless lives. These initiatives, inspired by the founders’ vision, continue to grow under the leadership of Dr. C P Abdulla Yasser, ensuring that our commitment to community welfare remains unwavering.''',
                        style: TextStyle(
                            fontSize: 24, color: Colors.grey[700], height: 1.6),
                      ),
                      SizedBox(height: 16), // Space between paragraphs

                      // Paragraph 4
                      Text(
                        '''Today, Highland Hospital stands as a beacon of trust and innovation, recognized for its contributions to healthcare and its role in uplifting the community. As we look to the future, we are continually evolving, driven by a passion for excellence, empathy, and integrity. Through every service and every interaction, we strive to create a healthcare ecosystem that not only treats illness but fosters long-term health and well-being. Our dedication to “YOUR HEALTH, OUR CARE” ensures that Highland Hospital remains a sanctuary for healing, hope, and compassionate care, not just for Mangalore, but for all who seek our services.''',
                        style: TextStyle(
                            fontSize: 24, color: Colors.grey[700], height: 1.6),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

// Chairman Message with Image Section
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[
                            100], // Light background color for the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(children: [
                        // Image Section with Color Overlay and Shadow
                        Container(
                          width: 180,
                          height: 270,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/Dr.c.p.abdul rahman.jpg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 6)
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        // Title and Content Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title with a gradient text color effect
                              Text(
                                "Message from the Chairman, Dr. C P Abdulla Rahman",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800],
                                  letterSpacing: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(1.5, 1.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              // Content Section with background color variation
                              Text(
                                '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ embodies our commitment to creating a compassionate, inclusive healthcare environment for everyone who walks through our doors. Founded with a vision to deliver high-quality, accessible care, we have dedicated over 30 years to meeting the evolving needs of our community. Every patient experience is shaped by our guiding values of integrity, respect, and empathy, upheld by a skilled team who share our dedication to healing and hope. It is a privilege to serve Mangalore and beyond, and we remain deeply committed to enhancing the health and wellness of our community with every step forward. Highland Hospital is more than a healthcare institution; it is a legacy of care, compassion, and unwavering dedication to the well-being of each patient who entrusts us with their health."''',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),

                  // Third container with image on the left and custom size using MediaQuery

                  width: MediaQuery.of(context).size.width, // Full screen width
                  child: Row(
                    children: [
                      // Title and Content Section
                      SizedBox(width: 20),
                      // Title and Content Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment
                                  .centerRight, // Align text to the right
                              child: Text(
                                "Message from the Managing Director, Dr. C P Abdulla Yasser",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800],
                                  letterSpacing: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(1.5, 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            // Content Section with background color variation
                            Text(
                              '''“As Managing Director of Highland Hospital, I am honored to carry forward the legacy that ‘YOUR HEALTH, OUR CARE’ represents. Each day, we work tirelessly to blend innovative medical practices with a human touch, recognizing that healthcare is not solely about treatments—it is about trust, dignity, and partnership. Our commitment to excellence is driven by a dedication to improve not only outcomes but also patient experiences. Highland Hospital is a place where cutting-edge technology meets compassion, and where our values of empathy, integrity, and quality drive everything we do. We envision a healthcare environment where every individual, regardless of circumstance, can feel safe, cared for, and respected. With a relentless focus on this mission, we continue to build on our legacy to serve our patients and community with unmatched dedication.”''',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 270,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/Dr.c.p.abdulla yasser.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 6)
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 16), // Spacing between text and image
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Image Section with Shadow
                      Container(
                        width: 180,
                        height: 270,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/img/Mr.Mohammed yoonus.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 6)
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      // Title and Content Section
                      SizedBox(width: 20),
                      // Title and Content Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with a gradient text color effect
                            Text(
                              "Message from the CEO, Mr. Mohammed Yoonus",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                                letterSpacing: 1.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(1.5, 1.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            // Content Section with background color variation
                            Text(
                              '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ reflects our relentless pursuit of operational excellence and our dedication to patient-centered care. As CEO, I believe that every facet of our hospital’s operations should serve to elevate the patient experience, making healthcare efficient, compassionate, and accessible to all. Our team is focused on implementing advanced technologies and evidence-based practices, while continually striving to maintain the warmth and respect our patients deserve. We invest in both our people and our resources to uphold Highland Hospital’s reputation as a trusted healthcare provider. By nurturing an environment of support and collaboration, we aim to transform healthcare delivery, ensuring each patient experiences a seamless, caring journey toward better health. This is the Highland promise, a commitment to quality, respect, and an unwavering focus on the well-being of our patients and community.”''',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

// Below part with health tips, news, and visiting hours
              SizedBox(height: 30),

// Below part with health tips, news, and visiting hours
              Stack(children: [
                // Main large container at the bottom
                Container(
                  width: double.infinity,
                  height:
                      330, // Fixed height but can adjust based on design needs
                  color: const Color(0xFF1FBCB1),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Distribute space evenly
                  children: [
                    // First Column: Location
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align items to the start
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/Location.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '''“ Mother Theresa Road,
  Kankanady, Highland Hospitals,
  Mangaluru, Karnataka 575002, 
  India."''',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Second Column: Emergency 24x7
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align items to the start
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/Call.png',
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Emergency 24x7',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '0824-4235555',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Third Column: Email
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align items to the start
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/E-mail.png', // Replace with your actual image path
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'reachus@highlandhospital.in', // Replace with your email
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    // Main large container at the bottom
                    Padding(
                      padding: const EdgeInsets.only(top: 220),
                      child: Container(
                          width: double.infinity,
                          height:
                              500, // Fixed height but can adjust based on design needs
                          color: Color(0xFFEAEBED)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        top: 230,
                      ), // Use uniform padding for better spacing
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Distribute space evenly between the columns
                        children: [
                          // First Column of Specialities (left side)
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align to the left side
                              children: [
                                Text(
                                  'Specialities',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 24, 14, 14),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '''General Medicine
General Surgery
Orthopaedic & Trauma Care
Total Knee & Hip Replacement
Arthroscopy & Sports Medicine
Pediatric & Pediatric Surgery
Nephrology
Gastroenterology''',
                                  textAlign: TextAlign
                                      .left, // Align the text to the left for better readability
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 24, 21, 21),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Second Column of Specialities (right side)
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align to the left side
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '''Ophthalmology
E.N.T Micro Surgery
Neurology and Neuro Surgery
Plastic & Reconstructive Surgery
Maxillofacial Surgery
Microvascular Surgery
Endocrinology
Urology & Andrology''',
                                  textAlign: TextAlign
                                      .left, // Align the text to the left for better readability
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 19, 18, 18),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Contact us Title
                                Text(
                                  'Contact us',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 15, 12, 12),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Name input field
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Name:',
                                      fillColor: Colors
                                          .white, // Set background color of the input box to white
                                      filled:
                                          true, // Enable background color filling
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Set the text color inside the input box to black
                                  ),
                                ),

// Email input field
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Email:',
                                      fillColor: Colors
                                          .white, // Set background color of the input box to white
                                      filled:
                                          true, // Enable background color filling
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Set the text color inside the input box to black
                                  ),
                                ),

// Mobile Number input field
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Mobile Number:',
                                      fillColor: Colors
                                          .white, // Set background color of the input box to white
                                      filled:
                                          true, // Enable background color filling
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Set the text color inside the input box to black
                                  ),
                                ),

// Message input field
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: TextField(
                                    maxLines:
                                        4, // To make it a multiline input box for messages
                                    decoration: InputDecoration(
                                      labelText: 'Message:',
                                      fillColor: Colors
                                          .white, // Set background color of the input box to white
                                      filled:
                                          true, // Enable background color filling
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Set the text color inside the input box to black
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        // Main large container at the bottom
                        Padding(
                          padding: const EdgeInsets.only(top: 600),
                          child: Container(
                            width: double.infinity,
                            height:
                                50, // Fixed height but can adjust based on design needs
                            color: Color(0xFF1BA08D),
                            child: Center(
                              // This centers the text inside the container
                              child: Text(
                                ' © Highland Hospitals.All Rights Reserved', // Replace with the desired text
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ])));
  }

  // Widget _buildImageTextContainer({
  //   required String imageUrl,
  //   required String text1,
  //   required String text2,
  //   bool isImageLeft = true,
  //   double width = double.infinity,
  //   double height = 800.0,
  //   EdgeInsetsGeometry padding = const EdgeInsets.all(20.0),
  //   EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 15.0),
  // }) {
  //   final mediaQuery = MediaQuery.of(context);
  //   final screenWidth = mediaQuery.size.width;
  //   final screenHeight = mediaQuery.size.height;

  //   // Responsive width and height for the container
  //   double containerWidth =
  //       width == double.infinity ? screenWidth * 0.85 : width;
  //   double containerHeight = height == 800.0 ? screenHeight * 0.6 : height;

  //   // Responsive padding
  //   double horizontalPadding = screenWidth * 0.05;
  //   double verticalPadding = screenHeight * 0.09;
  //   EdgeInsets responsivePadding = EdgeInsets.symmetric(
  //     horizontal: horizontalPadding,
  //     vertical: verticalPadding,
  //   );

  //   // Calculate a scaling factor for text size
  //   double scaleFactor = screenWidth / 375; // Assume 375 as a base screen width

  //   // Responsive text sizes
  //   double text1Size = 24.0 * scaleFactor; // Scale title text size
  //   double text2Size = 20.0 * scaleFactor; // Scale description text size

  //   // Increase image size
  //   double imageWidth = screenWidth * 0.45; // 45% of screen width
  //   double imageHeight = screenHeight * 0.5; // 50% of screen height

  //   return Container(
  //     padding: responsivePadding,
  //     margin: margin,
  //     height: containerHeight,
  //     width: containerWidth,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Colors.teal.shade200, Colors.blue.shade300],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(20.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2),
  //           blurRadius: 10.0,
  //           offset: Offset(0, 6),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         if (isImageLeft) ...[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(12.0),
  //             child: Image.asset(
  //               imageUrl,
  //               width: imageWidth, // Increased image width
  //               height: imageHeight, // Increased image height
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           SizedBox(width: 20),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   text1,
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: Colors.teal[900],
  //                     fontWeight: FontWeight.bold,
  //                     decoration: TextDecoration.underline,
  //                     letterSpacing: 1.0,
  //                   ),
  //                 ),
  //                 SizedBox(height: 10.0),
  //                 Text(
  //                   text2,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.black87,
  //                     height: 1.8,
  //                     fontFamily: 'Roboto',
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                   textAlign: TextAlign.justify,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ] else ...[
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   text1,
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: Colors.teal[900],
  //                     fontWeight: FontWeight.bold,
  //                     decoration: TextDecoration.underline,
  //                     letterSpacing: 1.0,
  //                   ),
  //                 ),
  //                 SizedBox(height: 10.0),
  //                 Text(
  //                   text2,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.black87,
  //                     height: 1.8,
  //                     fontFamily: 'Roboto',
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                   textAlign: TextAlign.justify,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(width: 20),
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(12.0),
  //             child: Image.asset(
  //               imageUrl,
  //               width: imageWidth, // Increased image width
  //               height: imageHeight, // Increased image height
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  // Helper function to create responsive paragraphs with adjusted text size
  Widget _buildParagraph({required String content}) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Responsive font size based on screen width
    double textSize;
    if (screenWidth < 400) {
      textSize = 16.0; // Smaller font size for smaller screens
    } else if (screenWidth < 800) {
      textSize = 19.0; // Medium font size for medium screens
    } else {
      textSize = 23.0; // Larger font size for larger screens
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: textSize,
          color: Colors.black87,
          height: 1.7,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
