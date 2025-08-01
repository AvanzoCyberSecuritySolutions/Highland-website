// To parse this JSON data, do
//
//     final doctorTimelistModel = doctorTimelistModelFromJson(jsonString);

import 'dart:convert';

DoctorTimelistModel doctorTimelistModelFromJson(String str) =>
    DoctorTimelistModel.fromJson(json.decode(str));

String doctorTimelistModelToJson(DoctorTimelistModel data) =>
    json.encode(data.toJson());

class DoctorTimelistModel {
  String? doctor;
  String? department;
  String? date;
  List<Slot>? slots;

  DoctorTimelistModel({
    this.doctor,
    this.department,
    this.date,
    this.slots,
  });

  factory DoctorTimelistModel.fromJson(Map<String, dynamic> json) =>
      DoctorTimelistModel(
        doctor: json["doctor"],
        department: json["department"],
        date: json["date"],
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "doctor": doctor,
        "department": department,
        "date": date,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
      };
}

class Slot {
  String? time;
  String? status;

  Slot({
    this.time,
    this.status,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "status": status,
      };
}
