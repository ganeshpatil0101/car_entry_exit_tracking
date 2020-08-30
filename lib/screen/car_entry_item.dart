import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:car_entry_exit/services/firebase_database.dart';

import 'car_exit.dart';

class CarEntryItem extends StatelessWidget {
  final Key key;
  final CarEntryData ce;
  final int index;
  CarEntryItem(this.ce, this.index) : key = ObjectKey(ce);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.white ,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
                child: ListTile(
                    contentPadding:
                    EdgeInsets.only(bottom: 1, top: 1, left: 10, right: 10),
                    title: Text(
                      ce.regNum,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date In : ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead,
                              ),
                              Text(
                                "${new DateFormat().format(DateTime.parse(ce.dateIn))}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .display4,
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Creta123456",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .display4,
                              ),
                              Text(
                                "KmIn :${ce.kmIn}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead,
                              ),
                            ]),
                        SizedBox(width: 5),
                        Text(
                          "Service Type : Servicing",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Comment : NA",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        )
                      ],
                    ),

                    //subtitle: MfItemDetails(mf.nav, mf.curValue, mf.amtInvstd),
                    //trailing: Icon(Icons.arrow_right),
                    onTap: () =>
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              CarExit(new FirebaseDatabse(), ce)))
                      // Navigator.pushNamed(context, AddEditMfPage.route,
                      //     arguments: EditMfPageArgs(mf)),
                    })),
          ),
        ],
      ),
    );
  }
}
