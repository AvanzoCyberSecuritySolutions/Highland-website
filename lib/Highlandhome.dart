import 'package:flutter/material.dart';
import 'package:flutter_highland/About.dart';
import 'package:flutter_highland/constants/color_constant.dart';
//import 'package:flutter_highland/constants/image_constant.dart';

class Highlandhome extends StatefulWidget {
  @override
  _HighlandhomeState createState() => _HighlandhomeState();
}

class _HighlandhomeState extends State<Highlandhome> {
  // List of navigation items
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
    if (menuItem == 'About') {
      // Navigate to AboutPage when "About" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => About()),
      );
    }
    // Add more conditions to handle other menu items if needed
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                  left: 100), // Reduced padding to allow space for icon
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // This ensures left and right are spaced apart
                children: [
                  // Left side: Email Icon and Text
                  Row(
                    children: [
                      // Email Icon
                      Icon(
                        Icons.mail,
                        color: const Color.fromARGB(255, 90, 78, 78),
                        size: 24, // Adjust size if needed
                      ),
                      SizedBox(width: 10), // Space between icon and text
                      // Email Text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'reachus@highlandhospital.in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16, // Adjust the font size as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Right side: Images
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Row(
                      children: [
                        // Image 1
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            'assets/img/twitter.png', // Update with your actual image path
                            width: 24,
                            height: 20,
                          ),
                        ),
                        // Image 2
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            'assets/img/facebook.png', // Update with your actual image path
                            width: 24,
                            height: 20,
                          ),
                        ),
                        // Image 3
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            'assets/img/instagram.png', // Update with your actual image path
                            width: 24,
                            height: 20,
                          ),
                        ),
                        // Image 4
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            'assets/img/youtube.png', // Update with your actual image path
                            width: 24,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xFFFFFFFF)),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20), // Space above the border
            width:
                screenWidth, // Dynamic width to adapt to different screen sizes
            height: 2, // Height of the border
            decoration: BoxDecoration(
              color: Color(0xFFEE9B27), // Color of the border
            ),
          ),
          // Menu items row at the top
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

// Stack containing background image, logo, and text
          Stack(
            children: [
              // Background Image
              Image.asset(
                'assets/img/bg.jpeg', // Update to actual path
                height: screenHeight *
                    0.9, // Adjusted height for the background image
                width: screenWidth,
                fit: BoxFit.cover,
              ),
              // Logo Positioned
              Positioned(
                top: screenHeight *
                    0.25, // Adjust the logo position to avoid overlap with text
                left: screenWidth * 0.110, // Center the logo horizontally
                child: Image.asset(
                  'assets/img/Logo1234.png', // Update to actual logo path
                  height: screenHeight *
                      0.25, // Adjust the height based on screen size
                  width: screenWidth *
                      0.4, // Adjust the width based on screen size
                  fit: BoxFit
                      .cover, // Ensures the image fits within the defined box
                ),
              ),
              // Text under the logo
              Positioned(
                top: screenHeight *
                    0.52, // Adjust the position for spacing from logo
                left: screenWidth * 0.1,
                right: screenWidth * 0.40,
                child: Text(
                  '''At Highland Hospital, it's not 
 just healthcare but care for your health''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                        255, 15, 2, 2), // Set white for visibility
                  ),
                ),
              ),
              // Button for "Our Specialties"
              Positioned(
                top: screenHeight * 0.65, // Adjust position for proper spacing
                left: screenWidth *
                    0.25, // Move the button a little more to the right
                right: screenWidth *
                    0.55, // You can keep the right margin the same for consistent spacing
                child: Container(
                  width: 80.0, // Reduced width of the button
                  height: 50, // Fixed height for the button
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF7CB3AC),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Center(
                    child: Text(
                      'Our Specialties',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)
                          // Ensure text is visible on the button
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // "Welcome to Highland Hospital" Text Section
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Welcome to Highland Hospital",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 24, 5, 5)),
              textAlign: TextAlign.center,
            ),
          ),

          // "Established in 1995" Text Section
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              "Established in 1995",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color(0xFF6CC1B6),
              ),
              textAlign: TextAlign.center, // Align text to the center
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10), // Space above the border
            width: 230, // Width of the border
            height: 2, // Height of the border
            decoration:
                BoxDecoration(color: Color(0xFFF1B056) // Color of the border
                    ),
          ),

          // Description of the Hospital and Services
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10, top: 40, left: 10, right: 10),
            child: Text(
              '''Our 250 bedded hospital brings you the best in multispecialty treatment with state-of-the-art 
technology focusing on various specialties including Critical Care, Cardiology, Cardiac 
Surgery, Orthopaedic & Joint Replacement, Neurology, Neuro-Surgery, Pulmonology, 
Gastroenterology, Diabetes and Endocrinology, Paediatrics, Gynaecology, Nephrology,
Urology, and many more. The focus of healthcare at Highland Hospital is the health and 
wellbeing of our patients, utilising the latest infrastructure and qualified medical expertise 
  available while at the same time ensuring affordability.''',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.normal,
                color: Color(0xFFADADAD),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),

          // "Know More" Button
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              height: 45.0, // Specify your desired height here
              width: screenWidth *
                  0.2, // Specify your desired width or use screenWidth * percentage
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: screenWidth * 0),
              decoration: BoxDecoration(
                color: Color(0xFF78CAC6),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Center(
                child: Text(
                  'Know more',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

// Carousel or feature containers with images
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20, // Set width for the left container
                  height: 300, // Set height for the left container
                  color: Color(0xFF1FBCB1), // Set background color
                ),
                Expanded(
                  child: carousalContainer(
                    image: 'assets/img/find a doctor.png',
                    label: 'FIND A DOCTOR',
                    content:
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed incididunt ut labore''',
                    backgroundColor: Color(0xFF1FBCB1), // Set unique color
                  ),
                ),
                Expanded(
                  child: carousalContainer(
                    image: 'assets/img/Test result.png',
                    label: 'TEST RESULT',
                    content:
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed incididunt ut labore''',
                    backgroundColor: Color(0xFFEE9821), // Set unique color
                  ),
                ),
                Expanded(
                  child: carousalContainer(
                      image: 'assets/img/online admission.png',
                      label: 'ONLINE ADMISSION',
                      content:
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed incididunt ut labore''',
                      backgroundColor: Color(0xFF1BA08D) // Set unique color
                      ),
                ),
                Expanded(
                  child: carousalContainer(
                      image: 'assets/img/Patient acces.png',
                      label: 'PATIENT ACCESS',
                      content:
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed incididunt ut labore''',
                      backgroundColor: Color(0xFF5592C8) // Set unique color
                      ),
                ),
                Container(
                    width: 20, // Set width for the right container
                    height: 300, // Set height for the right container
                    color: Color(0xFF5592C8) // Set background color
                    ),
              ],
            ),
          ),
          SizedBox(
              height:
                  5), // Reduced space between the carousel and vision/mission section

// Vision and Mission Image Section
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10), // Adjusted padding for both sides
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers the images horizontally
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns images to the top
              children: [
                // Vision Image
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5,
                      right: 1,
                      top: 100), // Adjusted padding for closer alignment
                  child: Container(
                    width: screenWidth *
                        0.45, // Adjusted width for Vision container
                    height: 350, // Set the height of the container
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 245, 149, 6), // Orange background color
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Clip the image with the same border radius
                      child: Image.asset(
                        'assets/img/vision.jpeg', // Your Vision image file path
                        width:
                            screenWidth * 0.7, // Adjust the width of the image
                        height: 280, // Adjust the height of the image
                        fit: BoxFit.cover, // Fit the image within the container
                      ),
                    ),
                  ),
                ),

                // Mission Image
                Padding(
                  padding: const EdgeInsets.only(
                      left: 80,
                      right: 5,
                      top: 100), // Adjust padding for spacing on the right
                  child: Container(
                    width: screenWidth *
                        0.45, // Adjusted width for Mission container
                    height: 350, // Set the height of the container
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 245, 149, 6), // Orange background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Clip the image with the same border radius
                      child: Image.asset(
                        'assets/img/Mission.JPG', // Your Mission image file path
                        width:
                            screenWidth * 0.7, // Adjust the width of the image
                        height: 280, // Adjust the height of the image
                        fit: BoxFit.cover, // Fit the image within the container
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height:
                  5), // Reduced the gap below the Vision and Mission section

          // Carousel or feature containers with images

          // Third Container with Multiple Overlays
          Column(children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Background container inside Stack
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 320, // Adjust bottom to make space
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 380,
                    color: Color(0xFF1FBCB1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Positioned "VISION" Container (left side)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 510,
                      ),
                      child: Container(
                        width: 500,
                        padding: EdgeInsets.all(19),
                        color: Color(0xFFFFFFFF),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'VISION',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 29, 23, 23),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '''To be a beacon of healthcare excellence, where “YOUR HEALTH, OUR CARE” is not just a tagline but a promise. We envision Highland Hospital as a leader in innovation and compassionate care, ensuring that every patient—regardless of their background—receives world-class, accessible healthcare. Through dedication to patient well-being, cutting-edge technology, and community welfare, we aim to shape a future where healthcare is a right, not a privilege.''',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 29, 23, 23),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Add a SizedBox to create a much larger space between the containers
                    SizedBox(
                        width:
                            150), // Significantly increased the width for more distance

                    // Positioned "MISSION" Container (right side)
                    Container(
                      width: 500,
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFFFFFFF),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'MISSION',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '''To provide advanced, patient-centered healthcare through our guiding principle of “YOUR HEALTH, OUR CARE.” We are dedicated to delivering the highest standards of care with empathy, integrity, and innovation. By investing in both our people and technology, we strive to improve the health and well-being of every individual we serve. We aim to create a supportive environment where every patient feels valued, ensuring accessible, high-quality healthcare that elevates lives and strengthens our community.''',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Doctor Image on the left side
                Padding(
                  padding: const EdgeInsets.only(right: 630, top: 290),
                  child: Image.asset(
                    'assets/img/doct.png',
                    width: 320,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),

                // "Book an Appointment" Container on the right side
                Padding(
                  padding: const EdgeInsets.only(top: 330, left: 320),
                  child: Container(
                    width: 700,
                    height: 340,
                    color: Colors.white,
                    child: Column(children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF1BA08F), // Background color
                          borderRadius: BorderRadius.circular(
                              2), // Rounded corners (half of height to make it circular)
                        ),
                        child: Center(
                          child: Text(
                            'Book an Appointment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFEE9821), width: 2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 300),
                                    child: Text(
                                      '''Enter your contacts below to schedule an appointment or
discuss it with us in details.''',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(children: [
                                  // Row for Name and State (left and right inside one input box)
                                  SizedBox(height: 10),
                                  Column(
                                    children: [
                                      // Row for Name and State (left and right labels inside one input box)
                                      Row(
                                        children: [
                                          // Name and State Input Field (left and right labels inside one container)
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 40,
                                              color: Color(0xFFF2F3F5),
                                              // Background color for the container
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  labelText:
                                                      null, // Remove the default labelText
                                                  border: InputBorder
                                                      .none, // Remove the border
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                  prefixIcon: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Text(
                                                          'Name:', // Left label text (Name)
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(), // Spacer to push the second label to the right side
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 270),
                                                        child: Text(
                                                          'State:', // Right label text (State)
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // Row for Email and Doctor (left and right inside one input box)
                                      Row(
                                        children: [
                                          // Email and Doctor Input Field (left and right labels inside one container)
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 40,
                                              color: Color(
                                                  0xFFF2F3F5), // Background color for the container
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  labelText:
                                                      null, // Remove the default labelText
                                                  border: InputBorder
                                                      .none, // Remove the border
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                  prefixIcon: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Text(
                                                          'Email:', // Left label text (Email)
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(), // Spacer to push the second label to the right side
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 270),
                                                        child: Text(
                                                          'Doctor:', // Right label text (Doctor)
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // Row for Phone Number Input (single label inside one input box)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              color: Color(
                                                  0xFFF2F3F5), // Background color for the container
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 525),
                                                  child: Text(
                                                    'Phone Number:', // Display the text as plain text
                                                    style: TextStyle(
                                                      fontSize:
                                                          16, // Adjust the font size if necessary
                                                      fontWeight: FontWeight
                                                          .bold, // Optional: make the text bold
                                                      color: Colors
                                                          .black, // Text color
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Adjust the height if necessary
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10), // Reduce padding if necessary
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal:
                                              30), // Adjust padding inside the container
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEE9821),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      width:
                                          250, // Adjust the width of the container
                                      height:
                                          50, // Adjust the height of the container
                                      child: Center(
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 8, 8, 8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ])))
                    ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 20),
              child: Row(children: [
                // Spacer(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Title "Out-Patient Services"
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          'Out-Patient Services',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF494949),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, left: 40),
                        width: 70, // Space between title and border
                        height: 5, // Height of the border
                        color: Colors.black, // Color of the border
                      ),
                      // Description Box
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Container(
                          width: 420,
                          height: 40, // Set the width of the container
                          decoration: BoxDecoration(
                            color: Color(0xFF1BA08F), // Background color
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50, top: 5),
                            child: Text(
                              'We provide the following features',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Health and Careers Services
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Left Column: Health & Careers
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align items to the left
                              children: [
                                // Health Service
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 10,
                                      left:
                                          210), // Added top and bottom padding for spacing
                                  child: Row(
                                    children: [
                                      // Health Icon on the Left
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          color: Color(0xFF3FAE9E),
                                          padding: const EdgeInsets.all(
                                              10), // Uniform padding for the icon
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/img/health.png', // Health icon
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Space between icon and text

                                      // Health Text on the Right
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Health',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '''"The First Wealth 
  is Health"''',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Careers Service (Placed below Health)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 70,
                                      bottom: 20,
                                      left:
                                          210), // Added top and bottom padding for spacing
                                  child: Row(
                                    children: [
                                      // Careers Icon on the Left
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          color: Color(0xFF3FAE9E),
                                          padding: const EdgeInsets.all(
                                              10), // Uniform padding for the icon
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/img/careers.png', // Careers icon
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Space between icon and text

                                      // Careers Text on the Right
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Careers',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '''"Be So good They 
  Can't ignore you"''',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Right side: Column containing "Surgery" and "Planning" services
                          Expanded(
                            child: Row(
                              children: [
                                // Column for Surgery and Planning Services
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align items to the left
                                    children: [
                                      // Surgery Service
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 10,
                                            left:
                                                80), // Added top and bottom padding for spacing
                                        child: Row(
                                          children: [
                                            // Surgery Icon on the Left
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                color: Color(0xFF3FAE9E),
                                                padding: const EdgeInsets.all(
                                                    10), // Uniform padding for the icon
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/img/Surgeryicon.png', // Surgery icon
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    10), // Space between icon and text

                                            // Surgery Text on the Right
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Surgery',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '''"Truth Like Surgery 
May Hurt But It Cures"''',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black54,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Planning Service (Placed below Surgery)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 70,
                                            bottom: 20,
                                            left:
                                                80), // Added top and bottom padding for spacing
                                        child: Row(
                                          children: [
                                            // Planning Icon on the Left
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                color: Color(0xFF3FAE9E),
                                                padding: const EdgeInsets.all(
                                                    10), // Uniform padding for the icon
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/img/calender.png', // Planning icon
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    10), // Space between icon and text

                                            // Planning Text on the Right
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Planning',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '''"If You Can Dream it,
 You Can Do It."''',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black54,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Container(
                    width: 580, // Set the width of the image
                    height: 400, // Set the height of the image
                    child: Image.asset(
                      'assets/img/Out Patient.jpeg',
                      fit: BoxFit
                          .contain, // Ensure the image covers the area without stretching
                    ),
                  ),
                ),
              ]),
            ),
          ]),

          // Right side: Column containing "Surgery" and "Planning" services

          // Health Service - Added below "We provide the following features"
          Stack(
              alignment:
                  Alignment.center, // Centering elements inside the Stack
              children: [
                // The container that holds the background color
                Padding(
                  padding: const EdgeInsets.only(bottom: 1700),
                  child: Container(
                    width: double.infinity,
                    height: 250, // Set the height of the container
                    color:
                        Color(0xFFEE9821), // Background color of the container
                  ),
                ),

                // QR Code image overlaying the container

                // Row for the images outside the container (Father & Son, Phone, MOM & girl)
                Padding(
                  padding: const EdgeInsets.only(
                      right: 970, bottom: 1220), // Adjust as necessary
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Image.asset(
                          'assets/img/Father & Son-01.png',
                          width: 200, // Image width
                          height: 600, // Image height
                          fit: BoxFit.contain, // Ensure image scales properly
                        ),
                      ),
                    ],
                  ),
                ),

                // Column for other images (Phone and MOM & girl)
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          // Phone image outside of container
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 1300,
                                left: 400), // Adjust positioning as needed
                            child: Image.asset(
                              'assets/img/Phone-01.png',
                              width: 250, // Image width
                              height: 350, // Image height
                              fit: BoxFit.contain,
                            ),
                          ),
                          // QR code image over the Phone image
                          Column(
                            children: [
                              // QR Code Image
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 900, top: 110),
                                child: Image.asset(
                                  'assets/img/qr.PNG',
                                  width: 150, // QR image width
                                  height: 200, // QR image height
                                  fit: BoxFit.contain, // Ensure image fits well
                                ),
                              ),
                              // Text below the QR code
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10,
                                    left:
                                        900), // Add some space between image and text
                                child: Text(
                                  '''Download Our 
  Mobile App''',
                                  style: TextStyle(
                                    fontSize:
                                        18, // Adjust the font size for readability
                                    fontWeight: FontWeight
                                        .bold, // Bold text for emphasis
                                    color: Colors.black, // Text color
                                  ),
                                  textAlign:
                                      TextAlign.center, // Center align the text
                                ),
                              ),
                            ],
                          ),

                          // MOM & girl image outside of container
                          Padding(
                            padding: const EdgeInsets.only(top: 80, left: 1300),
                            child: Image.asset(
                              'assets/img/MOM & girl-01.png',
                              width: 180, // Image width
                              height: 270, // Image height
                              fit: BoxFit.contain,
                            ),
                          ),
                          // QR code image over the MOM & girl image
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    // Main large container at the bottom
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        width: double.infinity,
                        height:
                            900, // Fixed height but can adjust based on design needs
                        color: Color(0xFF1FBCB1),
                      ),
                    ),

                    // Row for small containers (Health Tips, Latest News, Visiting Hours)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 220,
                        top: 70,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Change this line
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 195,
                              width: 380,
                              color: const Color.fromARGB(255, 231, 162, 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Ensures the content is spaced out
                                      children: [
                                        Text(
                                          'HEALTH TIPS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 110),
                                          child: Image.asset(
                                            'assets/img/healthi.png', // Replace with your image file path
                                            width: 40, // Adjust size as needed
                                            height: 40, // Adjust size as needed
                                            fit: BoxFit
                                                .contain, // Ensure the image scales correctly
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '''        exercitation ullamco laboris 
          nisi ut aliquip ex ea commodo 
    consequat. Duis aute irure 
dolor in reprehenderit in 
      voluptate velit esse proident''',

                                    textAlign:
                                        TextAlign.center, // Center the text
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height:
                                          1.5, // Adjust line height for better spacing
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 195,
                              width: 380,
                              color: Color(0xFF1BA08F),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Spreads the text and image to the edges
                                      children: [
                                        Text(
                                          'LATEST NEWS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 110),
                                          child: Image.asset(
                                            'assets/img/Latet.png', // Replace with your image file path
                                            width:
                                                50, // Adjust the width as needed
                                            height:
                                                40, // Adjust the height as needed
                                            fit: BoxFit
                                                .contain, // Ensures the image scales proportionally
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '''        exercitation ullamco laboris 
          nisi ut aliquip ex ea commodo 
    consequat. Duis aute irure 
dolor in reprehenderit in 
      voluptate velit esse proident''',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 195,
                              width: 380,
                              color: const Color.fromARGB(255, 7, 135, 221),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            60), // Reduced padding from 60 to 20
                                    child: Row(
                                      children: [
                                        // Image or Icon on the left
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right:
                                                  5), // Adjust space between image and text
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Image.asset(
                                              'assets/img/Visiting Hours.png', // Your image asset path
                                              width: 70, // Adjust image size
                                              height: 50, // Adjust image size
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        // Text next to the image
                                        Text(
                                          'VISITING HOURS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Add the "time" text or other widgets here

                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 40,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '10', // First part of the time
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 50,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Small space between "10" and "00"
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                '''00
am''', // Second part of the time
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      18, // Smaller font size for "00"
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    10), // Space between the time and image
                                            Image.asset(
                                              'assets/img/arrow.png', // Arrow image path
                                              width:
                                                  50, // Adjust the width of the image
                                              height:
                                                  50, // Adjust the height of the image
                                            ),
                                            SizedBox(
                                                height:
                                                    20), // Space between the first row and second row
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    child: Text(
                                                      '7', // First part of the time
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          4), // Small space between "7" and "30"
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      '''30
pm''', // Second part of the time
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            18, // Smaller font size for "30"
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // "SERVICES" Text Positioned
                    Padding(
                      padding: const EdgeInsets.only(left: 220, top: 270),
                      child: Row(
                        children: [
                          Container(
                            width: 60, // Short left border
                            height: 2, // Border height
                            color: const Color.fromARGB(
                                255, 231, 162, 14), // Border color
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    10), // Space between text and borders
                            child: Text(
                              'Services',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 1200, // Longer right border
                            height: 2, // Border height
                            color: const Color.fromARGB(
                                255, 231, 162, 14), // Border color
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1310, top: 328),
                      child: Container(
                        width: 150, // Set the width of the container for pi2
                        height: 350, // Set the height of the container for pi2
                        child: Image.asset(
                          'assets/img/pi1.jpg', // Image path
                          fit: BoxFit
                              .cover, // Ensures the image covers the entire container
                        ),
                      ),
                    ),

                    // Main Row for images (HEALTH TIPS, LATEST NEWS, VISITING HOURS)
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 320, left: 50, right: 300),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // First image with text overlay
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:
                                      400, // Set a fixed width for the image container
                                  height:
                                      350, // Set the height for the container
                                  child: Stack(
                                    fit: StackFit
                                        .expand, // Ensure the image fills the container
                                    children: [
                                      Image.asset(
                                        'assets/img/pi1.jpg', // Image path
                                        fit: BoxFit
                                            .cover, // Make the image cover the entire container
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Container(
                                              width:
                                                  40, // Width of the button (circle size)
                                              height:
                                                  30, // Height of the button (circle size)
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Make it a circle
                                                color: Colors
                                                    .orange, // Background color of the circle
                                              ),
                                              child: Icon(
                                                Icons.play_arrow, // Play icon
                                                color: Colors
                                                    .white, // Icon color (white)
                                                size:
                                                    30, // Size of the icon (adjust to your preference)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Text box overlay
                                      Positioned(
                                        left:
                                            70, // Positioning the text box from the left
                                        bottom:
                                            10, // Positioning the text box from the bottom
                                        child: Container(
                                          color: Color(
                                              0xFFFFFFFF), // Background color for the text box
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            '''EMERGENCY / 24-HOUR
SERVICES''', // Text you want to display
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Second image with text overlay
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 400, // Set the width of the container
                                  height:
                                      350, // Set the height of the container
                                  child: Stack(
                                    fit: StackFit
                                        .expand, // Ensure that the image expands to fill the container
                                    children: [
                                      Image.asset(
                                        'assets/img/pi2.jpg', // Image path
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the entire container
                                      ),

                                      // Text box overlay
                                      Positioned(
                                        left:
                                            70, // Positioning the text box from the left
                                        bottom:
                                            20, // Positioning the text box from the bottom
                                        child: Container(
                                          color: Color(
                                              0xFFFFFFFF), // Background color for the text box
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            '''SURGICAL AND MEDICAL 
                              ICU''', // Text you want to display
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Third image with text overlay
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    height: 350,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          'assets/img/pi3.jpg', // Replace with your image file path
                                          width: 900,
                                          height: 300,
                                          fit: BoxFit
                                              .cover, // Ensures the image covers the entire area
                                        ),

                                        // Text box overlay
                                        Positioned(
                                          left:
                                              230, // Positioning the text box from the left
                                          bottom:
                                              20, // Positioning the text box from the bottom
                                          child: Container(
                                            color: Color(
                                                0xFFFFFFFF), // Dark background for the text box
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              'LABORATORY', // Text you want to display
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 500,
                                            top: 290,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start, // Change this line
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: Color(0xFFEE9821),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'HEALTH TIPS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '''exercitation ullamco laboris 
                                nisi ut aliquip ex ea commodo 
                                consequat. Duis aute irure 
                                dolor in reprehenderit in 
                                voluptate velit esseproident''',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: const Color.fromARGB(
                                                      255, 15, 124, 79),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'LATEST NEWS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '''exercitation ullamco laboris
                                nisi ut aliquip ex ea commodo 
                                consequat. Duis aute irure
                                dolor in reprehenderit in
                                voluptate velit esseproident''',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: const Color.fromARGB(
                                                      255, 7, 135, 221),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'VISITING HOURS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '10:00 am',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 500,
                                            top: 290,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start, // Change this line
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: const Color.fromARGB(
                                                      255, 231, 162, 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'HEALTH TIPS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '''exercitation ullamco laboris 
                                nisi ut aliquip ex ea commodo 
                                consequat. Duis aute irure 
                                dolor in reprehenderit in 
                                voluptate velit esseproident''',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: const Color.fromARGB(
                                                      255, 15, 124, 79),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'LATEST NEWS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '''exercitation ullamco laboris
                                nisi ut aliquip ex ea commodo 
                                consequat. Duis aute irure
                                dolor in reprehenderit in
                                voluptate velit esseproident''',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 180,
                                                  width: 300,
                                                  color: Color(0xFF5592C8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'VISITING HOURS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '10:00 am',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ])),

// Emergency Text (aligned to the right of Location)

// Surgical Section (added below Emergency)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left:
                        30, // Adjust the left padding to control the overall position
                    top: 580,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Ensures even spacing between columns
                    children: [
                      // First Column: HEALTH TIPS
                      Padding(
                        padding: const EdgeInsets.only(
                            left:
                                230), // Space between the first and second column
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row for image and text in HEALTH TIPS
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Align items to the start
                                children: [
                                  // Image for HEALTH TIPS
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 85),
                                    child: Image.asset(
                                      'assets/img/Location.png', // Replace with your actual image path
                                      width: 60, // Adjust size as needed
                                      height: 60, // Adjust size as needed
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Space between image and text
                                  // Text for HEALTH TIPS
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align text to the start
                                    children: [
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Set text color to black
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '''Mother Theresa Road,
Kankanady, Highland Hospitals,
Mangaluru, Karnataka 575002,
India.''',
                                        textAlign: TextAlign
                                            .start, // Align text to the start
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Set text color to black
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Second Column: LATEST NEWS
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50,
                            right:
                                100), // Space between the second and third column
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row for image and text in LATEST NEWS
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Align items to the start
                              children: [
                                // Image for LATEST NEWS
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  child: Image.asset(
                                    'assets/img/Call.png', // Replace with your actual image path
                                    width: 60, // Adjust size as needed
                                    height: 60, // Adjust size as needed
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ), // Space between image and text

// Text for LATEST NEWS
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the start
                                  children: [
                                    Text(
                                      'Emergency 24x7',
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Set text color to black
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 90),
                                      child: Text(
                                        '0824-4235555',
                                        textAlign: TextAlign
                                            .start, // Align text to the start
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Set text color to black
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Third Column: VISITING HOURS
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 350,
                          bottom: 70,
                        ), // Adjust right padding as needed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row for image and text in VISITING HOURS
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Align items to the start
                              children: [
                                // Image for VISITING HOURS
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Image.asset(
                                    'assets/img/E-mail.png', // Replace with your actual image path
                                    width: 60, // Adjust size as needed
                                    height: 60, // Adjust size as needed
                                  ),
                                ),
                                SizedBox(
                                    width: 10), // Space between image and text
                                // Text for VISITING HOURS
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the start
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Set text color to black
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '''reachus@highlandhospital.in''',
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Set text color to black
                                        fontSize: 18,
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
                ),
                Stack(
                  children: [
                    // Main large container at the bottom
                    Padding(
                      padding: const EdgeInsets.only(top: 1350),
                      child: Container(
                          width: double.infinity,
                          height:
                              500, // Fixed height but can adjust based on design needs
                          color: Color(0xFFEAEBED)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        top: 1360,
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
                          padding: const EdgeInsets.only(top: 1840),
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

  Widget carousalContainer({
    required String image,
    required String label,
    required String content,
    // required IconData icon,
    required Color backgroundColor, // Added color parameter
  }) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        // width: 420, // Keeping the container width compact
        height: 300, // Keeping the height reduced
        margin: EdgeInsets.symmetric(
          vertical: 8.0, // Slightly reduced vertical margin for tighter space
          horizontal: 19.0, // Reduced horizontal margin for compact layout
        ),
        color: backgroundColor, // Use the passed color for background
        padding: EdgeInsets.all(
            2), // Reduced padding to minimize space evenly around the container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 160, // Image width reduced
              height: 60, // Image height reduced for compact fit
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10), // Space between image and label
            Text(
              label,
              softWrap: true,
              maxLines: 5,
              style: TextStyle(
                fontSize: 10, // Smaller font size for the label
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10), // Space between label and content
            SizedBox(
              width: 250,
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 17, // Smaller font size for content
                  fontWeight: FontWeight.normal,
                  color: ColorConstant.mainBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Icon(
              Icons.add_circle_outline_rounded,
              color: ColorConstant.mainWhite,
            ),
          ],
        ),
      ),
    );
  }
}
