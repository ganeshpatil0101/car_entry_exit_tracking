import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CarEntryData {
  final String regNum;
  final int kmIn;
  final String dateIn;
  final String createdDate;
  final String createdBy;
  final String carInComment;
  final String model;
  final String serviceType;
  final String carExitComment;
  final String carExitBy;

  DocumentReference reference;
  final String status;
  int kmOut;
  String outDate;

  CarEntryData(
      {@required this.regNum,
      @required this.kmIn,
      @required this.dateIn,
      @required this.createdDate,
      @required this.createdBy,
      @required this.carInComment,
      @required this.model,
      @required this.serviceType,
      @required this.status,
      this.kmOut,
      this.outDate,
      this.carExitComment,
      this.carExitBy});

  static fromSnapshot(DocumentSnapshot document) {
    CarEntryData data = CarEntryData.fromJson(document.data);
    data.reference = document.reference;
    return data;
  }

  factory CarEntryData.fromJson(Map<String, dynamic> json) {
    return CarEntryData(
        regNum: json['regnum'],
        kmIn: json['kmIn'],
        dateIn: json['dateIn'],
        createdDate: json['createdDate'],
        createdBy: json['createdBy'],
        model: json['model'],
        serviceType: json["servicetype"],
        carInComment: json["comment"],
        status: json["status"],
        kmOut: json["kmOut"],
        outDate: json["outDate"],
        carExitComment: json["carExitComment"],
        carExitBy: json['carExitBy']);
  }

  factory CarEntryData.toJson(Map<String, dynamic> json) {
    return CarEntryData(
        regNum: json['regnum'],
        kmIn: json['kmIn'],
        dateIn: json['dateIn'],
        createdDate: json['createdDate'],
        createdBy: json['createdBy'],
        model: json['model'],
        serviceType: json["servicetype"],
        carInComment: json["comment"],
        status: json["status"],
        kmOut: json["kmOut"],
        outDate: json["outDate"],
        carExitComment: json["carExitComment"],
        carExitBy: json['carExitBy']);
  }

  Map<String, dynamic> toJson(CarEntryData instance) {
    Map<String, dynamic> map = {
      'regnum': instance.regNum,
      'kmIn': instance.kmIn,
      'dateIn': instance.dateIn,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'servicetype': instance.serviceType,
      'model': instance.model,
      'comment': instance.carInComment,
      'status': instance.status,
      'kmOut': instance.kmOut,
      'outDate': instance.outDate,
      'carExitComment': instance.carExitComment,
      'carExitBy': instance.carExitBy
    };
    return map;
  }
}
