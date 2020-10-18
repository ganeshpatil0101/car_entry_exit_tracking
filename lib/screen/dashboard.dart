import 'dart:isolate';

import 'package:car_entry_exit/comman/progress_indicator.dart';
import 'package:car_entry_exit/screen/car_entry.dart';
import 'package:car_entry_exit/screen/car_entry_list.dart';
import 'package:car_entry_exit/screen/car_exit_list.dart';
import 'package:car_entry_exit/services/authentication.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'transition_route_observer.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  DashboardScreen({this.userId, this.auth, this.logoutCallback});
  final String userId;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  FirebaseDatabse db;
  bool isAdmin = false;
  bool loading = true;
  initState() {
    db = new FirebaseDatabse(widget.userId);
    db.getAdmins().then((data) {
      setState(() {
        isAdmin = this._isAdminUser(data.documents);
        loading = false;
      });
    });
    super.initState();
  }

  bool _isAdminUser(data) {
    for (var i in data) {
      if (i.data['user'] == widget.userId) {
        return true;
      }
    }
    return false;
  }

  Future _logOutUser() async {
    await widget.auth.signOut();
    print('Logout successfully ....');
    widget.logoutCallback();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return PaddedCircularProgressIndicator();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Dashbord")),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CarEntry(db)));
                },
                splashColor: Colors.deepPurple,
                color: Colors.deepPurpleAccent,
                highlightColor: Colors.deepPurple,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Car Entry', style: TextStyle(fontSize: 20)),
              )),
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(15.0, 5, 15, 15),
            children: <Widget>[
              CarEntryList(db, isAdmin),
            ],
          ),
        ],
      )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 140.0,
              child: DrawerHeader(
                child: Center(child: Text(widget.userId)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              title: Text('Car Exit List'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarExitList(db, isAdmin)));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                _logOutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
