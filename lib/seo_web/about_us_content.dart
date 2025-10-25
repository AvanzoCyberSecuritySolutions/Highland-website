import 'package:flutter/material.dart';

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'About Highland',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Highland is dedicated to providing cutting-edge healthcare solutions '
            'with a patient-first approach. Established in [Year], our mission '
            'is to integrate advanced medical technology with compassionate care '
            'to ensure the best outcomes for our community.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          Text(
            'Our Vision:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'To be the leading healthcare provider, recognized for excellence '
            'in medical services, innovative research, and patient satisfaction.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          Text(
            'Our Values:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '- Compassion\n'
            '- Integrity\n'
            '- Excellence\n'
            '- Innovation',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          Text(
            'Meet Our Team',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // ... your team members or other content
        ],
      ),
    );
  }
}
