// lib/models/booking_enquiry_model.dart

import 'dart:convert';

class BookingEnquiry {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String address; // This will be used for the message/enquiry

  BookingEnquiry({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.address,
  });

  // Converts the Dart object to a JSON map for the API request
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'address': address, // The 'address' field maps to your message
    };
  }
}
