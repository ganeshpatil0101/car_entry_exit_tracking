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
      // messages: LoginMessages(
      //   usernameHint: 'Username',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'LOG IN',
      //   signupButton: 'REGISTER',
      //   forgotPasswordButton: 'Forgot huh?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',
      //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
      //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //   recoverPasswordSuccess: 'Password rescued successfully',
      // ),
      // theme: LoginTheme(
      //   primaryColor: Colors.teal,
      //   accentColor: Colors.yellow,
      //   errorColor: Colors.deepOrange,
      //   pageColorLight: Colors.indigo.shade300,
      //   pageColorDark: Colors.indigo.shade500,
      //   titleStyle: TextStyle(
      //     color: Colors.greenAccent,
      //     fontFamily: 'Quicksand',
      //     letterSpacing: 4,
      //   ),
      //   // beforeHeroFontSize: 50,
      //   // afterHeroFontSize: 20,
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //       borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //   ),
      //   buttonTheme: LoginButtonTheme(
      //     splashColor: Colors.purple,
      //     backgroundColor: Colors.pinkAccent,
      //     highlightColor: Colors.lightGreen,
      //     elevation: 9.0,
      //     highlightElevation: 6.0,
      //     shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
      //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      //   ),
      // ),
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
