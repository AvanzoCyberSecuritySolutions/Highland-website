// import 'dart:convert';

// PatientDetailsApimodel bookingPatientModelFromJson(String str) =>
//     PatientDetailsApimodel.fromJson(json.decode(str));

// String bookingPatientModelToJson(PatientDetailsApimodel data) =>
//     json.encode(data.toJson());

// class PatientDetailsApimodel {
//   List<ListElement>? list;

//   PatientDetailsApimodel({
//     this.list,
//   });

//   factory PatientDetailsApimodel.fromJson(Map<String, dynamic> json) =>
//       PatientDetailsApimodel(
//         list: json["list"] == null
//             ? []
//             : List<ListElement>.from(
//                 json["list"]!.map((x) => ListElement.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "list": list == null
//             ? []
//             : List<dynamic>.from(list!.map((x) => x.toJson())),
//       };
// }

// class ListElement {
//   String? fname;
//   String? lname;
//   String? doc;
//   String? email;
//   String? phn;
//   String? dep;
//   String? empid;

//   ListElement({
//     this.fname,
//     this.lname,
//     this.doc,
//     this.email,
//     this.phn,
//     this.dep,
//     this.empid,
//   });

//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//         fname: json["fname"],
//         lname: json["lname"],
//         doc: json["doc"],
//         email: json["email"],
//         phn: json["phn"],
//         dep: json["dep"],
//         empid: json["empid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fname": fname,
//         "lname": lname,
//         "doc": doc,
//         "email": email,
//         "phn": phn,
//         "dep": dep,
//         "empid": empid,
//       };
// }

// To parse this JSON data, do

//     final patientDetailsApimodel = patientDetailsApimodelFromJson(jsonString);

import 'dart:convert';

PatientDetailsApimodel patientDetailsApimodelFromJson(String str) =>
    PatientDetailsApimodel.fromJson(json.decode(str));

String patientDetailsApimodelToJson(PatientDetailsApimodel data) =>
    json.encode(data.toJson());

class PatientDetailsApimodel {
  String? firstName;
  String? lastName;
  String? patientId;
  String? doctor;
  dynamic prescription;
  String? mobileNumber;
  DateTime? dateOfBirth;
  String? address;
  String? department;
  String? email;
  dynamic image;
  String? relativeType;
  dynamic relativeContactNumber;
  String? gender;
  String? bloodGroup;

  PatientDetailsApimodel({
    this.firstName,
    this.lastName,
    this.patientId,
    this.doctor,
    this.prescription,
    this.mobileNumber,
    this.dateOfBirth,
    this.address,
    this.department,
    this.email,
    this.image,
    this.relativeType,
    this.relativeContactNumber,
    this.gender,
    this.bloodGroup,
  });

  factory PatientDetailsApimodel.fromJson(Map<String, dynamic> json) =>
      PatientDetailsApimodel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        patientId: json["patient_id"],
        doctor: json["doctor"],
        prescription: json["prescription"],
        mobileNumber: json["mobile_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        address: json["address"],
        department: json["department"],
        email: json["email"],
        image: json["image"],
        relativeType: json["relative_type"],
        relativeContactNumber: json["relative_contact_number"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "patient_id": patientId,
        "doctor": doctor,
        "prescription": prescription,
        "mobile_number": mobileNumber,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "address": address,
        "department": department,
        "email": email,
        "image": image,
        "relative_type": relativeType,
        "relative_contact_number": relativeContactNumber,
        "gender": gender,
        "blood_group": bloodGroup,
      };
}
