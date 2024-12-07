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
    // Handle navigation or any other logic here
    print('Tapped: $menuItem');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Calculate padding based on screen width and height
    double horizontalPadding = screenWidth * 0.05; // 5% of screen width
    double verticalPadding = screenHeight * 0.02;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, // This centers the title
          title: Text(
            'Highland Hospital',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          backgroundColor: Color(0xFF3FAE9E), // Customize the app bar color
          elevation: 6, // Slightly elevated for a more modern look
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Social Media Section (Email & Social Icons)

              // Row(
              //   children: [
              //     // Email Section
              //     Row(
              //       children: [
              //         // Email Icon
              //         Icon(
              //           Icons.mail,
              //           color: const Color.fromARGB(255, 90, 78, 78),
              //           size: 24, // Adjust size if needed
              //         ),
              //         SizedBox(width: 10), // Space between icon and text
              //         // Email Text
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'reachus@highlandhospital.in',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 16, // Adjust the font size as needed
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),

              //     // Spacer to push content to the right side
              //     Expanded(child: SizedBox()),

              //     // Social Media Icons Section (on the right side)
              //     Padding(
              //       padding: const EdgeInsets.only(right: 120),
              //       child: Row(
              //         children: [
              //           // Image 1
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Image.asset(
              //               'assets/img/twitter.png', // Update with your actual image path
              //               width: 24,
              //               height: 20,
              //             ),
              //           ),
              //           // Image 2
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Image.asset(
              //               'assets/img/facebook.png', // Update with your actual image path
              //               width: 24,
              //               height: 20,
              //             ),
              //           ),
              //           // Image 3
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Image.asset(
              //               'assets/img/instagram.png', // Update with your actual image path
              //               width: 24,
              //               height: 20,
              //             ),
              //           ),
              //           // Image 4
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Image.asset(
              //               'assets/img/youtube.png', // Update with your actual image path
              //               width: 24,
              //               height: 20,
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(height: 20), // Space between social media and divider

              // Divider line

              // Menu Items Row (Horizontal Scrolling)
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
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                menuItems[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 1, 5, 10),
                                ),
                              ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              // Paragraphs

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: screenWidth,
                height: 2,
                decoration: BoxDecoration(
                  color: Color(0xFFEE9B27), // Color of the border
                ),
              ),
// Paragraphs
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Add some padding to the left and right
                child: _buildParagraph(
                  content:
                      '''Founded by Dr. C P Abdulla Rahman and Mrs. Y Razia Rahman, Highland Hospital in Mangalore has been a cornerstone of healthcare excellence for over three decades. Built on the ethos of “YOUR HEALTH, OUR CARE,” the hospital embodies a commitment to delivering compassionate and accessible healthcare services to all. From its humble beginnings, Highland has grown into a trusted healthcare provider, blending cutting-edge medical technology with personalized care that puts patients at the center of everything we do.''',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Add some padding to the left and right
                child: _buildParagraph(
                  content:
                      '''Our multidisciplinary team of healthcare professionals, driven by a shared mission of improving lives, provides world-class treatment across a wide range of medical specialties. Whether it’s preventive care, advanced surgeries, or rehabilitation services, Highland Hospital is dedicated to ensuring that every patient receives the highest standard of care in a comfortable and supportive environment.''',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Add some padding to the left and right
                child: _buildParagraph(
                  content:
                      '''Our journey doesn’t stop at medical care. Highland Hospital has been deeply involved in philanthropic initiatives that ensure healthcare is accessible to underserved communities, making a positive impact on countless lives. These initiatives, inspired by the founders’ vision, continue to grow under the leadership of Dr. C P Abdulla Yasser, ensuring that our commitment to community welfare remains unwavering.''',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Add some padding to the left and right
                child: _buildParagraph(
                  content:
                      '''Today, Highland Hospital stands as a beacon of trust and innovation, recognized for its contributions to healthcare and its role in uplifting the community. As we look to the future, we are continually evolving, driven by a passion for excellence, empathy, and integrity. Through every service and every interaction, we strive to create a healthcare ecosystem that not only treats illness but fosters long-term health and well-being. Our dedication to “YOUR HEALTH, OUR CARE” ensures that Highland Hospital remains a sanctuary for healing, hope, and compassionate care, not just for Mangalore, but for all who seek our services.''',
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    // You can add more content here if needed
                  ],
                ),
              ),
              SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First container with image on the left and custom size
                        _buildImageTextContainer(
                          imageUrl: 'assets/img/Dr.c.p.abdul rahman.jpg',
                          text1:
                              'Message from the Chairman, Dr. C P Abdulla Rahman',
                          text2:
                              '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ embodies our commitment to creating a compassionate, inclusive healthcare environment for everyone who walks through our doors. Founded with a vision to deliver high-quality, accessible care, we have dedicated over 30 years to meeting the evolving needs of our community. Every patient experience is shaped by our guiding values of integrity, respect, and empathy, upheld by a skilled team who share our dedication to healing and hope. It is a privilege to serve Mangalore and beyond, and we remain deeply committed to enhancing the health and wellness of our community with every step forward. Highland Hospital is more than a healthcare institution; it is a legacy of care, compassion, and unwavering dedication to the well-being of each patient who entrusts us with their health.”''',
                          isImageLeft: true,
                          width: MediaQuery.of(context).size.width *
                              0.95, // 90% of the screen width
                          height: MediaQuery.of(context).size.height *
                              0.7, // 30% of the screen height
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding,
                          ), // Dynamic padding
                          margin: EdgeInsets.symmetric(
                              vertical: 15.0), // Custom margin
                        ),
                        SizedBox(height: 30),

                        // Second container with image on the right and custom size
                        Align(
                          alignment: Alignment
                              .centerRight, // Align to the right side of the screen
                          child: _buildImageTextContainer(
                            imageUrl: 'assets/img/Dr.c.p.abdulla yasser.jpg',
                            text1:
                                'Message from the Managing Director, Dr. C P Abdulla Yasser',
                            text2:
                                '''“As Managing Director of Highland Hospital, I am honored to carry forward the legacy that ‘YOUR HEALTH, OUR CARE’ represents. Each day, we work tirelessly to blend innovative medical practices with a human touch, recognizing that healthcare is not solely about treatments—it is about trust, dignity, and partnership. Our commitment to excellence is driven by a dedication to improve not only outcomes but also patient experiences. Highland Hospital is a place where cutting-edge technology meets compassion, and where our values of empathy, integrity, and quality drive everything we do. We envision a healthcare environment where every individual, regardless of circumstance, can feel safe, cared for, and respected. With a relentless focus on this mission, we continue to build on our legacy to serve our patients and community with unmatched dedication.”''',
                            isImageLeft:
                                false, // Image will be on the right side
                            width: MediaQuery.of(context).size.width *
                                0.95, // 90% of the screen width
                            height: MediaQuery.of(context).size.height *
                                0.7, // 30% of the screen height
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: verticalPadding,
                            ), // Dynamic padding
                            margin: EdgeInsets.symmetric(
                                vertical: 20.0), // Custom margin
                          ),
                        ),
                        SizedBox(height: 30),

                        // Third container with image on the left and custom size using MediaQuery
                        _buildImageTextContainer(
                          imageUrl: 'assets/img/Mr.Mohammed yoonus.jpg',
                          text1: 'Message from the CEO, Mr. Mohammed Yoonus',
                          text2:
                              '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ reflects our relentless pursuit of operational excellence and our dedication to patient-centered care. As CEO, I believe that every facet of our hospital’s operations should serve to elevate the patient experience, making healthcare efficient, compassionate, and accessible to all. Our team is focused on implementing advanced technologies and evidence-based practices, while continually striving to maintain the warmth and respect our patients deserve. We invest in both our people and our resources to uphold Highland Hospital’s reputation as a trusted healthcare provider. By nurturing an environment of support and collaboration, we aim to transform healthcare delivery, ensuring each patient experiences a seamless, caring journey toward better health. This is the Highland promise, a commitment to quality, respect, and an unwavering focus on the well-being of our patients and community.”''',
                          isImageLeft: true,
                          width: MediaQuery.of(context).size.width *
                              0.95, // 90% of the screen width
                          height: MediaQuery.of(context).size.height *
                              0.7, // 30% of the screen height
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding,
                          ), // Dynamic padding
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0), // Custom margin
                        ),

                        SizedBox(height: 30),

                        // Below part with health tips, news, and visiting hours

                        Stack(children: [
                          // Main large container at the bottom
                          Container(
                            width: double.infinity,
                            height:
                                200, // Fixed height but can adjust based on design needs
                            color: Color(0xFF1FBCB1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Distribute space evenly across the row
                            children: [
                              // First Column: Location
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 80,
                                    bottom:
                                        90), // Adjust padding for balanced spacing
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
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                              'Highland Hospitals, Mangaluru, Karnataka 575002, India.',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Second Column: Emergency 24x7
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:
                                        10), // Adjust padding for balanced spacing
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
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Third Column: Email
                              Padding(
                                padding: const EdgeInsets.only(
                                    right:
                                        10), // Adjust padding for balanced spacing
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
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              // Main large container at the bottom
                              Padding(
                                padding: const EdgeInsets.only(top: 190),
                                child: Container(
                                    width: double.infinity,
                                    height:
                                        500, // Fixed height but can adjust based on design needs
                                    color: Color(0xFFEAEBED)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                  top: 200,
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
                                              color: const Color.fromARGB(
                                                  255, 24, 14, 14),
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
                                              color: const Color.fromARGB(
                                                  255, 24, 21, 21),
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
                                              color: const Color.fromARGB(
                                                  255, 19, 18, 18),
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Contact us Title
                                          Text(
                                            'Contact us',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 15, 12, 12),
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
                      ]))
            ])));
  }

  Widget _buildImageTextContainer({
    required String imageUrl,
    required String text1,
    required String text2,
    bool isImageLeft = true,
    double width = double.infinity,
    double height = 500.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20.0),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 15.0),
  }) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade200, Colors.blue.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isImageLeft) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imageUrl,
                width: 380,
                height: 620,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.teal[900],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    text2,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black87,
                      height: 1.8,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.teal[900],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    text2,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black87,
                      height: 1.8,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imageUrl,
                width: 380,
                height: 620,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    ); // Image and Text Containers
  }

  // Helper function to create beautifully styled paragraphs with spacing and formatting
  Widget _buildParagraph({required String content}) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 24.0), // Increased padding for better spacing
      child: Text(
        content,
        style: TextStyle(
          fontSize: 22.0, // Slightly smaller for better readability
          color: Colors.black87,
          height: 1.7, // Adjusted line height for easier reading
          fontFamily: 'Roboto', // Clean and modern font
        ),
        textAlign: TextAlign.justify, // Justified for a cleaner look
      ),
    );
  }

  // Helper function to create Image and Text containers side by side
}
