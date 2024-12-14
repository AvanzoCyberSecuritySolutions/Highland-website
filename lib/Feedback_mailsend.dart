import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Feedback_mailsend extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController patientIdController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController feedbackController;

  const Feedback_mailsend({
    required this.formKey,
    required this.patientIdController,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.feedbackController,
    Key? key,
  }) : super(key: key);

  @override
  _Feedback_mailsendState createState() => _Feedback_mailsendState();
}

class _Feedback_mailsendState extends State<Feedback_mailsend> {
  bool isLoading = false;

  Future<void> _sendFeedback() async {
    setState(() {
      isLoading = true;
    });

    if (widget.formKey.currentState!.validate()) {
      // Prepare the email data
      String patientId = widget.patientIdController.text;
      String name = widget.nameController.text;
      String email = widget.emailController.text;
      String phone = widget.phoneController.text;
      String feedback = widget.feedbackController.text;

      // Set up the email credentials
      String username = 'rabbit@gmail.com'; // Replace with your email
      String password = 'gsfhdfjj'; // Replace with your email password

      final smtpServer = gmail(username, password);

      // Create the email message
      final message = Message()
        ..from = Address(username, 'Feedback Form')
        ..recipients
            .add('sanavanzo834@gmail.com') // Replace with the recipient's email
        ..subject = 'Feedback Form Submission :: ${DateTime.now()}'
        ..text = '''
        Patient ID: $patientId
        Name: $name
        Email: $email
        Phone: $phone
        Feedback: $feedback
        ''';

      try {
        // Send the email
        final sendReport = await send(message, smtpServer);
        print('Email sent: ${sendReport.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback sent successfully!'),
            backgroundColor: Color(0xFF1BA08F),
          ),
        );

        // Clear form fields
        widget.patientIdController.clear();
        widget.nameController.clear();
        widget.emailController.clear();
        widget.phoneController.clear();
        widget.feedbackController.clear();
      } catch (e) {
        print('Email not sent: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send feedback. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : _sendFeedback,
      child: isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text('Submit'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF1BA08F),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
