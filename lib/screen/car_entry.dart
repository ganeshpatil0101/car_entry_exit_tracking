import 'package:car_entry_exit/comman/dropdown.dart';
import 'package:car_entry_exit/comman/input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
// Reg Num
// Date & time in
// Model with drop down
// Kms in
// Type of service drop down

class CarEntry extends StatefulWidget {
  static const routeName = '/car_entry';
  @override
  _CarEntryState createState() => _CarEntryState();
}

class _CarEntryState extends State<CarEntry> {
  String carModelValue = 'Select Model';
  String typeOfService = 'Type of Service';
  var now = new DateTime.now();
  var carRegiNumController = TextEditingController(),
      dateTimeInController = TextEditingController(),
      kmInController = TextEditingController();
  var maskedCarRegNumCtrl = new MaskedTextController(mask: 'AA-00-AA-0000');

  @override
  void initState() {
    dateTimeInController.text = now.toLocal().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Entry"),
      ),
      body: Scrollbar(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextFormField(
            //     keyboardType: TextInputType.name,
            //     controller: maskedCarRegNumCtrl,
            //     decoration: InputDecoration(
            //       hintText: "Registration Number",
            //       labelText: "Registration Number",
            //       border: OutlineInputBorder(),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Registration Number"),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  countryCode(),
                  otpNumberWidget(0),
                  otpNumberWidget(1),
                  otpNumberWidget(2),
                  otpNumberWidget(3),
                  //otpNumberWidget(4),
                  //otpNumberWidget(5),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: dateTimeInController,
                enabled: false,
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
                  'Honda',
                  'Maruti Suzuki',
                  'Mahindra',
                  'Kia',
                  'Hundai',
                  'Nexa'
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
              child: RaisedButton(
                onPressed: () {
                  print('REg NUm ');
                  //print(carRegiNumController.text);
                  print(maskedCarRegNumCtrl.text);
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

  Widget countryCode() {
    return Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Center(
          child: TextFormField(
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        controller: carRegiNumController,
        decoration: InputDecoration(
          hintText: "MH",
          border: OutlineInputBorder(),
        ),
      )),
    );
  }

  Widget otpNumberWidget(int position) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Center(
          child: Text(
        "${position}",
        style: TextStyle(color: Colors.black),
      )),
    );
  }
}
