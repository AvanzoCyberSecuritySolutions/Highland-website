import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_highland/AppUtils.dart';
import 'package:flutter_highland/doctors_modelclass.dart';
import 'package:flutter_highland/doctortimelist_model.dart';

// ▼▼▼ CORRECTED IMPORTS ▼▼▼

import 'package:flutter_highland/patientdetail_apimodel.dart';
// ▲▲▲ CORRECTED IMPORTS ▲▲▲

import 'package:http/http.dart' as http;

class BookingPatientController with ChangeNotifier {
  // Your existing controller code...
  // ... (No changes to the logic, only imports were fixed)
  PatientDetailsApimodel? patientDetailsModel = PatientDetailsApimodel();
  Doctorsmodelclass doctorsmodelclass = Doctorsmodelclass();
  DoctorTimelistModel doctorTimelistModel = DoctorTimelistModel();
  List<String> deptList = [];
  List<String> doctorList = [];
  List<String> doctorIdList = [];

  List<String> timeList = [];
  List<Map<String, dynamic>> listOfDoctors = [];

  List<String> selectedtimeList = [];
  bool? isSuccessful;

  department() async {
    deptList.clear();
    listOfDoctors.clear();
    String uri = "${AppUtils.baseURL}/departments.php";
    try {
      var res = await http.get(Uri.parse(uri));
      deptList = List<String>.from(await jsonDecode(res.body));
      print(deptList);
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> doctors(String? dept) async {
    doctorList.clear();
    doctorIdList.clear();
    String uri = "${AppUtils.baseURL}/department_select.php";
    try {
      var res = await http
          .post(Uri.parse(uri), body: {"departmentidcontroller": dept});
      // print(res.body);
      var json = await jsonDecode(res.body) as Map<String, dynamic>;
      doctorsmodelclass = Doctorsmodelclass.fromJson(json);
      if (doctorsmodelclass.list!.isNotEmpty) {
        for (var i = 0; i < doctorsmodelclass.list!.length; i++) {
          // doctorList.add(doctorsmodelclass.list?[i].name ?? "");
          // doctorIdList.add(doctorsmodelclass.list?[i].empcode ?? "");
        }
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  doctorTime(String? empid) async {
    timeList.clear();
    String uri = "${AppUtils.baseURL}/doctortiming.php";
    try {
      var res = await http
          .post(Uri.parse(uri), body: {"patienttimecontroller": empid});
      log(res.body);
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  listOfTimes({required String? dept, required String? date}) async {
    listOfDoctors.clear();
    await doctors(dept);
    for (var i = 0; i < doctorsmodelclass.list!.length; i++) {
      await doctorTime(doctorsmodelclass.list?[i].empcode);
      await doctorTimeSlots(
          empid: doctorsmodelclass.list?[i].empcode, dept: dept, date: date);
      listOfDoctors.add({
        'name': doctorList[i],
        'timeslots': List<String>.from(timeList),
        'selectedtimes': List<String>.from(selectedtimeList),
      });
      print("__________________________$listOfDoctors");
    }
    notifyListeners();
  }

  doctorTimeSlots({
    required String? empid,
    required String? dept,
    required String? date,
  }) async {
    selectedtimeList.clear();
    timeList.clear();
    String uri = "${AppUtils.baseURL}/booktimeslots.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "doctoridcontroller": empid,
        "departmentidcontroller": dept,
        "datecontroller": date,
      });
      print("-------------${res.body}");
      Map<String, dynamic> timeSlotMap = await jsonDecode(res.body);
      print(timeSlotMap);
      print("----$selectedtimeList");
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> patientdata(String patientId) async {
    notifyListeners();
    String uri =
        "${AppUtils.pythonBaseURL}/get_patient_details/?patientid=$patientId";
    var res = await http.get(Uri.parse(uri));
    log("=======================${res.body}");
    if (res.statusCode == 200) {
      var json = await jsonDecode(res.body) as Map<String, dynamic>;
      patientDetailsModel = PatientDetailsApimodel.fromJson(json);
    } else {
      patientDetailsModel == null;
    }

    notifyListeners();
  }

  patientBooking({
    required String patientId,
    required String fName,
    required String lName,
    required String eMail,
    required String phNum,
    required String dept,
    required String doc_firstname,
    required String doc_lastname,
    required String reason,
    required String date,
    required String start_time,
  }) async {
    log('''{
        "patientid": $patientId,
        "firstname": $fName,
        "lastname": $lName,
        "email": $eMail,
        "mobile": $phNum,
        "department": $dept, 
        "doctor_firstname": $doc_firstname, 
        "doctor_lastname": $doc_lastname, 
        "reason": $reason, 
        "date_book": $date, 
        "time_book_start": $start_time, 
      }''');

    try {
      String url = "${AppUtils.pythonBaseURL}/booking_appointment/";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "patientid": patientId,
          "firstname": fName,
          "lastname": lName,
          "email": eMail,
          "mobile": phNum,
          "department": dept,
          "doctor_firstname": doc_firstname,
          "doctor_lastname": doc_lastname,
          "reason": reason,
          "date_book": date,
          "time_book_start": start_time,
        },
      );
      log(response.body);
      isSuccessful = response.statusCode == 201 ? true : false;
    } on Exception catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  departmentAndDoctorSelection({String? dept}) async {
    if (dept == null || dept.isEmpty) {
      deptList.clear();
      doctorList.clear();
      selectedtimeList.clear();
      timeList.clear();
      try {
        final String url = '${AppUtils.pythonBaseURL}/departments/';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          log(response.body);
          deptList = (jsonDecode(response.body) as List<dynamic>).map((json) {
            return json['department'] as String;
          }).toList();
          log(deptList.toString());
          log(dept ?? '');
        }
      } on Exception catch (e) {
        log(e.toString());
      }
      notifyListeners();
    } else {
      doctorList.clear();
      selectedtimeList.clear();

      try {
        final String url =
            '${AppUtils.pythonBaseURL}/departments/$dept/doctors/';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          log(response.body);
          List<dynamic> responseData = jsonDecode(response.body);
          doctorList = responseData.map((item) {
            return '${item['firstname']?.trim() ?? ''} ${item['lastname']?.trim() ?? ''}';
          }).toList();
          log(doctorList.toString());
        }
      } on Exception catch (e) {
        log(e.toString());
      }
      notifyListeners();
    }
    notifyListeners();
  }

  bookingTimeSlots({
    required String department,
    required String firstName,
    required String lastName,
    required String date,
  }) async {
    print(department);
    print(firstName);
    print(lastName);
    print(date);
    timeList.clear();
    selectedtimeList.clear();
    try {
      var url =
          "${AppUtils.pythonBaseURL}/slots/$department/$firstName/$lastName/$date/";
      final response = await http.get(Uri.parse(url));
      print(response.body);
      var json = jsonDecode(response.body);
      doctorTimelistModel = DoctorTimelistModel.fromJson(json);
      log(doctorTimelistModel.slots!.length.toString());
      if (doctorTimelistModel.slots!.isNotEmpty) {
        for (var slot in doctorTimelistModel.slots!) {
          timeList.add(slot.time!);
          if (slot.status == "Available") {
            selectedtimeList.add(slot.time!);
          }
        }
        log(selectedtimeList.toString());
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  void clearPatientDetails() {
    patientDetailsModel = null;
    notifyListeners();
  }
}
