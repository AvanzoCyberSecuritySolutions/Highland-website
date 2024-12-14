import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highland/AppUtils.dart';
import 'package:flutter_highland/constants/Color_Constant.dart';
//import 'package:hms_web_project/constants/image_constants.dart';
// import 'package:hms_web_project/presentation/dashboard_screen/controller/new_booking_controller.dart';
import 'package:flutter_highland/AppUtils.dart';
import 'package:flutter_highland/newbookingappointcontroller.dart';
import 'package:flutter_highland/newbookings.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class bookappoint_register extends StatefulWidget {
  // const bookappoint_register({super.key, required String firstName, required String lastName, required String email, required String doctor, required String phone, required this.firstName, required this.lastName, required this.email, required this.doctor, required this.phone});

  final String firstName;
  final String lastName;
  final String email;
  final String doctor;
  final String phone;

  const bookappoint_register({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.doctor,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<bookappoint_register> createState() => _bookappoint_registerState();
}

class _bookappoint_registerState extends State<bookappoint_register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstnamecontroller = createUpperCaseController();
  TextEditingController lastnamecontroller = createUpperCaseController();
  TextEditingController dobController = createUpperCaseController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController fatherHusbandNameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController doctorToBeConsultedController = TextEditingController();
  TextEditingController idDocumentProvidedController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController currentdateController = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodGroup;
  String? _selectedMaritalStatus;
  String? _selectedDepartment;
  String? _selectedDoctor;
  String? _selectedDoctorEmpId;
  String? imageName;
  // bool _showPatientCard = false;
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

  final List<String> _doctors = [];

  bool visible = false;

  String? selectedNationality;
  bool showAdditionalFields = false;

  callFuction() async {
    // await Provider.of<BookingPatientController>(context, listen: false)
    //     .department();
    await Provider.of<Newbookingappointcontroller>(context, listen: false)
        .departmentAndDoctorSelection();
  }

  @override
  void initState() {
    super.initState();
    firstnamecontroller = TextEditingController(text: widget.firstName);
    lastnamecontroller = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    doctorToBeConsultedController = TextEditingController(text: widget.doctor);
    phoneNumberController = TextEditingController(text: widget.phone);
    callFuction();
  }

  @override
  void dispose() {
    // Dispose all controllers to free resources
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailController.dispose();
    doctorToBeConsultedController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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

  List<String> fileNames = [];
  List<Uint8List> pickedFiles = [];
  Uint8List? profileImage;
  String? profileName;
  Future<void> pickFile({required bool allowMultiple}) async {
    // ---------------------------------------------File Picker
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   files = File(result.files.single.path!);
    // }
    if (allowMultiple == true) {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: allowMultiple);

      if (result != null && result.files.isNotEmpty) {
        List<Uint8List?> fileBytes = result.files
            .map(
              (path) => path.bytes,
            )
            .toList();
        List<String?> fileName = result.files
            .map(
              (path) => path.name,
            )
            .toList();
        // final fileName = result.files.first.name;
        pickedFiles = List<Uint8List>.from(fileBytes);
        fileNames = List<String>.from(fileName);
        log(fileNames.toString());
        setState(() {
          visible = true;
        });
      }
    } else {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.single.bytes;
        final fileName = result.files.single.name;
        profileImage = fileBytes;
        profileName = fileName;
        log(fileName);
        setState(() {});
      }
    }
    // upload file
    // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
  }

  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final uri = Uri.parse("${AppUtils.baseURL}/test.php");

    // Create MultipartRequest for uploading the image
    var request = http.MultipartRequest('POST', uri);

    // Create MultipartFile from bytes
    var pic = http.MultipartFile.fromBytes(
      'image', // Field name for the image on the server
      imageBytes, // File as byte array
      filename: fileName, // Original file name
    );

    request.files.add(pic); // Add the file to the request

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded Successfully');
    } else {
      print('Image Upload Failed: ${response.statusCode}');
    }
  }

  Future<void> uploadFiles(
      List<Uint8List> files, List<String> fileNames) async {
    final uri = Uri.parse("${AppUtils.baseURL}/testdoc.php");

    var request = http.MultipartRequest('POST', uri);
    log("file length : ${files.length}");
    // Loop through the selected files and add each to the request
    for (int i = 0; i < files.length; i++) {
      // log(i.toString());
      var multipartFile = http.MultipartFile.fromBytes(
        'files[]', // Field name for multiple files on server side
        files[i], // File as bytes (Uint8List)
        filename: fileNames[i], // Original file name
      );
      log("multipart file :${multipartFile.filename}");
      request.files.add(multipartFile);
    }
    log("request : ${request.files}");
    var response = await request.send();

    log(response.statusCode.toString());
    log("after for loop");
    // Send the request

    if (response.statusCode == 200) {
      print('All Files Uploaded Successfully');
    } else {
      print('File Upload Failed: ${response.statusCode}');
    }
  }

  void _showPatientCardDialog() {
    // Retrieve values before clearing the controllers
    // String fullName = "${firstnamecontroller.text} ${lastnamecontroller.text}";
    // String address = addressController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Patient Card",
            style: TextStyle(
                color: ColorConstant.mainBlue, fontWeight: FontWeight.bold),
          ),
          // content: SizedBox(
          //   width: 600,
          //   child: PatientCards(
          //     name: fullName,
          //     patientId: "12345",
          //     address: address,
          //     dateOfRegistration: currentdateController.text,
          //   ),
          // ),
          actions: [
            ElevatedButton(
              onPressed: () {
                print("Print button pressed");

                _clearControllers();

                Navigator.of(context).pop();
              },
              child: Text("Print"),
            ),
          ],
        );
      },
    );

    // Clear the controllers after showing the dialog
    _clearControllers();
  }

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
    departmentController.clear();
    genderController.clear();
    bloodGroupController.clear();
    maritalStatusController.clear();
    remarkscontroller.clear();
    selectedRelationship = null;
    contactController.clear();
    // _selectedDoctorEmpId = null;
  }

  Future<void> insertrecord() async {
    try {
      String uri = "${AppUtils.pythonBaseURL}/add_patient_registration-post/";
      // var res = await http.post(Uri.parse(uri), body: {
      //   "firstname": firstnamecontroller.text.trim(),
      //   "lastname": lastnamecontroller.text.trim(),
      //   "dob": dobController.text.trim(),
      //   "occupationController": occupationController.text.trim(),
      //   "fatherHusbandNameController": fatherHusbandNameController.text.trim(),
      //   "nationalityController": nationalityController.text.trim(),
      //   "addressController": addressController.text.trim(),
      //   "phoneNumberController": phoneNumberController.text.trim(),
      //   "mobileController": mobileController.text.trim(),
      //   "emailController": emailController.text.trim(),
      //   "empcode": _selectedDoctorEmpId,
      //   "idDocumentProvidedController":
      //       idDocumentProvidedController.text.trim(),
      //   "departmentController": departmentController.text.trim(),
      //   "genderController": genderController.text.trim(),
      //   "bloodGroupController": bloodGroupController.text.trim(),
      //   "maritalStatusController": maritalStatusController.text.trim(),
      //   "remarkscontroller": remarkscontroller.text.trim(),
      //   "imagecontroller": imageName ?? '',
      //   "relativetypecontroller": selectedRelationship,
      //   "relativecontactnumbercontroller": contactController.text.trim(),
      // });
      log(dobController.text.trim());
      log(firstnamecontroller.text.trim());
      log(lastnamecontroller.text.trim());
      log(_selectedDepartment.toString());
      log(emailController.text.trim());
      log(phoneNumberController.text.trim());
      log(genderController.text.trim());
      log(occupationController.text.trim());
      log(bloodGroupController.text.trim());
      log(maritalStatusController.text.trim());
      log(addressController.text.trim());
      log(mobileController.text.trim());
      log(selectedNationality ?? '');
      log(idDocumentProvidedController.text.trim());
      log(remarkscontroller.text.trim());
      log(selectedRelationship.toString());
      log(_selectedDoctor.toString());

// -----------------------------------------
      final headers = {'Content-Type': 'application/json'};
      var res = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode(
          {
            "firstname": firstnamecontroller.text.trim(),
            "lastname": lastnamecontroller.text.trim(),
            "department": _selectedDepartment,
            "dob": dobController.text.trim(),
            "email": emailController.text.trim(),
            "phnumber": phoneNumberController.text.trim(),
            "gender": genderController.text.trim(),
            "occupation": occupationController.text.trim(),
            "bloodgroup": bloodGroupController.text.trim(),
            "maritialstatus": maritalStatusController.text.trim(),
            "address": addressController.text.trim(),
            "mobnumber": mobileController.text.trim(),
            "nationality": selectedNationality,
            "documentsubmitted": idDocumentProvidedController.text.trim(),
            "relativetype": selectedRelationship?.toUpperCase(),
            "remarks": remarkscontroller.text.trim(),
            "docname": _selectedDoctor
          },

          // {
          //   "firstname": "maxx",
          //   "lastname": "Doe",
          //   "department": "Cardiology",
          //   "dob": "1990-01-01",
          //   "email": "johndoe123@gmail.com",
          //   "phnumber": "1234567890",
          //   "gender": "Male",
          //   "occupation": "Engineer",
          //   "bloodgroup": "O+",
          //   "maritialstatus": "Single",
          //   "address": "23 Street Name",
          //   "mobnumber": "9876543210",
          //   "nationality": "Indian",
          //   "documentsubmitted": "Passport",
          //   "relativetype": "sibling",
          //   "remarks": "nothing",
          //   "docname": "Smrithi"
          // },
        ),
      );

// -----------------------------------
      if (res.statusCode == 201) {
        print("Record inserted");
        // await uploadImage(profileImage!, profileName!);
        // await uploadFiles(pickedFiles, fileNames);
        _showPatientCardDialog();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomePage()),
        //     (route) => false);
      } else {
        print("Failed to insert record");
        log(res.statusCode.toString());
      }
    } catch (e) {
      log("exception :$e");
    }
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 7) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
// --------------------------

  String? _validateNatnotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // Format the date
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    currentdateController.text = formattedDate;
    var functionprovider =
        Provider.of<Newbookingappointcontroller>(context, listen: false);
    var varprovider = Provider.of<Newbookingappointcontroller>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Patient Registration"),
          backgroundColor:
              Color(0xFF1BA08F), // You can customize the app bar color
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await pickFile(allowMultiple: false);
                        },
                        child: Container(
                          height: 100, width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          // backgroundImage: profileImage != null
                          //     ?
                          //     : null,
                          clipBehavior: Clip.antiAlias,
                          child: profileImage == null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 50,
                                )
                              : Image.memory(profileImage!,
                                  fit: BoxFit.scaleDown),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: firstnamecontroller,
                      decoration: InputDecoration(
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                    const SizedBox(height: 16.0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nationality',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('Indian'),
                                value: 'Indian',
                                groupValue: selectedNationality,
                                onChanged: (value) {
                                  setState(() {
                                    selectedNationality = value;
                                    showAdditionalFields = false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('Foreigner'),
                                value: 'Foreigner',
                                groupValue: selectedNationality,
                                onChanged: (value) {
                                  setState(() {
                                    selectedNationality = value;
                                    showAdditionalFields = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (showAdditionalFields) ...[
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Upload Hospital Invitation',
                              prefixIcon: Icon(Icons.upload_file),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: _validateNotEmpty,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Upload Passport',
                              prefixIcon: Icon(Icons.upload_file),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: _validateNotEmpty,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Upload Medical Visa',
                              prefixIcon: Icon(Icons.upload_file),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: _validateNotEmpty,
                          ),
                        ],
                        // SizedBox(height: 30),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState?.validate() ?? false) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content: Text('Form submitted successfully!')),
                        //       );
                        //     }
                        //   },
                        //   child: Text('Submit'),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
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
                      items: relationshipList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
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
                  ],
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ));
  }
}

// PatientCards widget
// class PatientCards extends StatelessWidget {
//   final String name;
//   final String patientId;
//   final String address;
//   final String dateOfRegistration;

//   const PatientCards({
//     Key? key,
//     required this.name,
//     required this.patientId,
//     required this.address,
//     required this.dateOfRegistration,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(20),
//         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         constraints: BoxConstraints(maxWidth: 600), // Set max width constraint
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white,
//               Color(0xFFADD8E6), // Using the custom color
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 4,
//               blurRadius: 6,
//               offset: Offset(0, 3),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     // children: [
//                     //   buildPatientDetailRow("Name :", name),
//                     //   buildPatientDetailRow("Patient ID :", patientId),
//                     //   buildPatientDetailRow("Address :", address),
//                     //   buildPatientDetailRow(
//                     //       "Date of registration :", dateOfRegistration),
//                     // ],
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   height: 150,
//                   width: 150,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(
//                           'assets/img/highlandlogo.jpeg'), // Correct asset path
//                       fit: BoxFit.fill,
//                     ),
//                     border: Border.all(color: Colors.black12, width: 2),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           "assets/images/qr-code.png"), // Ensure this path is correct
//                       fit: BoxFit.contain,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.withOpacity(0.5)),
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       buildDivider(),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(Icons.phone, color: ColorConstant.mainBlue),
//                           SizedBox(width: 10),
//                           Text(
//                             '+1 234 567 890', // Replace with actual phone number
//                             style:
//                                 TextStyle(color: Colors.black87, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(Icons.email, color: ColorConstant.mainBlue),
//                           SizedBox(width: 10),
//                           Text(
//                             'info@highlandhospital.com', // Replace with actual email
//                             style:
//                                 TextStyle(color: Colors.black87, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       buildDivider(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
// );
// }

// Widget buildPatientDetailRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Row(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(width: 10),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget buildDivider() {
  return Container(
    height: 2,
    width: double.infinity,
    color: ColorConstant.mainOrange,
  );
}

  // Widget _buildTextField(String label, {TextEditingController? controller, String? Function(String?)? validator}) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       prefixIcon: const Icon(Icons.edit),
  //       filled: true,
  //       fillColor: Colors.white.withOpacity(0.8),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //     validator: validator ?? _validateNotEmpty,
  //   );
  // }

