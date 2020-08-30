import 'package:car_entry_exit/comman/progress_indicator.dart';
import 'package:car_entry_exit/modal/car_entry_data.dart';
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
        var totalInvested = 0.0;
        var currentValuation = 0.0;
        var ch = snapshots.map((s) {
          CarEntryData ce = CarEntryData.fromSnapshot(s);
          print(ce);
          return CarEntryItem(ce);
        });

        List<Widget> chw = [];
        chw.addAll(ch);
        var greenStyle = TextStyle(
            fontSize: 21.0, fontWeight: FontWeight.w500, color: Colors.green);
        var redStyle = TextStyle(
            fontSize: 21.0, fontWeight: FontWeight.w500, color: Colors.red);
        // chw.insert(
        //     0,
        //     Container(
        //       padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.stretch,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: <Widget>[
        //             Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                 children: <Widget>[
        //                   Text("Total Invested",
        //                       style: Theme.of(context).textTheme.display1),
        //                   Text("Total Valuation",
        //                       style: Theme.of(context).textTheme.display1),
        //                 ]),
        //             Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                 children: <Widget>[
        //                   Text(totalInvested.toStringAsFixed(2),
        //                       style: Theme.of(context).textTheme.display1),
        //                   Text(
        //                     currentValuation.toStringAsFixed(2),
        //                     style:
        //                         (currentValuation < 0) ? redStyle : greenStyle,
        //                   )
        //                 ]),
        //           ]),
        //     ));

        return Scrollbar(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            //padding: EdgeInsets.all(2.0),
            children: chw, //TODO
            dragStartBehavior: DragStartBehavior.start,
          ),
        );
      },
    );
  }
}
