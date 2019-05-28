import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  static FirebaseMessaging _instance;

  static initialize() {
    _instance = FirebaseMessaging();
  }

  static register() {
    _instance.requestNotificationPermissions();
  }

  static Future<String> getToken() async {
    return await _instance.getToken();
  }
}
