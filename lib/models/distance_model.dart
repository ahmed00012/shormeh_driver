// To parse this JSON data, do
//
//     final distanceModel = distanceModelFromJson(jsonString);

import 'dart:convert';

DistanceModel distanceModelFromJson(String str) => DistanceModel.fromJson(json.decode(str));

String distanceModelToJson(DistanceModel data) => json.encode(data.toJson());

class DistanceModel {
  DistanceModel({
    this.success,
    this.message,
  });

  String ?success;
  Message? message;

  factory DistanceModel.fromJson(Map<String, dynamic> json) => DistanceModel(
    success: json["success"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message!.toJson(),
  };
}

class Message {
  Message({
    required this.distance,
  });

  int distance;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
  };
}
