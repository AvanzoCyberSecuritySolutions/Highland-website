import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0DBAD1), // Customize the app bar color
        elevation: 4, // AppBar shadow for a modern look
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              'About Highland Hospital',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 16.0),

            // Paragraph 1
            _buildParagraph(
                content:
                    '''Founded by Dr. C P Abdulla Rahman and Mrs. Y Razia Rahman, Highland Hospital in Mangalore has been a cornerstone of healthcare excellence for over three decades. Built on the ethos of “YOUR HEALTH, OUR CARE,” the hospital embodies a commitment to delivering compassionate and accessible healthcare services to all. From its humble beginnings, Highland has grown into a trusted healthcare provider, blending cutting-edge medical technology with personalized care that puts patients at the center of everything we do.'''),
            // Paragraph 2
            _buildParagraph(
                content:
                    '''Our multidisciplinary team of healthcare professionals, driven by a shared mission of improving lives, provides world-class treatment across a wide range of medical specialties. Whether it’s preventive care, advanced surgeries, or rehabilitation services, Highland Hospital is dedicated to ensuring that every patient receives the highest standard of care in a comfortable and supportive environment.'''),
            // Paragraph 3
            _buildParagraph(
                content:
                    '''Our journey doesn’t stop at medical care. Highland Hospital has been deeply involved in philanthropic initiatives that ensure healthcare is accessible to underserved communities, making a positive impact on countless lives. These initiatives, inspired by the founders’ vision, continue to grow under the leadership of Dr. C P Abdulla Yasser, ensuring that our commitment to community welfare remains unwavering.'''),
            // Paragraph 4
            _buildParagraph(
                content:
                    '''Today, Highland Hospital stands as a beacon of trust and innovation, recognized for its contributions to healthcare and its role in uplifting the community. As we look to the future, we are continually evolving, driven by a passion for excellence, empathy, and integrity. Through every service and every interaction, we strive to create a healthcare ecosystem that not only treats illness but fosters long-term health and well-being. Our dedication to “YOUR HEALTH, OUR CARE” ensures that Highland Hospital remains a sanctuary for healing, hope, and compassionate care, not just for Mangalore, but for all who seek our services.'''),

            // Image and Text Containers
            SizedBox(height: 20),
            _buildImageTextContainer(
              imageUrl: 'assets/your_image_1.jpg',
              text1: 'Message from the Chairman, Dr. C P Abdulla Rahman',
              text2:
                  '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ embodies our commitment to creating a compassionate, inclusive healthcare environment for everyone who walks through our doors. Founded with a vision to deliver high-quality, accessible care, we have dedicated over 30 years to meeting the evolving needs of our community. Every patient experience is shaped by our guiding values of integrity, respect, and empathy, upheld by a skilled team who share our dedication to healing and hope. It is a privilege to serve Mangalore and beyond, and we remain deeply committed to enhancing the health and wellness of our community with every step forward. Highland Hospital is more than a healthcare institution; it is a legacy of care, compassion, and unwavering dedication to the well-being of each patient who entrusts us with their health.”''',
            ),
            SizedBox(height: 20),
            _buildImageTextContainer(
              imageUrl: 'assets/your_image_2.jpg',
              text1:
                  'Message from the Managing Director, Dr. C P Abdulla Yasser',
              text2:
                  '''“As Managing Director of Highland Hospital, I am honored to carry forward the legacy that ‘YOUR HEALTH, OUR CARE’ represents. Each day, we work tirelessly to blend innovative medical practices with a human touch, recognizing that healthcare is not solely about treatments—it is about trust, dignity, and partnership. Our commitment to excellence is driven by a dedication to improve not only outcomes but also patient experiences. Highland Hospital is a place where cutting-edge technology meets compassion, and where our values of empathy, integrity, and quality drive everything we do. We envision a healthcare environment where every individual, regardless of circumstance, can feel safe, cared for, and respected. With a relentless focus on this mission, we continue to build on our legacy to serve our patients and community with unmatched dedication.”''',
            ),
            SizedBox(height: 20),
            _buildImageTextContainer(
              imageUrl: 'assets/your_image_3.jpg',
              text1: 'Message from the CEO, Mr. Mohammed Yoonus',
              text2:
                  '''“At Highland Hospital, ‘YOUR HEALTH, OUR CARE’ reflects our relentless pursuit of operational excellence and our dedication to patient-centered care. As CEO, I believe that every facet of our hospital’s operations should serve to elevate the patient experience, making healthcare efficient, compassionate, and accessible to all. Our team is focused on implementing advanced technologies and evidence-based practices, while continually striving to maintain the warmth and respect our patients deserve. We invest in both our people and our resources to uphold Highland Hospital’s reputation as a trusted healthcare provider. By nurturing an environment of support and collaboration, we aim to transform healthcare delivery, ensuring each patient experiences a seamless, caring journey toward better health. This is the Highland promise, a commitment to quality, respect, and an unwavering focus on the well-being of our patients and community.”''',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create beautifully styled paragraphs with spacing and formatting
  Widget _buildParagraph({required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 20.0, // Smaller font size for comfortable reading
          color: Colors.black87,
          height: 1.8, // Adjust line height for improved readability
          fontFamily: 'Roboto', // Modern font family
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Helper function to create Image and Text containers side by side
  Widget _buildImageTextContainer(
      {required String imageUrl,
      required String text1,
      required String text2}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade100, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0), // Round the image
            child: Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          // Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with underline and shadow
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.teal[900],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                // Regular content
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    height: 1.6,
                    fontFamily: 'Roboto', // Keep the font consistent
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
