import 'package:car_entry_exit/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'constants.dart';
import 'users.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.loginCallback});
  static const routeName = '/auth';
  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginScreenPageSate();
}

class _LoginScreenPageSate extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) async {
    String error = "";
    await widget.auth.signIn(data.name, data.password).then((FirebaseUser res) {
      widget.loginCallback();
    }).catchError((err) {
      error = err.message;
    });
    if (!(error == null || error == "")) {
      return error;
    }
    return null;
  }

  Future<String> _signUpUser(LoginData data) async {
    String error = "";
    await widget.auth.signUp(data.name, data.password).then((FirebaseUser res) {
      widget.loginCallback();
    }).catchError((err) {
      print(err);
      error = err.message;
    });
    if (!(error == null || error == "")) {
      return error;
    }
    return null;
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/car-2.jpeg',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) async {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        String err = await _loginUser(loginData);
        return err;
      },
      onSignup: (loginData) async {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        String err = await _signUpUser(loginData);
        return err;
      },
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(FadePageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}
