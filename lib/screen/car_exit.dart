import 'package:car_entry_exit/comman/dropdown.dart';
import 'package:car_entry_exit/comman/input_formatter.dart';
import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
// Reg Num
// Date & time in
// Model with drop down
// Kms in
// Type of service drop down

class CarExit extends StatefulWidget {
  CarExit(this.db, this._carEntryData );
  static const routeName = '/car_exit';
  final FirebaseDatabse db;

  final CarEntryData _carEntryData;

  @override
  _CarExitState createState() => _CarExitState(db);
}

class _CarExitState extends State<CarExit> {
  _CarExitState(this.db);
  final FirebaseDatabse db;
  String carModelValue = 'Select Model';
  String typeOfService = 'Type of Service';
  var now = new DateTime.now();
  var dateTimeOutController = TextEditingController(),
      kmOutController = TextEditingController(),
      outCommentController = TextEditingController();

  @override
  void initState() {
    dateTimeOutController.text = now.toLocal().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Car Exit"),
      ),
      body: Scrollbar(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          children: <Widget>[

        ListTile(
        contentPadding:
        EdgeInsets.only(bottom: 1, top: 1, left: 10, right: 10),
          title: Text(
            widget._carEntryData.regNum,
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
                  mainAxisAlignment: MainAxisAlignment.start ,
                  children: [
                    Text(
                      "Date In : ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .display4,
                    ),
                    Text(
                      "${new DateFormat().format(DateTime.parse(widget._carEntryData.dateIn))}",
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
                      "Model:" + widget._carEntryData.model,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display4,
                    ),
                    Text(
                      "Km In: ${widget._carEntryData.kmIn}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .display4,
                    ),
                  ]),
              SizedBox(width: 5),
              Text(
                "Service Type: " + widget._carEntryData.serviceType,
                style: Theme
                    .of(context)
                    .textTheme
                    .display4,
              ),
              SizedBox(width: 5),
              Text(
                "Comment: " + widget._carEntryData.comment,
                style: Theme
                    .of(context)
                    .textTheme
                    .display4,
              )
            ],
          ),

          //subtitle: MfItemDetails(mf.nav, mf.curValue, mf.amtInvstd),
          //trailing: Icon(Icons.arrow_right),
          onTap: () =>
          {

            // Navigator.pushNamed(context, AddEditMfPage.route,
            //     arguments: EditMfPageArgs(mf)),
          }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: dateTimeOutController,
                onFieldSubmitted: (String a) { FocusScope.of(context).nextFocus();},
                decoration: InputDecoration(
                  hintText: "Out Date Time",
                  labelText: "Out Date Time",
                  border: OutlineInputBorder(),
                ),
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: outCommentController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [],
                decoration: InputDecoration(
                  hintText: "Comment",
                  labelText: "Comments",

                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {

                  var datein = dateTimeOutController.text;
                  var kmIn =  int.parse(kmOutController.text);
                  var comment = outCommentController.text;


                  CarEntryData data = new CarEntryData(regNum: widget._carEntryData.regNum, kmIn: kmIn, dateIn: datein, createdDate: datein, createdBy: "dunny", comment: comment, model: carModelValue, serviceType: typeOfService);
                  widget.db.addCarEntry(data);
                  Navigator.pop(context);
                },
                splashColor: Colors.deepPurple,
                highlightColor: Colors.deepPurple,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Save', style: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
