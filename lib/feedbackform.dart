import 'package:flutter/material.dart';
import 'package:flutter_highland/constants/color_constant.dart';
import 'package:flutter_highland/feedback_controller.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();

  final patientidContoller = TextEditingController();
  final nameController = TextEditingController();
  final phnContoller = TextEditingController();
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();

  bool responseUpload = false;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  @override
  void dispose() {
    patientidContoller.dispose();
    nameController.dispose();
    phnContoller.dispose();
    emailController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  Widget _buildInfoSection(
      BuildContext context, String formattedDate, bool isMobile) {
    final Size size = MediaQuery.of(context).size;
    final double imageWidth = isMobile ? size.width * 0.7 : size.width * 0.3;
    final double imageHeight =
        isMobile ? size.height * 0.25 : size.height * 0.3;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (!isMobile) SizedBox(height: size.height * 0.1),
        Text(
          'We value your feedback!',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: ColorConstant.mainOrange,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: isMobile ? size.width * 0.7 : 390,
          height: 5,
          color: const Color(0xFF1BA08F),
        ),
        const SizedBox(height: 10),
        Text(
          'Date: $formattedDate',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/img/Artboard Highland.png',
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
        if (isMobile) const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFormSection(BuildContext context, String formattedDate,
      FeedbackController feedbackProvider, bool isMobile) {
    final double formFieldWidth = isMobile ? double.infinity : 500;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: formFieldWidth,
            child: TextFormField(
              controller: patientidContoller,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 18),
                labelText: 'Patient ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_add_alt_1_sharp,
                    color: Color(0xFF1BA08F)),
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Patient ID is required'
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: formFieldWidth,
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 18),
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: Color(0xFF1BA08F)),
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Name is required' : null,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: formFieldWidth,
            child: TextFormField(
              controller: phnContoller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 18),
                labelText: 'Mobile No',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: Color(0xFF1BA08F)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mobile No is required';
                }
                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Enter a valid 10-digit mobile number';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: formFieldWidth,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 18),
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: Color(0xFF1BA08F)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: TextFormField(
              controller: feedbackController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 18),
                labelText: 'Feedback',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.feedback, color: Color(0xFF1BA08F)),
              ),
              maxLines: 9,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Feedback cannot be empty';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: responseUpload,
                activeColor: const Color(0xFF1BA08F),
                onChanged: (value) {
                  setState(() {
                    responseUpload = value!;
                  });
                },
              ),
              const Flexible(
                child: Text(
                  "Would you like to upload this response to our official website?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                try {
                  int statusCode = await feedbackProvider.feedbackSaving(
                    patientid: patientidContoller.text,
                    name: nameController.text,
                    email: emailController.text,
                    phn: phnContoller.text,
                    feedback: feedbackController.text,
                    date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  );

                  Navigator.pop(context);

                  if (statusCode == 200 || statusCode == 201) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Thank you for your valuable feedback!'),
                        backgroundColor: Color(0xFF1BA08F),
                      ),
                    );
                    patientidContoller.clear();
                    nameController.clear();
                    emailController.clear();
                    phnContoller.clear();
                    feedbackController.clear();
                    setState(() {
                      responseUpload = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Submission failed. Status code: $statusCode'),
                        backgroundColor: ColorConstant.mainRed,
                      ),
                    );
                  }
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred: ${e.toString()}'),
                      backgroundColor: ColorConstant.mainRed,
                    ),
                  );
                }
              }
            },
            child: const Text('Submit'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1BA08F),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedbackProvider =
        Provider.of<FeedbackController>(context, listen: false);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    final bool mobile = isMobile(context);
    final bool tablet = isTablet(context);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Feedback Form', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1BA08F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (mobile || tablet)
              ? Column(
                  children: [
                    _buildInfoSection(context, formattedDate, mobile),
                    const SizedBox(height: 30),
                    _buildFormSection(
                        context, formattedDate, feedbackProvider, mobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildInfoSection(context, formattedDate, mobile),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: _buildFormSection(
                            context, formattedDate, feedbackProvider, mobile),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
