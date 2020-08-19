import 'package:car_entry_exit/screen/car_entry.dart';
import 'package:car_entry_exit/screen/car_entry_list.dart';
import 'package:car_entry_exit/services/authentication.dart';
import 'package:car_entry_exit/services/firebase_database.dart';
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
  FirebaseDatabse db = new FirebaseDatabse();

  Future _logOutUser() async {
    await widget.auth.signOut();
    print('Logout successfully ....');
    widget.logoutCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashbord")),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CarEntry()));
                  },
                  splashColor: Colors.deepPurple,
                  //backgroundColor: Colors.pinkAccent,

                  highlightColor: Colors.deepPurple,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Entry Car', style: TextStyle(fontSize: 20)),
                ),
                Scrollbar(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8.0),
                    children: <Widget>[
                      CarEntryList(db),
                    ],
                  ),
                )
              ],
            ),
            Center(child: Text('Dashbord Page')),
          ],
        ),
      ),
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
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
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
