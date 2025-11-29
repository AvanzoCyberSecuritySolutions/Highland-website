import 'dart:convert';

import 'package:flutter_highland/model/contact_enquiry.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ContactInquiryController with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // IMPORTANT: Replace this with your actual base URL
  final String _baseURL = "http://192.168.220.61:8000/patientapp/api";

  Future<bool> submitContactInquiry(ContactInquiry inquiry) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final url = Uri.parse('$_baseURL/contact-inquiry/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inquiry.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _successMessage = "Your message has been sent successfully!";
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        final errorData = json.decode(response.body);
        _errorMessage =
            errorData['message'] ?? 'Failed to send message. Please try again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage =
          'An error occurred. Please check your connection and try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
