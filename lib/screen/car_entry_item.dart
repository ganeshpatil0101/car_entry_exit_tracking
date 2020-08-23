import 'package:car_entry_exit/modal/car_entry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarEntryItem extends StatelessWidget {
  final Key key;
  final CarEntryData ce;
  final int index;
  CarEntryItem(this.ce, this.index) : key = ObjectKey(ce);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  (index % 2 == 0) ? Colors.white : Colors.black12,
      child: Row(
        children: <Widget>[
          Flexible(
            child: ListTile(
                contentPadding: EdgeInsets.only(bottom: 10),
                title: Text(ce.regNum),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("KmIn : ${ce.kmIn}"),
                    Text("Date In:${ce.dateIn}"),
                    Text("Model:${ce.model}")
                    //Text("NAV : ${mf.nav.toStringAsFixed(2)}")
                  ],
                ),
                //subtitle: MfItemDetails(mf.nav, mf.curValue, mf.amtInvstd),
                // trailing: VisualizedAmount(
                //   amount: mf.curValue - mf.amtInvstd,
                //   income: (mf.curValue - mf.amtInvstd < 0) ? false : true,
                // ),
                onTap: () => {
                      print('Navigate to exit page')
                      // Navigator.pushNamed(context, AddEditMfPage.route,
                      //     arguments: EditMfPageArgs(mf)),
                    }),
          ),
        ],
      ),
    );
  }
}
