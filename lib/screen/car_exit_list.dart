import 'package:car_entry_exit/comman/progress_indicator.dart';
import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:car_entry_exit/screen/car_entry_item.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CarExitList extends StatefulWidget {
  CarExitList(this.db, this.isAdmin);
  static const routeName = '/carexit';
  final FirebaseDatabse db;
  final isAdmin;
  @override
  State<StatefulWidget> createState() => new CarExitListState();
}

class CarExitListState extends State<CarExitList> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey1,
        appBar: AppBar(
          title: Text("Car Exit List"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: widget.db.getCarExitListSnapshot(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return PaddedCircularProgressIndicator();
            }
            List<DocumentSnapshot> snapshots = snapshot.data.documents;
            var index = 0;
            var ch = snapshots.map((s) {
              index++;
              CarEntryData ce = CarEntryData.fromSnapshot(s);
              return CarEntryItem(context,ce, index, widget.db, true, widget.isAdmin);
            });

            List<Widget> chw = [];
            chw.addAll(ch);
            return Scrollbar(
              child: ListView(
                padding: EdgeInsets.all(15.0),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: chw,
                dragStartBehavior: DragStartBehavior.start,
              ),
            );
          },
        ));
  }
}
