import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;



  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.autoInitEnabled();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");


      _firebaseMessaging.configure(
      //     onBackgroundMessage:(Map<String,dynamic> message) async {
      //       print("Back");
      // },
          onMessage: (Map<String,dynamic> message) async{
            print("Test" + message.toString());
          },


          onLaunch: (Map<String,dynamic> message) async {
            print("OnLaunch");
          },onResume: (Map<String,dynamic> message) async {
        print("OnResume");
      }
      );

      _initialized = true;
    }
  }
}