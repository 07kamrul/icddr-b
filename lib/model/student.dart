// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.id,
    required this.fullName,
    required this.age,
    required this.date,
    required this.time,
    required this.gender,
    required this.education,
  });

  int? id;
  String fullName;
  int age;
  DateTime date;
  String time;
  String gender;
  String education;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    fullName: json["full_name"],
    age: json["age"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    gender: json["gender"],
    education: json["education"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": jsonEncode(fullName),
    "age": age,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "gender": jsonEncode(gender),
    "education": jsonEncode(education),
  };
}
