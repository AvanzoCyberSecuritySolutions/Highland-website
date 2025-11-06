import 'package:flutter/material.dart';
import 'package:flutter_highland/webviewmap.dart';
import 'package:flutter_highland/responsive.dart'; // Make sure this import is correct

// Define colors for consistency (Optional, but good practice)
const Color kAppBarColor = Color(0xFF1BA08D);
const Color kButtonColor = Color(0xFFE7A20E);
const Color kFieldBackgroundColor = Colors.white;
const Color kDisclaimerBackgroundColor =
    Color(0xFFFAFAFA); // Light grey for static disclaimer

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _scrollAnimation;

  // Controllers for TextFields (Good practice for accessing values)
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Animation setup remains the same
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _scrollAnimation = Tween<Offset>(
      // Adjust end offset if needed for better scrolling appearance
      begin: const Offset(1.0, 0.0),
      end: const Offset(-2.5, 0.0), // End further left
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    // Dispose text controllers
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // --- Function to handle form submission ---
  void _submitForm() {
    // Add your submission logic here
    print("Form Submitted");
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Mobile: ${_mobileController.text}");
    print("Message: ${_messageController.text}");
    // Example: Show a confirmation dialog or send data to API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Form submitted (Placeholder)")),
    );
    // Optionally clear fields after submission
    // _nameController.clear();
    // _emailController.clear();
    // _mobileController.clear();
    // _messageController.clear();
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: kAppBarColor, // Use defined color
        foregroundColor: Colors.white,
      ),
      // Use SafeArea to avoid system UI overlaps
      body: SafeArea(
        child: SingleChildScrollView(
          // Padding applied once around the main content area
          padding: const EdgeInsets.all(16.0),
          child: Responsive(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context), // Reuse desktop or customize
            desktop: _buildDesktopLayout(context),
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(context), // Use helper for footer
    );
  }

  // --- Layout Builders ---

  // Desktop Layout: Side-by-side Row
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
      children: [
        // Left side - Contact form
        Expanded(
          flex: 2, // Keep original flex ratio
          child: _buildContactForm(context), // Use reusable form widget
        ),
        const SizedBox(width: 24.0), // Spacing between columns
        // Right side - Image
        Expanded(
          flex: 1, // Keep original flex ratio
          child: _buildMapImage(context), // Use reusable image widget
        ),
      ],
    );
  }

  // Tablet Layout: Reusing Desktop Layout for simplicity
  Widget _buildTabletLayout(BuildContext context) {
    // You can customize this if needed, e.g., adjust flex values or padding
    return _buildDesktopLayout(context);
  }

  // Mobile Layout: Stacked Column
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactForm(context), // Form first
        const SizedBox(height: 24.0), // Vertical spacing
        _buildMapImage(context), // Map image below
      ],
    );
  }

  // --- Reusable Content Widgets ---

  // Widget for the Contact Form section
  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact us Title
        // const Text(
        //   'Contact us',
        //   style: TextStyle(
        //     color: Color.fromARGB(255, 15, 12, 12),
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        SizedBox(height: 20),
// Name input field
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 18), // <- Added this
                labelText: 'Name:',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),

        // Email input field
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 18), // <- Added this
                labelText: 'Email:',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),

        // Mobile Number input field
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 18), // <- Added this
                labelText: 'Mobile Number:',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),

        // Message input field
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 18), // <- Added this
                labelText: 'Message:',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: 240, // Make the button stretch across the width
            child: ElevatedButton(
              onPressed: () {
                // Add your submission logic here
                print("Form Submitted");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(
                    0xFFE7A20E), // Correct parameter for Button background color
                padding: EdgeInsets.symmetric(vertical: 15), // Button height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30), // Space before disclaimer

        // --- Responsive Disclaimer ---
        Responsive(
          mobile: _buildStaticDisclaimer(), // Static for mobile
          tablet: _buildStaticDisclaimer(), // Static for tablet
          desktop: _buildDisclaimerMarquee(), // Animated for desktop
        ),
        // --- End Responsive Disclaimer ---
      ],
    );
  }

  // Helper to build styled TextFields consistently
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      // Wrap in container for shadow
      decoration: BoxDecoration(
        color: kFieldBackgroundColor, // Ensure background is set for shadow
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Softer shadow
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          fillColor:
              kFieldBackgroundColor, // Redundant due to container, but safe
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.grey.shade300), // Subtle border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.grey.shade300), // Consistent border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: kAppBarColor, width: 1.5), // Highlight focus
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        style: const TextStyle(color: Colors.black87), // Default text color
      ),
    );
  }

  // Widget for the Map Image section
  Widget _buildMapImage(BuildContext context) {
    // Use LayoutBuilder to get constraints if needed for aspect ratio
    return LayoutBuilder(builder: (context, constraints) {
      // Determine a reasonable height based on width for mobile/tablet if needed
      double imageHeight = Responsive.isMobile(context)
          ? constraints.maxWidth * 0.8
          : 360; // Example aspect ratio adjustment

      return GestureDetector(
        onTap: () {
          // Consider opening map link directly on web or using platform checks
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Webviewmap()),
          );
        },
        child: Container(
          height: imageHeight, // Use calculated or fixed height
          // width: double.infinity, // Takes width from Expanded or Column
          clipBehavior: Clip.antiAlias, // Clip the image to rounded corners
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(12), // Rounded corners for image
              boxShadow: [
                // Optional shadow for image
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]),
          child: Image.asset(
            'assets/img/hospital-map.png', // Ensure asset path is correct
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }

  // --- Helper: Scrolling Marquee for Desktop ---
  Widget _buildDisclaimerMarquee() {
    const double titleSize = 14.0; // Smaller size suitable for disclaimer
    const double bodySize = 14.0;

    return SizedBox(
      height: 30, // Reduced height
      child: ClipRect(
        child: SlideTransition(
          position: _scrollAnimation,
          child: Row(
            // Ensures the Row is wide enough to scroll off-screen before repeating
            children: [
              // Repeat the text couple of times to ensure continuous scroll
              for (int i = 0; i < 1; i++)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0), // Spacing
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: bodySize), // Subdued color
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Disclaimer: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleSize)),
                        TextSpan(text: 'We do not charge for hiring! '),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper: Static Disclaimer for Mobile/Tablet ---
  Widget _buildStaticDisclaimer() {
    const double titleSize = 13.0;
    const double bodySize = 13.0;

    return Container(
        width: double.infinity, // Take full width
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: kDisclaimerBackgroundColor, // Light background
            borderRadius: BorderRadius.circular(8)),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
                color: Colors.black54, fontSize: bodySize, height: 1.3),
            children: <TextSpan>[
              TextSpan(
                  text: 'Disclaimer: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: titleSize)),
              TextSpan(text: 'We do not charge for hiring!'),
            ],
          ),
        ));
  }

  // --- Reusable Footer Widget ---
  Widget _buildFooter(BuildContext context) {
    // Determine layout based on screen size for footer content
    bool isMobile = Responsive.isMobile(context);

    return Container(
      // Use bottom: 0 instead of wrapping with Padding for alignment
      // padding: const EdgeInsets.only(bottom: 10), // Padding might cause issues with fixed height
      width: double.infinity,
      height: isMobile ? 70 : 50, // Taller footer on mobile for stacked text
      color: kAppBarColor,
      padding: const EdgeInsets.symmetric(
          horizontal: 18.0), // Padding inside container
      child: isMobile
          ? Column(
              // Stack vertically on mobile
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '© Highland Hospitals. All Rights Reserved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ), // Smaller font
                ),
                const SizedBox(height: 4),
                const Text(
                  'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ), // Smaller font
                ),
              ],
            )
          : Row(
              // Side-by-side on larger screens
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '© Highland Hospitals. All Rights Reserved',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ), // Slightly larger font
                ),
                const Text(
                  'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ), // Slightly larger font
                ),
              ],
            ),
    );
  }
} // End of _ContactsState
