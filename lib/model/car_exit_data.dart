import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CarExitData {
  final String regNum;
  final int kmIn;
  final String dateIn;
  final String createdDate;
  final String createdBy;
  final String comment;
  final String model;
  final String serviceType;
  DocumentReference reference;
  final String status;


  CarExitData({@required this.regNum,
    @required this.kmIn,
    @required this.dateIn,
    @required this.createdDate,
    @required this.createdBy,
    @required this.comment,
    @required this.model,
    @required this.serviceType,
    @required this.status});

  static fromSnapshot(DocumentSnapshot document) {
    CarExitData data = CarExitData.fromJson(document.data);
    data.reference = document.reference;
    return data;
  }

  factory CarExitData.fromJson(Map<String, dynamic> json){
    return CarExitData(
        regNum: json['regnum'],
        kmIn: json['kmIn'],
        dateIn: json['datein'],
        createdDate: json['createdDate'],
        createdBy: json['createdBy'],
        model: json['model'],
        serviceType:json["servicetype"],
        comment:json["comment"],
        status: json["status"]
    );
  }


  factory CarExitData.toJson(Map<String, dynamic> json){
    return CarExitData(
        regNum: json['regnum'],
        kmIn: json['kmIn'],
        dateIn: json['datein'],
        createdDate: json['createdDate'],
        createdBy: json['createdBy'],
        model: json['model'],
        serviceType:json["servicetype"],
        comment:json["comment"],
        status: json["status"]

    );
  }

  Map<String, dynamic> toJson(CarExitData instance) {
    Map<String, dynamic> map = {'regnum': instance.regNum,
      'kmIn': instance.kmIn,
      'datein': instance.dateIn,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'servicetype':instance.serviceType,
      'model':instance.model,
      'comment':instance.comment,
      'status': instance.status
    };
    return map;
  }
}
