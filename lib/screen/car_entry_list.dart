import 'package:car_entry_exit/comman/progress_indicator.dart';
import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:car_entry_exit/screen/car_entry_item.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CarEntryList extends StatefulWidget {
  CarEntryList(this.db);
  static const routeName = '/auth';
  final FirebaseDatabse db;

  @override
  State<StatefulWidget> createState() => new CarEntryListState();
}

class CarEntryListState extends State<CarEntryList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.db.getCarEntryListSnapshot(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return PaddedCircularProgressIndicator();
        }
        List<DocumentSnapshot> snapshots = snapshot.data.documents;
        var index = 0;
        var ch = snapshots.map((s) {
          index++;
          CarEntryData ce = CarEntryData.fromSnapshot(s);
          return CarEntryItem(ce, index, widget.db, false);
        });

        List<Widget> chw = [];
        chw.addAll(ch);
        return Scrollbar(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: chw,
            dragStartBehavior: DragStartBehavior.start,
          ),
        );
      },
    );
  }
}
