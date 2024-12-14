import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_highland/AppUtils.dart';
//import 'package:hms_web_project/presentation/dashboard_screen/model/doctor_model_class.dart';
//import 'package:hms_web_project/presentation/dashboard_screen/model/doctor_timelist_model.dart';
// import 'package:hms_project/model/booking_patient_model.dart';
// import 'package:hms_project/model/doctors_model.dart';
// import 'package:hms_web_project/presentation/dashboard_screen/model/newbooking_model.dart';
import 'package:flutter_highland/AppUtils.dart';
import 'package:http/http.dart' as http;

class Newbookingappointcontroller with ChangeNotifier {
  // PatientDetailsApimodel? patientDetailsModel = PatientDetailsApimodel();
  // Doctorsmodelclass doctorsmodelclass = Doctorsmodelclass();
  //DoctorTimelistModel doctorTimelistModel = DoctorTimelistModel();
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

  // Future<void> doctors(String? dept) async {
  //   doctorList.clear();
  //   doctorIdList.clear();
  //   String uri = "${AppUtils.baseURL}/department_select.php";
  //   try {
  //     var res = await http
  //         .post(Uri.parse(uri), body: {"departmentidcontroller": dept});
  //     // print(res.body);
  //     var json = await jsonDecode(res.body) as Map<String, dynamic>;
  //     doctorsmodelclass = Doctorsmodelclass.fromJson(json);
  //     if (doctorsmodelclass.list!.isNotEmpty) {
  //       for (var i = 0; i < doctorsmodelclass.list!.length; i++) {
  //         // doctorList.add(doctorsmodelclass.list?[i].name ?? "");
  //         // doctorIdList.add(doctorsmodelclass.list?[i].empcode ?? "");
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  // doctorTime(String? empid) async {
  //   timeList.clear();
  //   String uri = "${AppUtils.baseURL}/doctortiming.php";
  //   try {
  //     var res = await http
  //         .post(Uri.parse(uri), body: {"patienttimecontroller": empid});
  //     log(res.body);
  //     // timeList = List<String>.from(await jsonDecode(res.body));
  //     // listOfTimeList.add(List<String>.from(await jsonDecode(res.body)));
  //     // print(timeList);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  // listOfTimes({required String? dept, required String? date}) async {
  //   listOfDoctors.clear();
  //   await doctors(dept);
  //   for (var i = 0; i < doctorsmodelclass.list!.length; i++) {
  //     await doctorTime(doctorsmodelclass.list?[i].empcode);
  //     await doctorTimeSlots(
  //         empid: doctorsmodelclass.list?[i].empcode, dept: dept, date: date);
  //     listOfDoctors.add({
  //       'name': doctorList[i],
  //       'timeslots': List<String>.from(timeList),
  //       'selectedtimes': List<String>.from(selectedtimeList),
  //     });
  // print("------------------${listOfDoctors[i]['name']}");
  // print("------------------${listOfDoctors[i]['timeslots']}");
  // print("------------------${listOfDoctors[i]['selectedtimes']}");
  // print("__________________________$listOfDoctors");
  //   }
  //   notifyListeners();
  // }

  // doctorTimeSlots({
  //   required String? empid,
  //   required String? dept,
  //   required String? date,
  // }) async {
  //   selectedtimeList.clear();
  //   timeList.clear();
  //   String uri = "${AppUtils.baseURL}/booktimeslots.php";
  //   try {
  //     var res = await http.post(Uri.parse(uri), body: {
  //       "doctoridcontroller": empid,
  //       "departmentidcontroller": dept,
  //       "datecontroller": date,
  //     });
  //     print("-------------${res.body}");
  //     Map<String, dynamic> timeSlotMap = await jsonDecode(res.body);
  //     print(timeSlotMap);
  //     // for (var i = 1; i < timeList.length + 2; i++) {
  //     //   if (timeSlotMap.containsKey(i.toString())) {
  //     //     // selectedtimeList.add(timeSlotList[0][i.toString()]);
  //     //     int j = i - 2;
  //     //     // selectedtimeList.add(j.toString());
  //     //     // listOfSelectedTimeList.add(selectedtimeList);
  //     //   }
  //     // }
  //     print("----$selectedtimeList");
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  Future<void> patientdata(String patientId) async {
    notifyListeners();
    // String uri = "${AppUtils.baseURL}/bookingpatient.php";
    // try {
    //   var res = await http.post(Uri.parse(uri), body: {
    //     "patientidcontroller": searchText,
    //   });
    //   var json = await jsonDecode(res.body) as Map<String, dynamic>;
    //   print(json);
    //   patientBookingModel = BookingPatientModel.fromJson(json);
    // } catch (e) {
    //   log(e.toString());
    // }

    // String uri =
    //     "${AppUtils.pythonBaseURL}/get_patient_details/?patientid=$patientId";
    // var res = await http.get(Uri.parse(uri));
    // log("=======================${res.body}");
    // if (res.statusCode == 200) {
    //   var json = await jsonDecode(res.body) as Map<String, dynamic>;
    //   patientDetailsModel = PatientDetailsApimodel.fromJson(json);
    // } else {
    //   patientDetailsModel == null;
    // }

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
    // String uri = "${AppUtils.baseURL}/bookingsave.php";
    // try {
    //   var res = await http.post(Uri.parse(uri), body: {
    //     "patientidcontroller": patientId,
    //     "FirstNamecontroller": fName,
    //     "LastNamecontroller": lName,
    //     "emailcontroller": eMail,
    //     "mobilecontroller": phNum,
    //     "departmentcontroller": dept,
    //     "doctornamecontroller": docId,
    //     "reasoncontroller": reason,
    //     "datecontroller": date,
    //     "timecontroller": time,
    //   });
    //   print("booking : ${res.body}");
    //   isSuccessful = res.statusCode == 200 ? true : false;
    // } catch (e) {
    //   log(e.toString());
    // }

    log('''{
        "patientid": $patientId,
        "firstname": $fName,
        "lastname": $lName,
        "email": $eMail,
        "mobile": $phNum,
        "department": $dept, // Department name, not ID
        "doctor_firstname": $doc_firstname, // Doctor's first name
        "doctor_lastname": $doc_lastname, // Doctor's last name
        "reason": $reason, // Reason for appointment
        "date_book": $date, // Date in YYYY-MM-DD format
        "time_book_start": $start_time, // Start time with AM/PM
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
          "department": dept, // Department name, not ID
          "doctor_firstname": doc_firstname, // Doctor's first name
          "doctor_lastname": doc_lastname, // Doctor's last name
          "reason": reason, // Reason for appointment
          "date_book": date, // Date in YYYY-MM-DD format
          "time_book_start": start_time, // Start time with AM/PM
          // "time_book_end": "09:15 AM" // End time with AM/PM
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

  // bookingTimeSlots({
  //   required String department,
  //   required String firstName,
  //   required String lastName,
  //   required String date,
  // }) async {
  //   print(department);
  //   print(firstName);
  //   print(lastName);
  //   print(date);
  //   timeList.clear();
  //   selectedtimeList.clear();
  //   try {
  //     var url =
  //         "${AppUtils.pythonBaseURL}/slots/$department/$firstName/$lastName/$date/";
  //     final response = await http.get(Uri.parse(url));
  //     print(response.body);
  //     var json = jsonDecode(response.body);
  //     doctorTimelistModel = DoctorTimelistModel.fromJson(json);
  //     log(doctorTimelistModel.slots!.length.toString());
  //     if (doctorTimelistModel.slots!.isNotEmpty) {
  //       for (var slot in doctorTimelistModel.slots!) {
  //         timeList.add(slot.time!);
  //         if (slot.status == "Available") {
  //           selectedtimeList.add(slot.time!);
  //         }
  //       }
  //       log(selectedtimeList.toString());
  //     }
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  // void clearPatientDetails() {
  //   patientDetailsModel = null;
  //   notifyListeners();
  // }

//

  // timeslotBooking({
  //   required String dept,
  //   required String docId,
  // }) async {
  //   String uri = "${AppUtils.baseURL}/booktimeslots.php";
  //   try {
  //     var res = await http.post(Uri.parse(uri), body: {
  //       "departmentcontroller": dept,
  //       "doctornamecontroller": docId,
  //     });
  //     print(res.body);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

//
}
