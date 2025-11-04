import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highland/already_registered.dart';
import 'package:flutter_highland/apputils.dart';
// Ensure these imports are correct for your project structure

import 'package:flutter_highland/constants/color_constant.dart';

// Or the correct navigation target
import 'package:flutter_highland/newbooking_appoint_controller.dart';
import 'package:flutter_highland/responsive.dart'; // Import the Responsive widget

import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class New_register2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String phone;

  const New_register2({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<New_register2> createState() => _New_register2State();
}

class _New_register2State extends State<New_register2> {
  final _formKey = GlobalKey<FormState>();

  // --- Controllers (As provided in your code) ---
  TextEditingController firstnamecontroller = createUpperCaseController();
  TextEditingController lastnamecontroller = createUpperCaseController();
  TextEditingController dobController =
      createUpperCaseController(); // Keep as is if intended
  TextEditingController occupationController = TextEditingController();
  TextEditingController fatherHusbandNameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController doctorToBeConsultedController = TextEditingController();
  TextEditingController idDocumentProvidedController = TextEditingController();
  TextEditingController departmentController =
      TextEditingController(); // Keep if used
  TextEditingController genderController =
      TextEditingController(); // Keep if used
  TextEditingController bloodGroupController =
      TextEditingController(); // Keep if used
  TextEditingController maritalStatusController =
      TextEditingController(); // Keep if used
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController currentdateController = TextEditingController();

  // --- State Variables (As provided in your code) ---
  String? _selectedGender;
  String? _selectedBloodGroup;
  String? _selectedMaritalStatus;
  String? _selectedDepartment;
  String? _selectedDoctor;
  String? _selectedDoctorEmpId;
  String? imageName; // Keep if used
  bool _termsAccepted = false;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  final List<String> _maritalStatuses = [
    'Single',
    'Married',
    'Divorced',
    'Widowed'
  ];
  String? selectedRelationship;
  final List<String> relationshipList = [
    'Parent',
    'Sibling',
    'Spouse',
    'Son',
    'Daughter',
    'Relative',
    'Friend',
    'Other',
  ];

  bool visible = false; // For file upload indicator
  String? selectedNationality; // Keep if used
  bool showAdditionalFields = false; // Keep if used

  List<String> fileNames = [];
  List<Uint8List> pickedFiles = [];
  Uint8List? profileImage;
  String? profileName;

  // --- initState (As provided in your code) ---
  @override
  void initState() {
    super.initState();
    firstnamecontroller = TextEditingController(text: widget.firstName);
    lastnamecontroller = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    addressController = TextEditingController(text: widget.address);
    phoneNumberController = TextEditingController(text: widget.phone);

    // Set current date (only if controller is empty)
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    if (currentdateController.text.isEmpty) {
      currentdateController.text = formattedDate;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      callFuction(); // Fetch initial data after build
    });
  }

  // --- dispose (As provided in your code, ensure all controllers are disposed) ---
  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    dobController.dispose();
    occupationController.dispose();
    fatherHusbandNameController.dispose();
    nationalityController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    mobileController.dispose();
    emailController.dispose();
    doctorToBeConsultedController.dispose();
    idDocumentProvidedController.dispose();
    departmentController.dispose();
    genderController.dispose();
    bloodGroupController.dispose();
    maritalStatusController.dispose();
    remarkscontroller.dispose();
    contactController.dispose();
    currentdateController.dispose();
    super.dispose();
  }

  // --- createUpperCaseController (As provided) ---
  static TextEditingController createUpperCaseController() {
    final controller = TextEditingController();
    controller.addListener(() {
      final text = controller.text.toUpperCase();
      if (controller.text != text) {
        controller.value = controller.value.copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });
    return controller;
  }

  // --- callFuction (As provided) ---
  callFuction() async {
    // Use try-catch for robustness
    try {
      await Provider.of<Newbookingappointcontroller>(context, listen: false)
          .departmentAndDoctorSelection();
    } catch (e) {
      log("Error in callFuction: $e");
      // Handle error appropriately, e.g., show a message
    }
  }

  // --- pickFile (As provided) ---
  Future<void> pickFile({required bool allowMultiple}) async {
    // Using try-catch for error handling during file picking
    try {
      if (allowMultiple == true) {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.any, allowMultiple: allowMultiple);

        if (result != null && result.files.isNotEmpty) {
          // Use map and whereType to safely handle potential nulls
          List<Uint8List> tempBytes = result.files
              .map((file) => file.bytes)
              .whereType<Uint8List>()
              .toList();
          List<String> tempNames = result.files
              .map((file) => file.name)
              .whereType<String>()
              .toList();

          if (tempBytes.length == tempNames.length && tempBytes.isNotEmpty) {
            pickedFiles = tempBytes;
            fileNames = tempNames;
            log(fileNames.toString());
            setState(() {
              visible = true;
            });
          } else {
            log("Mismatch in file bytes and names or empty result.");
          }
        }
      } else {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);
        if (result != null && result.files.isNotEmpty) {
          final fileBytes = result.files.single.bytes;
          final fileName = result.files.single.name;
          if (fileBytes != null && fileName != null) {
            profileImage = fileBytes;
            profileName = fileName;
            log(fileName);
            setState(() {});
          } else {
            log("Picked image file bytes or name is null.");
          }
        }
      }
    } catch (e) {
      log("Error picking file: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error picking file: $e")));
    }
  }

  // --- uploadImage (As provided) ---
  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    // Using the implementation from your code
    final uri = Uri.parse(
        "${AppUtils.baseURL}/test.php"); // Replace with your actual URL
    var request = http.MultipartRequest('POST', uri);
    var pic = http.MultipartFile.fromBytes(
      'image', // Field name expected by server
      imageBytes,
      filename: fileName,
    );
    request.files.add(pic);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image Uploaded Successfully');
      } else {
        print('Image Upload Failed: ${response.statusCode}');
        // Log response body for debugging
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      }
    } catch (e) {
      print("Exception during image upload: $e");
    }
  }

  // --- uploadFiles (As provided) ---
  Future<void> uploadFiles(
      List<Uint8List> files, List<String> fileNames) async {
    // Using the implementation from your code
    final uri = Uri.parse(
        "${AppUtils.baseURL}/testdoc.php"); // Replace with your actual URL
    var request = http.MultipartRequest('POST', uri);
    log("uploadFiles: file count : ${files.length}");

    if (files.length != fileNames.length) {
      print("Error: Mismatch between files and fileNames count.");
      return;
    }

    for (int i = 0; i < files.length; i++) {
      var multipartFile = http.MultipartFile.fromBytes(
        'files[]', // Field name expected by server for multiple files
        files[i],
        filename: fileNames[i],
      );
      log("Adding file to request: ${fileNames[i]}");
      request.files.add(multipartFile);
    }
    // log("Request files: ${request.files.map((f) => f.filename).toList()}"); // Log files added

    try {
      var response = await request.send();
      log("Upload response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print('All Files Uploaded Successfully');
      } else {
        print('File Upload Failed: ${response.statusCode}');
        // Log response body for debugging
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      }
    } catch (e) {
      print("Exception during file upload: $e");
    }
  }

  // --- _showPatientCardDialog (As provided) ---
  void _showPatientCardDialog() {
    // Retrieve values safely
    String fullName = "${firstnamecontroller.text} ${lastnamecontroller.text}";
    String address = addressController.text;
    String regDate = currentdateController.text; // Assuming this holds the date

    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Patient Registered", // Simple title
            style: TextStyle(
                color: ColorConstant.mainBlue, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Name: $fullName'),
                Text('Address: $address'),
                Text('Registration Date: $regDate'),
                const SizedBox(height: 20),
                // --- Placeholder for actual Patient Card ---
                // Replace with your actual PatientCards widget if you have one
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                        child: Text("[Patient Card Placeholder]"))),
                // --- End Placeholder ---
              ],
            ),
          ),
          actions: [
            TextButton(
              // Changed to TextButton for less emphasis
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog first
                _clearControllers(); // Then clear the form
                // Navigate away if needed
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SomeOtherPage()));
              },
              child: const Text('OK & Clear Form'),
            ),
            ElevatedButton(
              onPressed: () {
                print("Print button pressed - (Implement Print Logic Here)");
                // Add your printing logic
                // Optionally close dialog after printing: Navigator.of(context).pop();
              },
              child: const Text("Print Card"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1BA08F), // Theme color
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );

    // Don't clear controllers here, clear them in the dialog's action
  }

  // --- _clearControllers (As provided) ---
  void _clearControllers() {
    firstnamecontroller.clear();
    lastnamecontroller.clear();
    dobController.clear();
    occupationController.clear();
    fatherHusbandNameController.clear();
    nationalityController.clear();
    addressController.clear();
    phoneNumberController.clear();
    mobileController.clear();
    emailController.clear();
    idDocumentProvidedController.clear();
    // Clear Text Controllers used for dropdowns if any (though using state variables is better)
    departmentController.clear();
    genderController.clear();
    bloodGroupController.clear();
    maritalStatusController.clear();
    remarkscontroller.clear();
    contactController.clear();
    // currentdateController.clear(); // Usually keep the current date

    // Reset state variables
    setState(() {
      _selectedGender = null;
      _selectedBloodGroup = null;
      _selectedMaritalStatus = null;
      _selectedDepartment = null;
      _selectedDoctor = null;
      _selectedDoctorEmpId = null; // Reset if used
      selectedRelationship = null;
      selectedNationality = null; // Reset if used
      _termsAccepted = false;
      profileImage = null;
      profileName = null;
      pickedFiles.clear();
      fileNames.clear();
      visible = false; // Hide file indicator
      // Reset provider state if necessary, e.g.
      // Provider.of<Newbookingappointcontroller>(context, listen: false).resetDoctors();
    });
  }

  // --- insertrecord (As provided) ---
  Future<void> insertrecord() async {
    // **Crucial:** Validate form and terms FIRST
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fix the errors in the form.'),
            backgroundColor: Colors.orange),
      );
      return; // Stop submission if form is invalid
    }
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please accept the terms and conditions.'),
            backgroundColor: Colors.orange),
      );
      return; // Stop submission if terms not accepted
    }

    // Proceed with submission
    try {
      String uri =
          "${AppUtils.pythonBaseURL}/add_patient_registration-post/"; // Your API endpoint

      // --- Logging Data Being Sent (Essential for Debugging) ---
      log("--- Submitting Patient Registration ---");
      log("First Name: ${firstnamecontroller.text.trim()}");
      log("Last Name: ${lastnamecontroller.text.trim()}");
      log("DOB: ${dobController.text.trim()}"); // Ensure format matches API (e.g., yyyy-MM-dd)
      log("Gender: ${_selectedGender ?? genderController.text.trim()}"); // Prefer state var
      log("Blood Group: ${_selectedBloodGroup ?? bloodGroupController.text.trim()}"); // Prefer state var
      log("Marital Status: ${_selectedMaritalStatus ?? maritalStatusController.text.trim()}"); // Prefer state var
      log("Department: ${_selectedDepartment ?? departmentController.text.trim()}"); // Prefer state var
      log("Doctor: ${_selectedDoctor ?? doctorToBeConsultedController.text.trim()}"); // Prefer state var
      log("Occupation: ${occupationController.text.trim()}");
      log("Nationality: ${nationalityController.text.trim()}"); // Use text field value
      log("Address: ${addressController.text.trim()}");
      log("Phone: ${phoneNumberController.text.trim()}");
      log("Mobile: ${mobileController.text.trim()}");
      log("Email: ${emailController.text.trim()}");
      log("Relationship: ${selectedRelationship?.toUpperCase()}");
      log("Relative Contact: ${contactController.text.trim()}");
      log("ID Doc: ${idDocumentProvidedController.text.trim()}");
      log("Remarks: ${remarkscontroller.text.trim()}");
      log("Profile Image: ${profileName ?? "None"}");
      log("Documents: ${fileNames.join(', ')}");
      log("------------------------------------");
      // --- End Logging ---

      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        "firstname": firstnamecontroller.text.trim(),
        "lastname": lastnamecontroller.text.trim(),
        // Use state variables for dropdowns if they are reliably updated
        "department": _selectedDepartment,
        "dob": dobController.text
            .trim(), // Make sure format is correct (e.g., yyyy-MM-dd)
        "email": emailController.text.trim(),
        "phnumber": phoneNumberController.text.trim(),
        "gender": _selectedGender, // Send state variable
        "occupation": occupationController.text.trim(),
        "bloodgroup": _selectedBloodGroup, // Send state variable
        "maritialstatus": _selectedMaritalStatus, // Send state variable
        "address": addressController.text.trim(),
        "mobnumber": mobileController.text.trim(),
        "nationality":
            nationalityController.text.trim(), // Send text field value
        "documentsubmitted": idDocumentProvidedController.text.trim(),
        "relativetype":
            selectedRelationship?.toUpperCase(), // Send state variable
        "relativecontact":
            contactController.text.trim(), // Send relative contact
        "remarks": remarkscontroller.text.trim(),
        "docname": _selectedDoctor, // Send state variable
        // Include file info if your backend expects it in the main JSON
        // "profile_image_name": profileName,
        // "document_names": fileNames,
      });

      log("Request Body: $body"); // Log the JSON body

      var res = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: body,
      );

      log("Response Status Code: ${res.statusCode}");
      log("Response Body: ${res.body}"); // Log the raw response body

      if (res.statusCode == 201 || res.statusCode == 200) {
        // Accept 200 OK too
        print("Record inserted/updated successfully");

        // Upload files *after* successful record submission
        bool imageUploadSuccess = true;
        if (profileImage != null && profileName != null) {
          try {
            await uploadImage(profileImage!, profileName!);
          } catch (e) {
            log("Error during profile image upload: $e");
            imageUploadSuccess = false; // Mark as failed, but continue
          }
        }

        bool filesUploadSuccess = true;
        if (pickedFiles.isNotEmpty && fileNames.isNotEmpty) {
          try {
            await uploadFiles(pickedFiles, fileNames);
          } catch (e) {
            log("Error during document upload: $e");
            filesUploadSuccess = false; // Mark as failed, but continue
          }
        }

        _showPatientCardDialog(); // Show success dialog

        // Optionally notify user about upload status
        if (!imageUploadSuccess || !filesUploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Patient registered, but file upload encountered issues.'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 4),
            ),
          );
        }

        // Navigate after showing dialog and clearing (if needed)
        Navigator.pushReplacement(
          // Use pushReplacement to prevent going back to the form
          context,
          MaterialPageRoute(
            builder: (context) => NewBookings(), // Navigate to the target page
          ),
        );
      } else {
        // Handle API error (e.g., show specific error from response body if available)
        String errorMessage =
            "Failed to register patient. Server Error: ${res.statusCode}.";
        try {
          var decodedResponse = jsonDecode(res.body);
          // Try to get a more specific error message from the response
          errorMessage = decodedResponse['message'] ??
              decodedResponse['error'] ??
              errorMessage;
        } catch (_) {
          // Ignore decoding errors, use the default message
        }
        print(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      log("Exception during API call: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred: $e. Please check connection and try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Validation Methods (As provided) ---
  String? _validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use trim()
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    // Consider using a more robust email validation package if needed
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    // Adjust length validation as per requirements
    if (value.trim().length < 7 || value.trim().length > 15) {
      return 'Please enter a valid phone number (7-15 digits)';
    }
    // Optional: Check for digits only
    RegExp phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter digits only';
    }
    return null;
  }

  String? _validateDropdown(String? value) {
    // This validation works for DropdownButtonFormField where `value` is the selected item's value (String in this case)
    if (value == null || value.isEmpty) {
      return 'Please select an option'; // More user-friendly message
    }
    return null;
  }

  // --- _selectDate (As provided, formatting to yyyy-MM-dd is common) ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // Prevent selecting future dates for DOB
    );
    if (picked != null) {
      setState(() {
        // Format consistently, e.g., yyyy-MM-dd is standard for APIs
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // --- _validateNatnotEmpty (Keep if used, same as _validateNotEmpty) ---
  String? _validateNatnotEmpty(String? value) {
    return _validateNotEmpty(value); // Re-use the main validator
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    // Providers can be accessed inside _buildFormContent if needed there

    return Scaffold(
        appBar: AppBar(
          title: const Text("Patient Registration"),
          backgroundColor: Color(0xFF1BA08F),
          foregroundColor: Colors.white,
        ),
        // --- Use Responsive Widget ---
        body: Responsive(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context), // Uses desktop layout by default
          desktop: _buildDesktopLayout(context),
        ));
  }

  // --- Layout Builders ---
  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      // More padding for desktop might look better
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 40.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
              maxWidth: 600), // Adjust max width as desired
          child: _buildFormContent(context),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    // For simplicity, reuse the desktop layout. Or create a custom one.
    return _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0), // Standard mobile padding
      child: _buildFormContent(context), // Form takes full width
    );
  }

  // --- Shared Form Content ---
  Widget _buildFormContent(BuildContext context) {
    // Access providers needed within the form content
    var functionprovider =
        Provider.of<Newbookingappointcontroller>(context, listen: false);
    var varprovider =
        Provider.of<Newbookingappointcontroller>(context); // Listen for changes

    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16.0),
          // --- Profile Image Picker ---
          Center(
            child: GestureDetector(
              onTap: () async => await pickFile(allowMultiple: false),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                    profileImage != null ? MemoryImage(profileImage!) : null,
                child: profileImage == null
                    ? const Icon(Icons.add_a_photo,
                        color: Colors.white, size: 50)
                    : null,
              ),
            ),
          ),
          // --- Display Profile File Name ---
          if (profileName != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  profileName!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: firstnamecontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'First Name',
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
// onChanged: (value) {
//   setState(() {
//     // value = firstnamecontroller.text;
//     // value = value.toUpperCase();
//     // firstnamecontroller.text = value;
//     firstnamecontroller.text =
//         firstnamecontroller.text.toUpperCase();
//   });
// },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: lastnamecontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Last Name',
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: dobController,
// decoration: const InputDecoration(
//   labelText: 'Date of Birth',
//   border: OutlineInputBorder(),
// ),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 18), // <- Added this
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  labelText: 'DOB',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF1BA08F),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: _validateNotEmpty,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Gender',
              prefixIcon: Icon(
                Icons.wc,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: _genders.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
                genderController.text = newValue ?? '';
              });
            },
            validator: _validateDropdown,
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedBloodGroup,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Blood Group',
              prefixIcon: Icon(
                Icons.invert_colors,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: _bloodGroups.map((String bloodGroup) {
              return DropdownMenuItem<String>(
                value: bloodGroup,
                child: Text(bloodGroup),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedBloodGroup = newValue;
                bloodGroupController.text = newValue ?? '';
              });
            },
            validator: _validateDropdown,
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedMaritalStatus,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Marital status',
              prefixIcon: Icon(
                Icons.group,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: _maritalStatuses.map((String maritalStatus) {
              return DropdownMenuItem<String>(
                value: maritalStatus,
                child: Text(maritalStatus),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMaritalStatus = newValue;
                maritalStatusController.text = newValue ?? '';
              });
            },
            validator: _validateDropdown,
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
              value: _selectedDepartment,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 18), // <- Added this
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                labelText: 'Department',
                prefixIcon: Icon(
                  Icons.business_center,
                  color: Color(0xFF1BA08F),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: varprovider.deptList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) async {
                setState(() {
                  _selectedDepartment = newValue;
                });
// _doctors.clear();
// await functionprovider.doctors(_selectedDepartment);
// if (varprovider.doctorsmodelclass.list!.isNotEmpty) {
//   for (var i = 0;
//       i < varprovider.doctorsmodelclass.list!.length;
//       i++) {
//     _doctors.add(
//         varprovider.doctorsmodelclass.list?[i].name ??
//             "");
//   }
// }
                await functionprovider.departmentAndDoctorSelection(
                    dept: _selectedDepartment);
                _selectedDoctor = varprovider.doctorList[0];
// _selectedDoctor = _doctors[0];
// _selectedDoctorEmpId =
//     varprovider.doctorsmodelclass.list?[0].empcode ?? "";
                print(_selectedDoctor);
              }),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedDoctor,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Doctor',
              prefixIcon: Icon(
                Icons.medical_services,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: varprovider.doctorList.map((String doctor) {
              return DropdownMenuItem<String>(
                value: doctor,
                child: Text(doctor),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              setState(() {});
              _selectedDoctor = newValue;
// doctorToBeConsultedController.text = newValue ?? '';

              int itemid = 0;
              await functionprovider.departmentAndDoctorSelection(
                  dept: _selectedDepartment);
              // await functionprovider.doctors(_selectedDepartment);
              // for (var i = 0; i < _doctors.length; i++) {
              //   if (_doctors[i] == newValue) {
              //     itemid = i;
              //   }
              // }
              // _selectedDoctorEmpId = _doctors[itemid];
              setState(() {});
            },
            validator: _validateDropdown,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: occupationController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Occupation',
              prefixIcon: Icon(
                Icons.work,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),
          const SizedBox(height: 16.0),
          // TextFormField(
          //   controller: fatherHusbandNameController,
          //   decoration: InputDecoration(
          //     contentPadding:
          //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     labelText: 'Father/Husband Name/Relative',
          //     prefixIcon: Icon(
          //       Icons.family_restroom,
          //       color: ColorConstants.mainBlue,
          //     ),
          //     filled: true,
          //     fillColor: Colors.white.withOpacity(0.8),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //   ),
          //   validator: _validateNotEmpty,
          // ),
          // ------------------------------------------

          // DropdownButtonFormField<String>(
          //   value: selectedRelationship,
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedRelationship = newValue;
          //     });
          //   },
          //   items: relationshipList
          //       .map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   decoration: InputDecoration(
          //     contentPadding:
          //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     border: OutlineInputBorder(),
          //     labelText: 'Relationship',
          //     prefixIcon: Icon(
          //       Icons.family_restroom,
          //       color: Color(0xFF1BA08F),
          //     ),
          //     filled: true,
          //     fillColor: Colors.white.withOpacity(0.8),
          //   ),
          // ),
          // const SizedBox(height: 16.0),

          // TextFormField(
          //   controller: contactController,
          //   decoration: InputDecoration(
          //     contentPadding:
          //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     labelText: 'contact number',
          //     prefixIcon: Icon(
          //       Icons.phone,
          //       color: Color(0xFF1BA08F),
          //     ),
          //     filled: true,
          //     fillColor: Colors.white.withOpacity(0.8),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //   ),
          //   validator: _validatePhoneNumber,
          // ),

          // TextFormField(
          //   controller: nationalityController,
          //   decoration: InputDecoration(
          //     contentPadding:
          //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     labelText: 'Nationality',
          //     prefixIcon: Icon(
          //       Icons.flag,
          //       color: ColorConstants.mainBlue,
          //     ),
          //     filled: true,
          //     fillColor: Colors.white.withOpacity(0.8),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //   ),
          //   validator: _validateNotEmpty,
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Text(
          //     //   'Nationality',
          //     //   style: TextStyle(
          //     //       fontSize: 16, fontWeight: FontWeight.bold),
          //     // ),
          //     // Row(
          //     //   children: [
          //     //     // Expanded(
          //     //     //   child: RadioListTile<String>(
          //     //     //     title: Text('Indian'),
          //     //     //     value: 'Indian',
          //     //     //     groupValue: selectedNationality,
          //     //     //     onChanged: (value) {
          //     //     //       setState(() {
          //     //     //         selectedNationality = value;
          //     //     //         showAdditionalFields = false;
          //     //     //       });
          //     //     //     },
          //     //     //   ),
          //     //     // ),
          //     //     // Expanded(
          //     //     //   child: RadioListTile<String>(
          //     //     //     title: Text('Foreigner'),
          //     //     //     value: 'Foreigner',
          //     //     //     groupValue: selectedNationality,
          //     //     //     onChanged: (value) {
          //     //     //       setState(() {
          //     //     //         selectedNationality = value;
          //     //     //         showAdditionalFields = true;
          //     //     //       });
          //     //     //     },
          //     //     //   ),
          //     //     // ),
          //     //   ],
          //     // ),
          //     // if (showAdditionalFields) ...[
          //     //   SizedBox(height: 20),
          //     //   TextFormField(
          //     //     decoration: InputDecoration(
          //     //       labelText: 'Upload Hospital Invitation',
          //     //       prefixIcon: Icon(Icons.upload_file),
          //     //       filled: true,
          //     //       fillColor: Colors.white.withOpacity(0.8),
          //     //       border: OutlineInputBorder(
          //     //         borderRadius: BorderRadius.circular(8.0),
          //     //       ),
          //     //     ),
          //     //     validator: _validateNotEmpty,
          //     //   ),
          //     //   SizedBox(height: 20),
          //     //   TextFormField(
          //     //     decoration: InputDecoration(
          //     //       labelText: 'Upload Passport',
          //     //       prefixIcon: Icon(Icons.upload_file),
          //     //       filled: true,
          //     //       fillColor: Colors.white.withOpacity(0.8),
          //     //       border: OutlineInputBorder(
          //     //         borderRadius: BorderRadius.circular(8.0),
          //     //       ),
          //     //     ),
          //     //     validator: _validateNotEmpty,
          //     //   ),
          //     //   SizedBox(height: 20),
          //     //   TextFormField(
          //     //     decoration: InputDecoration(
          //     //       labelText: 'Upload Medical Visa',
          //     //       prefixIcon: Icon(Icons.upload_file),
          //     //       filled: true,
          //     //       fillColor: Colors.white.withOpacity(0.8),
          //     //       border: OutlineInputBorder(
          //     //         borderRadius: BorderRadius.circular(8.0),
          //     //       ),
          //     //     ),
          //     //     validator: _validateNotEmpty,
          //     //   ),
          //     // ],
          //     // SizedBox(height: 30),
          //     // ElevatedButton(
          //     //   onPressed: () {
          //     //     if (_formKey.currentState?.validate() ?? false) {
          //     //       ScaffoldMessenger.of(context).showSnackBar(
          //     //         SnackBar(
          //     //             content: Text('Form submitted successfully!')),
          //     //       );
          //     //     }
          //     //   },
          //     //   child: Text('Submit'),
          //     // ),
          //   ],
          // ),
          // const SizedBox(height: 16.0),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Nationality',
              prefixIcon: Icon(
                Icons.flag,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            //controller: addressController,
            enabled: false, // Disable the TextField input
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Upload Hospital Invitation',
              prefixIcon: Icon(
                Icons.file_upload,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            //controller: addressController,
            enabled: false, // Disable the TextField input
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Upload Passport',
              prefixIcon: Icon(
                Icons.book,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            // controller: addressController,
            enabled: false, // Disable the TextField input
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Upload Medical Visa',
              prefixIcon: Icon(
                Icons.airplane_ticket,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Address',
              prefixIcon: Icon(
                Icons.home,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Phone Number',
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validatePhoneNumber,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: mobileController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Mobile',
              prefixIcon: Icon(
                Icons.phone_android,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validatePhoneNumber,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateEmail,
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: selectedRelationship,
            onChanged: (String? newValue) {
              setState(() {
                selectedRelationship = newValue;
              });
            },
            items:
                relationshipList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              border: OutlineInputBorder(),
              labelText: 'Relationship',
              prefixIcon: Icon(
                Icons.family_restroom,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16.0),

          TextFormField(
            controller: contactController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'contact number',
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validatePhoneNumber,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: idDocumentProvidedController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Identification Document provided',
              prefixIcon: Icon(
                Icons.badge,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: remarkscontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Remarks',
              prefixIcon: Icon(
                Icons.note,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: _validateNotEmpty,
          ),
          const SizedBox(height: 16.0),

          TextFormField(
            controller: currentdateController,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 18), // <- Added this
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: '',
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Color(0xFF1BA08F),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            // validator: _validateEmail,
          ),

          Visibility(
            visible: visible,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/file.png",
                    height: MediaQuery.sizeOf(context).height * .1,
                  ),
                ),
                Text(fileNames.length > 1
                    ? "${fileNames[0]}.etc."
                    : fileNames.length > 0
                        ? fileNames[0]
                        : ""),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: InkWell(
              onTap: () async {
                pickFile(allowMultiple: true);
              },
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * .5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF1BA08F),
                ),
                alignment: Alignment.center,
                child: const Text("Upload files"),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("I accept the terms and conditions"),
            value: _termsAccepted,
            onChanged: (bool? value) {
              setState(() {
                _termsAccepted = value ?? false;
              });
            },
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _termsAccepted
                      ? const Color(0xff0ea69f)
                      : const Color(0xff8d8d8d),
                ),
              ),
              onPressed: _termsAccepted
                  ? () async {
                      // Perform your record insertion logic
                      await insertrecord();

                      // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewBookings(), // Replace with your next page widget
                        ),
                      );
                    }
                  : null, // Disable button when terms are not accepted
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]));
  }
}

// --- Helper for Input Decoration (Optional but cleans up code) ---
InputDecoration _inputDecoration(
    {required String label, required IconData icon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
        vertical: 18, horizontal: 20), // Consistent padding
    labelText: label,
    prefixIcon: Icon(icon, color: Color(0xFF1BA08F)),
    filled: true,
    fillColor: Colors.white.withOpacity(0.8), // Your fill color
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade300) // Softer border
        ),
    enabledBorder: OutlineInputBorder(
      // Border when enabled
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      // Border when focused
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color: Color(0xFF1BA08F), width: 1.5), // Highlight focus
    ),
    errorBorder: OutlineInputBorder(
      // Border on error
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      // Border on error + focus
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
    ),
  );
}

Widget buildDivider() {
  return Container(
    height: 2,
    width: double.infinity,
    color: ColorConstant.mainOrange,
  );
}
// End of _New_register2State

// --- Helper Widget (Keep if used elsewhere, like in Patient Card Dialog) ---
/*
Widget buildDivider() {
  return Container(
    height: 2,
    width: double.infinity,
    // Ensure ColorConstant.mainOrange is defined if you use this
    color: ColorConstant.mainOrange,
  );
}
*/
