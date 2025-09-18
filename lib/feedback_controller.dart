import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_highland/AppUtils.dart';
import 'package:flutter_highland/sample_view_feedback_api_model.dart.dart';

import 'package:http/http.dart' as http;

class FeedbackController with ChangeNotifier {
  List<SampleViewfeedbackApimodel> viewfeedbackList = [];
  List deptwiseFeedbackList = [];

  Future<int> feedbackSaving({
    required String patientid,
    required String name,
    required String email,
    required String phn,
    required String feedback,
    required String date,
  }) async {
    int statusCode = 0;
    String uri = "${AppUtils.pythonBaseURL}/feedback_response-post/";
    try {
      final res = await http.post(
        Uri.parse(uri),
        body: {
          "patientid": patientid,
          "name": name,
          "mobile": phn,
          "response": feedback,
          "date_reg": date,
          "mail_reg": email,
        },
      );

      if (res.statusCode == 201) {
        log("Feedback saved successfully: ${res.body}");
        statusCode = res.statusCode;
      } else {
        log("Failed to save feedback. Status code: ${res.statusCode}");
        return 0;
      }
    } catch (e) {
      log("Error saving feedback: $e");
    }
    notifyListeners();
    return statusCode;
  }

  Future<void> datePassing({required String date}) async {
    String uri = "${AppUtils.baseURL}/feedbackview.php";
    try {
      final res = await http.post(
        Uri.parse(uri),
        body: {'datecontroller': date},
      );

      if (res.statusCode == 200) {
        viewfeedbackList = (jsonDecode(res.body) as List)
            .map((json) => SampleViewfeedbackApimodel.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        log("Failed to fetch feedback list. Status code: ${res.statusCode}");
      }
    } catch (e) {
      log("Error fetching feedback list: $e");
    }
  }

  Future<void> feedbackReturnresponse({
    required String response,
    required String feedbackid,
    required String approvedby,
    required String date,
  }) async {
    String uri = "${AppUtils.baseURL}/feedbackresponse.php";
    try {
      final res = await http.post(
        Uri.parse(uri),
        body: {
          'datecontroller': date,
          'responsebackcontroller': response,
          'feedbackidcontroller': feedbackid,
          'approvedbycontroller': approvedby,
        },
      );

      if (res.statusCode == 200) {
        log("Feedback response saved: ${res.body}");
      } else {
        log("Failed to save feedback response. Status code: ${res.statusCode}");
      }
    } catch (e) {
      log("Error saving feedback response: $e");
    }
  }
}
