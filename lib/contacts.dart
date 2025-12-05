import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highland/controller/contact_inquiry_controller.dart';
import 'package:flutter_highland/model/contact_enquiry.dart';
import 'package:flutter_highland/webviewmap.dart';
import 'package:flutter_highland/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure this import is correct

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
//   Widget _buildContactForm(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Contact us Title
//         // const Text(
//         //   'Contact us',
//         //   style: TextStyle(
//         //     color: Color.fromARGB(255, 15, 12, 12),
//         //     fontSize: 24,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//         SizedBox(height: 20),
// // Name input field
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                 ),
//               ],
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelStyle: TextStyle(fontSize: 18), // <- Added this
//                 labelText: 'Name:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),

//         // Email input field
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                 ),
//               ],
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelStyle: TextStyle(fontSize: 18), // <- Added this
//                 labelText: 'Email:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),

//         // Mobile Number input field
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                 ),
//               ],
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelStyle: TextStyle(fontSize: 18), // <- Added this
//                 labelText: 'Mobile Number:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),

//         // Message input field
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                 ),
//               ],
//             ),
//             child: TextField(
//               maxLines: 4,
//               decoration: InputDecoration(
//                 labelStyle: TextStyle(fontSize: 18), // <- Added this
//                 labelText: 'Message:',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: SizedBox(
//             width: 240, // Make the button stretch across the width
//             child: ElevatedButton(
//               onPressed: () {
//                 // Add your submission logic here
//                 print("Form Submitted");
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(
//                     0xFFE7A20E), // Correct parameter for Button background color
//                 padding: EdgeInsets.symmetric(vertical: 15), // Button height
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15), // Rounded corners
//                 ),
//               ),
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   color: Colors.white, // Text color
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
// Widget _buildContactForm(BuildContext context) {
//   // Controllers for inputs
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final mobileController = TextEditingController();
//   final messageController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   return ChangeNotifierProvider(
//     create: (_) => ContactInquiryController(),
//     child: Consumer<ContactInquiryController>(
//       builder: (context, controller, _) {
//         return Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),

//               // 🟢 Name Field
//               _buildTextField(
//                 controller: nameController,
//                 label: 'Name:',
//                 validator: (v) =>
//                     v == null || v.isEmpty ? 'Please enter your name' : null,
//               ),

//               // 🟢 Email Field
//               _buildTextField(
//                 controller: emailController,
//                 label: 'Email:',
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (v) {
//                   if (v == null || v.isEmpty) return 'Please enter email';
//                   final emailRegex =
//                       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                   if (!emailRegex.hasMatch(v)) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),

//               // 🟢 Mobile Number Field
//               _buildTextField(
//                 controller: mobileController,
//                 label: 'Mobile Number:',
//                 keyboardType: TextInputType.phone,
//                 validator: (v) {
//                   if (v == null || v.isEmpty) return 'Please enter mobile number';
//                   final phoneRegex = RegExp(r'^[0-9]{10}$');
//                   if (!phoneRegex.hasMatch(v)) {
//                     return 'Enter valid 10-digit phone number';
//                   }
//                   return null;
//                 },
//               ),

//               // 🟢 Message Field
//               _buildTextField(
//                 controller: messageController,
//                 label: 'Message:',
//                 maxLines: 4,
//                 validator: (v) =>
//                     v == null || v.isEmpty ? 'Please enter a message' : null,
//               ),

//               // 🟠 Submit Button
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: SizedBox(
//                   width: 240,
//                   child: ElevatedButton(
//                     onPressed: controller.isLoading
//                         ? null
//                         : () async {
//                             if (!formKey.currentState!.validate()) return;

//                             final inquiry = ContactInquiry(
//                               name: nameController.text,
//                               email: emailController.text,
//                               phone: mobileController.text,
//                               message: messageController.text,
//                             );

//                             final success = await controller
//                                 .submitContactInquiry(inquiry);

//                             if (success) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(controller.successMessage ??
//                                       'Message sent successfully!'),
//                                   backgroundColor: Colors.green,
//                                 ),
//                               );
//                               nameController.clear();
//                               emailController.clear();
//                               mobileController.clear();
//                               messageController.clear();
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(controller.errorMessage ??
//                                       'Something went wrong'),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                             }
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE7A20E),
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: controller.isLoading
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Text(
//                             'Submit',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

// /// 🧱 Reusable TextField Builder
// Widget _buildTextField({
//   required TextEditingController controller,
//   required String label,
//   TextInputType? keyboardType,
//   int maxLines = 1,
//   String? Function(String?)? validator,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8),
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         validator: validator,
//         decoration: InputDecoration(
//           labelStyle: const TextStyle(fontSize: 18),
//           labelText: label,
//           fillColor: Colors.white,
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         ),
//         style: const TextStyle(color: Colors.black),
//       ),
//     ),
//   );
// }

//         const SizedBox(height: 30), // Space before disclaimer

//         // --- Responsive Disclaimer ---
//         Responsive(
//           mobile: _buildStaticDisclaimer(), // Static for mobile
//           tablet: _buildStaticDisclaimer(), // Static for tablet
//           desktop: _buildDisclaimerMarquee(), // Animated for desktop
//         ),
//         // --- End Responsive Disclaimer ---
//       ],
//     );
//   }

  Widget _buildContactForm(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => ContactInquiryController(),
      child: Consumer<ContactInquiryController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: nameController,
                        label: 'Name:',
                        validator: (v) => v == null || v.isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      _buildTextField(
                        controller: emailController,
                        label: 'Email:',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Please enter email';
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(v))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: mobileController,
                        label: 'Mobile Number:',
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Please enter mobile number';
                          final phoneRegex = RegExp(r'^[0-9]{10}$');
                          if (!phoneRegex.hasMatch(v))
                            return 'Enter valid 10-digit number';
                          return null;
                        },
                      ),

                      _buildTextField(
                        controller: messageController,
                        label: 'Message:',
                        maxLines: 4,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Please enter a message'
                            : null,
                      ),

                      // Submit button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Center(
                          child: SizedBox(
                            width: 170,
                            child: ElevatedButton(
                              onPressed: controller.isLoading
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate())
                                        return;

                                      final inquiry = ContactInquiry(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: mobileController.text,
                                        message: messageController.text,
                                      );

                                      final success = await controller
                                          .submitContactInquiry(inquiry);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(success
                                              ? (controller.successMessage ??
                                                  'Message sent successfully!')
                                              : (controller.errorMessage ??
                                                  'Something went wrong')),
                                          backgroundColor: success
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      );

                                      if (success) {
                                        nameController.clear();
                                        emailController.clear();
                                        mobileController.clear();
                                        messageController.clear();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kButtonColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: controller.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 30),
                // Responsive(
                //   mobile: _buildStaticDisclaimer(),
                //   tablet: _buildStaticDisclaimer(),
                //   desktop: _buildDisclaimerMarquee(),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 💫 Animated Marquee Disclaimer (Desktop) — now INSIDE class
  // Widget _buildDisclaimerMarquee() {
  //   return Container(
  //     color: const Color(0xFFF5F5F5),
  //     height: 40,
  //     alignment: Alignment.centerLeft,
  //     child: ClipRect(
  //       child: SlideTransition(
  //         position: _scrollAnimation,
  //         child: Row(
  //           children: const [
  //             SizedBox(width: 40),
  //             Text(
  //               'We do not charge for hiring!',
  //               style: TextStyle(fontSize: 16, color: Colors.black54),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // /// 🟣 Static Disclaimer (Mobile + Tablet)
  // Widget _buildStaticDisclaimer() {
  //   return const Padding(
  //     padding: EdgeInsets.all(15),
  //     child: Text(
  //       'We do not charge for hiring!',
  //       textAlign: TextAlign.center,
  //       style: TextStyle(fontSize: 16, color: Colors.black54),
  //     ),
  //   );
  // }

  // 🧱 Styled TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters, // ✅ Added here
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          inputFormatters: inputFormatters, // ✅ Added here
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  // 🗺️ Map Image
  // Widget _buildMapImage(BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final double imageHeight =
  //           Responsive.isMobile(context) ? constraints.maxWidth * 0.8 : 360;

  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const Webviewmap()),
  //           );
  //         },
  //         child: Container(
  //           height: imageHeight,
  //           clipBehavior: Clip.antiAlias,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.3),
  //                 blurRadius: 6,
  //                 spreadRadius: 2,
  //               ),
  //             ],
  //           ),
  //           child: Image.asset(
  //             'assets/img/hospital-map.png',
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildMapImage(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageHeight =
            Responsive.isMobile(context) ? constraints.maxWidth * 0.8 : 360;

        return GestureDetector(
          onTap: () async {
            const url =
                'https://www.google.com/maps/place/Highland+Hospital/@12.8664995,74.8546887,17z/data=!3m1!4b1!4m6!3m5!1s0x3ba35a34c13203f9:0xfb2782cbf31a7784!8m2!3d12.8664995!4d74.8546887!16s%2Fg%2F1thcl645?entry=ttu&g_ep=EgoyMDI1MTEwMi4wIKXMDSoASAFQAw%3D%3D';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open Google Maps')),
              );
            }
          },
          child: Container(
            height: imageHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Image.asset(
              'assets/img/highlandhospitalmap.png',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
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
// End of _ContactsState
}
