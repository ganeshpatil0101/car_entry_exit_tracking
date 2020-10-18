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
  final FirebaseDatabse db;
  final isCarExit;
  final isAdmin;
  CarEntryItem(this.ce, this.index, this.db, this.isCarExit, this.isAdmin)
      : key = ObjectKey(ce);

  Widget showDelete() {
    if (isCarExit == false && isAdmin) {
      return IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: () {
          print("=== delete entry");
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
                color: (index % 2 == 0)
                    ? Colors.white
                    : Color.fromRGBO(192, 192, 192, 0.01),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
                    title: Text(
                      ce.regNum,
                      style: Theme.of(context).textTheme.display1,
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
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              Text(
                                "${new DateFormat('dd-MM-yyyy kk:mm').format(DateTime.parse(ce.dateIn))}",
                                style: Theme.of(context).textTheme.display4,
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${ce.model}",
                                style: Theme.of(context).textTheme.display4,
                              ),
                              Text(
                                "KmIn :${ce.kmIn}",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ]),
                        SizedBox(width: 5),
                        Text(
                          "Service Type : ${ce.serviceType}",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Comment : ${ce.carInComment}",
                          style: Theme.of(context).textTheme.subhead,
                        )
                      ],
                    ),
                    trailing: showDelete(),
                    onTap: () => {
                          if (this.isCarExit)
                            {print("Don't navigate on exit page.")}
                          else
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CarExit(ce, db)))
                            }
                        })),
          ),
        ],
      ),
    );
  }
}
