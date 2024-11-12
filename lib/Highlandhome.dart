import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: const Color.fromARGB(255, 232, 233, 235),
        ),
        body: SingleChildScrollView(
            // Use SingleChildScrollView to prevent overflow
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            // Menu items row at the top
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Scrollable row for menu items
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(menuItems.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        // Handle item tap (you can add specific actions here)
                      },
                      child: menuItems[index] == 'CONTACT'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.orange, // Orange background color
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Text(
                                menuItems[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // White text color
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          : Text(
                              menuItems[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 1, 5, 10),
                                decoration: TextDecoration.none,
                              ),
                            ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20), // Space between menu items and image

            // Stack to overlay images and text
            Stack(
              children: [
                // Background Image
                Image.asset(
                  'assets/img/bg.jpeg', // Background image
                  height: 800, // Height of the background image
                  width: 1630, // Full width of the screen
                  fit: BoxFit.cover, // Adjust how the background image fits
                ),
                // Overlay Image (placed on top of the background)
                Positioned(
                  bottom: 300,
                  top: 100, // Position the overlay image vertically
                  left: 270, // Position the overlay image horizontally
                  child: Image.asset(
                    'assets/img/Logo1234.png', // Your second image (make sure it exists in assets)
                    height: 800, // Adjust height of the overlay image
                    width: 500, // Adjust width of the overlay image
                    fit: BoxFit.contain, // Fit the overlay image properly
                  ),
                ),
                // Text below the overlay image
                Positioned(
                  top: 400, // Position the text below the image
                  left: 300, // Align the text horizontally to the left
                  right: 850, // Keep it within screen bounds
                  child: Column(
                    children: [
                      Text(
                        '''At Highland Hospital it is not 
just health-care but care for your health''',
                        textAlign: TextAlign.center, // Centers the text
                        style: TextStyle(
                          fontSize: 16, // Adjust the text size
                          fontWeight:
                              FontWeight.bold, // Optional: Adjust text weight
                          color: Colors.black, // Adjust text color
                        ),
                      ),
                    ],
                  ),
                ),
                // Add the "Our Specialities" below the text
                Positioned(
                  top: 470, // Position it below the main text (500 + 100)
                  left: 50, // Align it to the left
                  right: 600, // Keep it within screen bounds
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 75.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(209, 21, 183,
                              241), // Green background for specialties
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: Text(
                          'Our Specialities',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .white, // White text color for specialities
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50), // Space after "Our Specialities"

            // Add another section with text or content
            Text(
              'Welcome to Highland Hospital',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Stack(
              children: [
                Text(
                  'Established in 1995',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 20, 196, 219),
                    decoration: TextDecoration.underline, // Underline text
                  ),
                ),
                Positioned(
                  bottom:
                      -2.0, // Adjust this value to control the space between the text and the underline
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2.0, // Thickness of the underline
                    color: Colors.blue, // Color of the underline
                  ),
                ),
              ],
            ),
            Text(
              '''Our 250 bedded hospital brings you the best in multispeciality treatment with state-of-the-art
        technology focusing on various specialities including Critical Care,Cardiology,Cardiac 
          Surgery,Orthopaedic & joint Replacement,Neurology,Neuro-Surgery,Pulmonology,
        Gastroenterology,Diabetes and Endocrinology,Paediatrics,Gynaecology,Nephrology,
      Urology, and many more.The focus of healthcare at Highland Hospital is the health and 
    wellbeing of our patients,utilsing the latest infrastructure and qualified medical experise
                     available while at the same time ensuring affordability. ''',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // "Know more" button as a regular widget
            SizedBox(height: 30), // Add space before the button
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(209, 21, 183,
                    241), // Background color for the "Know More" button
                borderRadius: BorderRadius.circular(2.0), // Rounded corners
              ),
              child: Text(
                'Know more',
                style: TextStyle(
                  fontSize: 12,
                  height: 0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color for visibility
                  decoration: TextDecoration.none, // No text decoration
                ),
              ),
            ),
            SizedBox(height: 20), // Space after "Know more" button

            // Horizontal container under "Know more"
            Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align horizontally
                children: [
                  // Left Container
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0, // Margin at the top
                      bottom: 10.0, // Margin at the bottom
                      left: 15.0, // Margin on the left
                      right: 25.0, // Margin on the right
                    ),
                    width: 170, // Set width of the container
                    height: 120.0, // Set height of the container
                    color: Colors.blue, // Background color of the container
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Padding around the texts
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center align the text vertically
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Center align the text horizontally
                        children: [
                          Text(
                            'FIND A DOCTOR',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // White text color
                            ),
                          ),
                          SizedBox(height: 5), // Space between texts

                          Text(
                            '''Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed incididunt ut labore''',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(
                                  255, 24, 5, 5), // White text color
                            ),
                            textAlign: TextAlign.center, // Centers the text
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Space after "Know more" button

                  // Horizontal container under "Know more"
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Align horizontally
                      children: [
                        // Left Container
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0, // Margin at the top
                            bottom: 10.0, // Margin at the bottom
                            left: 15.0, // Margin on the left
                            right: 25.0, // Margin on the right
                          ),
                          width: 170, // Set width of the container
                          height: 120.0, // Set height of the container
                          color:
                              Colors.blue, // Background color of the container
                          child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Padding around the texts
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center align the text vertically
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Center align the text horizontally
                              children: [
                                Text(
                                  'TEST RESULTS',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                                SizedBox(height: 5), // Space between texts

                                Text(
                                  '''Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed incididunt ut labore''',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: const Color.fromARGB(
                                        255, 26, 12, 12), // White text color
                                  ),
                                  textAlign:
                                      TextAlign.center, // Centers the text
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          //width: 5,
                        ), // Space after "Know more" button

                        // Horizontal container under "Know more"
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Align horizontally
                          children: [
                            // Left Container
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.0, // Margin at the top
                                bottom: 10.0, // Margin at the bottom
                                left: 15.0, // Margin on the left
                                right: 25.0, // Margin on the right
                              ),
                              width: 170, // Set width of the container
                              height: 120.0, // Set height of the container
                              color: Colors
                                  .blue, // Background color of the container
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding around the texts
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center align the text vertically
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Center align the text horizontally
                                  children: [
                                    Text(
                                      'ONLINE ADMISSION',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // White text color
                                      ),
                                    ),
                                    SizedBox(height: 5), // Space between texts

                                    Text(
                                      '''Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed incididunt ut labore''',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: const Color.fromARGB(255, 15, 13,
                                            13), // White text color
                                      ),
                                      textAlign:
                                          TextAlign.center, // Centers the text
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 20), // Space after "Know more" button

                            // Horizontal container under "Know more"
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Align horizontally
                              children: [
                                // Left Container
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.0, // Margin at the top
                                    bottom: 10.0, // Margin at the bottom
                                    left: 15.0, // Margin on the left
                                    right: 25.0, // Margin on the right
                                  ),
                                  width: 170, // Set width of the container
                                  height: 120.0, // Set height of the container
                                  color: Colors
                                      .blue, // Background color of the container
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        8.0), // Padding around the texts
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Center align the text vertically
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Center align the text horizontally
                                      children: [
                                        Text(
                                          'PATIENT ACCES',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .white, // White text color
                                          ),
                                        ),
                                        SizedBox(
                                            height: 5), // Space between texts

                                        Text(
                                          '''Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed incididunt ut labore''',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: const Color.fromARGB(255, 14,
                                                9, 9), // White text color
                                          ),
                                          textAlign: TextAlign
                                              .center, // Centers the text
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Image asset

                            SizedBox(height: 10),
                            Image.asset(
                              'assets/img/your_image.png', // Your image file path
                              width: 600, // Width of the image
                              height: 400, // Height of the image
                              fit: BoxFit
                                  .cover, // Fit the image within the container
                            ),
                            // Space after the horizontal container

                            // Add other widgets/content below as needed
                          ],
                        )
                      ]),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/img/your_image.png', // Your image file path
                    width: 600, // Width of the image
                    height: 400, // Height of the image
                    fit: BoxFit.cover, // Fit the image within the container
                  ),
                ]),
          ]),
        )));
  }
}
