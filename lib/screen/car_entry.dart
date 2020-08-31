import 'package:car_entry_exit/comman/dropdown.dart';
import 'package:car_entry_exit/comman/input_formatter.dart';
import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
// Reg Num
// Date & time in
// Model with drop down
// Kms in
// Type of service drop down

class CarEntry extends StatefulWidget {
  CarEntry(this.db);
  static const routeName = '/car_entry';
  final FirebaseDatabse db;

  @override
  _CarEntryState createState() => _CarEntryState(db);
}

class _CarEntryState extends State<CarEntry> {
  _CarEntryState(this.db);
  final FirebaseDatabse db;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();
  String carModelValue = 'Select Model';
  String typeOfService = 'Type of Service';
  var now = new DateTime.now();
  var dateTimeInController = TextEditingController(),
      kmInController = TextEditingController(),
      commentController = TextEditingController();
  var maskedCarRegNumCtrl = new MaskedTextController(mask: 'AA-00-AA-0000');

  @override
  void initState() {
    dateTimeInController.text = now.toLocal().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          key: _scaffoldKey1,

      appBar: AppBar(
        title: Text("Car Entry"),
      ),
      body:Scrollbar(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: maskedCarRegNumCtrl,
                onFieldSubmitted: (String a) {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  hintText: "Registration Number",
                  labelText: "Registration Number",
                  border: OutlineInputBorder(),
                ),
                validator: (regnum){
                  if(regnum == null || regnum.isEmpty){
                    return "Please enter valid registration number";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: dateTimeInController,
                enabled: false,
                onFieldSubmitted: (String a) {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  hintText: "In Date Time",
                  labelText: "In Date Time",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Dropdown(
                defaultValue: carModelValue,
                hintText: carModelValue,
                onChange: (selectedValue) {
                  setState(() {
                    carModelValue = selectedValue;
                  });
                },
                options: [
                  'Select Model',
                  'Santro',
                  'Verena',
                  'Creta',
                  'Accent',
                  'Elantra',
                  'i20',
                  'Eon'
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: kmInController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalInputFormatter()],
                decoration: InputDecoration(
                  hintText: "Kilometer In",
                  labelText: "Kilometer In",
                  border: OutlineInputBorder(),
                ),
                validator: (kmIn){
                  if(kmIn == null || kmIn.isEmpty){
                    return "Please enter kilometer in";
                  }
                   return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Dropdown(
                defaultValue: typeOfService,
                hintText: typeOfService,
                onChange: (selectedValue) {
                  setState(() {
                    typeOfService = selectedValue;
                  });
                },
                options: ["Type of Service", "Servicing", "Accident"],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: commentController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [],
                decoration: InputDecoration(
                  hintText: "Comment",
                  labelText: "Comments:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  print('REg NUm ');

                 if(_formKey.currentState.validate()) {
                   var dateIn = dateTimeInController.text;
                   var kmIn =  int.parse(kmInController.text);
                   var comment = commentController.text;
                   var regNum = maskedCarRegNumCtrl.text;
                  var userID = widget.db.getUserId();
                   if(carModelValue== null || carModelValue.isEmpty || carModelValue == 'Select Model'){

                     _scaffoldKey1.currentState.showSnackBar(SnackBar(content: Text('Please select Model of the car')));
                   } else if( typeOfService == null || typeOfService.isEmpty || typeOfService == 'Type of Service'){
                     _scaffoldKey1.currentState.showSnackBar(SnackBar(content: Text('Please select service type')));
                   }else {
                     CarEntryData data = new CarEntryData(regNum: regNum,
                         kmIn: kmIn,
                         dateIn: dateIn,
                         createdDate: dateIn,
                         createdBy: userID,
                  carInComment: comment,
                         model: carModelValue,
                         serviceType: typeOfService,
                         status: "IN");
                     widget.db.addCarEntry(data);
                     Navigator.pop(context);
                   }
                 }
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
    ));
  }
}
