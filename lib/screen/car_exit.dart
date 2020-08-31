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
  CarExit(this._carEntryData, this.db);
  static const routeName = '/car_exit';
  final FirebaseDatabse db;
  final CarEntryData _carEntryData;

  @override
  _CarExitState createState() => _CarExitState();
}

class _CarExitState extends State<CarExit> {
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
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "Date In : ",
                      style: Theme.of(context).textTheme.display4,
                    ),
                    Text(
                      "${new DateFormat('dd-MM-yyyy kk:mm').format(DateTime.parse(widget._carEntryData.dateIn))}",
                      style: Theme.of(context).textTheme.display4,
                    ),
                  ]),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Model:" + widget._carEntryData.model,
                          style: Theme.of(context).textTheme.display4,
                        ),
                        Text(
                          "Km In: ${widget._carEntryData.kmIn}",
                          style: Theme.of(context).textTheme.display4,
                        ),
                      ]),
                  SizedBox(height: 10),
                  Text(
                    "Service Type: " + widget._carEntryData.serviceType,
                    style: Theme.of(context).textTheme.display4,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Comment: " + widget._carEntryData.carInComment,
                    style: Theme.of(context).textTheme.display4,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: dateTimeOutController,
                onFieldSubmitted: (String a) {
                  FocusScope.of(context).nextFocus();
                },
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
                controller: kmOutController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalInputFormatter()],
                decoration: InputDecoration(
                  hintText: "Kilometer Out",
                  labelText: "Kilometer Out",
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
                  hintText: "Exit Comment",
                  labelText: "Exit Comments",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  var dateOut = dateTimeOutController.text;
                  var kmOut = int.parse(kmOutController.text);
                  var carExtComment = outCommentController.text;
                  var userID = widget.db.getUserId();

                  CarEntryData data = new CarEntryData(
                      outDate: dateOut,
                      kmOut: kmOut,
                      carExitComment: carExtComment,
                      carExitBy: userID,
                      status: "OUT",
                      regNum: widget._carEntryData.regNum,
                      kmIn: widget._carEntryData.kmIn,
                      dateIn: widget._carEntryData.dateIn,
                      createdDate: widget._carEntryData.createdDate,
                      createdBy: widget._carEntryData.createdBy,
                      carInComment: widget._carEntryData.dateIn,
                      model: widget._carEntryData.model,
                      serviceType: widget._carEntryData.serviceType);

                  widget.db
                      .exitCar(data)
                      .then((value) => {Navigator.pop(context)})
                      .catchError((err) => {showDialog(context: err)});
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
