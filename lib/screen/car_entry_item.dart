import 'package:car_entry_exit/modal/car_entry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarEntryItem extends StatelessWidget {
  final Key key;
  final CarEntryData ce;
  CarEntryItem(this.ce) : key = ObjectKey(ce);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
                child: ListTile(
                    contentPadding:
                        EdgeInsets.only(bottom: 1, top: 1, left: 10, right: 10),
                    title: Text(
                      ce.regNum,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Km In : ${ce.kmIn}",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Date : ${ce.dateIn}",
                          style: Theme.of(context).textTheme.subhead,
                        )
                      ],
                    ),

                    //subtitle: MfItemDetails(mf.nav, mf.curValue, mf.amtInvstd),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => {
                          print('Navigate to exit page')
                          // Navigator.pushNamed(context, AddEditMfPage.route,
                          //     arguments: EditMfPageArgs(mf)),
                        })),
          ),
        ],
      ),
    );
  }
}
