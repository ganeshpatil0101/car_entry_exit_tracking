import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CarEntryData {
  final String regNum;
  final int kmIn;
  final String dateIn;
  final int createdDate;
  final String createdBy;

  CarEntryData(
      {@required this.regNum,
      @required this.kmIn,
      @required this.dateIn,
      @required this.createdDate,
      @required this.createdBy});

  static fromSnapshot(DocumentSnapshot document) {
    return CarEntryData(
      regNum: document.data['regNum'],
      kmIn: document.data['kmIn'],
      dateIn: document.data['dateIn'],
      createdDate: document.data['createdDate'],
      createdBy: document.data['createdBy'],
    );
  }
}
