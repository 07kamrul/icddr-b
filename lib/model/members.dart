// To parse this JSON data, do
//
//     final member = memberFromJson(jsonString);

import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  Member({
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

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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
    "full_name": fullName,
    "age": age,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "gender": gender,
    "education": education,
  };
}
