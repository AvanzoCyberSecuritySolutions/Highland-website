import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:provider/provider.dart';
import 'Feedback_controller.dart'; // Ensure this is the correct path to your FeedbackController file
import 'constants/color_constant.dart'; // Ensure this is the correct path to your ColorConstant file

class FeedbackForm extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    var feedbackProvider =
        Provider.of<FeedbackController>(context, listen: false);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback Form',
          style: TextStyle(
            color: Colors.white, // Set the text color to red
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1BA08F),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text(
                            'We value your feedback!',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.mainOrange,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 390,
                            height: 5,
                            color: Color(0xFF1BA08F),
                          ),

                          SizedBox(height: 10),
                          Text(
                            'Date: $formattedDate',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
// Add your image asset here
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width *
                                  0.01, // 1% of screen width for left
                              MediaQuery.of(context).size.height *
                                  0.09, // 2% of screen height for top
                              MediaQuery.of(context).size.width *
                                  0.012, // 1% of screen width for right
                              MediaQuery.of(context).size.height *
                                  0.01, // 2% of screen height for bottom
                            ),
                            child: Image.asset(
                              'assets/img/Artboard Highland.png', // Replace with your image path
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% of screen width
                              height: MediaQuery.of(context).size.height *
                                  0.3, // 30% of screen height
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    controller: patientidContoller,
                                    decoration: InputDecoration(
                                      labelText: 'Patient ID',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.person_add_alt_1_sharp,
                                        color: Color(0xFF1BA08F),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Patient ID is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFF1BA08F),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    controller: phnContoller,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile No',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Color(0xFF1BA08F),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile No is required';
                                      }
                                      if (!RegExp(r'^\d{10}$')
                                          .hasMatch(value)) {
                                        return 'Enter a valid 10-digit mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFF1BA08F),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                          .hasMatch(value)) {
                                        return 'Enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.5, // 80% of the screen width
                                  child: TextFormField(
                                    controller: feedbackController,
                                    decoration: InputDecoration(
                                      labelText: 'Feedback',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.feedback,
                                        color: Color(0xFF1BA08F),
                                      ),
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
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: responseUpload,
                                      onChanged: (value) {
                                        setState(() {
                                          responseUpload = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Would you like to upload this response to our official website?",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      int statusCode =
                                          await feedbackProvider.feedbackSaving(
                                        patientid: patientidContoller.text,
                                        name: nameController.text,
                                        email: emailController.text,
                                        phn: phnContoller.text,
                                        feedback: feedbackController.text,
                                        date: formattedDate,
                                      );

                                      if (statusCode == 201) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Thank you for your valuable feedback!'),
                                            backgroundColor: Color(0xFF1BA08F),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please correct the errors in the form before submitting.'),
                                            backgroundColor:
                                                ColorConstant.mainRed,
                                          ),
                                        );
                                      }

                                      patientidContoller.clear();
                                      nameController.clear();
                                      emailController.clear();
                                      phnContoller.clear();
                                      feedbackController.clear();
                                    }
                                  },
                                  child: Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xFF1BA08F),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
