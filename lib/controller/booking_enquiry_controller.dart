import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_highland/model/booking_enquiry_model.dart';

import 'package:http/http.dart' as http;

class BookingEnquiryController with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // IMPORTANT: Replace this with your actual base URL
  final String _baseURL = "http://192.168.220.61:8000/patientapp/api";

  Future<bool> submitEnquiry(BookingEnquiry enquiry) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final url = Uri.parse('$_baseURL/appointment-inquiry/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(enquiry.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        _successMessage =
            "Enquiry submitted successfully! Our team will call you back soon.";
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle server errors
        final errorData = json.decode(response.body);
        _errorMessage = errorData['message'] ??
            'Failed to submit enquiry. Please try again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      _errorMessage =
          'An error occurred. Please check your connection and try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
